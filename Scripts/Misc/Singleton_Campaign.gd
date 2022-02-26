extends Node2D
#list of worlds start levels
export(PackedScene) var w00
export(PackedScene) var w01
export(PackedScene) var w02
export(PackedScene) var w03
export(PackedScene) var w04
export(PackedScene) var w05
export(PackedScene) var w06
export(PackedScene) var w07
export(PackedScene) var w08
export(PackedScene) var w09
export(PackedScene) var w10

#list of world titles
export var title_00 = "text 00"
export var title_01 = "text 01"
export var title_02 = "text 02"
export var title_03 = "text 03"
export var title_04 = "text 04"
export var title_05 = "text 05"
export var title_06 = "text 06"
export var title_07 = "text 07"
export var title_08 = "text 08"
export var title_09 = "text 09"
export var title_10 = "text 10"

#list of world discriptions
export var w00_dis = ""
export var w01_dis = ""
export var w02_dis = ""
export var w03_dis = ""
export var w04_dis = ""
export var w05_dis = ""
export var w06_dis = ""
export var w07_dis = ""
export var w08_dis = ""
export var w09_dis = ""
export var w10_dis = ""

#list of worlds completed
var w00_comp = false
var w01_comp = false
var w02_comp = false
var w03_comp = false
var w04_comp = false
var w05_comp = false
var w06_comp = false
var w07_comp = false
var w08_comp = false
var w09_comp = false
var w10_comp = false

var control_order = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass #connect a reset here

func get_map(_num):
	if _num == 1:
		return w01
	elif _num == 2:
		return w02
	elif _num == 3:
		return w03
	elif _num == 4:
		return w04
	elif _num == 5:
		return w05
	elif _num == 6:
		return w06
	elif _num == 7:
		return w07
	elif _num == 8:
		return w08
	elif _num == 9:
		return w09
	elif _num == 10:
		return w10
	elif _num == 0:
		return w00
	else:
		print("error in campiagn singleton in valid map request in get map asked for ", _num, ". returning map 1 instead")
		return w01

func get_map_title(_num):
	if _num == 1:
		return title_01
	elif _num == 2:
		return title_02
	elif _num == 3:
		return title_03
	elif _num == 4:
		return title_04
	elif _num == 5:
		return title_05
	elif _num == 6:
		return title_06
	elif _num == 7:
		return title_07
	elif _num == 8:
		return title_08
	elif _num == 9:
		return title_09
	elif _num == 10:
		return title_10
	elif _num == 0:
		return title_00
	else:
		print("error in campiagn singleton in valid map request in get map asked for ", _num, ". returning map 1 instead")
		return w01

func get_map_discription(_num):
	if _num == 1:
		return w01_dis
	elif _num == 2:
		return w02_dis
	elif _num == 3:
		return w03_dis
	elif _num == 4:
		return w04_dis
	elif _num == 5:
		return w05_dis
	elif _num == 6:
		return w06_dis
	elif _num == 7:
		return w07_dis
	elif _num == 8:
		return w08_dis
	elif _num == 9:
		return w09_dis
	elif _num == 10:
		return w10_dis
	elif _num == 0:
		return w00_dis
	else:
		print("error in campiagn singleton in valid map request in get map asked for ", _num, ". returning map 1 instead")
		return w01


# this section has to do with who is in control of the map selection in campaign
func get_player_in_control():
	if control_order.size() > 0:
		return control_order[0]
	else:
		print("error in singleton campaign get player in control no players in array so retruning 1")
		return 1

func add_player(_player):
	if control_order.find(_player) != -1:
		control_order.append(_player)

func remove_player(_player):
	if control_order.find != -1:
		control_order.remove(_player)
	else:
		print("error trying to remove player from control ", _player , " is not in the array")

func clear_players():
	control_order.clear()