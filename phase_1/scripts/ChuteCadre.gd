extends Node2D

var temps = 0
export var tempsChute = 20
export var vitesseChute = 1.5
export var tempsAvantDebutDeChute = 4
export var vitesseRetressissement = 0.02
export var proportionInterieur = 2.7

export var remonteQuandTir = 5

var tempsChute2 = 1.5
var vitesseRetressissement2 = 15

var is_chute = true
var is_chute_phase_2 = false

onready var cadre = get_node("../Camera2D/cadre")
onready var cadre_bord = cadre.get_node("bord")
onready var son_chute = preload("res://phase_1/sons/CADRE FINAL2.wav")
var son_joue = false

var taille_debut

# Called when the node enters the scene tree for the first time.
func _ready():
	taille_debut = cadre.scale
	temps = -tempsAvantDebutDeChute
	tempsChute2 += tempsChute

func _physics_process(delta):
	if is_chute:
		if temps <= tempsChute:
			temps += delta * vitesseChute
			if temps > 0 :
				update_cadre()
		if temps > tempsChute:
			is_chute_phase_2 = true
	
	if is_chute_phase_2 :
		if temps <= tempsChute2:
			temps += delta * vitesseChute
			update_cadre_2()
			if temps > tempsChute2 - 0.25 && son_joue == false:
				son_joue = true
				get_node("../sound manager").play(son_chute,get_node("AudioStreamPlayer"))
		else :
			get_node("/root/singleton").position_perso = get_node("../player").global_position
			get_tree().change_scene("res://phase2/phase2 main.tscn")


func update_cadre():
	cadre.scale = Vector2(taille_debut.x,taille_debut.y - vitesseRetressissement * temps)
	cadre_bord.position = Vector2(0,temps * proportionInterieur )

func update_cadre_2():
	cadre.scale = Vector2(taille_debut.x - vitesseRetressissement * (temps - tempsChute),taille_debut.y - vitesseRetressissement * temps)
	cadre.position += Vector2(0,vitesseRetressissement2)


func stop_chute():
	if !is_chute_phase_2 :
		temps = clamp(temps - remonteQuandTir,0,tempsChute)
		update_cadre()
		if temps == 0:
			temps= - tempsAvantDebutDeChute



