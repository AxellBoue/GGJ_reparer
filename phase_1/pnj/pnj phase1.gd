extends KinematicBody2D

# bouge
export var numPath = 1
var etapes : Array
var target_path
var i = 0

export var vitesse = 500
var direction = Vector2(0,0)

#lance pansement
var cibles_pansement_faille1
var cibles_pansement_faille2
var current_faille = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if numPath == 1:
		etapes = get_node("../pnjPath1").get_children()
	elif numPath == 2:
		etapes = get_node("../pnjPath2").get_children()
	target_path = etapes[i]
	

func _physics_process(delta):
	direction = -(global_position - target_path.global_position).normalized()
	move_and_slide(direction * vitesse)
	z_index = global_position.y/3
	if (global_position - target_path.global_position).length() <= 50:
		change_target()


func change_target():
	i += 1
	if i >= etapes.size():
		i = 0
	target_path = etapes[i]