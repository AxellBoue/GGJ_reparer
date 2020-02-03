extends Node2D

var actif = true
onready var viseur = get_node("../viseur")
var pansement = preload("res://phase_1/objets/pansement.tscn")
var faille = null

onready var flingue = get_node("../Camera2D/flingue")

onready var chute_cadre = get_node("../chute cadre")

onready var soundManager = get_node("../sound manager")
onready var sonShoot = preload("res://phase_1/sons/SHOTGUN.wav")
onready var playerShoot = get_node("playerShoot")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if actif:
		viseur.global_position = get_global_mouse_position()


func _input(event):
	if event.is_action_pressed("tir"):
		cree_pansement()
		soundManager.play_random_pitch(sonShoot,playerShoot)
		chute_cadre.stop_chute()


func cree_pansement():
	var new_p =  pansement.instance()
	new_p.failleOuFeu = faille
	get_node("/root/Node2D").add_child(new_p)
	new_p.global_position = flingue.global_position
	new_p.init(get_global_mouse_position())