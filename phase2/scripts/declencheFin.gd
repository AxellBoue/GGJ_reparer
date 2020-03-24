extends Area2D

export var dezoom = 2.6
export var vitesse_dezoom = 2
export var temps_Changement = 2

var pnjs
var i = 0

var rand = RandomNumberGenerator.new()

export var wait_time_cris_min = 0.2
export var wait_time_cris_max = 0.8
export var nombre_cris_avant_ensemble = 20
export var nombre_cris_ensemble = 10
export var wait_time_cris_ensemble = 1
var nombre_cris_total

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"on_body_entered")
	$Timer.connect("timeout",self,"on_timer")
	$Timer.wait_time = wait_time_cris_max
	$Timer.one_shot = false
	nombre_cris_total = nombre_cris_ensemble + nombre_cris_avant_ensemble
	rand.randomize()
	pnjs = get_node("/root/Node2D/level 2/groupe pnj boss").get_children()


func on_body_entered(body):
	if body.name=="player":
		$Timer.start()
		body.is_bloque = true
		body.anim.play("idle")
		get_node("/root/Node2D/phase2 obligatoir/Camera2D").change_target_smooth($"target fin",temps_Changement)
		get_node("/root/Node2D/phase2 obligatoir/Camera2D").change_zoom(dezoom,vitesse_dezoom)
		
		
func on_timer():
	if i < nombre_cris_avant_ensemble:
		var r = rand.randi_range(0,pnjs.size()-1)
		affiche_ou_cache_bulle(pnjs[r])
		$Timer.wait_time = rand.randf_range(wait_time_cris_min,wait_time_cris_max)
	elif i == nombre_cris_avant_ensemble:
		for p in pnjs:
			p.get_node("bulle").visible = false
		$Timer.wait_time = wait_time_cris_ensemble
		$Timer.stop()
		$Timer.start()
	else :
		for p in pnjs:
			affiche_ou_cache_bulle(p)
	if i == nombre_cris_total :
		get_node("/root/Node2D/CanvasLayer/Control/illu fin").visible = true
	i += 1
	
func affiche_ou_cache_bulle(pnj):
	var bulle = pnj.get_node("bulle")
	bulle.visible = ! bulle.visible