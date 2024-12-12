import sys



def is_flag(condition):
    return condition in arguments

def print_depend_flag(condition, string):
    if is_flag(condition):
        print(string)