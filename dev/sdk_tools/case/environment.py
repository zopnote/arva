import os
import shutil
import tomllib

import yaml
from typing import Optional


def find_file_recursive(filename: str) -> Optional[str]:
    """
    Searches recursively upwards in the directory structure for a file.

    Args:
        filename (str): The name of the file to search for.

    Returns:
        Optional[str]: The absolute path of the file if found, otherwise None.
    """
    current_dir = os.path.abspath(os.path.dirname(__file__))

    while True:
        # Construct the full path to the file in the current directory
        file_path = os.path.join(current_dir, filename)

        if os.path.isfile(file_path):
            return file_path

        # Move to the parent directory
        parent_dir = os.path.abspath(os.path.join(current_dir, ".."))

        # Stop if the current directory is the root
        if current_dir == parent_dir:
            break

        current_dir = parent_dir

    return None


def find_directory_recursive(directory_name: str) -> Optional[str]:
    """
    Searches recursively upwards in the directory structure for a directory.

    Args:
        directory_name (str): The name of the directory to search for.

    Returns:
        Optional[str]: The absolute path of the directory if found, otherwise None.
    """
    current_dir = os.path.abspath(os.path.dirname(__file__))

    while True:
        # Construct the full path to the directory in the current directory
        dir_path = os.path.join(current_dir, directory_name)

        if os.path.isdir(dir_path):
            return dir_path

        # Move to the parent directory
        parent_dir = os.path.abspath(os.path.join(current_dir, ".."))

        # Stop if the current directory is the root
        if current_dir == parent_dir:
            break

        current_dir = parent_dir

    return None




def get_value(key_path: str) -> Optional[any]:
    """
    Retrieves a value from a YAML file using a dot-separated key path.

    Args:
        key_path (str): A dot-separated key path (e.g., "global.some_key").

    Returns:
        Optional[any]: The value associated with the key path, or None if not found.
    """
    # Split the key path into individual keys
    keys = key_path.split(".")
    if len(keys) < 2:
        return None

    # Determine the correct file based on the first key
    file_path = find_file_recursive(f"{keys[0]}.yml")

    # Ensure the file exists
    if not file_path or not os.path.exists(file_path):
        raise FileNotFoundError(f"File {file_path} does not exist.")

    # Load the YAML file
    with open(file_path, "r") as file:
        data = yaml.safe_load(file)

    # Traverse the YAML data structure using the keys
    current = data
    try:
        for key in keys[1:]:
            current = current[key]
        return current
    except (KeyError, TypeError):
        # Return None if a key is missing or the structure is invalid
        return None

def get_project_info(string):
    with open(find_file_recursive('pyproject.toml'), "rb") as f:
        data = tomllib.load(f)
        return data['project'][string]
if __name__ == "__main__":
    print(get_project_info('name'))