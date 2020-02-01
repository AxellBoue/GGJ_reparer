extends KinematicBody2D

export var numPath = 1
var etapes : Array
var target
var i = 0

export var vitesse = 500
var direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	if numPath == 1:
		etapes = get_node("../pnjPath1").get_children()
	target = etapes[i]
	

func _physics_process(delta):
	direction = -(global_position - target.global_position).normalized()
	move_and_slide(direction * vitesse)
	if (global_position - target.global_position).length() <= 50:
		change_target()


func change_target():
	i += 1
	if i >= etapes.size():
		i = 0
	target = etapes[i]