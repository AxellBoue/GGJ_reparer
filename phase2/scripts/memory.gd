extends Node2D

var pnj_selected : Array = []

onready var sound_manager = get_node("/root/Node2D/phase2 obligatoir/soundManager2")
onready var player = get_node("AudioStreamPlayer")
var son_reussi = preload("res://phase2/sons/son reussite final.wav")
var son_rate = preload("res://phase2/sons/son echec - 01_02_2020 22.10.wav")
onready var timer_feedback = get_node("Timer feedback")
var is_bonne_paire

onready var bulles_ui = get_node("/root/Node2D/CanvasLayer/Control/bulles ui container")

#fin
var pairesEues = 0
var pairesTotal = 3
onready var lieu_pop_fin = get_node("/root/Node2D/phase2 obligatoir/pop fin")
onready var timer_fin = get_node("Timer fin")

#paires eues
var paire = " "
var pnj_trouves
onready var timer_effet_paires = get_node("Timer effet paire")
onready var timer_retour_paires = get_node("Timer retour effet paire")
export var temps_affiche_effet_paires = 4
onready var anim_noir = get_node("/root/Node2D/CanvasLayer/Control/AnimationPlayer")
onready var camera = get_node("../Camera2D")
onready var perso = get_node("../player")

onready var mouton_fin = get_node("/root/Node2D/level 2/mouton_fin")
onready var poireau_fin = get_node("/root/Node2D/level 2/poireau_fin")
onready var journal_fin = get_node("/root/Node2D/level 2/journal_fin")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_feedback.connect("timeout",self,"play_retard")
	timer_feedback.one_shot = true
	
	timer_effet_paires.connect("timeout",self,"affiche_victoire_paire")
	timer_effet_paires.wait_time = 6.5
	timer_effet_paires.one_shot = true
	
	timer_retour_paires.connect("timeout",self,"retour_effet_paires")
	timer_retour_paires.wait_time = temps_affiche_effet_paires
	timer_retour_paires.one_shot = true
	
	timer_fin.connect("timeout",self,"fin")
	timer_fin.wait_time = 9.5
	timer_fin.one_shot = true
	
	poireau_fin.visible = false
	mouton_fin.get_node("moutons").visible = false
	mouton_fin.visible = false
	

func add_pnj(pnj):
	if pnj_selected.size() == 0 :
		pnj_selected.append(pnj)
		bulles_ui.premiere_bulle(pnj.texture_icone)
		return true
	elif pnj_selected.size() == 1 :
		bulles_ui.deuxieme_bulle(pnj.texture_icone)
		if pnj_selected[0].groupe == pnj.groupe:
			pnj_selected.append(pnj)
			reussi_paire()
			for p in pnj_selected:
				p.reussi()
				pnj_selected = []
			return true
		else :
			remove_pnj()
			rate_paire(pnj)
			return false
		
func remove_pnj():
	for p in pnj_selected:
		p.unselect()
	pnj_selected = []
	

func rate_paire(pnj):
	pnj.anim_bulle.play("bulle echec")
	is_bonne_paire = false
	timer_feedback.wait_time = 0.9
	timer_feedback.start()


func reussi_paire():
	is_bonne_paire = true
	timer_feedback.wait_time = 0.3
	timer_feedback.start()
	pairesEues += 1
	
	pnj_selected[0].vient_voir_son_pote(pnj_selected[1].lieu_pote_vient.global_position,pnj_selected[1].lieu_pop_pote)
	paire = pnj_selected[0].groupe
	pnj_trouves = pnj_selected
	if paire == "journal":
		timer_effet_paires.wait_time = 3.5
	else :
		timer_effet_paires.wait_time = 6.5
	timer_effet_paires.start()
	
	if pairesEues >= pairesTotal :
		timer_fin.start()


func play_retard():
	if is_bonne_paire :
		sound_manager.play(son_reussi,player)
		bulles_ui.reussi()
	else :
		sound_manager.play(son_rate,player)
		bulles_ui.rate()


func affiche_victoire_paire():
	perso.is_bloque = true
	anim_noir.play("fondu noir")
	if paire == "poireau":
		pnj_trouves[1].queue_free()
		pnj_trouves[0].queue_free()
		poireau_fin.visible = true
		camera.change_target(poireau_fin)
	elif paire == "mouton":
		pnj_trouves[1].queue_free()
		pnj_trouves[0].queue_free()
		mouton_fin.visible = true
		mouton_fin.get_node("moutons").visible = true
		get_node("/root/Node2D/level 2/zone moutons/crevasse moutons/tentacule1/moutonidle2").visible = false
		get_node("/root/Node2D/level 2/zone moutons/crevasse moutons/tentacule6/moutonidle").visible = false
		get_node("/root/Node2D/level 2/zone moutons/moutons").visible = false
		camera.change_target(mouton_fin.get_node("target camera"))
		timer_retour_paires.wait_time += 1 #parce qu'elle est moins compréhensiblle vite que celle du poireau avec les tentacules
	elif paire == "journal":
		pnj_trouves[1].queue_free()
		pnj_trouves[0].queue_free()
		journal_fin.visible = true
		camera.change_target(journal_fin)
	timer_retour_paires.start()

func retour_effet_paires():
	anim_noir.play("fondu noir")
	camera.stop_change_target()
	perso.fin_anim_paire_eue()
	

func fin():
	get_node("/root/Node2D/level 2/navigation pnj fin/Navigation2D/pnj fin").pop()