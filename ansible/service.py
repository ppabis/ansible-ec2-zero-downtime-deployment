from http.server import BaseHTTPRequestHandler, HTTPServer
from socket import gethostname
from hashlib import sha256
from datetime import datetime
from timeit import default_timer as timer

def lotsofcrypto():
    """
    A heavy CPU load function.
    """
    start = timer()
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S.%f")
    current = f"helloworld {now}"
    for i in range(250000):
        current = sha256(current.encode()).hexdigest()
    return current, timer() - start

def generate_response():
    myhash, timed = lotsofcrypto()
    return f""" This is {gethostname()}.
            My hash is {myhash} and took me {timed}s.
    """.encode()

class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/plain')
        self.end_headers()
        self.wfile.write(generate_response())
        return
    
def run():
    print('starting server...')
    server_address = ('0.0.0.0', 80)
    httpd = HTTPServer(server_address, MyHandler)
    print('running server...')
    httpd.serve_forever()

if __name__ == "__main__":
    run()