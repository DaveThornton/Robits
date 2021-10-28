extends Node2D

export(PackedScene) var four_bricks
export var color_1_red = Color(255,0,0,255)
export var color_2_blue = Color(0,0,255,255)
export var color_3_yellow = Color(0,120,120,255)
export var color_4_green = Color(0,0,255,255)


func _ready():
	pass

func add_four(_color):
	pass

func get_color(_num):
	if _num == 1:
		return color_1_red
	elif _num == 2:
		return color_2_blue
	elif _num == 3:
		return color_3_yellow
	elif _num == 4: 
		return color_4_green
	else:
		print("get color in bricks in FX invalid number")
		return Color(255,255,255,255)