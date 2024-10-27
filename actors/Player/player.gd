extends CharacterBody2D

@export var player_velocity:int = 300
@export var player_jump: int = -800
@export var gravity:int = 30

@onready var animate:AnimationPlayer = $AnimationPlayer
@onready var FX:AnimationPlayer = $FXPlayer

@export var is_jumping = false
var is_dissassembled = false
var on_ground = false

var lives:int = 6
var timer:float = 0.0

const TRAIL = preload("res://actors/Player/particle_trail.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Main.health_updated.connect(get_hit)
	var trail = TRAIL.instantiate()
	add_child(trail)
	trail.position = position
	pass # Replace with function body.

func jump():
	velocity.y = player_jump
	$Jump_LandSFX.play()

func get_hit(num:int):
	lives = num
	$Sprite2D.set_modulate(Color(1,0.1,0))
	ShakeBus.trigger_shake(20.0, 10.0)
	$Hit.start()

func _on_hit_timeout() -> void:
	$Sprite2D.set_modulate(Color(1,1,1))	

func _physics_process(delta: float) -> void:
	#Add gravity when jumping
	if !is_on_floor():
		on_ground = false
		velocity.y += gravity
		if (velocity.y > 1000):
			velocity.y = 1000
	if is_on_floor() and !is_dissassembled:
		if !on_ground: #When the player has landed
			animate.play("blue_land_right")
			is_jumping = false
			ShakeBus.trigger_shake(6.0, 5.0)
			FX.play("land_FX")
			$LnadSFX.play()
		on_ground = true

	#Move forward if currently assembled
	if !is_dissassembled:
		velocity.x = player_velocity
		if (!animate.is_playing()):
			animate.play("blue_run_right")
			
	#Start the timer when the space bar is pressed
	if Input.is_action_pressed("action") and is_on_floor(): 
		timer += delta
	
	
	#When the button is released
	if Input.is_action_just_released("action") and is_on_floor() and !is_jumping:
		if timer < 0.2 and timer > 0 and !is_dissassembled: #Jump
			animate.play("blue_jump_right")
			timer = 0
			is_jumping = true
		elif is_dissassembled: #Assemble
			animate.play("blue_assemble")
			await get_tree().create_timer(0.7).timeout
			is_dissassembled = false
			$ParticleTrail.emitting = true
			timer = 0
			
	#When player holds down the button
	if timer >= 0.2 and !is_dissassembled:
		animate.play("blue_dissassemble")
		is_dissassembled = true
		velocity.x = 0
		$ParticleTrail.emitting = false
		$DissassSFX.play()

	move_and_slide()
	pass
