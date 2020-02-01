extends Control

onready var vbox = get_node("CenterContainer/VBoxContainer")

# Called when the node enters the scene tree for the first time.
func _ready():
	vbox.get_node("commencer").connect("button_down",self,"start")
	vbox.get_node("quitter").connect("button_down",self,"quitter")

func start():
	get_tree().change_scene("res://phase_1/phase1 main.tscn")

func quitter():
	get_tree().quit()
