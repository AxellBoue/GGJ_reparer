extends Node2D

onready var player = get_node("../player")
onready var player_anim = player.get_node("AnimatedSprite")
onready var timer = get_node("Timer")
onready var camera = get_node("../Camera2D")
export var duree_noir = 0.5
export var duree_avant_dezoom = 0.8
export var duree_gun = 3
export var duree_avant_rezoom = 3
export var dezoom = 4
export var rezoom = 1.5
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player.global_position = get_node("/root/singleton").position_perso
	get_node("/root/Node2D/level 2/cadre par terre").global_position = player.global_position
	player.is_bloque= true
	player_anim.play("flingue")
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.wait_time = duree_noir
	timer.start()


func _on_timer_timeout():
	if i == 0 :
		get_node("../Camera2D/noir").visible = false
		relance_timer(duree_avant_dezoom)
	elif i == 1 :
		camera.change_zoom(dezoom)
		relance_timer(duree_gun)
	elif i == 2 :
		player_anim.play("idle")
		player.is_bloque=false
		relance_timer(duree_avant_rezoom)
	elif i == 3:
		camera.change_zoom(rezoom)
		queue_free()
	i += 1
	

func relance_timer(new_wait_time):
	timer.stop()
	timer.wait_time = new_wait_time
	timer.start()
