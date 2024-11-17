import os
import shutil

from dev.sdk_tools.case.environment import find_directory_recursive

output_dir = f'{find_directory_recursive('arva')}/output/'

def build(args):
    try:
        os.makedirs(output_dir, exist_ok=True)
        os.chdir(output_dir)
        shutil.copytree(
            f'{find_directory_recursive('arva')}/bin',
            f'{output_dir}/bin'
        )
    except Exception as e:
        print(f'Error while creating output directory: {e}')


if __name__ == '__main__':
    build([])