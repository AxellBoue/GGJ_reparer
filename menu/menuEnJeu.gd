extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	cache()

func active_desactive():
	if !get_parent().visible:
		affiche()
	else:
		cache()

func affiche():
	get_parent().visible = true
	get_tree().paused = true
	
func cache():
	get_parent().visible = false
	get_tree().paused = false
	
func retour_au_jeu():
	cache()
	
func retour_au_menu():
	cache()
	get_tree().change_scene("res://menu/menu.tscn")
	
func quitter():
	get_tree().quit()
	
