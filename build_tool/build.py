import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--mode', type=str, default='release')
    parser.add_argument('--runtime', action='store_true')
    parser.add_argument('--')
    args = parser.parse_args()
    print(args)