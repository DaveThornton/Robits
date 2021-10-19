extends Area2D

export(PackedScene) var bg
export(PackedScene) var explode
export var activation_num = 0
export var right = true
export var delayed_start = true
export var delay = 3.0
export var health = 150
export var armor = 5

onready var spawn_spot = $Position2D
onready var anim = $AnimationPlayer
onready var shape = $CollisionShape2D
onready var timer = $Timer

var activated = false
var dead = false
var cbg 
var hit_time = 0.0
var can_spawn = true

func _ready():
	timer.wait_time = delay
	var map = Map_Hand.map
	var map_connected = map.connect("activate", self, "activate")
	if !map_connected:
		print("error in mp 52 not connecting to map")
	shape.disabled = true

func activate(_num, _player):
	if activation_num == _num:
		if !activated:
			activated = true
			call_deferred("set_shape_disabled",false)
			# shape.disabled = false
			if delayed_start:
				timer.start()
			else:
				anim.play("Spawn")

func set_shape_disabled(_disabled):
	shape.disabled = _disabled
#func _process(delta):
#	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		hit_time += .1
		health -= (_damage - armor)
		if health <= 0:
			print("mp 52 dead")
			call_deferred("set_shape_disabled",true)
			call_deferred("_explode")
			anim.play("Broke")
			timer.stop()
			dead = true

func _explode():
	var e = explode.instance()
	Map_Hand.add_kid_to_map(e)
	e.init(9, self.position, str("MP-52 Distruction"), 0, 0)
	
func spawn():
	if can_spawn:
		cbg = bg.instance()
		Map_Hand.add_kid_to_map(cbg)
		cbg.right = right
		cbg.global_position = spawn_spot.global_position


func set_can_spawn(_can):
	can_spawn = _can
	if _can:
		timer.start()

func set_activation_num(_num):
	activation_num = _num
		
func pause():
	if cbg is Node2D:
		cbg.stop()

func unpause():
	# var valid = get_node_or_null(cbg)
	if cbg is Node2D:
		cbg.go()

func _on_Timer_timeout():
	if !dead && can_spawn:
		anim.play("Spawn")

func _on_AnimationPlayer_animation_finished(_anim_name):
	if !dead && can_spawn:
		timer.start()
