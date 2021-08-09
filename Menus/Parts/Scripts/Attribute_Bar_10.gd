extends Node2D
onready var top = $Top
onready var back = $Back

onready var attribute_01 = $Top/attribute_square_64_1
onready var attribute_02 = $Top/attribute_square_64_2
onready var attribute_03 = $Top/attribute_square_64_3
onready var attribute_04 = $Top/attribute_square_64_4
onready var attribute_05 = $Top/attribute_square_64_5
onready var attribute_06 = $Top/attribute_square_64_6
onready var attribute_07 = $Top/attribute_square_64_7
onready var attribute_08 = $Top/attribute_square_64_8
onready var attribute_09 = $Top/attribute_square_64_9
onready var attribute_10 = $Top/attribute_square_64_10

export var amount = 0

func _ready():
	go()
func go():
	zero_out()
	if amount >= 1:
		attribute_01.frame = 1
	if amount >= 2:
		attribute_02.frame = 1
	if amount >= 3:
		attribute_03.frame = 1
	if amount >= 4:
		attribute_04.frame = 1
	if amount >= 5:
		attribute_05.frame = 1
	if amount >= 6:
		attribute_06.frame = 1
	if amount >= 7:
		attribute_07.frame = 1
	if amount >= 8:
		attribute_08.frame = 1
	if amount >= 9:
		attribute_09.frame = 1
	if amount >= 10:
		attribute_10.frame = 1

func color(_pri, _sec):
	top.modulate = _sec
	back.modulate = _pri 

func zero_out():
		attribute_01.frame = 3
		attribute_02.frame = 3
		attribute_03.frame = 3
		attribute_04.frame = 3
		attribute_05.frame = 3
		attribute_06.frame = 3
		attribute_07.frame = 3
		attribute_08.frame = 3
		attribute_09.frame = 3
		attribute_10.frame = 3