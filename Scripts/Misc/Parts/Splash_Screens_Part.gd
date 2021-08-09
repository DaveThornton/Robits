extends Node2D

onready var winners = $Winners_Dont_use_Drugs
onready var recycle = $Recycle_it_Dont_trash_it
onready var company = $torpedohousegames
onready var dead = $Dead_Weight_Dave_inc_02
onready var robits = $ROBITS
onready var godot = $"Godot-Logo-02"
onready var v_demo = $VideoPlayer_Demo

onready var pawn_01 = $Pawn/Pawn_01_About
onready var pawn_02 = $Pawn/Pawn_18_About
onready var pawn_03 = $Pawn/Pawn_03_About
onready var pawn_04 = $Pawn/Pawn_17_About
onready var pawn_05 = $Pawn/Pawn_05_About
onready var pawn_06 = $Pawn/Pawn_06_About
onready var pawn_07 = $Pawn/Pawn_07_About
onready var pawn_08 = $Pawn/Pawn_16_About
onready var pawn_09 = $Pawn/Pawn_09_About
onready var pawn_10 = $Pawn/Pawn_10_About
onready var pawn_11 = $Pawn/Pawn_11_About
onready var pawn_12 = $Pawn/Pawn_12_About
onready var pawn_13 = $Pawn/Pawn_13_About
onready var pawn_14 = $Pawn/Pawn_14_About
onready var pawn_15 = $Pawn/Pawn_15_About

onready var timer = $Timer
var how_many_screens = 6

#time for each screen to splash
var t_robits = 3
var t_winners = 4
var t_recycle = 3
var t_company = 4
var t_godot = 3
var t_this_robit = 8
var t_this_weap = 8
var t_demo = 5
var t_about = 8
var screen_count = 0

var current_pawn_about = 1
var recycle_or_drugs = false #false to show drugs and true to show recycle
var show_demo = false 
func go():
	screen(1)

func stop():
	timer.stop()
	screen(0)


func screen(_num):
	all_out()
	if _num == 0:
		return
	elif _num == 1:
		timer.start(t_robits)
		robits.visible = true
	elif _num == 2:
		timer.start(t_company)
		dead.visible = true
	elif _num == 3:
		timer.start(t_godot)
		godot.visible = true
	elif _num == 4:
		timer.start(t_about)
		show_pawn(current_pawn_about,true)
		current_pawn_about += 1
		if current_pawn_about > 15:
			current_pawn_about = 1
	elif _num == 5:
		timer.start(t_winners)
		if recycle_or_drugs:
			recycle.visible = true
			recycle_or_drugs = false
		else:
			winners.visible = true
			recycle_or_drugs = true
	elif _num == 6:
		if show_demo:
			timer.start(t_demo)
			v_demo.play()
			v_demo.visible = true
			show_demo = false
		else:
			timer.start(t_robits)
			robits.visible = true
			show_demo = true
	screen_count += 1
	if screen_count > how_many_screens:
		screen_count = 1


func show_pawn(_num,_visible):
	if _num == 1:
		pawn_01.visible = _visible
	elif _num == 2:
		pawn_02.visible = _visible
	elif _num == 3:
		pawn_03.visible = _visible
	elif _num == 4:
		pawn_04.visible = _visible
	elif _num == 5:
		pawn_05.visible = _visible
	elif _num == 6:
		pawn_06.visible = _visible
	elif _num == 7:
		pawn_07.visible = _visible
	elif _num == 8:
		pawn_08.visible = _visible
	elif _num == 9:
		pawn_09.visible = _visible
	elif _num == 10:
		pawn_10.visible = _visible
	elif _num == 11:
		pawn_11.visible = _visible
	elif _num == 12:
		pawn_12.visible = _visible
	elif _num == 13:
		pawn_13.visible = _visible
	elif _num == 14:
		pawn_14.visible = _visible
	elif _num == 15:
		pawn_15.visible = _visible


func all_out():
	winners.visible = false
	recycle.visible = false
	# company.visible = false
	robits.visible = false
	godot.visible = false
	dead.visible = false
	v_demo.visible = false
	for i in 15:
		show_pawn(i + 1,false)
	v_demo.stop()

func _on_Timer_timeout():
	screen(screen_count)
