from bridge import Bridge
import schedule
import time

def main():
    bridge = Bridge()
    bridge.setup_serial()
    #bridge.loop()
    while(True):
        val = input('Inserisci valore: ')
        bridge.write_msg(val)



if __name__ == '__main__':
    main()