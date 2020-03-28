extends Control

onready var vbox = get_node("CenterContainer/VBoxContainer")
onready var son_player = get_node("VBoxContainer/AudioStreamPlayer")

onready var son1 = preload("res://menu/son/menu nav - 01_01_2019 01.12.wav")
onready var son2 = preload("res://menu/son/tick navigation menu - 01_02_2020 23.00.wav")

onready var fond_credits = get_node("/root/Node2D/fond credits")
onready var credits = get_node("../credits")
onready var fond_menu = get_node("/root/Node2D/fond menu")
onready var menu = self
onready var fond_controles = get_node("/root/Node2D/fond controles")
onready var controles = get_node("../controles")

onready var fond_controles2 = get_node("/root/Node2D/fond controles2")
var is_starting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("VBoxContainer/commencer").grab_focus()
	pass


func start():
	fond_controles2.visible = true
	menu.visible = false
	is_starting = true
	
func _input(event):
	if is_starting && event.is_action_pressed("tir"):
		get_tree().change_scene("res://phase_1/phase1 main.tscn")

func quitter():
	get_tree().quit()


func credits():
	fond_credits.visible = true
	credits.visible = true
	fond_menu.visible = false
	menu.visible = false
	#credits.get_node("VBoxContainer/retour").grab_focus()

func controles():
	fond_controles.visible = true
	controles.visible = true
	fond_menu.visible = false
	menu.visible = false

func retour():
	fond_menu.visible = true
	menu.visible = true
	fond_credits.visible = false
	credits.visible = false
	fond_controles.visible = false
	controles.visible = false


func play_sound(num):
	var son
	if num == 1:
		son = son1
	elif num == 2:
		son = son2
	son_player.stream=son
	son_player.play()
	


