from flask import Flask, jsonify
from utils import get_connection_sql, show_item


app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False


@app.route("/<itemid>")
def get_info(itemid):
    result = show_item(itemid)
    return jsonify(result)


if __name__=="__main__":
    app.run()