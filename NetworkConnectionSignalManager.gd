extends Node

func _connect(source: Object, trigger: String, target: Object, method: String):
	var error = source.connect(trigger, target, method)
	if error != OK:
		print("Error: ", error)
