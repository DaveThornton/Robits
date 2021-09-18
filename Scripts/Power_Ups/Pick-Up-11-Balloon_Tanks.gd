extends Area2D

export(PackedScene) var balloon
export(PackedScene) var balloon_on_player

export var spawn_time = 2.0

onready var timer = $Timer
onready var no_balloon = $RigidBody2D

onready var pin_01 = $PinJoint2D_01
onready var pin_02 = $PinJoint2D_02
onready var pin_03 = $PinJoint2D_03
onready var pin_04 = $PinJoint2D_04

var balloon_01
var balloon_02
var balloon_03
var balloon_04

var balloons
var balloon_count = 1
var bye_balloon
var next_balloon = 0

func _ready():
	balloons = Node2D.new()
	Map_Hand.add_child(balloons)
	timer.wait_time = spawn_time

func spawn_balloon():
	print(balloons.get_child_count())
	var new_balloon = balloon.instance()
	balloons.add_child(new_balloon)
	new_balloon.on_map()
	if balloon_count == 1:
		balloon_01 = new_balloon
		new_balloon.global_position = pin_01.global_position
		pin_01.node_a = new_balloon.get_path()
	elif balloon_count == 2:
		balloon_02 = new_balloon
		new_balloon.global_position = pin_02.global_position
		pin_02.node_a = new_balloon.get_path()
	elif balloon_count == 3:
		balloon_03 = new_balloon
		new_balloon.global_position = pin_03.global_position
		pin_03.node_a = new_balloon.get_path()
	elif balloon_count == 4:
		balloon_04 = new_balloon
		new_balloon.global_position = pin_04.global_position
		pin_04.node_a = new_balloon.get_path()
	balloon_count += 1
	if balloon_count > 4:
		balloon_count = 1
	# print(balloons.get_child_count())

func get_next_balloon():
	next_balloon += 1
	if balloon_count == 1:
		return balloon_02
	elif balloon_count == 2:
		return balloon_03
	elif balloon_count == 3:
		return balloon_04
	elif balloon_count == 4:
		return balloon_01


func _on_PickUp11Balloon_Tanks_body_entered(body):
	if body.get_groups().has("player"):
		bye_balloon = get_next_balloon()
		var new_balloon = balloon_on_player.instance()
		new_balloon.color(bye_balloon.get_color(),Color(0,0,0))
		pin_01.node_a = no_balloon.get_path()
		balloons.add_child(new_balloon)
		new_balloon.position = body.attachment_point.position
		body.attachment_point.attach_to_pin(new_balloon)
		bye_balloon.queue_free()



func _on_Timer_timeout():
	spawn_balloon()
