extends KinematicBody2D

export var groupe = "ecolo"
onready var icone_mouton = preload("res://phase2/images/icones/logomouton.png")
onready var icone_poireau = preload("res://phase2/images/icones/logopoireau2.png")
onready var icone_feu = preload("res://phase2/images/icones/logofeu.png")
onready var icone_tenta = preload("res://phase2/images/icones/logotentacule.png")
onready var icone_pont = preload("res://phase2/images/icones/logopont.png")
var texture_icone

export (AudioStream) var son_parle
onready var sound_manager = get_node("/root/Node2D/phase2 obligatoire/soundManager2")
onready var sound_player = get_node("AudioStreamPlayer2D")

onready var memory = get_node("/root/Node2D/phase2 obligatoire/memory")

onready var zone_capte_joueur = get_node("Area2D")
onready var feedback = get_node("feedback")
onready var bulle = get_node("bulle")
var joueur_proche = false
onready var anim_bulle = get_node("bulle/AnimationPlayer")

var selected = false
var a_reussi = false

#### part 2 bouge une fois que reussi

onready var lieu_pop_pote = get_node("lieu pop pote")
onready var lieu_pote_vient = get_node("lieu_pote_vient")
var bouge = false
var target
var direction
export (float) var vitesse  = 400
onready var anim = get_node("pnj/AnimatedSprite")


# Called when the node enters the scene tree for the first time.
func _ready():
	zone_capte_joueur.connect("body_entered",self,"on_body_entered")
	zone_capte_joueur.connect("body_exited",self,"on_body_exited")
	feedback.visible = false
	bulle.visible = false
	anim.play("idle")
	
	var icone_bulle = bulle.get_node("bulle/iconeBulle")
	if groupe == "mouton" :
		icone_bulle.texture = icone_mouton
	elif groupe == "poireau" :
		icone_bulle.texture = icone_poireau
	elif groupe == "feu" :
		icone_bulle.texture = icone_feu
	elif groupe == "pont" :
		icone_bulle.texture = icone_pont
	elif groupe == "tentacule" :
		icone_bulle.texture = icone_tenta
	elif groupe == "journal" :
		pass
		#icone_bulle.texture = icone_pont
	texture_icone = icone_bulle.texture #pour la passer à la bulle dans l'ui

func _input(event):
	if event.is_action_pressed("tir") && joueur_proche:
		change_bulle()


func change_bulle():
	if bulle.visible == true :
		pass
		#bulle.visible = false
		#unselect()
		#memory.remove_pnj()
	else :
		bulle.visible = true
		anim_bulle.play("bulle normale")
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
				pass
				#bulle.visible = false


func reussi():
	a_reussi = true
	joueur_proche = false


#### part 2

func _physics_process(delta):
	if (bouge):
		direction = ( target - global_position ).normalized()
		move_and_slide(direction * vitesse)
		z_index = global_position.y/3
		if direction.x > 0:
			anim.flip_h = false
		else :
			anim.flip_h = true
		if (target - global_position).length() <= 50:
			bouge = false
			anim.play("idle")

func vient_voir_son_pote(new_target,new_position=null):
	if new_position != null:
		global_position = new_position.global_position
	target = new_target
	bouge = true
	anim.play("marche")
