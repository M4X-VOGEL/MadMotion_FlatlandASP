import subprocess
import shutil

from envs import params as ep
from asp import params as ap

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

    if width is not None:
        ep.width = width

    if height is not None:
        ep.height = height

    if number_of_agents is not None:
        ep.number_of_agents = number_of_agents

    if max_num_cities is not None:
        ep.max_num_cities = max_num_cities

    if seed is not None:
        ep.seed = seed

    if grid_mode is not None:
        ep.grid_mode = grid_mode

    if max_rails_between_cities is not None:
        ep.max_rails_between_cities = max_rails_between_cities

    if max_rail_pairs_in_city is not None:
        ep.max_rail_pairs_in_city = max_rail_pairs_in_city

    if remove_agents_at_target is not None:
        ep.remove_agents_at_target = remove_agents_at_target

    if speed_ratio_map is not None:
        ep.speed_ratio_map = speed_ratio_map

    if malfunction_rate is not None:
        ep.malfunction_rate = malfunction_rate

    if min_duration is not None:
        ep.min_duration = min_duration

    if max_duration is not None:
        ep.max_duration = max_duration
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
        subprocess.run(['python', 'build.py', str(amount)])  #
    else:
        print('No environment amount provided!')
        exit()
    return


def modify_asp_params(*files):
    """Specify the paths to ASP files for the solve function.

    Specify the paths to ASP files that the solve function is supposed to use
    to generate an answer.
    This modifies the primary list in the asp/params.py file.

    Example:
        modify_asp_params(
            'A/a.lp',
            'B/b.lp',
            'A/c.lp'
        )

    Args:
            files: paths to the asp files that the solver should use, paths
                should be separated by commas.
    """
    if files:
        ap.primary = files
    else:
        print('No asp files provided!')
        exit()
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
    modify_build_paras(width=30, height=30,)
    build_env(amount=3)
    modify_asp_params(
        '',
    )
    # TODO: find way to get the name of the created env and give it to solve
    solve(env_path='')
    reset_params()
