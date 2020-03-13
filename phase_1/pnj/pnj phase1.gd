extends KinematicBody2D

# bouge
export var numPath = 1
var etapes : Array
var target_path
var i = 0

export var vitesse = 500
var direction = Vector2(0,0)

#lance pansement
var cibles_pansement_faille1
var cibles_pansement_faille2
var current_faille_cibles
var pansement = preload("res://phase_1/objets/pansement.tscn")
export (NodePath) var faille1
export (NodePath) var faille2
var current_faille
export var begin_faille_is_2 = false
var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	etapes = get_node("../pnjPath"+str(numPath)).get_children()
	target_path = etapes[i]
	var cibles = get_node("../pnj target "+str(numPath))
	cibles_pansement_faille1 = cibles.get_node("faille1").get_children()
	cibles_pansement_faille2 = cibles.get_node("faille2").get_children()
	faille1 = get_node(faille1)
	faille2 = get_node(faille2)
	
	current_faille_cibles = cibles_pansement_faille1
	current_faille = faille1
	if begin_faille_is_2 :
		change_faille_cible(self)
	
	$Timer.connect("timeout",self,"envoie_peutetre_pansement")
	$Timer.start()
	$Timer.wait_time = 0.8
	
	cibles.get_node("Area2D").connect("body_entered",self,"change_faille_cible")


func _physics_process(delta):
	direction = -(global_position - target_path.global_position).normalized()
	move_and_slide(direction * vitesse)
	z_index = global_position.y/3
	if (global_position - target_path.global_position).length() <= 50:
		change_target()


func change_target():
	i += 1
	if i >= etapes.size():
		i = 0
	target_path = etapes[i]
	
	
#envoie pansements
func change_faille_cible(body):
	if body.name == name:
		if current_faille_cibles == cibles_pansement_faille1:
			current_faille_cibles = cibles_pansement_faille2
		else :
			current_faille_cibles = cibles_pansement_faille1
	
func envoie_peutetre_pansement():
	var r = rand.randi_range(0,100)
	if r <= 65:
		envoie_pansement()
	
func envoie_pansement():
	var new_p =  pansement.instance()
	new_p.failleOuFeu = current_faille
	get_node("/root/Node2D").add_child(new_p)
	new_p.global_position = $"pop pansement".global_position
	var r = rand.randi_range(0,current_faille_cibles.size()-1)
	new_p.init(current_faille_cibles[r].global_position, true)