extends Node2D

onready var sprite = $Sprite

var spawnable = true
var count = 0 

func _ready():
	sprite.visible = false

func can_spawn():
	return spawnable

func set_spawn(_spawn):
	spawnable = _spawn

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if Map_Hand.map:
			Map_Hand.map.remove_spawn_pos(self)
		spawnable = false 
		count += 1
#	print_debug("entered    ",spawnable)

func _on_Area2D_body_exited(body):
	if body.get_groups().has("player"):
		count -= 1
		if count <= 0:
			if Map_Hand.map:
				Map_Hand.map.add_spawn_pos(self)
			spawnable = true
#			count = 0
#	print_debug("exited    ",spawnable)
