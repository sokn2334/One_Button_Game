extends Line2D

var point_queue: Array
@export var max_length: int = 10

func _process(delta: float) -> void:
	var pos = get_parent().global_position

	point_queue.push_front(pos)
	
	if (point_queue.size() > max_length):
		point_queue.pop_back()	
	clear_points()
	
	for p in point_queue:
		add_point(p)
	pass

#var tween
#func run_tween():
	#if tween: tween.kill()
	
	#tween = create_tween()
	#tween.tween_property(self, "position", Vector2(100, -100), 1).set_trans(Tween.TRANS_ELASTIC)
	#tween.tween_property(self, "position", Vector2(0, 0), 1)
	
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"): run_tween()
