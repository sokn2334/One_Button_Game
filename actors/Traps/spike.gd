extends Area2D


func _ready() -> void:
	play_spike()

func play_spike():
	$AnimationPlayer.play("spike_on")
	$AudioStreamPlayer2D.play()
	$SpikeOnTimer.start()

func _on_spike_on_timer_timeout() -> void:
	$AnimationPlayer.play("spike_off")
	$AudioStreamPlayer2D.play()
	$SpikeOffTimer.start()
	
func _on_spike_off_timer_timeout() -> void:
	play_spike()

func _on_body_entered(body: Node2D) -> void:
	Main.change_health(-1)
