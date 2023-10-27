# syde599-a1

## Prerequisite Setup

Used python virtual environment to set it up. Sample run:
- python3 -m venv .venv
- source .venv/bin/activate
- pip install -r requirements.txt

Files are run as Python files: `python autodiff.py`.

## Structure

Files contained in directory:
- `autodiff.py`: Contains network implementation and training, including supporting `Network` and `Node` models. Run file to train network, with results printed and plot shown.
- `test.py`: Unit testing for `autodiff.py`.
- `test_model.py`: Test model built using PyTorch for comparison to trained network.