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
var w02_comp = true
var w03_comp = true
var w04_comp = false
var w05_comp = false
var w06_comp = true
var w07_comp = true
var w08_comp = false
var w09_comp = true
var w10_comp = false

var control_order = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print_debug("error Singleton Controller connecting Player Controller to reset from world gd")

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
		print_debug("error in campiagn singleton in valid map request in get map asked for ", _num, ". returning map 1 instead")
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
		print_debug("error in campiagn singleton in valid map request in get map asked for ", _num, ". returning map 1 instead")
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
		print_debug("error in campiagn singleton in valid map request in get map asked for ", _num, ". returning map 1 instead")
		return w01

func set_level_comp(_num, _bool):
	if _num == 0:
		w00_comp = _bool
	elif _num == 1:
		w01_comp = _bool
	elif _num == 2:
		w02_comp = _bool
	elif _num == 3:
		w03_comp = _bool
	elif _num == 4:
		w04_comp = _bool
	elif _num == 5:
		w05_comp = _bool
	elif _num == 6:
		w06_comp = _bool
	elif _num == 7:
		w07_comp = _bool
	elif _num == 8:
		w08_comp = _bool
	elif _num == 9:
		w09_comp = _bool
	elif _num == 10:
		w10_comp = _bool
	else:
		print_debug("error in campiagn singleton in valid level num  in set level comp asking for ",_num,"   ",_bool)

func get_level_comp(_num):
	if _num == 0:
		return w00_comp
	elif _num == 1:
		return w01_comp
	elif _num == 2:
		return w02_comp
	elif _num == 3:
		return w03_comp
	elif _num == 4:
		return w04_comp
	elif _num == 5:
		return w05_comp
	elif _num == 6:
		return w06_comp
	elif _num == 7:
		return w07_comp
	elif _num == 8:
		return w08_comp
	elif _num == 9:
		return w09_comp
	elif _num == 10:
		return w10_comp
	else:
		print_debug("error in campiagn singleton in valid level num  in get level comp asking for", _num)

func get_level_comp_count():
	var level_count = 0
	if w00_comp: 
		level_count += 1
	if w01_comp: 
		level_count += 1
	if w02_comp: 
		level_count += 1
	if w03_comp: 
		level_count += 1
	if w04_comp: 
		level_count += 1
	if w05_comp: 
		level_count += 1
	if w06_comp: 
		level_count += 1
	if w07_comp: 
		level_count += 1
	if w08_comp: 
		level_count += 1
	if w09_comp: 
		level_count += 1
	if w10_comp: 
		level_count += 1
	return level_count

func get_level_comp_array():
	var a = [w00_comp, w01_comp, w02_comp, w03_comp, w04_comp, w05_comp, w06_comp, w07_comp, w08_comp, w09_comp, w10_comp]
	return a

func get_levels_there():
	var _levels = []
	var l0 = false
	var l1 = false
	var l2 = false
	var l3 = false
	var l4 = false
	var l5 = false
	var l6 = false
	var l7 = false
	var l8 = false
	var l9 = false
	var l10 = false
	if w00:
		l0 = true
	if w01:
		l1 = true
	if w02:
		l2 = true
	if w03:
		l3 = true
	if w04:
		l4 = true
	if w05:
		l5 = true
	if w06:
		l6 = true
	if w07:
		l7 = true
	if w08:
		l8 = true
	if w09:
		l9 = true
	if w10:
		l10 = true
	_levels = [l0,l1,l2,l3,l4,l5,l6,l7,l8,l9,l10]
	return _levels


func reset():
	clear_players()
	for i in 11:
		set_level_comp(i,false)

func complete_level(_num):
	if _num == 0:
		w00_comp = true 
	elif _num == 1:
		w01_comp = true 
	elif _num == 2:
		w02_comp = true 
	elif _num == 3:
		w03_comp = true 
	elif _num == 4:
		w04_comp = true 
	elif _num == 5:
		w05_comp = true 
	elif _num == 6:
		w06_comp = true 
	elif _num == 7:
		w07_comp = true 
	elif _num == 8:
		w08_comp = true 
	elif _num == 9:
		w09_comp = true 
	elif _num == 10:
		w10_comp = true 


# this section has to do with who is in control of the map selection in campaign
func get_player_in_control():
	if control_order.size() > 0:
		return control_order[0]
	else:
		print_debug("error in singleton campaign get player in control no players in array so retruning 1")
		return 1

func add_player(_player):
	if control_order.find(_player) == -1:
		control_order.append(_player)
	print_debug(control_order,"in singleton campaign")

func remove_player(_player):
	if control_order.find != -1:
		control_order.remove(_player)
	else:
		print_debug("error trying to remove player from control ", _player , " is not in the array")

func clear_players():
	control_order.clear()
