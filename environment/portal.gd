extends Area2D

@onready var level = Main.get_scene()

func _ready() -> void:
	$AnimationPlayer.play("spin")

func _on_body_entered(body: Node2D) -> void:
	level = Main.get_scene()
	$AudioStreamPlayer.play()
	if level == 1:
		Main.win()
	else:
		Main.call_deferred("change_scene")
