extends Node2D

var position_perso = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("Pause") :
		position_perso = Vector2(4700,4000)
		get_tree().reload_current_scene()
