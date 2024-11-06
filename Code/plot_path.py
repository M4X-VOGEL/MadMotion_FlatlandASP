import re
import os
from datetime import datetime

# these need to be downloaded
import clingo
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from PIL import Image

def plot_path(position_string, answer_num, background_path, folder_path, raster_size_x, raster_size_y):
    """
    Plots the path based on position data in the given string and overlays it onto a background image.

    Parameters:
    - position_string (str): The position data string.
    - answer_num (int): The enumeration number of the answer.
    - background_path (str): The path to the background image to overlay on.
    - folder_path (str): The path to the folder where plots should be saved.
    - raster_size_x (int): The number of columns for the grid.
    - raster_size_y (int): The number of rows for the grid.
    """
    # Define a regex pattern to match each position entry
    pattern = r'position\((\d+),\((\d+),(\d+)\),\w+,\s*(\d+)\)'

    # Find all matches in the string
    matches = re.findall(pattern, position_string)

    # Extract data and convert to the appropriate types, ignoring the third argument
    data = []
    for match in matches:
        ID = int(match[0])
        y = int(match[1])  # Now Y is the first value
        x = int(match[2])  # Now X is the second value
        time = int(match[3])  # Time is still extracted but not used
        data.append((ID, (x, y), time))

    # Create DataFrame
    df = pd.DataFrame(data, columns=['col1', 'col2', 'col3'])

    # Define a custom color map with specific colors
    color_map_list = ['red', 'blue', 'green', 'yellow', 'purple']
    unique_ids = df['col1'].unique()
    color_map = {id_val: color_map_list[i % len(color_map_list)] for i, id_val in enumerate(unique_ids)}

    # Open the background image
    background = Image.open(background_path)
    fig, ax = plt.subplots(figsize=(10, 10))

    # Plotting over the background image
    ax.imshow(background, extent=[0, raster_size_x, raster_size_y, 0])

    # Create a raster grid
    ax.set_xlim(0, raster_size_x)
    ax.set_ylim(raster_size_y, 0)  # Invert y-axis to have (0, 0) at the top left
    ax.set_xticks(range(raster_size_x))
    ax.set_yticks(range(raster_size_y))
    ax.grid(True, color='gray', linestyle='-', linewidth=0.5)

    # Plot each entry in the DataFrame
    for _, row in df.iterrows():
        x, y = row['col2']
        number = row['col3']
        color = color_map[row['col1']]
        ax.text(x + 0.5, y + 0.5, str(number), ha='center', va='center', fontsize=12, color=color)

    ax.axis('off')  # Hide axes
    ax.set_aspect('equal', adjustable='box')

    # Save the overlayed image
    file_path = os.path.join(folder_path, os.path.basename(background_path))
    plt.gcf().set_facecolor('none')
    plt.savefig(file_path, transparent=True, bbox_inches='tight', pad_inches=0)
    plt.close(fig)

    print(f"Plot saved to {file_path}")

def run_clingo_program(*files):
    """
    Runs a Clingo program with the provided files and processes each answer set.

    Parameters:
    files (str): File names of logic programs to load (e.g., 'ets.lp', 'test2.lp').

    Returns:
    list: A list of strings, where each string represents an answer set.
    """
    ctl = clingo.Control()
    for file in files:
        ctl.load(file)

    ctl.ground([("base", [])])

    answer_sets = []
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    # Create a folder named with the timestamp
    save_folder = f"../Plots/XY/{timestamp}"
    os.makedirs(save_folder, exist_ok=True)

    def on_model(model):
        answer_str = " ".join(str(atom) for atom in model.symbols(shown=True))
        answer_sets.append(answer_str)

    ctl.solve(on_model=on_model)

    return answer_sets, save_folder

def process_clingo_and_plot(*files):
    """
    Processes the Clingo program and plots all paths.

    Parameters:
    files (str): File names of logic programs to load (e.g., 'ets.lp', 'test2.lp').
    """
    raster_size_x = int(input("Enter the number of columns for the raster (e.g., 30 for a 30x20 grid): "))
    raster_size_y = int(input("Enter the number of rows for the raster (e.g., 20 for a 30x20 grid): "))

    # Run the Clingo program and get the answer sets
    answer_sets, save_folder = run_clingo_program(*files)

    # Generate plots for each answer set in the timestamped folder
    for i, answer in enumerate(answer_sets, 1):
        # Identify the correct background image based on the env_XX.lp file name
        env_file = files[1]
        background_image_path = env_file.replace('.lp', '.png')

        # Plot the path and overlay on the background
        plot_path(answer, i, background_image_path, save_folder, raster_size_x, raster_size_y)

# Main program
if __name__ == "__main__":

    # this can overlay the generated numbers onto the env_XX.lp
    # if env_XX.lp is in second position of files

    process_clingo_and_plot(
        "trans.lp",
        "../envs/assignment/env_01.lp",
        "flat.lp"
    )
