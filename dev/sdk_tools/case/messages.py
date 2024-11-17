from dev.sdk_tools.case.environment import get_project_info, get_value


def throw_info(string):
    project_name = get_project_info('name')
    project_version = get_project_info('version')
    message = f'[INFO] {project_name}-{project_version}: {get_value(f'messages.{string}')}'
    print(message)