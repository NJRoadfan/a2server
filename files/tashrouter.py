import logging
import time
import signal
import sys
import os
import serial
import serial.tools.list_ports

import tashrouter.netlog
from tashrouter.port.appletalk.ethertalk.tap import LinuxTapPort
from tashrouter.port.appletalk.localtalk.ltoudp import LtoudpPort
from tashrouter.port.appletalk.localtalk.tashtalk import TashTalkPort
from tashrouter.router.router import Router

def sigterm_handler(_signo, _stack_frame):
    # Raises SystemExit(0):
    sys.exit(0)

def find_usb_serial(target_name):
    ports = serial.tools.list_ports.grep(target_name)

    for port in ports:
        # Match using product string
        if port.product:
            return port.device

    return None

logging.basicConfig(level=logging.DEBUG, format='%(levelname)s: %(message)s')
#tashrouter.netlog.set_log_str_func(logging.debug)  # comment this line for speed and reduced spam
portlist = [LtoudpPort(seed_network=5, seed_zone_name=b'A2SERVER')]
portlist.append(LinuxTapPort(tap_name='tash0', hw_addr=b'\xAA\xBB\xCC\xDD\x11\x22', seed_network_min=6502, seed_network_max=6502, seed_zone_names=[b'A2SERVER']))

TARGET_VID = 0x10C4
TARGET_PID = 0xEA60
TARGET_NAME = 'tashtalk'

#Autodetect TashTalk USB
#If your device has different identifiers, you can change them above
tashtalkusbdevice=find_usb_serial(TARGET_NAME)
tashtalkhatdevice=None

if tashtalkusbdevice is not None:
    if os.path.exists(tashtalkusbdevice):
        portlist.append(TashTalkPort(serial_port=tashtalkusbdevice, seed_network=6, seed_zone_name=b'A2SERVER'))

if tashtalkhatdevice is not None:
    if os.path.exists(tashtalkhatdevice):
        portlist.append(TashTalkPort(serial_port=tashtalkhatdevice, seed_network=7, seed_zone_name=b'A2SERVER'))

router = Router('router', ports=portlist)

print('router away!')
router.start()
signal.signal(signal.SIGTERM, sigterm_handler)

try:
  while True: time.sleep(1)
except (KeyboardInterrupt, SystemExit):
  router.stop()
