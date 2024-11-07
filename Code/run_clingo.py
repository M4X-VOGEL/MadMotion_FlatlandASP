import clingo

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

    answers = []

    def on_model(model):
        answer_str = " ".join(str(atom) for atom in model.symbols(shown=True))
        answers.append(answer_str)

    ctl.solve(on_model=on_model)

    return answers


# Main program
if __name__ == "__main__":
    # Run the Clingo program and get the answer sets
    answer_sets = run_clingo_program(
        "../asp/trans.lp",
        "../envs/assignment/env_01.lp",
        "../asp/flat.lp"
    )
    if len(answer_sets) == 0:
        print('UNSATISFIABLE')
    else:
        # Print each answer set as a string
        for i, answer in enumerate(answer_sets, 1):
            print(f"Answer Set {i}: {answer}")

