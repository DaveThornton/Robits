extends Node2D

onready var timer = $Timer
onready var sprite = $Sprite

export(PackedScene) var weap_num_01
export(PackedScene) var weap_num_02
export(PackedScene) var weap_num_03
export(PackedScene) var weap_num_04

export var rand_weap = true
export var spawn_time = 25.0
export var weap_num = 1

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
	var weap
	if rand_weap:
		weap_num = rng.randi_range(1, 4)
	if weap_num == 1:
		weap = weap_num_01.instance()
	elif weap_num == 2:
		weap = weap_num_02.instance()
	elif weap_num == 3:
		weap = weap_num_03.instance()
	elif weap_num == 4:
		weap = weap_num_04.instance()
	weap.dont_hit_player()
	weap.global_position = self.global_position
#	weap.init(-1, -1, _time, _is_right, _dir, _just_shot)
	Map_Hand.add_kid_to_map(weap)

#	part.init(trash_num, self.global_position, shoot_dir, trash_time)
#	part.init(1, 1, 1, true, (self.global_position + Vector2(-7, -7)), shoot_dir)# its for the robit wreckage
