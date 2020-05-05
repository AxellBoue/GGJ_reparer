tool 
extends Node2D

export var desactive_au_debut = false


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("visibility_changed",self,"on_visibility_changed")
	if desactive_au_debut :
		visible = false
		on_visibility_changed()

func on_visibility_changed():
	var moutons = get_children()
	for m in moutons :
		m.get_node("CollisionShape2D").disabled = !visible