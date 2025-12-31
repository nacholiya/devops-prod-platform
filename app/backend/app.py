from flask import Flask, jsonify
import logging
import os

app = Flask(__name__)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s"
)

@app.route("/health")
def health():
    app.logger.info("Health check requested")
    return jsonify(status="UP"), 200

@app.route("/")
def home():
    app.logger.info("Home endpoint accessed")
    return jsonify(message="DevOps Production App is running"), 200

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.logger.info(f"Starting application on port {port}")
    app.run(host="0.0.0.0", port=port)

