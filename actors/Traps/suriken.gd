extends Node2D

@onready var parent = get_parent() as PathFollow2D
@export var speed = 200

func _ready() -> void:
	$TrapAnimation.play("suriken_spin")
	parent.progress_ratio = randf()

func _process(delta: float) -> void:
	if parent is PathFollow2D:
		parent.set_progress(parent.get_progress() + speed * delta)


func _on_body_entered(body: Node2D) -> void:
	Main.change_health(-2)
