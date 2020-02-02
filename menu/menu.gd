extends Control

onready var vbox = get_node("CenterContainer/VBoxContainer")
onready var son_player = get_node("VBoxContainer/AudioStreamPlayer")

onready var son1 = preload("res://menu/son/menu nav - 01_01_2019 01.12.wav")
onready var son2 = preload("res://menu/son/tick navigation menu - 01_02_2020 23.00.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	#vbox.get_node("commencer").connect("button_down",self,"start")
	#vbox.get_node("quitter").connect("button_down",self,"quitter")
	pass

func start():
	get_tree().change_scene("res://phase_1/phase1 main.tscn")

func quitter():
	get_tree().quit()

func credits():
	get_tree().change_scene("res://menu/credits.tscn")

func retour():
	get_tree().change_scene("res://menu/menu.tscn")
	
func play_sound(num):
	var son
	if num == 1:
		son = son1
	elif num == 2:
		son = son2
		son_player.stream=son
	son_player.play()
	


