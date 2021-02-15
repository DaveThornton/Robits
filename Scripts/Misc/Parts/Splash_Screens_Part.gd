extends Node2D

onready var winners = $Winners_Dont_use_Drugs
onready var company = $torpedohousegames
onready var robits = $"ROBITS-Logo-04"
onready var godot = $"Godot-Logo-01"

var how_many_screens = 4

func screen(_num):
	all_out()
	if _num == 0:
		pass
	elif _num == 1:
		winners.visible = true
	elif _num == 2:
		company.visible = true
	elif _num == 3:
		robits.visible = true
	elif _num == 4:
		godot.visible = true
	else:
		print("error in splash screen part invalid screen number")

func all_out():
	winners.visible = false
	company.visible = false
	robits.visible = false
	godot.visible = false
