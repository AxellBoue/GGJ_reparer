extends Node2D

var rand = RandomNumberGenerator.new()
export var pitch_range = 0.15

var son_applause = preload("res://phase_1/sons/APPLAUSFINAL2.wav")
onready var player_applause = get_node("playerApplause")

var son_pansement_atterit = preload("res://phase_1/sons/PANSE_ATTERIT.wav")
onready var player_pans_atterit = get_node("player pans atterit")


# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()

func play_random_pitch(son,audioPlayer):
	audioPlayer.stream = son
	audioPlayer.pitch_scale += rand.randf_range(-pitch_range,+pitch_range)
	audioPlayer.play()
	
func play (son,audioPlayer):
	audioPlayer.stream = son
	audioPlayer.play()
	
