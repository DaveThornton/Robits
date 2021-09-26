extends Node2D

export(PackedScene) var boom

onready var timer = $Timer
onready var part = $CPUParticles2D

var player = 0
var my_name = "Plasma Grenade"
var damage = 200

func init(_player, _time, _started):
	self.visible = true
	player = _player
	timer.wait_time = _time

func start(_time):
	timer.wait_time = _time
	timer.start()
	part.visible = true

func _on_Timer_timeout():
	print(global_position)
	var b = boom.instance()
	Map_Hand.add_kid_to_map(b)
	b.init(player, self.global_position, my_name, 0, damage)
	if get_parent().has_method("booming"):
		get_parent().booming()
	call_deferred("free")