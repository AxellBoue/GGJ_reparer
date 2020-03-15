extends KinematicBody2D

# mouvement
onready var nav = get_node("../")
var target 
var chemin = []
var direction
export var vitesse = 600
onready var anim = get_node("pnjcarre/AnimatedSprite")
#aller
var va_vers_player = false
var target_is_player = false
onready var player = get_node("/root/Node2D/phase2 obligatoir/player")
# retour
var retour = false
var attends_player = false
onready var target_retour = get_node("../lieu retour")
export var distance_arret_pour_attendre = 1100
export var distance_repart = 400

# entre les deux
onready var timer_retour = get_node("Timer retour")
var etape = 0

# fin
onready var groupe_pnj_boss = get_node("/root/Node2D/level 2/groupe pnj boss")


# Called when the node enters the scene tree for the first time.
func _ready():
	timer_retour.connect("timeout",self,"action_avant_retour")
	timer_retour.wait_time = 0.5

func _input(event):
	if Input.is_action_pressed("trie Y"):
		pop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#si il est loin du personnage : suit le path : qui change pas si le personnage bouge
	# ou si retour : sui le path vers le lieu de retour, si le personnage est pas trop loin
	if (va_vers_player && !target_is_player) || (retour && !attends_player):
		direction = ( target - global_position ).normalized()
		move_and_slide(direction * vitesse)
		set_flip()
		z_index = global_position.y/3
		if retour && (player.global_position - global_position).length() > distance_arret_pour_attendre:
			attends_player = true
			anim.play("idle")
		if (target - global_position).length() <= 10:
			change_target()
		if retour && (target_retour.global_position - global_position).length() <= 50:
			end_retour()
	#si il est pres : target = player, ça le suit si il bouge
	elif (va_vers_player && target_is_player):
		direction = ( player.global_position - global_position ).normalized()
		move_and_slide(direction * vitesse)
		set_flip()
		z_index = global_position.y/3
		if (player.global_position - global_position).length() <= 250:
			trouve_player()
	# pendant phase retour, si attends le player et qu'il se rapproche : repart
	elif attends_player && (player.global_position - global_position).length() < distance_repart :
		attends_player = false
		anim.play("marche")
		update_path()
		


func set_flip():
	if direction.x > 0 :
		anim.flip_h = false
	else :
		anim.flip_h = true

func update_path():
	if !retour :
		chemin = nav.get_simple_path(global_position,player.global_position)
	else :
		chemin = nav.get_simple_path(global_position,target_retour.global_position)
	chemin.remove(0)
	if chemin.size() > 1 && (chemin[0] - global_position).length()<=12:
		chemin.remove(0)
	if chemin.size() > 1:
		target = chemin[0]
		target_is_player = false
	else :
		if !retour:
			target = player.global_position
			target_is_player = true
		else:
			target = target_retour.global_position
			
			
func change_target():
	update_path()
	
# premiere partie
func pop():
	update_path()
	va_vers_player = true
	anim.play("marche")


func trouve_player():
	va_vers_player = false
	timer_retour.start()
	anim.play("idle")


# avec pnj
func action_avant_retour():
	if etape == 1 :
		get_node("bulle").visible = true
		groupe_pnj_boss.visible = true
	elif etape == 2 :
		player.affiche_bulle()
	elif etape == 8 :
		start_retour()
		timer_retour.stop()
	etape += 1


# retour
func start_retour():
	target = target_retour.global_position
	retour = true
	anim.play("marche")
	update_path()

func end_retour():
	retour = false
	anim.play("idle")
	timer_retour.disconnect("timeout",self,"action_avant_retour")
	timer_retour.connect("timeout",self,"affiche_fin")
	timer_retour.wait_time = 5
	timer_retour.one_shot = true
	timer_retour.start()

func affiche_fin():
	get_node("/root/Node2D/CanvasLayer/Control/illu fin").visible = true
