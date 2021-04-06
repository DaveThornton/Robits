extends Node2D

onready var winners = $Winners_Dont_use_Drugs
onready var recycle = $Recycle_it_Dont_trash_it
onready var company = $torpedohousegames
onready var dead = $Dead_Weight_Dave_inc_02
onready var robits = $ROBITS
onready var godot = $"Godot-Logo-02"
onready var v_robit = $VideoPlayer_Robit
onready var v_weap = $VideoPlayer_Weap
onready var v_demo = $VideoPlayer_Demo
onready var timer = $Timer
var how_many_screens = 8

#time for each screen to splash
var t_robits = 5
var t_winners = 4
var t_recycle = 3
var t_company = 4
var t_godot = 3
var t_this_robit = 8
var t_this_weap = 8
var t_demo = 5
var screen_count = 0

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
		timer.start(t_this_robit)
		v_robit.play()
		v_robit.visible = true
	elif _num == 5:
		timer.start(t_winners)
		winners.visible = true
	elif _num == 6:
		timer.start(t_this_weap)
		v_weap.play()
		v_weap.visible = true
	elif _num == 7:
		timer.start(t_recycle)
		recycle.visible = true
	elif _num == 8:
		timer.start(t_demo)
		v_demo.play()
		v_demo.visible = true
	screen_count += 1
	if screen_count > how_many_screens:
		screen_count = 1


func all_out():
	winners.visible = false
	recycle.visible = false
	# company.visible = false
	robits.visible = false
	godot.visible = false
	dead.visible = false
	v_robit.visible = false
	v_weap.visible = false
	v_demo.visible = false
	v_robit.stop()
	v_weap.stop()
	v_demo.stop()

func _on_Timer_timeout():
	screen(screen_count)
