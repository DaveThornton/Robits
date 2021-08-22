extends Node2D

export(PackedScene) var next_screen

onready var logo = $Sprite
onready var timer = $Timer

var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false
var p6_ready = false
var p7_ready = false
var p8_ready = false
var screen_count = 0

func _ready():
	var test = HUD.connect("input_to_screen", self, "movement")
	var test2 = HUD.connect("screen_update", self, "_next_screen")
	if test != 0:
		print("error M01 Arcade Start  connecting input to movement")
	if test2 != 0:
		print("error M01 Arcade Start  connecting next_screen")
	Player_Stats.reset()
	HUD.menu_state()
	FX.set_back(0)
	FX.splash(true,0)

func movement(_player, _dir):
	if _player == 1:
		if Player_Stats.p1["credit"] >= 1:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				_next_screen()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 2:
		if Player_Stats.p2["credit"] >= 1:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				_next_screen()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 3:
		if Player_Stats.p3["credit"] >= 1:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				_next_screen()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 4:
		if Player_Stats.p4["credit"] >= 1:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				_next_screen()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 5:
		if Player_Stats.p5["credit"] >= 1:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				_next_screen()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 6:
		if Player_Stats.p6["credit"] >= 1:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				_next_screen()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 7:
		if Player_Stats.p7["credit"] >= 1:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				_next_screen()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 8:
		if Player_Stats.p8["credit"] >= 1:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				_next_screen()
		else:
			HUD.ask_insert_coin(_player)
	else:
		print("error invald player in arcade start")
	HUD.menu_state()

func _next_screen():
	SFX.menu(1)
	HUD.load_screen(next_screen)
	FX.splash(false,0)
	queue_free()

func _on_Timer_timeout():
	screen_count += 1
	if screen_count > FX.splash_screens.how_many_screens:
		screen_count = 0
		logo.visible = true
		timer.start(60)
	else:
		logo.visible = false
		timer.start(6)
	FX.splash(screen_count,0)
