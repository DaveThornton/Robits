extends Node2D

onready var area = $Area2D
onready var anim = $AnimationPlayer
export var speed = 650
var occ_player_array = []

func _ready():
	area.set_gravity_vector($Position2D.position)
	anim.play("128")
	
func _process(delta):
	if !occ_player_array.empty():
		for j in range(occ_player_array.size()):
			_move_player(j,delta)

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		occ_player_array.append(body)

func _on_Area2D_body_exited(body):
	if body.get_groups().has("player"):
		remove_player(body)

func _move_player(array_num, delta):
	var p = occ_player_array[array_num]
	p.position.y -= delta * speed

func remove_player(_player):
	if _player.get_groups().has("player"):
		occ_player_array.erase(_player)

func setup(size):
	match size:
		64: anim.play("64")
		128: anim.play("128")
		256: anim.play("256")
		512: anim.play("512")
