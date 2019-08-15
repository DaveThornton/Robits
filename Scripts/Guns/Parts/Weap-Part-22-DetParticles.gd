extends Node2D

export(PackedScene) var boom

onready var timer = $Timer

var player = 0
var my_name = "Plasma Grenade"
var damage = 100

signal explode

func _ready():
	var test = self.connect("explode", get_parent(), "booming")
	if test != 0:
		print("error connecting explode to free in part 22 DetParticles")

func init(_player, _time, _started):
	self.visible = true
	player = _player
	timer.wait_time = _time
	if _started:
		timer.start()

func _on_Timer_timeout():
	var dad = get_parent()
	if dad.get_groups().has("player"):
		var b = boom.instance()
		Map_Hand.add_kid_to_map(b)
#		self.get_tree().get_current_scene().add_child(b)
	#	b.position = self.global_position
		b.init(player, self.global_position, my_name, 0, damage)
	else:
		emit_signal("explode")