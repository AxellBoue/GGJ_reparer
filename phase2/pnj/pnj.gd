extends Node2D

export var groupe = "ecolo"
onready var memory = get_node("")

onready var zone_capte_joueur = get_node("Area2D")
onready var feedback = get_node("feedback")
onready var bulle = get_node("bulle")
var joueur_proche = false

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# relie l'area 2D aux fonctions qui enregistrent si le personnage est assez proche pour interragir
	zone_capte_joueur.connect("body_entered",self,"on_body_entered")
	zone_capte_joueur.connect("body_exited",self,"on_body_exited")
	# cache le texte et le feedback au depart
	feedback.visible = false
	bulle.visible = false

# capte quand on appuie sur espace (l'action "ui accept"  est reliée à espace par default
# pour créer vos propres actions aller dans projet - paramettre du projet - controles
# et si on est proche, appelle change_texte()
func _input(event):
	if event.is_action_pressed("tir") && joueur_proche:
		change_bulle()

func change_bulle():
	bulle.visible = !bulle.visible
	feedback.visible = !bulle.visible
	if selected :
		selected = false
		#memory.remove_pnj()
	else :
		pass
		#selected = memory.add_pnj(self)
	
#quand le.a joueur.se entre dans la zone, affiche le feedback et enregitre que le.a joueurse est la
func on_body_entered(body):
	if body.name == "player":
		joueur_proche = true
		feedback.visible = true
		
#quand le.a joueur.se sort de la zone, cache le feedback et le texte, et réinitialise le compteur de texte
func on_body_exited(body):
	if body.name == "player":
		joueur_proche = false
		feedback.visible = false
		if !selected:
			bulle.visible = false
		
