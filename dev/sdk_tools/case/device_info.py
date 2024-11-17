import multiprocessing
import platform

class Device:
    def __init__(self):
        self.cpu_cores = multiprocessing.cpu_count()
        self.os = platform.system()
        self.architecture = platform.architecture()[:1]
        self.os_version = platform.version()
    def __str__(self):
        return (f"Device information:\n"
                f"Operating System: {self.os}, version: {self.os_version}\n"
                f"Processor: {self.architecture}, cores: {self.cpu_cores}\n"
                )

if __name__ == "__main__":
    device = Device()
    print(device)
