extends Area2D

# chemin
var is_init = false
var is_arrive = false
var cible = Vector2(0,0)
export var vitesse = 700
var direction = Vector2(1,0)

# quand il arrive
export var tempsDisparitionRate = 0.5
export var tempsDisparitionReussi = 6.0
onready var timerDisparait = get_node("Timer")
var faille = null
onready var soundManager = get_node("/root/Node2D/phase 1 obligatoire/sound manager")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init(new_cible):
	cible = new_cible
	direction = -Vector2(global_position.x-cible.x,global_position.y-cible.y).normalized()
	is_init = true

func _physics_process(delta):
	if !is_arrive && is_init:
		global_position += direction * delta * vitesse
		if Vector2(global_position.x-cible.x,global_position.y-cible.y).length() <= 10 :
			arrive()


func arrive():
	is_arrive = true
	timerDisparait.connect("timeout",self,"on_timerDisparait_timeout")
	timerDisparait.wait_time = tempsDisparitionRate
	soundManager.play(soundManager.son_pansement_atterit,soundManager.player_pans_atterit)
	
	if faille != null:
		rotation_degrees = faille.rotation_degrees
		soundManager.play(soundManager.son_applause,soundManager.player_applause)
		timerDisparait.wait_time = tempsDisparitionReussi
		timerDisparait.start()
	else :
		timerDisparait.start()


func on_timerDisparait_timeout():
	queue_free()