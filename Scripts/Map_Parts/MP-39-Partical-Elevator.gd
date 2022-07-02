extends Node2D

onready var area = $Area2D

export var speed = 650
var occ_player_array = []

func _ready():
	area.set_gravity_vector($Position2D.position)

func _process(delta):
	if !occ_player_array.empty():
#		print_debug(occ_player_array)
		for j in range(occ_player_array.size()):
			_move_player(j,delta)

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		occ_player_array.append(body)

func _on_Area2D_body_exited(body):
	if body.get_groups().has("player"):
		occ_player_array.erase(body)

func _move_player(array_num, delta):
	var p = occ_player_array[array_num]
	p.position.y -= delta * speed
