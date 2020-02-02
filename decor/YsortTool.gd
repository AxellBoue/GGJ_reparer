tool
extends Node2D


export var do_Ysort = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sort()


func _input(event):
	if event.is_action_pressed("trie Y"):
		sort()


func sort():
	var noeuds = get_tree().get_nodes_in_group("Ysort")
	for n in noeuds:
		n.z_as_relative = false
		n.z_index = n.global_position.y/3