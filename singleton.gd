extends Node2D

var position_perso = Vector2(4700,4000)
var cocardes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("Pause") :
		#position_perso = Vector2(4700,4000)
		#get_tree().reload_current_scene()
		var menu = get_tree().get_nodes_in_group("menu")
		if menu.size() > 0:
			menu[0].active_desactive()
