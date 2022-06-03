extends Control

onready var player2Button = $Player2Button
onready var player3Button = $Player3Button
onready var player4Button = $Player4Button
onready var player5Button = $Player5Button

var is_server

func start_game(is_server, playerId):
	var world = preload("res://World.tscn")
	var worldInstance = world.instance()
	worldInstance.is_server = is_server
	worldInstance.playerId = playerId
	get_tree().root.add_child(worldInstance)
	queue_free()
	
func _on_Player2Button_pressed():
	GameConfig.add_new_player(2)
	start_game(is_server, 2)

func _on_Player3Button_pressed():
	GameConfig.add_new_player(3)
	start_game(is_server, 3)

func _on_Player4Button_pressed():
	GameConfig.add_new_player(4)
	start_game(is_server, 4)
	
func _on_Player5Button_pressed():
	GameConfig.add_new_player(5)
	start_game(is_server, 5)

func _player_selected(playerId):
	if(playerId == 2 and player2Button != null):
		player2Button.disabled = true
	if(playerId == 3 and player3Button != null):
		player3Button.disabled = true
	if(playerId == 4 and player4Button != null):
		player4Button.disabled = true
	if(playerId == 5 and player5Button != null):
		player5Button.disabled = true
	
func _ready():
	GameConfig.connect("player_selected", self, "_player_selected")
