extends Camera2D

@export var shake_strength: float = 30.0
@export var fade_rate: float = 5.0

var rng = RandomNumberGenerator.new()
var current_strength :float = 0.0

func _ready():
	ShakeBus.shake_triggered.connect(do_shake)

func _process(delta: float) -> void:
	if(current_strength > 0):
		current_strength = lerp(current_strength, 0.0, fade_rate * delta)
		offset = Vector2(rng.randf_range(-current_strength, current_strength), rng.randf_range(-current_strength, current_strength))
	
func do_shake(shake_strength:float, fade:float):
	current_strength = shake_strength
	fade_rate = fade
