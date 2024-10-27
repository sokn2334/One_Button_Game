extends Node

signal shake_triggered(strength:float, fade:float)


func trigger_shake(strength:float, fade:float):
	shake_triggered.emit(strength, fade)
