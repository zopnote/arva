import argparse
import os
from pathlib import Path

from dev.scripts.script_library.persistent_data import get_persistent_data

script_dir = Path(__file__).resolve().parent
directory = script_dir / f'{get_persistent_data('relative_root')}{get_persistent_data('output_dir')}'
def build(args):
    print(args)
    os.makedirs(directory, exist_ok=True)

if __name__ == '__main__':
    build([])