from bridge import Bridge
import schedule
import time

def job(bridge):
    bridge.write_msg('1')

def main():
    bridge = Bridge()
    bridge.setup_serial()
    #bridge.loop()



if __name__ == '__main__':
    main()