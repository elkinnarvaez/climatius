extends Node

signal player_selected(playerId)

func add_new_player(playerId):
	emit_signal("player_selected", playerId)
