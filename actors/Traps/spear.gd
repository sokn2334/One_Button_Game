extends Area2D

@onready var level = Main.get_scene()

func _ready() -> void:
	spike()

func spike():
	level = Main.get_scene()
	$AnimationPlayer.play("spike_out")
	$AudioStreamPlayer2D.play()
	if level == 1:
		$SpikeOn.set_wait_time(2)
	$SpikeOn.start()

func _on_spike_on_timeout() -> void:
	$AnimationPlayer.play("spike_in")
	$AudioStreamPlayer2D.play()
	if level == 1:
		$SpikeOff.set_wait_time(3)
	$SpikeOff.start()

func _on_spike_off_timeout() -> void:
	spike()


func _on_body_entered(body: Node2D) -> void:
	Main.change_health(-6)
