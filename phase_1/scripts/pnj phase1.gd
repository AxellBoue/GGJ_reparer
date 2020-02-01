extends KinematicBody2D

export (NodePath) var path_path
var etapes : Array
var target
var i = 0

export var vitesse = 200
var direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	etapes = get_node(path_path).get_children()
	target = etapes[i]

func _physics_process(delta):
	move_and_slide(direction * vitesse)
	if (global_position - target.global_position).length() <= 10:
		change_target()


func change_target():
	i += 1
	if i >= etapes.size():
		i = 0
	target = etapes[i]
	direction = (global_position - target.global_position).normalized()