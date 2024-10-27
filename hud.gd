extends CanvasLayer

@onready var start_of_game_screen = $StartScreen
@onready var end_of_game_screen = $EndScreen
@onready var win_screen = $WinScreen
@onready var heart_icon = $HealthUi

@onready var current_level = Main.get_scene()
@onready var num_try = Main.get_num_try()
var current_health:int = 6
var is_game_ended = false

func _ready() -> void:
	Main.health_updated.connect(update_hearts)
	Main.game_started.connect(start_game)
	Main.game_end.connect(end_game)
	Main.scene_changed.connect(change_level)
	Main.you_win.connect(winner)
	if current_level == 0 and !is_game_ended and num_try == 0:
		start_of_game_screen.visible = true
	else:
		start_of_game_screen.visible = false
		get_tree().paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action") and is_game_ended == true:
		is_game_ended = false
		get_tree().paused = false
		get_tree().reload_current_scene()

func start_game():
	start_of_game_screen.visible = false
	
func change_level(level_change: int):
	current_level = level_change
	
func end_game():
	get_tree().paused = true
	end_of_game_screen.visible = true
	is_game_ended = true
	$EndScreen/Score.text = str(current_level)
	Main.reset_health()
	
func winner():
	num_try = Main.get_num_try()
	win_screen.visible = true
	$WinScreen/Tries.text = str(current_level)
	get_tree().paused = true
	Main.get_num_try()

func update_hearts(num: int):
	current_health = num
	match current_health:
		6: 
			flash()
			heart_icon.set_frame(0)
		5: 
			flash()
			heart_icon.set_frame(1)
		4: 
			flash()
			heart_icon.set_frame(2)
		3: 
			flash()
			heart_icon.set_frame(3)
		2: 
			flash()
			heart_icon.set_frame(4)
		1: 
			flash()
			heart_icon.set_frame(5)
		0: 
			flash()
			heart_icon.set_frame(6)
	
func flash():
	heart_icon.set_modulate(Color(0,0,0))
	$Flash.start()
	
func _on_flash_timeout() -> void:
	heart_icon.set_modulate(Color(1,1,1))
