extends Area2D

var exited_body = false

func hurt():
	Main.change_health(-2)
	$Hurt.start()

func _on_body_entered(body: Node2D) -> void:
	hurt()

func _on_hurt_timeout() -> void:
	if exited_body == false:
		hurt()

func _on_body_exited(body: Node2D) -> void:
	exited_body = true
	pass # Replace with function body.
