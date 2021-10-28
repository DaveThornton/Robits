extends Node2D

onready var r_timer = $"Respawn-Timer"
# export(PackedScene) var boom
var spawn_spot
var my_pawn
var player = 1
var play_type = 2
var pawn_color = 1
var player_input_l = "P1_Left"
var player_input_r = "P1_Right"
var player_input_u = "P1_Up"
var player_input_d = "P1_Down"
var player_input_j = "P1_Jump"
var player_input_s = "P1_Shoot"
var player_input_p = "P1_Pick"
var player_input_h = "P1_Hold_Ground"
var player_input_start = "P1_start"
var player_input_coin = "P1_Coin"
var auto_respawn = true
var alive = false
var start_equiped = 0

func _ready():
	pass

func init(_player_num):
	player = _player_num
	if player == 1:
		pawn_color = 1
		player_input_l = "P1_Left"
		player_input_r = "P1_Right"
		player_input_u = "P1_Up"
		player_input_d = "P1_Down"
		player_input_j = "P1_Jump"
		player_input_s = "P1_Shoot"
		player_input_p = "P1_Pick"
		player_input_h = "P1_Hold_Ground"
		player_input_start = "P1_start"
		player_input_coin = "P1_Coin"
	elif player == 2:
		pawn_color = 2
		player_input_l = "P2_Left"
		player_input_r = "P2_Right"
		player_input_u = "P2_Up"
		player_input_d = "P2_Down"
		player_input_j = "P2_Jump"
		player_input_s = "P2_Shoot"
		player_input_p = "P2_Pick"
		player_input_h = "P2_Hold_Ground"
		player_input_start = "P2_start"
		player_input_coin = "P2_Coin"
	elif player == 3:
		pawn_color = 3
		player_input_l = "P3_Left"
		player_input_r = "P3_Right"
		player_input_u = "P3_Up"
		player_input_d = "P3_Down"
		player_input_j = "P3_Jump"
		player_input_s = "P3_Shoot"
		player_input_p = "P3_Pick"
		player_input_h = "P3_Hold_Ground"
		player_input_start = "P3_start"
		player_input_coin = "P3_Coin"
	elif player == 4:
		pawn_color = 4
		player_input_l = "P4_Left"
		player_input_r = "P4_Right"
		player_input_u = "P4_Up"
		player_input_d = "P4_Down"
		player_input_j = "P4_Jump"
		player_input_s = "P4_Shoot"
		player_input_p = "P4_Pick"
		player_input_h = "P4_Hold_Ground"
		player_input_start = "P4_start"
		player_input_coin = "P4_Coin"
	elif player == 5:
		pawn_color = 5
		player_input_l = "P5_Left"
		player_input_r = "P5_Right"
		player_input_u = "P5_Up"
		player_input_d = "P5_Down"
		player_input_j = "P5_Jump"
		player_input_s = "P5_Shoot"
		player_input_p = "P5_Pick"
		player_input_h = "P5_Hold_Ground"
		player_input_start = "P5_start"
		player_input_coin = "P5_Coin"
	elif player == 6:
		pawn_color = 6
		player_input_l = "P6_Left"
		player_input_r = "P6_Right"
		player_input_u = "P6_Up"
		player_input_d = "P6_Down"
		player_input_j = "P6_Jump"
		player_input_s = "P6_Shoot"
		player_input_p = "P6_Pick"
		player_input_h = "P6_Hold_Ground"
		player_input_start = "P6_start"
		player_input_coin = "P6_Coin"
	elif player == 7:
		pawn_color = 7
		player_input_l = "P7_Left"
		player_input_r = "P7_Right"
		player_input_u = "P7_Up"
		player_input_d = "P7_Down"
		player_input_j = "P7_Jump"
		player_input_s = "P7_Shoot"
		player_input_p = "P7_Pick"
		player_input_h = "P7_Hold_Ground"
		player_input_start = "P7_start"
		player_input_coin = "P7_Coin"
	elif player == 8:
		pawn_color = 8
		player_input_l = "P8_Left"
		player_input_r = "P8_Right"
		player_input_u = "P8_Up"
		player_input_d = "P8_Down"
		player_input_j = "P8_Jump"
		player_input_s = "P8_Shoot"
		player_input_p = "P8_Pick"
		player_input_h = "P8_Hold_Ground"
		player_input_start = "P8_start"
		player_input_coin = "P8_Coin"
	else: print("Error in Robit controller init player number invald")

func spawn_pawn():
	if !Game.over && !Player_Stats.get_continuing(player):
#		if my_pawn:
#			my_pawn.queue_free()
		print("spawning pawn bc game is not over in robit controller")
		var z = Equipment.get_pawn(Player_Stats.get_pawn_num(player)).instance()
		get_tree().get_current_scene().pawns.add_child(z)
		z.connect("explode_p", self, "explode_pawn")
		my_pawn = z
		_init_pawn()
		Player_Stats.set_in_game(player, true)
		alive = true
	
	elif !Game.over && Player_Stats.get_continuing(player):
		print("robit controller not working when tring to spawn maybe try to spawn again")
	
#	else:
#		Player_Stats.set_in_game(player, false)

func _init_pawn():
	my_pawn.init(player, Map_Hand.spawn_pos(), Game.start_eq, play_type)

