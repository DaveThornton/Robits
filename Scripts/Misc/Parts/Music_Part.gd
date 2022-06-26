extends Node2D

onready var song_01 = $Song_01
onready var song_02 = $Song_02
onready var song_03 = $Song_03
onready var song_04 = $Song_04
onready var song_05 = $Song_05
onready var song_06 = $Song_06
onready var song_07 = $Song_07
onready var song_08 = $Song_08
onready var song_09 = $Song_09
onready var song_10 = $Song_10

var song_playing

func _ready():
	song_playing = song_01

func play(_num):
	stop()
	if _num == 1:
		song_playing == song_01
	elif _num == 2:
		song_playing == song_02
	elif _num == 3:
		song_playing == song_03
	elif _num == 4:
		song_playing == song_04
	elif _num == 5:
		song_playing == song_05
	elif _num == 6:
		song_playing == song_06
	elif _num == 7:
		song_playing == song_07
	elif _num == 8:
		song_playing == song_08
	elif _num == 9:
		song_playing == song_09
	elif _num == 10:
		song_playing == song_10
	else:
		print_debug("error in SFX_Lib singleton Music_part invalid number : ", _num, " - last song played will be played again")
	song_playing.play()

func stop():
	song_playing.stop()