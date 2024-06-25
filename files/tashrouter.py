import logging
import time
import signal
import sys

import tashrouter.netlog
from tashrouter.port.ethertalk.tap import TapPort
from tashrouter.port.localtalk.ltoudp import LtoudpPort
#from tashrouter.port.localtalk.tashtalk import TashTalkPort
from tashrouter.router.router import Router

def sigterm_handler(_signo, _stack_frame):
    # Raises SystemExit(0):
    sys.exit(0)

logging.basicConfig(level=logging.DEBUG, format='%(levelname)s: %(message)s')
#tashrouter.netlog.set_log_str_func(logging.debug)  # comment this line for speed and reduced spam

router = Router('router', ports=(
  LtoudpPort(seed_network=5, seed_zone_name=b'A2SERVER'),
  #TashTalkPort(serial_port='/dev/ttyAMA0', seed_network=6, seed_zone_name=b'A2SERVER'),
  TapPort(tap_name='tash0', hw_addr=b'\xAA\xBB\xCC\xDD\x11\x22', seed_network_min=6502, seed_network_max=6502, seed_zone_names=[b'A2SERVER']),
))
print('router away!')
router.start()
signal.signal(signal.SIGTERM, sigterm_handler)

try:
  while True: time.sleep(1)
except (KeyboardInterrupt, SystemExit):
  router.stop()
