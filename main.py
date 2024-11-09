import subprocess
import shutil
import time


def modify_build_paras(
    width=None,
    height=None,
    number_of_agents=None,
    max_num_cities=None,
    seed=None,
    grid_mode=None,
    max_rails_between_cities=None,
    max_rail_pairs_in_city=None,
    remove_agents_at_target=None,
    speed_ratio_map=None,
    malfunction_rate=None,
    min_duration=None,
    max_duration=None
):
    """Set the parameters for the environment creation.

    This modifies the parameters in the envs/params.py file.

    Args:
            width: width of the environment, number of columns (Y-Dimension)
            height: height of the environment, number of rows (X-Dimension)
            number_of_agents: number of trains in the environment
            max_num_cities: maximum number of cities in the environment
            seed: seed for random generation
            grid_mode: arrangement style for cities, (True/False)
            max_rails_between_cities: number of track lanes between cities
            max_rail_pairs_in_city: number of track lanes in cities
            remove_agents_at_target: trains despawn on arrival (True/False)
            speed_ratio_map: speed of trains, specify as {X:Y} e.g. {1:1}
            malfunction_rate: rate of malfunctions, specify as X/Y e.g. 3/10
            min_duration: minimum malfunction length
            max_duration: maximum malfunction length
    """

    file_path = 'envs/params.py'

    # Read the current contents of the file
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Modify the lines in the file
    with open(file_path, 'w') as file:
        for line in lines:
            if line.startswith("width") and width is not None:
                file.write(f'width={width}\n')
            elif line.startswith('height') and height is not None:
                file.write(f'height={height}\n')
            elif line.startswith('number_of_agents') and number_of_agents is not None:
                file.write(f'number_of_agents={number_of_agents}\n')
            elif line.startswith('max_num_cities') and max_num_cities is not None:
                file.write(f'max_num_cities={max_num_cities}\n')
            elif line.startswith('seed') and seed is not None:
                file.write(f'seed={seed}\n')
            elif line.startswith('grid_mode') and grid_mode is not None:
                file.write(f'grid_mode={grid_mode}\n')
            elif line.startswith('max_rails_between_cities') and max_rails_between_cities is not None:
                file.write(f'max_rails_between_cities={max_rails_between_cities}\n')
            elif line.startswith('max_rail_pairs_in_city') and max_rail_pairs_in_city is not None:
                file.write(f'max_rail_pairs_in_city={max_rail_pairs_in_city}\n')
            elif line.startswith('remove_agents_at_target') and remove_agents_at_target is not None:
                file.write(f'remove_agents_at_target={remove_agents_at_target}\n')
            elif line.startswith('speed_ratio_map') and speed_ratio_map is not None:
                file.write(f'speed_ratio_map={speed_ratio_map}\n')
            elif line.startswith('malfunction_rate') and malfunction_rate is not None:
                file.write(f'malfunction_rate={malfunction_rate}\n')
            elif line.startswith('min_duration') and min_duration is not None:
                file.write(f'min_duration={min_duration}\n')
            elif line.startswith('max_duration') and max_duration is not None:
                file.write(f'max_duration={max_duration}\n')
            else:
                file.write(line)
    return


def build_env(amount=None):
    """Call the build.py file with a desired amount of environments.

    Creates amount of environments with the parameters specified in
    modify_build_params and the envs/params.py file
    The env is saved in the 'envs' folder.
    The lp file in envs/lp
    The pickle file in envs/pkl
    The png file in envs/png

    Args:
            amount: amount of environments to be created
    """
    if amount is not None:
        # this line can randomly throw an OverflowError.
        # subprocess.run(['python', 'build.py', str(amount)])

        # this block is temporary until build.py error issue is fixed
        retries = 0
        max_retries = 10
        while retries < max_retries:
            try:
                subprocess.run(
                    ['python', 'build.py', str(amount)],
                    capture_output=True, text=True, check=True
                )
                print(f'build.py successfully executed with {retries} retries.')
                return
            except subprocess.CalledProcessError as e:
                if ("OverflowError: Python integer" in e.stderr and
                        "out of bounds for uint16" in e.stderr):
                    retries += 1
                else:
                    raise RuntimeError(f"Subprocess failed with error: {e.stderr}")
        raise RuntimeError("Maximum retries for build.py exceeded without success.")
        # end of temporary block
    else:
        print('No environment amount provided!')
        exit()
    return


def modify_asp_params(primary=None, secondary=None):
    """Specify the paths to ASP files for the solve function.

    Specify the paths to ASP files that the solve function is supposed to use
    to generate an answer.
    This modifies the primary and secondary list in the asp/params.py file.

    Example:
        modify_asp_params(
            primary=['A/a.lp', 'B/b.lp', 'A/c.lp'],
            secondary=['X/x.lp', 'Y/y.lp', 'X/z.lp']
        )

    Args:
            primary: primary list of paths to asp files the solver should
                use as solving files, should be a list of strings
            secondary: secondary list of paths to asp files the solver should
                use as solving files, should be a list of strings
    """
    file_path = 'asp/params.py'

    # Read the current contents of the file
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Modify the lines in the file
    with open(file_path, 'w') as file:
        for line in lines:
            if line.startswith("primary") and primary:
                file.write(f'primary={primary}\n')
            elif line.startswith('secondary') and secondary:
                file.write(f'secondary={secondary}\n')
            else:
                file.write(line)
    return


def solve(env_path=None):
    """Call the solve.py file with the given env_path.

    Use the pickle file of the environment to run the solver on and generate a
    gif of the result.
    The gif is saved in the output folder.

    Args:
            env_path: path to the pickle version of the environment to run the
                solver on.
    """
    if env_path is not None:
        subprocess.run(['python', 'solve.py', env_path])
    else:
        print('No environment path provided!')
        exit()
    return


def reset_params():
    """Reset asp and envs parameters to original values.

    Use files in 'Backups' to restore original parameter values in
    'asp/params.py' and 'envs/params.py'.
    """
    shutil.copy('Backups/asp/params.py', 'asp/params.py')
    shutil.copy('Backups/envs/params.py', 'envs/params.py')
    print('Reset of asp and envs parameters complete!')
    return


if __name__ == "__main__":
    # TODO: find way to get the name of the created env and give it to solve

    # Building stage
    modify_build_paras(
        width=40, height=40, number_of_agents=4, max_num_cities=2, seed=1,
        grid_mode=False, max_rails_between_cities=2, max_rail_pairs_in_city=2
    )
    build_env(amount=1)

    # wait for envs to be saved
    time.sleep(5)

    # Solving Stage
    modify_asp_params(primary=['asp/flat.lp', 'asp/trans.lp'])
    solve(env_path='envs/pkl/env_001--4_2.pkl')

    # reset parameters
    # reset_params()
