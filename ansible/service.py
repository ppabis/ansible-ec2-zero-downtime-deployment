from http.server import BaseHTTPRequestHandler, HTTPServer
from socket import gethostname
from hashlib import sha256
from datetime import datetime
from timeit import default_timer as timer
from os.path import exists

VERSION = "?Unknown?"

def get_version():
    global VERSION
    if exists('/opt/version'):
        with open('/opt/version', 'r') as f:
            VERSION = f.read()

def lotsofcrypto(iters):
    """
    A heavy CPU load function.
    """
    start = timer()
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S.%f")
    current = f"helloworld {now}"
    for i in range(iters):
        current = sha256(current.encode()).hexdigest()
    return current[:16], timer() - start

def generate_response(iters=250000):
    myhash, timed = lotsofcrypto(iters)
    return f"v: {VERSION}, this is {gethostname().split('.')[0]}. My hash is {myhash} in {timed:.3f}s, {iters}i".encode()

class MyHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        # Log the request
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S.%f")
        print(f"[{now}] - {self.client_address[0]} - {self.path}")
        self.send_response(200)
        self.send_header('Content-type','text/plain')
        self.end_headers()
        if self.path.startswith('/healthcheck'):
            self.wfile.write(generate_response(2)) # Make healthcheck faster
        else:
            self.wfile.write(generate_response())

def run():
    get_version()
    print(f"VERSION: {VERSION}")
    print('starting server...')
    server_address = ('0.0.0.0', 8080)
    httpd = HTTPServer(server_address, MyHandler)
    print('running server...')
    httpd.serve_forever()

if __name__ == "__main__":
    run()