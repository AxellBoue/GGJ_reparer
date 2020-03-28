extends Spatial

onready var foule = get_node("crowd")
onready var foule_haut = get_node("crowd haut")
onready var timer = get_node("Timer")
export var duree_affiche_foule = 1

onready var soundManager = get_node("/root/Node2D/phase 1 obligatoire/sound manager")

var rand = RandomNumberGenerator.new()

# pour archievement
var score = 0
export var scoreAvantArchievement = 8
onready var emplacements_cocardes = $cocardes.get_children()
var num_archievement = 0
onready var archievement = $archievement
onready var timer_archievement = $archievement/Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("AnimationPlayer").play("cadre")
	timer.connect("timeout",self,"cache_foule")
	timer.wait_time = duree_affiche_foule
	timer.one_shot = true
	rand.randomize()
	
	timer_archievement.connect("timeout",self,"cache_archievement")
	timer_archievement.wait_time = 3.0


func affiche_foule():
	soundManager.play(soundManager.son_applause,soundManager.player_applause)
	if rand.randi_range(0,10) == 10 :
		foule_haut.visible = true
	else: 
		foule.visible = true
	timer.stop()
	timer.start()
	ajoute_score()

func cache_foule():
	foule.visible = false
	foule_haut.visible = false


func ajoute_score():
	score += 1
	if score%scoreAvantArchievement == 0:
		ajoute_archievement()

func ajoute_archievement():
	archievement.visible = true
	timer_archievement.start()
	if num_archievement >= emplacements_cocardes.size() :
		num_archievement = 0
	emplacements_cocardes[num_archievement].visible = true
	print(num_archievement)
	num_archievement += 1

func cache_archievement():
	archievement.visible = false