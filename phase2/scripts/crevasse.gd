extends Node2D

export var crevasse_mouton = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if !crevasse_mouton :
		get_node("crevasseanim").play("tentacule7")
	else :
		get_node("crevasseanim").play("crevasse mouton")
		

