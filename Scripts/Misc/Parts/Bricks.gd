extends Node2D

export(PackedScene) var four_bricks

export var color_1_red = Color(255,0,0,255)
export var color_2_blue = Color(0,0,255,255)
export var color_3_yellow = Color(0,120,120,255)
export var color_4_green = Color(0,0,255,255)


func _ready():
	pass

func add_four(_owned, _pos, _color):
	SFX.play("EX_Brick")
	var e = four_bricks.instance()
	e.self_modulate = _color
	Map_Hand.add_kid_to_map(e)
	e.global_position = _pos
	e.init(_owned, _pos, _color)
	FX.explode(11, _owned, _pos, "bricks", 0, 0)

func get_color(_num):
	match _num:
		1:
			return color_1_red
		2:
			return color_2_blue
		3:
			return color_3_yellow
		4: 
			return color_4_green
		
	print("get color in bricks in FX invalid number")
	return Color(255,255,255,255)