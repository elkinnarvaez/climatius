extends Node2D

onready var ySort = $YSort
var is_server
var playerId

func _ready():
	NetworkConnectionSignalManager._connect(Network, "create_player", self, "_create_player")
	if is_server:
		Network.create_server()
	else:
		Network.create_client()

func _create_player(id):
	var path = "res://Player/Player" + str(playerId) + ".tscn"
	var player = load(path)
	var playerInstance = player.instance()
	playerInstance.name = str(id)
	playerInstance.position = Vector2(40, -70)
	playerInstance.set_network_master(id)
	ySort.add_child(playerInstance)
