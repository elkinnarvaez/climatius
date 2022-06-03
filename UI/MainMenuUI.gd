extends Control

func _on_StartButton_pressed():
	get_tree().change_scene("res://UI/StartGameMenu.tscn")
	
func _on_OptionsButton_pressed():
	print("Button not implemented")

func _on_ExitButton_pressed():
	get_tree().quit()
