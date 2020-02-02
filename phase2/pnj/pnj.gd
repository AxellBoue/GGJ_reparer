extends Node2D

export var groupe = "ecolo"
onready var icone_mouton = preload("res://phase2/images/icones/logomouton.png")
onready var icone_poireau = preload("res://phase2/images/icones/logopoireau.png")
onready var icone_feu = preload("res://phase2/images/icones/logofeu.png")
onready var icone_tenta = preload("res://phase2/images/icones/logotentacule.png")

export (AudioStream) var son_parle
onready var sound_manager = get_node("/root/Node2D/phase2 obligatoir/soundManager2")
onready var sound_player = get_node("AudioStreamPlayer2D")

onready var memory = get_node("/root/Node2D/phase2 obligatoir/memory")

onready var zone_capte_joueur = get_node("Area2D")
onready var feedback = get_node("feedback")
onready var bulle = get_node("bulle")
var joueur_proche = false

var selected = false
var a_reussi = false


# Called when the node enters the scene tree for the first time.
func _ready():
	zone_capte_joueur.connect("body_entered",self,"on_body_entered")
	zone_capte_joueur.connect("body_exited",self,"on_body_exited")
	feedback.visible = false
	bulle.visible = false
	
	if groupe == "bla" :
		bulle.get_node("iconeBulle").texture = icone_mouton
	elif groupe == "ecolo" :
		bulle.get_node("iconeBulle").texture = icone_poireau
	elif groupe == "feu" :
		bulle.get_node("iconeBulle").texture = icone_feu
	elif groupe == "tentacule" :
		bulle.get_node("iconeBulle").texture = icone_tenta


func _input(event):
	if event.is_action_pressed("tir") && joueur_proche:
		change_bulle()


func change_bulle():
	if bulle.visible == true :
		bulle.visible = false
		unselect()
		memory.remove_pnj()
	else :
		bulle.visible = true
		sound_manager.play(son_parle,sound_player)
		selected = memory.add_pnj(self)
	feedback.visible = !bulle.visible


func unselect():
	selected = false
	bulle.visible = false


func on_body_entered(body):
	if body.name == "player" :
		if !a_reussi:
			joueur_proche = true
			if !selected:
				feedback.visible = true


func on_body_exited(body):
	if body.name == "player":
		if !a_reussi:
			joueur_proche = false
			feedback.visible = false
			if !selected:
				bulle.visible = false


func reussi():
	a_reussi = true
	joueur_proche = false

