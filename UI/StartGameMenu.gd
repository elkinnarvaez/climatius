extends Control

func select_player(is_server):
	var gameConfigUI = preload("res://UI/GameConfigUI.tscn")
	var gameConfigUIInstance = gameConfigUI.instance()
	gameConfigUIInstance.is_server = is_server
	get_tree().root.add_child(gameConfigUIInstance)
	queue_free()
	
func _on_CreateServer_pressed():
	select_player(true)
	# start_game(true)
	# Network.create_server()

func _on_JoinServer_pressed():
	select_player(false)
	# start_game(false)
	# Network.create_client()

func _on_MainMenu_pressed():
	get_tree().change_scene("res://UI/MainMenuUI.tscn")
