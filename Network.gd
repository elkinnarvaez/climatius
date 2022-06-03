extends Node

const IP_ADDRESS = "127.0.0.1"
const MAX_CLIENTS = 4
const PORT = 5055

var server
var client

signal create_player(id)

func _ready():
	NetworkConnectionSignalManager._connect(get_tree(), "network_peer_connected", self, "_on_peer_connected")
	NetworkConnectionSignalManager._connect(get_tree(), "network_peer_disconnected", self, "_on_peer_disconnected")
	NetworkConnectionSignalManager._connect(get_tree(), "connected_to_server", self, "_connected_to_server")
	NetworkConnectionSignalManager._connect(get_tree(), "server_disconnected", self, "_server_disconnected")

func create_client():
	client = NetworkedMultiplayerENet.new()
	client.create_client(IP_ADDRESS, PORT)
	get_tree().network_peer = client

func create_server():
	server = NetworkedMultiplayerENet.new()
	var error = server.create_server(PORT, MAX_CLIENTS)
	if error != OK:
		print("There was an error while creating the server")
		return
	get_tree().network_peer = server
	var id_net = get_tree().get_network_unique_id()
	emit_signal("create_player", id_net)
	
func _on_peer_connected(id):
	print("Peer " + str(id) + " connected...")
	emit_signal("create_player", id)

func _on_peer_disconnected(id):
	print("Peer " + str(id) + " disconnected...")
	
func _connected_to_server():
	print("Connected to server...")
	var id_net = get_tree().get_network_unique_id()
	emit_signal("create_player", id_net)

func _server_disconnected():
	print("Server disconnected...")
