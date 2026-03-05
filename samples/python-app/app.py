"""
A minimal Flask application — demonstrates a containerised Python web service.

Build:  docker build -t python-sample .
Run:    docker run -p 5000:5000 python-sample
Open:   http://localhost:5000
"""

from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)


@app.route("/")
def index():
    return """
    <html><head><title>Python Sample</title>
    <style>body{font-family:system-ui,sans-serif;max-width:600px;margin:4rem auto;padding:0 1rem}</style>
    </head><body>
    <h1>🐍 Python Container Sample</h1>
    <p>A minimal Flask app running in a Docker container.</p>
    <p>Try <a href="/info">/info</a> for environment details.</p>
    </body></html>
    """


@app.route("/info")
def info():
    return jsonify({
        "hostname": socket.gethostname(),
        "python_version": os.popen("python --version").read().strip(),
        "environment": os.environ.get("FLASK_ENV", "production"),
        "message": "Running inside a container!",
    })


@app.route("/health")
def health():
    return jsonify({"status": "ok"}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
