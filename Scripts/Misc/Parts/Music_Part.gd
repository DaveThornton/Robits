extends Node2D

onready var level = $Level
onready var boss = $Boss
onready var menu = $Menu

var song_playing

func _ready():
	song_playing = level.get_child(0)

func play(_num):
	stop()
	if _num < 700:
		if _num <= level.get_child_count():
			song_playing = level.get_child(_num)
			song_playing.play()
		else: print_debug("error invalid song number: ", _num, "   in music part   1")
	elif _num >= 900:
		if (_num - 900) <= menu.get_child_count():
			song_playing = menu.get_child(_num - 900)
			song_playing.play()
		else: print_debug("error invalid song number: ", _num, "   in music part   2")
	elif _num >= 700:
		if (_num - 700) <= boss.get_child_count():
			song_playing = boss.get_child(_num - 700)
			song_playing.play()
		else: print_debug("error invalid song number: ", _num, "   in music part   3")

func stop():
	song_playing.stop()
