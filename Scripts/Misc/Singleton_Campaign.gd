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
	pass # Replace with function body.

func add_player(_player):
	if control_order.find(_player) != -1:
		control_order.append(_player)

func remove_player(_player):
	if control_order.find != -1:
		control_order.remove(_player)
	else:
		print("error trying to remove player from control ", _player , " is not in the array")