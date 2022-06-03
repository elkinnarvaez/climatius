extends Control

var max_water_pollution = 100 setget set_max_water_pollution
var water_pollution = 90 setget set_water_pollution
var max_air_pollution = 100 setget set_max_air_pollution
var air_pollution = 30 setget set_air_pollution
var max_contamination = 100 setget set_max_contamination
var contamination = 30 setget set_contamination
var max_level_progress = 100 setget set_max_level_progress
var level_progress = 60 setget set_level_progress

onready var label = $Label
onready var waterPollutionEmpty = $WaterPollutionEmpty
onready var waterPollutionFull = $WaterPollutionFull
onready var airPollutionEmpty = $AirPollutionEmpty
onready var airPollutionFull = $AirPollutionFull
onready var contaminationEmpty = $ContaminationEmpty
onready var contaminationFull = $ContaminationFull
onready var levelProgressEmpty = $LevelProgressEmpty
onready var levelProgressFull = $LevelProgressFull

func update_stats():
	if(waterPollutionFull != null):
		waterPollutionFull.rect_size.x = water_pollution * 4
	if(airPollutionFull != null):
		airPollutionFull.rect_size.x = air_pollution * 4
	if(contaminationFull != null):
		contaminationFull.rect_size.x = contamination * 4
	if(levelProgressFull != null):
		levelProgressFull.rect_size.x = level_progress * 4

func update_label():
	label.text = "Water Pollution: " + str(water_pollution) + "\nAir Pollution: " + str(air_pollution) + "\nContamination: " + str(contamination) + "\nLevel Progress: " + str(level_progress)

func set_max_water_pollution(value):
	max_water_pollution = max(value, 1)
	
func set_water_pollution(value):
	water_pollution = clamp(value, 0, max_water_pollution)
	if(label != null):
		update_label()
	update_stats()

func set_max_air_pollution(value):
	max_air_pollution = max(value, 1)

func set_air_pollution(value):
	air_pollution = clamp(value, 0, max_air_pollution)
	if(label != null):
		update_label()
	update_stats()

func set_max_contamination(value):
	max_contamination = max(value, 1)

func set_contamination(value):
	contamination = clamp(value, 0, max_contamination)
	if(label != null):
		update_label()
	update_stats()

func set_max_level_progress(value):
	max_level_progress = max(value, 1)

func set_level_progress(value):
	level_progress = clamp(value, 0, max_level_progress)
	if(label != null):
		update_label()
	update_stats()

func _ready():
	self.max_water_pollution = Stats.max_water_pollution
	self.water_pollution = Stats.water_pollution
	self.max_air_pollution = Stats.max_air_pollution
	self.air_pollution = Stats.air_pollution
	self.max_contamination = Stats.max_contamination
	self.contamination = Stats.contamination
	self.max_level_progress = Stats.max_level_progress
	self.level_progress = Stats.level_progress
	Stats.connect("water_pollution_changed", self, "set_water_pollution")
	Stats.connect("air_pollution_changed", self, "set_air_pollution")
	Stats.connect("contamination_changed", self, "set_contamination")
	Stats.connect("level_progress_changed", self, "set_level_progress")
