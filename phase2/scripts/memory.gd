extends Node2D

var pnj_selected : Array = []

onready var sound_manager = get_node("/root/Node2D/phase2 obligatoir/soundManager2")
onready var player = get_node("AudioStreamPlayer")
var son_reussi = preload("res://phase2/sons/son réussite final.wav")

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
			print ("reussi")
			sound_manager.play(son_reussi,player)
			for p in pnj_selected:
				p.reussi()
			pnj_selected = []
			return true
		else :
			remove_pnj()
			print ("raté")
			return false
		
func remove_pnj():
	for p in pnj_selected:
		p.unselect()
	pnj_selected = []
