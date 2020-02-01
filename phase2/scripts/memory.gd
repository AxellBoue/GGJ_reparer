extends Node2D

var pnj_selected : Array = []

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
			return true
		else :
			remove_pnj()
			print ("raté")
			return false
		
func remove_pnj():
	for p in pnj_selected:
		p.unselect()
	pnj_selected = []
