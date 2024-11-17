from dev.sdk_tools.case.argument import arguments
from dev.sdk_tools.case.environment import get_value
from dev.sdk_tools.case.messages import throw_info

if __name__ == '__main__':
    if len(arguments) == 0:
        throw_info('main.not_enough_arguments')
    if arguments[0] == 'clean':
