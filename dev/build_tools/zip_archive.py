import shutil
import sys

if __name__ == '__main__':
    args = sys.argv[1:]
    print(args)
    if len(args) < 2:
        print('Usage: <directory> <output>')
        sys.exit(1)
    shutil.make_archive(args[1].split(".")[0], 'zip', args[0])