func explode_pawn(_player, _pos, _by_who, _by_what):
	FX.explode(3, player, _pos, str("player ", player, "'s destruct system"), Player_Stats.get_pawn_num(player), 2)
	alive = false
	my_pawn.call_deferred("free")
	if !Game.over:
		Player_Stats.add_kill(player, _by_who , 1, _by_what)
		if Game.mode != 0:
			Game.check_over()
		if auto_respawn:
			if Player_Stats.get_in_game(player):
				r_timer.start()

func game_over(_winner):
	print("the player controller noticed the game is over winner is player ", _winner)

func _process(delta):
	var left_input = Input.is_action_pressed(player_input_l)
	var left_input_j = Input.is_action_just_pressed(player_input_l)
	var right_input = Input.is_action_pressed(player_input_r)
	var right_input_j = Input.is_action_just_pressed(player_input_r)
	var up_input = Input.is_action_pressed(player_input_u)
	var up_input_j = Input.is_action_just_pressed(player_input_u)
	var down_input = Input.is_action_pressed(player_input_d)
	var down_input_j = Input.is_action_just_pressed(player_input_d)
	var jump_input = Input.is_action_pressed(player_input_j)
	var jump_input_j = Input.is_action_just_pressed(player_input_j)
	var jump_input_r = Input.is_action_just_released(player_input_j)
	var shoot_input = Input.is_action_pressed(player_input_s)
	var shoot_input_j = Input.is_action_just_pressed(player_input_s)
	var shoot_input_r = Input.is_action_just_released(player_input_s)
	var pick_input_j = Input.is_action_just_pressed(player_input_p)
	var hold_input = Input.is_action_pressed(player_input_h)
	var hold_input_j = Input.is_action_just_pressed(player_input_h)
	var start_input_j = Input.is_action_just_pressed(player_input_start)
	var coin_input_j = Input.is_action_just_pressed(player_input_coin)

	#delete me when done please!!!!
	var test_button = Input.is_action_just_pressed("test_button")
	if player == 1:
		if test_button:
			print("test button add trama pressed in controller")
			FX.add_trauma(1)
	if Input.is_action_pressed("Exit"):
		get_tree().quit()
	if coin_input_j:
		Player_Stats.coin_insert(player)
		HUD.coin_up(player)

	if !Game.over:
		if Player_Stats.get_in_game(player):
			if alive:
				if right_input && !left_input:
					if !hold_input:
						my_pawn.move_x(true, true)
					my_pawn.is_right = true
				if left_input && !right_input:
					if!hold_input:
						my_pawn.move_x(true, false)
					my_pawn.is_right = false
				if hold_input || !left_input && !right_input:
					my_pawn.move_x(false, false)
				if jump_input_j:
					my_pawn.jump_j(down_input, left_input, right_input)
				if jump_input:
					my_pawn.jump(down_input, left_input, right_input)
				if jump_input_r:
					my_pawn.jump_rel()
				if shoot_input:
					my_pawn.shoot()
				if shoot_input_j:
					my_pawn.shoot_j()
				if shoot_input_r:
					my_pawn.shoot_r()
				if pick_input_j:
					my_pawn.pick_throw(left_input, right_input, up_input, down_input,hold_input)
				my_pawn.anim_update(left_input, right_input, up_input, down_input, jump_input, hold_input, delta)
			else:
				if start_input_j:
					if Player_Stats.can_player_start(player):
						Player_Stats.use_credit(player)
						spawn_pawn()
					else:
						print("need to put a coin in or this is an error  ", Player_Stats.can_player_start(player))
		else:
			if start_input_j:
				HUD.input(player, 0)
			elif up_input_j:
				HUD.input(player, 1)
			elif left_input_j:
				HUD.input(player, 2)
			elif right_input_j:
				HUD.input(player, 3)
			elif down_input_j:
				HUD.input(player, 4)
			elif jump_input_j:
				HUD.input(player, 5)
			elif shoot_input_j:
				HUD.input(player, 6)
			elif hold_input_j:
				HUD.input(player, 7)
			elif pick_input_j:
				HUD.input(player, 8)
	else:
		if start_input_j:
			HUD.game_over_input(player, 0)
		elif up_input_j:
			HUD.game_over_input(player, 1)
		elif left_input_j:
			HUD.game_over_input(player, 2)
		elif right_input_j:
			HUD.game_over_input(player, 3)
		elif down_input_j:
			HUD.game_over_input(player, 4)
		elif jump_input_j || shoot_input_j:
			HUD.game_over_input(player, 5)
		elif hold_input_j || pick_input_j:
			HUD.game_over_input(player, 6)

func set_spawn_spot(_pos):
	spawn_spot = _pos

func _spawn_spot():# set up for map handler singleton
	print("in controller spawn spot not doing anything")
	pass

func _on_RespawnTimer_timeout():
	if !Game.over:
		spawn_pawn()

func get_pawn():
	if my_pawn:
		return my_pawn
	else:
		return false

func player_equip_start_weap():
	if my_pawn:
		# my_pawn.start_equiped = true
		my_pawn.equip_start_weap()

func player_remove_start_weap():
	if my_pawn:
		my_pawn.remove_start_weap()

func reset():
	print("reset called in controller")
	Player_Stats.set_in_game(player, false)
	Player_Stats.set_in_play(player, false)
	alive = false
