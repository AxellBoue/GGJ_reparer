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
export var tempsDisparitionFeu = 1.25
onready var timerDisparait = get_node("Timer")
var failleOuFeu = null
onready var soundManager = get_node("/root/Node2D/phase 1 obligatoire/sound manager")
onready var cadre = get_node("/root/Node2D/phase 1 obligatoire/Camera2D/Viewport/Spatial/cadre")

# pour pnj
var from_pnj = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init(new_cible, is_from_pnj = false):
	from_pnj = is_from_pnj
	if from_pnj :
		$pansementnormal.z_index = -3900
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
	if soundManager != null && !from_pnj:
		soundManager.play_random_pitch(soundManager.son_pansement_atterit,soundManager.player_pans_atterit)
	
	if failleOuFeu != null && !from_pnj:
		rotation_degrees = failleOuFeu.rotation_degrees
		cadre.affiche_foule()
		if failleOuFeu.is_in_group("faille"):
			timerDisparait.wait_time = tempsDisparitionReussi
			get_node("AnimationPlayer").play("pansementNormal")
			$pansementnormal.z_index = -3900
		elif failleOuFeu.is_in_group("feu"):
			get_node("AnimationPlayer").play("pansementBrule")
			timerDisparait.wait_time = tempsDisparitionFeu
	elif from_pnj:
		rotation_degrees = failleOuFeu.rotation_degrees
		timerDisparait.wait_time = tempsDisparitionReussi
		get_node("AnimationPlayer").play("pansementNormal")
	
	timerDisparait.start()


func on_timerDisparait_timeout():
	queue_free()