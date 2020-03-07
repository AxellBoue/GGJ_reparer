extends KinematicBody2D

var target 
var chemin = []
var direction
export var vitesse = 600
var va_vers_player = false

onready var pop_zone_haut 
onready var player = get_node("/root/Node2D/phase2 obligatoir/player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_pressed("trie Y"):
		pop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (va_vers_player):
		direction = ( target.global_position - global_position ).normalized()
		move_and_slide(direction * vitesse)
		z_index = global_position.y/3
		if (target.global_position - global_position).length() <= 150:
			va_vers_player = false


func pop():
	global_position = player.global_position + Vector2(0,-800)
	target = player
	va_vers_player = true
	