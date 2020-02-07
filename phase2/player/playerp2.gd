extends KinematicBody2D

export var vitesse = 200
var mouvement
onready var anim = get_node("AnimatedSprite")
var is_bloque = false

var transition_terminee = false
onready var camera = get_node("../Camera2D")
export var dezoom_max = 3.5
export var vitesse_dezoom = 4
export var zoom_normal = 1.8
export var vitesse_rezoom = 10
export var temps_debut_dezoom = 4
var t = 0
var dezoom = false

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = global_position.y/3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	mouvement = Vector2(0,0)
	if !is_bloque :
		if Input.is_action_pressed("haut"):
			mouvement.y -= 1
		if Input.is_action_pressed("bas"):
			mouvement.y += 1
		if Input.is_action_pressed("droite"):
			mouvement.x += 1
			anim.flip_h = false
		if Input.is_action_pressed("gauche"):
			mouvement.x -= 1
			anim.flip_h = true
		mouvement = mouvement.normalized()
		mouvement = move_and_slide(mouvement*vitesse)
		if mouvement == Vector2(0,0) :
			anim.play("idle")
			t += delta
			if t > temps_debut_dezoom && transition_terminee && !dezoom:
				dezoom = true
				camera.change_zoom(dezoom_max,vitesse_dezoom)
		else :
			anim.play("marche")
			if dezoom:
				dezoom = false
				t = 0
				camera.change_zoom(zoom_normal,vitesse_rezoom)
			z_index = global_position.y/3

