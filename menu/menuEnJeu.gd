extends VBoxContainer
var anim

# Called when the node enters the scene tree for the first time.
func _ready():
	cache()
	anim = get_node("../AnimationPlayer")
	anim.connect("animation_finished",self,"fin_anim")

func active_desactive():
	if !get_parent().visible:
		affiche()
	else:
		anim_cache()

func affiche():
	get_parent().visible = true
	get_tree().paused = true
	anim.play("coin ouverture")
	
func cache():
	get_parent().visible = false
	get_tree().paused = false
	
func anim_cache():
	anim.play("coin fermeture")
	
func fin_anim(anim):
	if anim == "coin fermeture":
		cache()
	
func retour_au_jeu():
	anim_cache()
	
func retour_au_menu():
	cache()
	get_tree().change_scene("res://menu/menu.tscn")
	
func quitter():
	get_tree().quit()
	
