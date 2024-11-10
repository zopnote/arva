from dev.scripts.build import build
from dev.scripts.script_library.argument import get_arguments, print_depend_flag
from dev.scripts.script_library.device_info import Device

def _help_msg():
    return ('Arva development kit, Copyright (c) 2024, Lenny Siebert\n'
            'The arva.py script is the main entry point for \n'
            'all development scripts and tooling for arva.\n'
            '\n'
            'arguments:\n'
            'build         (Build specific sdk/modules, artifacts)\n'
            '\n'
            'flags:\n'
            '--verbose     (Verbose mode to display debug information)\n')
if __name__ == '__main__':
    args = get_arguments()
    print_depend_flag('--verbose', 'Verbose mode is enabled.')
    print_depend_flag('--verbose', Device())
    if len(args) < 1:
        print(_help_msg())
        exit(1)
    if args[0] == 'build':
        build(args)
    else:
        _help_msg()