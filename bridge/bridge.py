from serial.tools import list_ports
import serial
                                                                                                                                                                             
class Bridge:
    def __init__(self):
        self.ser = None
        self.port_name = None
        self.inbuffer = []

    def setup_serial(self):
        print('List of available ports: ')

        ports = list_ports.comports()
        for port in ports:
            print('--> ' + port.device + port.description)
            if 'com' in port.description.lower():
                self.port_name = port.device

        if self.port_name is not None:
            print('Connecting to ' + self.port_name + '...')
            self.ser = serial.Serial(self.port_name, timeout=0)
            print('Connected with success!')
        else:
            print('No available ports!')

    def write_msg(self, msg):
        self.ser.write(msg.encode())


    def loop(self):
        print('bridge_thread')
        while (True):
            #look for a byte from serial
            if not self.ser is None:

                if self.ser.in_waiting > 0:
                    # data available from the serial port
                    lastchar=self.ser.read(1)


                    if lastchar==b'\xfe': #EOL
                        print("\nValue received")
                        self.useData()
                        self.inbuffer = []
                    else:
                        # append
                        self.inbuffer.append (lastchar)

    def useData(self):
        # I have received a line from the serial port. I can use it
        if len(self.inbuffer)<3:   # at least header, size, footer
            return False
        # split parts
        if self.inbuffer[0] != b'\xff':
            return False

        numval = int.from_bytes(self.inbuffer[1], byteorder='little')
        for i in range(numval):
            val = int.from_bytes(self.inbuffer[i+2], byteorder='little')
            strval = "Sensor %d: %d " % (i, val)
            print(strval)