extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var FRICTION = 500

enum {
	MOVE,
	BUILD,
	TALK,
	FARM,
	DESTROY
}

var state = MOVE
var velocity = Vector2.ZERO
var input_vector

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var camera2d = $Camera2D
onready var animationState = animationTree.get("parameters/playback")
onready var stats = Stats

func _ready():
	animationTree.active = true
	stats.connect("max_water_pollution_reached", self, "_on_Stats_max_water_pollution_reached")
	stats.connect("max_air_pollution_reached", self, "_on_Stats_max_air_pollution_reached")
	stats.connect("max_contamination_reached", self, "_on_Stats_max_contamination_reached")
	stats.connect("max_level_progress_reached", self, "_on_Stats_max_level_progress_reached")

func _physics_process(delta):
	if is_network_master():
		camera2d.current = true
		match state:
			MOVE:
				move_state(delta)
			BUILD:
				build_state(delta)
			TALK:
				talk_state(delta)
			FARM:
				farm_state(delta)
			DESTROY:
				destroy_state(delta)
		rpc_unreliable("remote_move", position)
		rpc_unreliable("remote_animations", state, input_vector)
		rpc_unreliable("remote_stats", state)

func move_state(delta):
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		# velocity += input_vector * ACCELERATION * delta
		# velocity = velocity.clamped(MAX_SPEED)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("build"):
		state = BUILD
	elif Input.is_action_just_pressed("talk"):
		state = TALK
	elif Input.is_action_just_pressed("farm"):
		state = FARM
	elif Input.is_action_just_pressed("destroy"):
		state = DESTROY

func build_state(delta):
	stats.water_pollution += 1
	state = MOVE

func talk_state(delta):
	stats.air_pollution += 1
	state = MOVE
	
func farm_state(delta):
	stats.contamination += 1
	state = MOVE

func destroy_state(delta):
	stats.level_progress += 1
	state = MOVE

func _on_Stats_max_water_pollution_reached():
	print("Max water pollution reached")
	
func _on_Stats_max_air_pollution_reached():
	print("Max air pollution reached")

func _on_Stats_max_contamination_reached():
	print("Max contamination reached")

func _on_Stats_max_level_progress_reached():
	print("Max level progress reached")

remote func remote_move(pos):
	position = pos

remote func remote_animations(current_state, current_input_vector):
	if current_state == MOVE:
		if current_input_vector != Vector2.ZERO:
			animationTree.set("parameters/Idle/blend_position", current_input_vector)
			animationTree.set("parameters/Run/blend_position", current_input_vector)
			animationState.travel("Run")
		else:
			animationState.travel("Idle")
	elif current_state == BUILD:
		pass
	elif current_state == TALK:
		pass
	elif current_state == FARM:
		pass
	elif current_state == DESTROY:
		pass

remote func remote_stats(current_state):
	if current_state == BUILD:
		stats.water_pollution += 1
	elif current_state == TALK:
		stats.air_pollution += 1
	elif current_state == FARM:
		stats.contamination += 1
	elif current_state == DESTROY:
		stats.level_progress += 1
