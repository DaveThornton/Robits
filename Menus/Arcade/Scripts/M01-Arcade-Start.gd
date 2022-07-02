extends Node2D

export(PackedScene) var next_screen

onready var logo = $Sprite
onready var timer = $Timer
export var song_num = 0
var screen_count = 0

func _ready():
	SFX.music(true, song_num)
	var test = HUD.connect("input_to_screen", self, "movement")
	var test2 = HUD.connect("screen_update", self, "_next_screen")
	if test != 0:
		print_debug("error M01 Arcade Start  connecting input to movement")
	if test2 != 0:
		print_debug("error M01 Arcade Start  connecting next_screen")
	Player_Stats.reset()
	HUD.menu_state()
	FX.set_back(0)
	FX.splash(true,0)

func movement(_player, _dir):
	if _player > 0 && _player < Settings.get_max_num_players():
		if Player_Stats.get_credit(_player) > 0:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				_next_screen()
		else:
			HUD.ask_insert_coin(_player)
	else:
		print_debug("error invald player in arcade start")
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

func get_ready(_player):
	return false