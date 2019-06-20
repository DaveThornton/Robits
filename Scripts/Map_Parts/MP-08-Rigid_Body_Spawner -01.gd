extends Node2D

export var respawn_time = 18
export var spawn_only_1 = true
export(PackedScene) var body_1
export(PackedScene) var body_2
export(PackedScene) var body_3
export(PackedScene) var body_4
export(PackedScene) var body_5
export(PackedScene) var body_6

#onready var sprite =$Sprite
onready var pos = $Position2D
onready var timer = $Timer
onready var timer_start = $Timer_start

var bodies = 0
var spawn_next = 1

func _ready():
	timer_start.start()
	timer.wait_time = respawn_time

func _spawn():
	var s = body_1.instance()
	if !spawn_only_1:
		if spawn_next == 1:
			s = body_1.instance()
			self.get_tree().get_current_scene().add_kid_to_map(s)
#			self.get_tree().get_current_scene().add_child(s)
			s.global_position = pos.global_position
		elif spawn_next == 2:
			s = body_2.instance()
			self.get_tree().get_current_scene().add_kid_to_map(s)
			s.global_position = pos.global_position
		elif spawn_next == 3:
			s = body_3.instance()
			self.get_tree().get_current_scene().add_kid_to_map(s)
			s.global_position = pos.global_position
		elif spawn_next == 4:
			s = body_4.instance()
			self.get_tree().get_current_scene().add_kid_to_map(s)
			s.global_position = pos.global_position
		elif spawn_next == 5:
			s = body_5.instance()
			self.get_tree().get_current_scene().add_kid_to_map(s)
			s.global_position = pos.global_position
		elif spawn_next == 6:
			s = body_6.instance()
			self.get_tree().get_current_scene().add_kid_to_map(s)
			s.global_position = pos.global_position
		spawn_next += 1
		if spawn_next == 7:
			spawn_next = 1
	else:
		s = body_1.instance()
		self.get_tree().get_current_scene().add_kid_to_map(s)
		s.global_position = pos.global_position
		
#	s.set_collision_layer_bit( 1, false)
#	s.set_collision_mask_bit( 1, false)



func _check_area():
	if bodies <= 0:
		timer.start()

func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		bodies += 1
		_check_area()
#		print(bodies)

func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		bodies -= 1
		_check_area()
#		print(bodies)

func _on_Timer_timeout():
	if bodies <= 0:
		_spawn()

func _on_Timer_start_timeout():
	if bodies <= 0:
		_spawn()