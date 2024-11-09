import os
import re

import clingo
import pandas as pd
import numpy as np

import matplotlib.pyplot as plt
from datetime import datetime
from PIL import Image


# options for pandas to show all rows and columns
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', None)


# image counter for plot_path function
img_counter = 0


def run_clingo(files):
    """Run Clingo program with provided files.

    Uses the given ASP files to run the program and return the answer set:

    Example:
        run_clingo_program(
            ['asp/trans.lp', 'envs/lp/env_001--4_2.lp', 'asp/flat.lp']
        )

    Args:
        files: list of paths to asp files.

    Returns:
        An answer set.
    """
    # helper function for the solver
    def on_model(model):
        # concat all atoms and separate with space
        answer_str = " ".join(str(atom) for atom in model.symbols(shown=True))
        # append answer to answer set
        answer_set.append(answer_str)

    ctl = clingo.Control()

    # load .lp files
    for file in files:
        ctl.load(file)

    # ground the program
    ctl.ground([("base", [])])

    # create empty answer set
    answer_set = []

    # solve the ground program
    ctl.solve(on_model=on_model)

    # print answers
    # if len(answer_set) == 0:
    #     print('UNSATISFIABLE')
    # else:
    #     # Print each answer set as a string
    #     for i, answer in enumerate(answer_set, 1):
    #         print(f"Answer {i}: \n{answer}\n")

    return answer_set


def answer_to_df(answer):
    """Convert a clingo answer to pandas dataframe.

    Takes a string of predicates from a clingo answer and returns
    a pandas dataframe containing the columns: agent, timestep, position.

    Example:
        answer_to_df(
            'action(train(0),move_forward,0) action(train(0),move_forward,1)
            position(0,(16,11),n,1) position(0,(16,12),n,2)'
        )

        returns:
        df =
            agent   timestep    position    given_command
        0   0       0           NaN         move_forward
        1   0       1           (16, 11)    move_forward
        2   0       2           (16, 12)    NaN

    Args:
            answer: answer returned by clingo, as a string of positions
                separated by spaces.

    Returns:
        A pandas dataframe.
    """
    # pattern to detect all positions
    pattern = r'position\((\d+),\((\d+),(\d+)\),\w+,(\d+)\)'

    # find all positions
    matches = re.findall(pattern, answer)

    agent, position, time = [], [], []
    for match in matches:
        # get the data from each position
        agent.append(int(match[0]))
        time.append(int(match[3]))
        position.append((int(match[1]), int(match[2])))

    # build position dataframe
    pos_df = pd.DataFrame({
        'agent': agent,
        'timestep': time,
        'position': position
    })

    # pattern to detect all actions
    pattern = r'action\(train\((\d+)\),(\w+),(\d+)\)'

    # find all actions
    matches = re.findall(pattern, answer)

    agent, action, time = [], [], []
    for match in matches:
        # get the data from each action
        agent.append(int(match[0]))
        time.append(int(match[2]))
        action.append(str(match[1]))

    # build action dataframe
    act_df = pd.DataFrame({
        'agent': agent,
        'timestep': time,
        'given_command': action
    })

    # merge position dataframe and action dataframe
    df = pd.merge(pos_df, act_df, on=['agent', 'timestep'], how='outer')

    # sort by agent and timestep
    df.sort_values(['agent', 'timestep'], inplace=True)

    # print info for each agent
    # for i in df['agent'].unique():
    #     print(df[df['agent'] == i])
    #     print('\n\n\n')

    return df


def convert_position(pos):
    """Convert a position string to an integer tuple.

    Takes a string from the position column of the paths.csv and returns a tuple
    of integer coordinates.

    Example:
        convert_position('(np.int64(24), np.int64(4))')

        returns:
            (24, 6)

    Args:
            pos: string from position column in paths.csv.

    Returns:
        A tuple of two int.
    """
    # check if data is np.nan and return nan
    if pd.isna(pos):
        return pos

    # pattern to find all x in np.int64(x)
    pattern = r'np\.int64\((\d+)\)'

    # extract all x and y from (np.int64(x), np.int64(y))
    matches = re.findall(pattern, pos)

    # return (x, y)
    return tuple(map(int, matches))


def import_paths(file):
    """Import data from paths.csv.

    Example:
        import_paths('output/XXX.XXX/paths.csv')

    Args:
            file: path to paths.csv.

    Returns:
        A pandas dataframe with the data from paths.csv.
    """
    # import paths file to Dataframe
    df = pd.read_csv(file, sep=';')

    # convert position column to integer tuples
    df['position'] = df['position'].apply(convert_position)

    # sort by agent and timestep
    df.sort_values(['agent', 'timestep'], inplace=True)

    # print info for each agent
    # for i in df['agent'].unique():
    #     print(df[df['agent'] == i])
    #     print('\n\n\n')

    return df


