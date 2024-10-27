extends Node2D

signal health_updated
signal game_started
signal game_end
signal you_win
signal scene_changed

var is_game_started:bool = false
var current_health: int = 6
var current_level:int = 0
var num_try:int = 0

#@onready var ui: CanvasLayer = get_tree().current_scene.get_node("HUD")
@onready var background = get_tree().current_scene.get_node("Background")
@onready var player = get_tree().current_scene.get_node("Player")
@onready	 var scene_transition:AnimationPlayer = get_tree().current_scene.get_node("Player/Camera2D/AnimationPlayer")


func _ready() -> void:
	scene_transition = get_tree().current_scene.get_node("Player/Camera2D/AnimationPlayer")
	if get_tree().current_scene.get_name() == "main":
		current_level = 0
	if get_tree().current_scene.get_name() == "level1":
		get_tree().current_scene.get_node("Player/Camera2D/ColorRect").color.a = 255
		current_level = 1
		scene_transition.play("fade_out")
	
	if current_level == 0 and num_try == 0:
		get_tree().paused = true
	else:
		get_tree().paused = false
	player.modulate = Color(2, 4, 2) #Green
	
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action") and is_game_started == false and num_try == 0:
		game_started.emit()
		is_game_started = true
		get_tree().paused = false

func change_health(num: int):
	scene_transition = get_tree().current_scene.get_node("Player/Camera2D/AnimationPlayer")
	current_health += num
	if current_health <= 0:
		scene_transition.play("fade_in")
		get_tree().paused = true
		await get_tree().create_timer(1).timeout
		num_try += 1
		game_end.emit()

	health_updated.emit(current_health)
	
func reset_health():
	current_health = 6
	health_updated.emit(current_health)

func change_scene():
	current_level += 1
	scene_transition.play("fade_in")
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	var current_level_name = "res://level" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file.bind(current_level_name).call_deferred()
	scene_changed.emit(current_level)
	reset_health()

func win():
	you_win.emit()

func get_scene() -> int:
	return current_level

func get_num_try() -> int:
	return num_try
	
