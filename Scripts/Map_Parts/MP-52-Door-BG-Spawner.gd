extends Area2D

export(PackedScene) var bg
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

signal go
signal stop


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

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		hit_time += .1
		health -= (_damage - armor)
		if health <= 0:
			print("mp 52 dead")
			call_deferred("set_shape_disabled",true)
			FX.explode(2, -1, self.position, str("MP-52 Distruction"), 0, 0)
			# call_deferred("_explode")
			anim.play("Broke")
			timer.stop()
			dead = true

func spawn():
	if can_spawn:
		cbg = bg.instance()
		Map_Hand.add_kid_to_map(cbg)
		var a = connect("stop", cbg, "stop")
		var b = connect("go", cbg, "go")
		if !a:
			print("mp 52 door couldnt connect stop to bad guy that was spawned")
		if !b:
			print("mp 52 door couldnt connect go to bad guy that was spawned")
		cbg.right = right
		cbg.global_position = spawn_spot.global_position

func set_can_spawn(_can):
	can_spawn = _can
	if _can:
		timer.start()

func set_activation_num(_num):
	activation_num = _num
		
func pause():
	print("emiting stop map part 52")
	emit_signal("stop")

func unpause():
	print("emiting go map part 52")
	emit_signal("go")
	if is_connected("stop",cbg, "stop"):
		disconnect("stop", cbg, "stop") 
	if is_connected("go",cbg, "go"):
		disconnect("go", cbg, "go") 

func _on_Timer_timeout():
	if !dead && can_spawn:
		anim.play("Spawn")

func _on_AnimationPlayer_animation_finished(_anim_name):
	if !dead && can_spawn:
		timer.start()
