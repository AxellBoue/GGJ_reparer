extends Node2D

onready var area = get_node("Area start paire")

onready var pnj1 = get_node("pnj feu 1")
onready var pnj2 = get_node("pnj feu 2")
onready var pnj_feu_fin = get_node("pnj pompiers fin")

onready var destination = pnj1.get_node("destination pnj2")
var pnj_bouge = false
export var vitesse = 400

var pnj_bouge_2 = false
onready var destination1 = pnj_feu_fin.get_node("destination1")
onready var destination2 = pnj_feu_fin.get_node("destination2")

onready var timer = get_node("Timer")
var t = 0 
var wait_time_1 = 0.5



# Called when the node enters the scene tree for the first time.
func _ready():
	area.get_node("CollisionPolygon2D").disabled = true
	area.connect("body_entered",self,"on_body_entered")
	timer.connect("timeout",self,"pnj_parlent")
	timer.wait_time = wait_time_1
	
	pnj_feu_fin.visible = false
	pnj1.get_node("bulle").visible = false
	pnj2.get_node("bulle").visible = false


func _physics_process(delta):
	if pnj_bouge :
		var mouvement = destination.global_position - pnj2.global_position
		if mouvement.length() >= 10 :
			mouvement = mouvement.normalized() * vitesse
			pnj2.move_and_slide(mouvement) 
		else :
			pnj_bouge = false
			timer.start()
			
	if pnj_bouge_2:
		var mouvement1 = destination1.global_position - pnj1.global_position
		if mouvement1.length() >= 5 :
			mouvement1 = mouvement1.normalized() * vitesse
			pnj1.move_and_slide(mouvement1) 
		
		var mouvement2 = destination2.global_position - pnj2.global_position
		if mouvement2.length() >= 5 :
			mouvement2 = mouvement2.normalized() * vitesse
			pnj2.move_and_slide(mouvement2) 
		else :
			pnj_bouge_2 = false
			affiche_pnj_fin()


func on_body_entered(body):
	if body.name == "player":
		start_anim_pnj()

func active_collision():
	area.get_node("CollisionPolygon2D").disabled = false

func start_anim_pnj():
	pnj_bouge = true
	area.queue_free()


func pnj_parlent():
	if t == 0 :
		pnj2.get_node("bulle").visible = true
		timer.start()
	elif t == 1 :
		pnj1.get_node("bulle").visible = true
		timer.start()
	elif t == 2 :
		pnj_bouge_2 = true
	t += 1


func affiche_pnj_fin():
	pnj1.visible = false
	pnj2.visible = false
	pnj1.get_node("CollisionShape2D").disabled = true
	pnj2.get_node("CollisionShape2D").disabled = true
	pnj_feu_fin.visible = true