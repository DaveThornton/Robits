extends Node2D
export var weight = 0
export var hops = 0
export var speed = 0
export var armor = 0
export var hp = 0
export var about = "gjkalsdhglkjashglkajsfhglkjdhfggfhdfkljghsdflkjghsldkfjhgslkdfjhglskdjfhglksjdhglksjdhfglksjdhfg"

onready var bar_01 = $Attribute_Bar_10_1
onready var bar_02 = $Attribute_Bar_10_2
onready var bar_03 = $Attribute_Bar_10_3
onready var bar_04 = $Attribute_Bar_10_4
onready var bar_05 = $Attribute_Bar_10_5
onready var about_label = $Label2
onready var timer_next_char = $Timer_Next_Char

var char_total
var current_char = 0

func _ready():
	bar_01.amount = weight
	bar_02.amount = hops
	bar_03.amount = speed
	bar_04.amount = armor
	bar_05.amount = hp
	about_label.text = about
	bar_01.go()
	bar_02.go()
	bar_03.go()
	bar_04.go()
	bar_05.go()
	char_total = about.length()

func print_about():
	clear_about()
	print_next_char()

func clear_about():
	current_char = 0
	about_label.text = ""
	timer_next_char.stop()

func print_next_char():
	if char_total > current_char:
		about_label.text = about_label.text + about.substr(current_char, 1)
		current_char += 1
		SFX.play("Menu_Click_Short")
		timer_next_char.start()
	# else:
	# 	print_about()

func color(_pri, _sec):
	bar_01.color(_pri, _sec)
	bar_02.color(_pri, _sec)
	bar_03.color(_pri, _sec)
	bar_04.color(_pri, _sec)
	bar_05.color(_pri, _sec)

func _on_Timer_Next_Char_timeout():
	print_next_char()