def get_grid_dimensions():
    """Get input for grid dimensions.

    Returns:
       A tuple of two integers.
    """
    # ask user for grid dimensions
    while True:
        try:
            grid_rows = int(input("Enter the number of rows for the grid: "))
            grid_cols = int(input("Enter the number of columns for the grid: "))
            if grid_rows > 0 and grid_cols > 0:
                return grid_rows, grid_cols
            else:
                print("Please enter positive integers for rows and columns.")
        except ValueError:
            print("Invalid input. Please enter integers.")


def plot_path(df, env_image, grid_dim=None, border_width=None, ):
    """Plot path of agents onto environment and save plot.

    Plots the path taken by the agents into a grid of grid_dim dimensions on
    the environment. Also crops the white border out of the env_image according
    to the specified border_width.
    Plots will be saved in Plots folder under the time of program execution.

    Example:
        plot_path(data, (40, 40), 4, 'envs/png/env_001--4_2.png')

    Args:
            df: Dataframe with agent, timestep and position column
            env_image: path to env.png
            grid_dim: tuple of dimensions of the environment grid (rows, cols)
            border_width: width of the white strip on env_image
    """
    # Load environment image
    img = Image.open(env_image)
    img_width, img_height = img.size

    if border_width is not None:
        # noinspection PyTypeChecker
        img = img.crop([0, 0, img_width - border_width, img_height - border_width])
        img_width, img_height = img.size

    # get environment dimensions
    if grid_dim is None:
        grid_rows, grid_cols = get_grid_dimensions()
    else:
        grid_rows, grid_cols = grid_dim

    fig, ax = plt.subplots(figsize=(img_width / 100, img_height / 100), dpi=100)

    # display environment
    # noinspection PyTypeChecker
    ax.imshow(img, extent=[0, img_width, 0, img_height])

    # cell dimensions
    cell_width = img_width / grid_cols
    cell_height = img_height / grid_rows

    # grid lines
    for i in range(grid_cols + 1):
        ax.plot([i * cell_width, i * cell_width], [0, img_height],
                color='black', lw=1)
    for i in range(grid_rows + 1):
        ax.plot([0, img_width], [i * cell_height, i * cell_height],
                color='black', lw=1)

    # hide axis label
    ax.set_xticks([])
    ax.set_yticks([])

    agent_colors = plt.get_cmap('Set1', 10)

    # plot timestep at agent position
    for agent_id in df['agent'].unique():
        # get data for agent
        agent_df = df[df['agent'] == agent_id]

        for _, row in agent_df.iterrows():
            position = row['position']
            if position is not np.nan:
                x, y = position

                # convert to pixel coordinates (adjusted for top-left origin)
                pixel_x = y * cell_width
                pixel_y = (grid_rows - x - 1) * cell_height

                # get offset in each cell
                offset_x, offset_y = 0, 0
                if (agent_id % 4) == 0:
                    offset_x = cell_width / 4
                elif (agent_id % 4) == 1:
                    offset_y = cell_height / 6
                elif (agent_id % 4) == 2:
                    offset_x = -cell_width / 6
                elif (agent_id % 4) == 3:
                    offset_y = -cell_height / 4

                # plot timestep in agent color
                ax.text(
                    pixel_x + cell_width / 2 + offset_x,
                    pixel_y + cell_height / 2 + offset_y,
                    str(row["timestep"]),
                    color=agent_colors(agent_id),
                    ha='center',
                    va='center',
                    fontsize=2
                )

    # Create a Plots folder if necessary
    folder = f'./Plots'
    os.makedirs(folder, exist_ok=True)

    # get image counter
    global img_counter

    # get time
    plot_time = datetime.now().isoformat(timespec='minutes')
    plot_time = plot_time.replace(":", "-")

    # save plot under time and image count
    plt.savefig(f'{folder}/{plot_time}_{img_counter}', transparent=True,
                bbox_inches='tight', dpi=400)
    plt.close(fig)

    # increase image counter
    img_counter += 1
    return



if __name__ == "__main__":
    print(f'Program Start: {datetime.now()}\n')

    answers = run_clingo([
        'asp/trans.lp',
        'envs/lp/env_001--4_2.lp',
        'asp/flat.lp'
    ])

    answer_data = answer_to_df(answers[0])
    plot_path(answer_data, 'envs/png/env_001--4_2.png', (40, 40), 4)

    paths_data = import_paths('output/1731183101.1544976/paths.csv')
    plot_path(paths_data, 'envs/png/env_001--4_2.png', (40, 40), 4)
