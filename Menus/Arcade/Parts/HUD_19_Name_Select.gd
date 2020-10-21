extends HBoxContainer

onready var letter1 = $HUD_20_Letter_Select1
onready var letter2 = $HUD_20_Letter_Select2
onready var letter3 = $HUD_20_Letter_Select3
onready var letter4 = $HUD_20_Letter_Select4

var letter_count = 1

var text1 = ""
var text2 = ""
var text3 = ""
var text4 = ""
var my_name = "!!!!"

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print("error name select in sore hud connecting to reset from world gd")

func up():
	if letter_count == 1: get_child(0).up()
	elif letter_count == 2: get_child(1).up()
	elif letter_count == 3: get_child(2).up()
	elif letter_count == 4: get_child(3).up()

func down():
	if letter_count == 1: get_child(0).down()
	elif letter_count == 2: get_child(1).down()
	elif letter_count == 3: get_child(2).down()
	elif letter_count == 4: get_child(3).down()

func select():
	if letter_count == 1:
		text1 = get_child(0).select()
		my_name = text1 + "   "
		letter2.visible = true
	elif letter_count == 2:
		text2 = get_child(1).select()
		my_name = text1 +  text2 + "  "
		letter3.visible = true
	elif letter_count == 3:
		text3 = get_child(2).select()
		my_name = text1 +  text2 + text3 + " "
		letter4.visible = true
	elif letter_count == 4:
		text4 = get_child(3).select()
		my_name = text1 +  text2 + text3 + text4
	letter_count += 1
	return my_name

func back():
	pass

func reset():
	letter_count = 1
	my_name = "    "
	letter2.visible = false
	letter3.visible = false
	letter4.visible = false
	letter1.reset()
	letter2.reset()
	letter3.reset()
	letter4.reset()
