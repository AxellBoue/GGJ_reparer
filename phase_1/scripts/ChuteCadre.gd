extends Node2D

var temps = 0
export var tempsChute = 15
export var vitesseChute = 1
export var tempsAvantDebutDeChute = 3
export var vitesseRetressissement = 0.01
export var proportionInterieur = 2

var is_chute = true

onready var cadre = get_node("../Camera2D/cadre")
onready var cadre_bord = cadre.get_node("bord")
var taille_debut

# Called when the node enters the scene tree for the first time.
func _ready():
	taille_debut = cadre.scale
	temps = -tempsAvantDebutDeChute

func _physics_process(delta):
	if is_chute:
		if temps <= tempsChute:
			temps += delta * vitesseChute
			if temps > 0 :
				update_cadre()

func update_cadre():
	cadre.scale = Vector2(taille_debut.x,taille_debut.y - vitesseRetressissement * temps)
	cadre_bord.position = Vector2(0,temps * proportionInterieur )
	
func stop_chute():
	temps = 0
	update_cadre()
	temps= - tempsAvantDebutDeChute