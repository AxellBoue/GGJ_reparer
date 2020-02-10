extends Node2D

var pnj_selected : Array = []

onready var sound_manager = get_node("/root/Node2D/phase2 obligatoir/soundManager2")
onready var player = get_node("AudioStreamPlayer")
var son_reussi = preload("res://phase2/sons/son reussite final.wav")
var son_rate = preload("res://phase2/sons/son echec - 01_02_2020 22.10.wav")

var pairesEues = 0
var pairesTotal = 3
onready var timer = get_node("Timer")

var paire = " "
var pnj_trouves
onready var mouton_fin
onready var poireau_fin = get_node("/root/Node2D/level 2/poireau_fin")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"affiche_victoire_paire")
	timer.wait_time = 6
	timer.one_shot = true
	
	poireau_fin.visible = false

func add_pnj(pnj):
	if pnj_selected.size() == 0 :
		pnj_selected.append(pnj)
		return true
	elif pnj_selected.size() == 1 :
		if pnj_selected[0].groupe == pnj.groupe:
			pnj_selected.append(pnj)
			reussi_paire()
			for p in pnj_selected:
				p.reussi()
			pnj_selected = []
			return true
		else :
			remove_pnj()
			sound_manager.play(son_rate,player)
			pnj.anim_bulle.play("bulle echec")
			return false
		
func remove_pnj():
	for p in pnj_selected:
		p.unselect()
	pnj_selected = []
	
	
func reussi_paire():
	sound_manager.play(son_reussi,player)
	pairesEues += 1
	pnj_selected[0].vient_voir_son_pote(pnj_selected[1].lieu_pote_vient.global_position,pnj_selected[1].lieu_pop_pote)
	paire = pnj_selected[0].groupe
	pnj_trouves = pnj_selected
	timer.start()
	if pairesEues >= pairesTotal :
		fin()

func affiche_victoire_paire():
	if paire == "poireau":
		pnj_trouves[1].queue_free()
		pnj_trouves[0].queue_free()
		poireau_fin.visible = true
		

func fin():
	pass