extends Node2D
onready var anim = $AnimationPlayer
onready var node_timers = $Node2D_Timers
export var bounce = 100000
export var duration = 1

var players = []
var timers = []

func _process(delta):
	if players.size() > 0:
		for p in players.size():
			if is_instance_valid(players[p]):
				players[p].move_and_slide(Vector2(0, -bounce * timers[0].time_left * delta))
			else:
				time_out()

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if !players.has(body):
			players.append(body)
			anim.play("Bounce")
			var t = Timer.new()
			timers.append(t)
			node_timers.add_child(t)
			t.connect("timeout", self, "time_out")
			t.start(duration)
	else:
		body.apply_impulse(body.position, Vector2(0, -10))

func time_out():
	players.pop_front()
	timers[0].call_deferred("free")
	timers.pop_front()