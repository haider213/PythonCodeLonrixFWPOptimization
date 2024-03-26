from flask import Flask, render_template, jsonify
import xml.etree.ElementTree as ET

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/get_graph_data')
def get_graph_data():
    # Replace 'your_file.ml' with the actual path to your .ml file
    file_path = 'compatibility_graph.ml'
    graph_data = parse_ml_file(file_path)
    return jsonify(graph_data)

def parse_ml_file(file_path):
    tree = ET.parse(file_path)
    root = tree.getroot()

    nodes = []
    links = []

    for node in root.iter('node'):
        node_id = node.attrib['id']
        label = node.find(".//data[@key='d0']").text
        nodes.append({'id': node_id, 'label': label})

    for edge in root.iter('edge'):
        source = edge.attrib['source']
        target = edge.attrib['target']
        links.append({'source': source, 'target': target})

    return {'nodes': nodes, 'links': links}


    return {'nodes': nodes, 'links': links}

if __name__ == '__main__':
    app.run(debug=True)
