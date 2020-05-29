extends Spatial

onready var foule = get_node("crowd")
onready var foule_haut = get_node("crowd haut")
onready var timer = get_node("Timer")
export var duree_affiche_foule = 1

onready var soundManager = get_node("/root/Node2D/phase 1 obligatoire/sound manager")

var rand = RandomNumberGenerator.new()
var r

# pour archievement
var score = 0
export var scoreAvantArchievement = 8
onready var emplacements_cocardes = $cocardes.get_children()
var num_archievement = 0
onready var archievement = $archievement
onready var timer_archievement = $archievement/Timer
var cocardes : Array = []
#var textes_cocardes : Array = []
var nombre_cocardes = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("AnimationPlayer").play("cadre")
	timer.connect("timeout",self,"cache_foule")
	timer.wait_time = duree_affiche_foule
	timer.one_shot = true
	rand.randomize()
	
	timer_archievement.connect("timeout",self,"cache_archievement")
	timer_archievement.wait_time = 3.0
	timer_archievement.one_shot = true

	var i = 1 
	while i <= nombre_cocardes :
		cocardes.append(load("res://phase_1/images/cocardes/cocarde" + String(i) + ".png"))
		#textes_cocardes.append(load("res://phase_1/images/cocardes/texte" + String(i) + ".png"))
		i += 1
	rand.randomize()
	
	for e in emplacements_cocardes :
		singleton.cocardes = []
		singleton.cocardes.append(9)

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
	r = rand.randi_range(0,nombre_cocardes-1)
	$archievement/cocarde.texture = cocardes[r]
	#$archievement/texte.texture = textes_cocardes[r]
	archievement.visible = true
	timer_archievement.start()
	if num_archievement >= emplacements_cocardes.size() :
		num_archievement = 0
	singleton.cocardes[num_archievement] = r
	

func cache_archievement():
	archievement.visible = false
	emplacements_cocardes[num_archievement].texture = cocardes[r]
	emplacements_cocardes[num_archievement].visible = true
	num_archievement += 1