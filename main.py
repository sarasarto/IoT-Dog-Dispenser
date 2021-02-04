from bridge import Bridge
import requests


def main():
    bridge = Bridge()
    bridge.setup_serial()
    #bridge.loop()


if __name__ == '__main__':
    main()