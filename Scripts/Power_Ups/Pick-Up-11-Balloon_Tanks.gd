extends Area2D

export(PackedScene) var balloon
export(PackedScene) var balloon_on_player

export var spawn_time = 8.0
export var extra_spawn_time = 25.0
onready var timer = $Timer
onready var timer2 = $Timer2
onready var no_balloon = $RigidBody2D

var balloons = []

func _ready():
	timer.wait_time = spawn_time
	timer2.wait_time = extra_spawn_time
	call_deferred("start")

func start():
	spawn_balloon()
	spawn_balloon()
	spawn_balloon()
	spawn_balloon()

func popped_balloon(_balloon):
	var _pin = _balloon.get_parent()
	balloons.erase(_balloon)
	_pin.remove_child(_balloon)
	Map_Hand.add_child(_balloon)
	_balloon.global_position = global_position
	_pin.queue_free()
	timer.start()


func spawn_balloon():
	if balloons.size() < 4:
		var pin = PinJoint2D.new()
		self.add_child(pin)
		var new_balloon = balloon.instance()
		pin.add_child(new_balloon)
		balloons.append(new_balloon)
		pin.global_position = global_position
		new_balloon.global_position = global_position
		pin.node_a = new_balloon.get_path()
		pin.node_b = no_balloon.get_path()
		new_balloon.connect("death", self, "popped_balloon")

func _on_PickUp11Balloon_Tanks_body_entered(body):
	if body.get_groups().has("player"):
		if balloons.size() > 0:
			call_deferred("put_on_player",body)
		else:
			pass
func put_on_player(body):
	var new_balloon = balloon_on_player.instance()
	new_balloon.color(balloons[0].get_color(),Color(0,0,0))
	new_balloon.on_player(body.player)
	body.attachment_point.attach_to_pin(new_balloon)
	var _balloon = balloons[0]
	var _pin = _balloon.get_parent()
	balloons.erase(_balloon)
	_pin.queue_free()
	timer.start()

func _on_Timer_timeout():
		spawn_balloon()

func _on_Timer2_timeout():
	pass
	# spawn_balloon_num(next_balloon)
	# next_balloon += 1
	# if next_balloon > 4: next_balloon = 1
