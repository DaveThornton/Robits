extends Node2D

export(PackedScene) var boom

onready var timer = $Timer
onready var part = $Particles2D

var player = 0
var my_name = "Plasma Grenade"
var damage = 100

#signal explode
#
#func _ready():
#	pass
##	var test = self.connect("explode", get_parent(), "booming")
##	if test != 0:
##		print("error connecting explode to free in part 22 DetParticles")

func init(_player, _time, _started):
	self.visible = true
	player = _player
	timer.wait_time = _time

func start(_time):
	timer.wait_time = _time
	timer.start()
	part.visible = true

func _on_Timer_timeout():
	var b = boom.instance()
	Map_Hand.add_kid_to_map(b)
	b.init(player, self.global_position, my_name, 0, damage)
	if get_parent().has_method("booming"):
#		print("yeah it has boom w 22")
		get_parent().booming()
#	else:
#		print("there is no boom w 22")
	call_deferred("free")
