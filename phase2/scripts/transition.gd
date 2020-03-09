extends Node2D

onready var player = get_node("../player") 
onready var player_anim = player.get_node("AnimatedSprite")
onready var timer = get_node("Timer")
onready var camera = get_node("../Camera2D")
export var duree_noir = 0.8
export var duree_avant_dezoom = 0.8
export var duree_gun = 3
export var duree_avant_rezoom = 3
export var duree_avant_peut_re_dezoomer = 4
export var dezoom = 4.5
export var vitesse_dezoom = 1.5
var rezoom 
export var vitesse_rezoom = 8
var i = 0

onready var player_area : Area2D = player.get_node("Area2D")
var stop_debloque = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/Node2D/CanvasLayer/Control/noir").visible = true
	rezoom = player.zoom_normal
	player.global_position = get_node("/root/singleton").position_perso
	get_node("/root/Node2D/level 2/cadre par terre").global_position = player.global_position
	player.is_bloque= true
	player_anim.play("flingue")
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.wait_time = duree_noir
	timer.start()


func _on_timer_timeout():
	if i == 0 :
		stop_debloque = true
		set_physics_process(false)
		get_node("/root/Node2D/CanvasLayer/Control/noir").visible = false
		relance_timer(duree_avant_dezoom)
	elif i == 1 :
		camera.change_zoom(dezoom,vitesse_dezoom)
		relance_timer(duree_gun)
	elif i == 2 :
		player_anim.play("idle")
		player.is_bloque=false
		relance_timer(duree_avant_rezoom)
	elif i == 3:
		camera.change_zoom(rezoom,vitesse_rezoom)
		relance_timer(duree_avant_peut_re_dezoomer)
	elif i == 4:
		player.t = 0
		player.transition_terminee = true
		queue_free()
	i += 1
	

func relance_timer(new_wait_time):
	timer.stop()
	timer.wait_time = new_wait_time
	timer.start()
	
func _physics_process(delta):
	if !stop_debloque && player_area.get_overlapping_bodies().size() > 1:
		player.global_position.y += 5
		player.z_index = player.global_position.y/3
		get_node("/root/Node2D/level 2/cadre par terre").global_position = player.global_position
	
