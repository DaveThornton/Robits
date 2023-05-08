extends Node2D
export(PackedScene) var bubble 
export var spawn_time = 20.0
onready var pos = $Pos
onready var timer = $Timer
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	timer.wait_time = spawn_time

func _on_Timer_timeout():
	var rando_num = rng.randf_range(0,9)
	var new_bubble = bubble.instance()
	Map_Hand.add_kid_to_map(new_bubble)
	new_bubble.global_position = pos.get_child(rando_num).global_position
	new_bubble.middle_point = new_bubble.global_position.x
