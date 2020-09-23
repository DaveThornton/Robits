extends Area2D

export(PackedScene) var bg
export(PackedScene) var explode
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

func _ready():
	timer.wait_time = delay
	var map = Map_Hand.map
	var map_connected = map.connect("activate", self, "activate")
	if !map_connected:
		print("error in mp 52 not connecting to map")

func activate(_num, _player):
	if !activated:
		activated = true
		shape.disabled = false
		if delayed_start:
			timer.start()
		else:
			anim.play("Spawn")

#func _process(delta):
#	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		hit_time += .1
		health -= (_damage - armor)
		if health <= 0:
			print("mp 52 dead")
			shape.disabled = true
			call_deferred("_explode")
			anim.play("Broke")
			timer.stop()
			dead = true

func _explode():
	var e = explode.instance()
	Map_Hand.add_kid_to_map(e)
	e.init(9, self.position, str("MP-52 Distruction"), 0, 0)
	
func spawn():
	cbg = bg.instance()
	Map_Hand.add_kid_to_map(cbg)
	cbg.right = right
	cbg.global_position = spawn_spot.global_position

func pause():
	if cbg:
		cbg.stop()
func unpause():
	if cbg:
		cbg.go()

func _on_Timer_timeout():
	if !dead:
		anim.play("Spawn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if !dead:
		timer.start()
