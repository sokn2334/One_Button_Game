extends CPUParticles2D

func _ready() -> void:
	emitting = true
	#finished.connect(clean_up)

func clean_up():
	queue_free()
