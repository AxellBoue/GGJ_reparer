extends Node2D

onready var pnj1 = get_node("pnj feu 1")
onready var pnj2 = get_node("pnj feu 2")

# Called when the node enters the scene tree for the first time.
func _ready():
	vire_pnj()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func vire_pnj():
	pnj1.visible = false
	pnj2.visible = false
	pnj1.get_node("CollisionShape2D").disabled = true
	pnj2.get_node("CollisionShape2D").disabled = true	