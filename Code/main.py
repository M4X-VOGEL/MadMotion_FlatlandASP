import subprocess

from envs import params as ep
from asp import params as ap

def modify_build_paras(width, height):
    ep.width = width
    ep.height = height
    return


def build_env(amount):
    subprocess.run(command=['python', 'build.py', str(amount)])
    return


def modify_asp_params(*files):
    ap.primary = files
    return


def solve(env_path):
    subprocess.run(command=['python', 'solve.py', env_path])
    return


if __name__ == "__main__":
    modify_build_paras(
        width=30,
        height=30,
    )
    build_env(
        amount=3
    )
    modify_asp_params(
        '',
    )
    solve(
        env_path=''
    )
