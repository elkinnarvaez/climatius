extends Node

export var max_water_pollution = 100
onready var water_pollution = 90 setget set_water_pollution
export var max_air_pollution = 100
onready var air_pollution = 30 setget set_air_pollution
export var max_contamination = 100
onready var contamination = 30 setget set_contamination
export var max_level_progress = 100
onready var level_progress = 60 setget set_level_progress

signal max_water_pollution_reached
signal max_air_pollution_reached
signal max_contamination_reached
signal max_level_progress_reached
signal water_pollution_changed(value)
signal air_pollution_changed(value)
signal contamination_changed(value)
signal level_progress_changed(value)

func set_water_pollution(value):
	water_pollution = value
	emit_signal("water_pollution_changed", water_pollution)
	if(water_pollution >= max_water_pollution):
		emit_signal("max_water_pollution_reached")

func set_air_pollution(value):
	air_pollution = value
	emit_signal("air_pollution_changed", air_pollution)
	if(air_pollution >= max_air_pollution):
		emit_signal("max_air_pollution_reached")

func set_contamination(value):
	contamination = value
	emit_signal("contamination_changed", contamination)
	if(contamination >= max_contamination):
		emit_signal("max_contamination_reached")
		
func set_level_progress(value):
	level_progress = value
	emit_signal("level_progress_changed", level_progress)
	if(level_progress >= max_level_progress):
		emit_signal("max_level_progress_reached")
