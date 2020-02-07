extends Sprite

onready var foule = get_node("crowd")
onready var foule_haut = get_node("crowd haut")
onready var timer = get_node("Timer")
export var duree_affiche_foule = 1

onready var soundManager = get_node("/root/Node2D/phase 1 obligatoire/sound manager")

var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimationPlayer").play("cadre")
	timer.connect("timeout",self,"cache_foule")
	timer.wait_time = duree_affiche_foule
	timer.one_shot = true
	rand.randomize()


func affiche_foule():
	soundManager.play(soundManager.son_applause,soundManager.player_applause)
	if rand.randi_range(0,10) == 10 :
		foule_haut.visible = true
	else: 
		foule.visible = true
	timer.stop()
	timer.start()


func cache_foule():
	foule.visible = false
	foule_haut.visible = false