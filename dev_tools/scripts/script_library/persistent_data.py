import json
import os

script_dir = os.path.dirname(os.path.realpath(__file__))
file_path = os.path.join(script_dir, '../data.json')

def get_persistent_data(string_key):
    with open(file_path) as file:
        data = json.load(file)
        return data.get(string_key)

def json_exists():
    return os.path.exists(file_path)

def create_persistent_data():
    if not json_exists():
        with open(file_path) as file:
            json.dump({}, file)

def add_persistent_data(dictionary):
    with open(file_path) as file:
        data = json.load(file)
        data.update(dictionary)
        with open(file_path) as file:
            json.dump(data, file)

if __name__ == "__main__":
    with open(file_path) as file:
        data = json.load(file)
        print(data)