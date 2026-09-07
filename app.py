import socket
from datetime import datetime
from flask import Flask

app = Flask(__name__)

# A simple in-memory counter so we can SEE the app doing something
visit_count = 0


@app.route("/")
def hello():
    global visit_count
    visit_count += 1

    hostname = socket.gethostname()  # shows the container ID when running in Docker
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    return f"""
    <h1>Hello, Docker! 🐳</h1>
    <p>This page has been visited <b>{visit_count}</b> time(s).</p>
    <p>Running inside container: <b>{hostname}</b></p>
    <p>Server time: {now}</p>
    """


@app.route("/health")
def health():
    return {"status": "ok"}


if __name__ == "__main__":
    # 0.0.0.0 is important: it lets the app be reached from OUTSIDE the container
    app.run(host="0.0.0.0", port=5000, debug=True)
