extends Area2D

onready var sprite = $Sprite

export var is_visible = true 
export var auto_kill = true
export var my_name = "spike"

func _ready():
	sprite.visible = is_visible

func _on_Spike_body_entered(body):
	if body.get_groups().has("player"):
		if auto_kill:
			body.killed_by_map(-1, my_name,my_name, 50)
		else:
			body.hit(-1, my_name, my_name, 50)
