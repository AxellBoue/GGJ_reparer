extends Node2D

var rand = RandomNumberGenerator.new()
export var pitch_range = 0.10


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
	