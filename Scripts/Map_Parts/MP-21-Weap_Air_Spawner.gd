extends Node2D

onready var timer = $Timer
onready var sprite = $Sprite

export var gun1_nade2_power3 = 1
export var spawn_number = 1
export var spawn_rand = false
export var spawn_time = 2.0
export var spawn_number_1 = 1
export var spawn_number_2 = 2
export var spawn_number_3 = 3
export var spawn_number_4 = 4
export var spawn_number_5 = 5
export var spawn_number_6 = 6
export var spawn_number_7 = 7
export var spawn_number_8 = 8
var rng = RandomNumberGenerator.new()

func _ready():
	sprite.visible = false
	timer.wait_time = spawn_time
	timer.start()
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	var spawned
	if gun1_nade2_power3 == 1:
		if !spawn_rand:
			spawned = Map_Hand.map.get_gun(spawn_number)
		else:
			var weap_num = rng.randi_range(1, 8)
			if weap_num == 1:
				spawned = Map_Hand.map.get_gun(spawn_number_1)
			elif weap_num == 2:
				spawned = Map_Hand.map.get_gun(spawn_number_2)
			elif weap_num == 3:
				spawned = Map_Hand.map.get_gun(spawn_number_3)
			elif weap_num == 4:
				spawned = Map_Hand.map.get_gun(spawn_number_4)
			elif weap_num == 5:
				spawned = Map_Hand.map.get_gun(spawn_number_5)
			elif weap_num == 6:
				spawned = Map_Hand.map.get_gun(spawn_number_6)
			elif weap_num == 7:
				spawned = Map_Hand.map.get_gun(spawn_number_7)
			elif weap_num == 8:
				spawned = Map_Hand.map.get_gun(spawn_number_8)
	elif gun1_nade2_power3 == 2:
		if !spawn_rand:
			spawned = Map_Hand.map.get_nade(spawn_number)
		else:
			var nade_num = rng.randi_range(1, 4)
			if nade_num == 1:
				spawned = Map_Hand.map.get_nade(spawn_number_1)
			elif nade_num == 2:
				spawned = Map_Hand.map.get_nade(spawn_number_2)
			elif nade_num == 3:
				spawned = Map_Hand.map.get_nade(spawn_number_3)
			elif nade_num == 4:
				spawned = Map_Hand.map.get_nade(spawn_number_4)
	elif gun1_nade2_power3 == 3:
		if !spawn_rand:
			spawned = Map_Hand.map.get_power_up(spawn_number)
		else:
			var power_num = rng.randi_range(1, 4)
			if power_num == 1:
				spawned = Map_Hand.map.get_power_up(spawn_number_1)
			elif power_num == 2:
				spawned = Map_Hand.map.get_power_up(spawn_number_2)
			elif power_num == 3:
				spawned = Map_Hand.map.get_power_up(spawn_number_3)
			elif power_num == 4:
				spawned = Map_Hand.map.get_power_up(spawn_number_4)

	spawned = spawned.instance()
	spawned.dont_hit_player()
	spawned.global_position = self.global_position
#	weap.init(-1, -1, _time, _is_right, _dir, _just_shot)
	Map_Hand.add_kid_to_pick_ups(spawned)
