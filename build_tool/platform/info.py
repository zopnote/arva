import platform
import os

class Platform:
    def __init__(self, os_name, os_arch, os_version, os_threads_count):
        self.name = os_name
        self.arch = os_arch
        self.version = os_version
        self.threads_count = os_threads_count

def get():
    return Platform(
        platform.system(),
        platform.machine(),
        platform.version(),
        os.cpu_count()
    )

if __name__ == "__main__":
    system_info = get()
    text = f"""
    This system is identified as a {system_info.name} machine with version {system_info.version}.
    The cpu architecture is {system_info.arch} with {system_info.threads_count} cores.
    """
    print(text)