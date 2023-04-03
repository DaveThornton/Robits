extends Node2D

#---------------#first  group#---------------------#
onready var e1 = $"Mega_Explosion-03-Part_Single-01"
onready var e2 = $"Mega_Explosion-03-Part_Single-02"
onready var e3 = $"Mega_Explosion-03-Part_Single-03"
onready var e4 = $"Mega_Explosion-03-Part_Single-04"
onready var e5 = $"Mega_Explosion-03-Part_Single-05"
onready var e6 = $"Mega_Explosion-03-Part_Single-06"
onready var e7 = $"Mega_Explosion-03-Part_Single-07"
onready var e8 = $"Mega_Explosion-03-Part_Single-08"
#---------------#second group#---------------------#
onready var e11 = $"Mega_Explosion-03-Part_Single-11"
onready var e12 = $"Mega_Explosion-03-Part_Single-12"
onready var e13 = $"Mega_Explosion-03-Part_Single-13"
onready var e14 = $"Mega_Explosion-03-Part_Single-14"
onready var e15 = $"Mega_Explosion-03-Part_Single-15"
onready var e16 = $"Mega_Explosion-03-Part_Single-16"
onready var e17 = $"Mega_Explosion-03-Part_Single-17"
onready var e18 = $"Mega_Explosion-03-Part_Single-18"

var d1 = Vector2(-2, 0)
var d2 = Vector2(-1.5, 1.5)
var d3 = Vector2(0, 2)
var d4 = Vector2(1.5, 1.5)
var d5 = Vector2(2, 0)
var d6 = Vector2(1.5, -1.5)
var d7 = Vector2(0, -2)
var d8 = Vector2(-1.5, -1.5)

var move_time = 0.3

var count = 0

var less_color = Color8(0,0,0,3)

var first_speed = 1.4
var second_speed = 1

func _ready():
	for i in self.get_child_count():
		self.get_child(i).play()

func _process(delta):
	modulate -= less_color
	if modulate.a8 == 0:
		call_deferred("queue_free")
	e1.move(d1 * first_speed)
	e2.move(d2 * first_speed)
	e3.move(d3 * first_speed)
	e4.move(d4 * first_speed)
	e5.move(d5 * first_speed)
	e6.move(d6 * first_speed)
	e7.move(d7 * first_speed)
	e8.move(d8 * first_speed)
	count += delta
	if count >= move_time:
		e11.move(d1 * second_speed)
		e12.move(d2 * second_speed)
		e13.move(d3 * second_speed)
		e14.move(d4 * second_speed)
		e15.move(d5 * second_speed)
		e16.move(d6 * second_speed)
		e17.move(d7 * second_speed)
		e18.move(d8 * second_speed)
		if e11.visible == false:
			e11.visible = true
			e12.visible = true
			e13.visible = true
			e14.visible = true
			e15.visible = true
			e16.visible = true
			e17.visible = true
			e18.visible = true
