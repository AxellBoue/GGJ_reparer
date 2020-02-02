extends Node2D

var pnj_selected : Array = []

onready var sound_manager = get_node("/root/Node2D/phase2 obligatoir/soundManager2")
onready var player = get_node("AudioStreamPlayer")
var son_reussi = preload("res://phase2/sons/son reussite final.wav")
var son_rate = preload("res://phase2/sons/son echec - 01_02_2020 22.10.wav")

var pairesEues = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
			return false
		
func remove_pnj():
	for p in pnj_selected:
		p.unselect()
	pnj_selected = []
	
func reussi_paire():
	print ("reussi")
	sound_manager.play(son_reussi,player)
	pairesEues += 1
