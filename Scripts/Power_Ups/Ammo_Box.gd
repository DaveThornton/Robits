extends Area2D

export var respawn = true
export var respawn_time = 20
export var how_much = 30

onready var r_timer = $Respawn_Timer
onready var shape = $CollisionShape2D
onready var box = $Sprite

func _ready():
	r_timer.wait_time = respawn_time

func _on_Ammo_Box_body_entered(body):
	if body.get_groups().has("player"):
		if body.take_ammo:
			body.add_ammo(how_much)
			if respawn:
				r_timer.start()
				call_deferred("_box_state", true, false)
			else:
				call_deferred("free")

func _on_Respawn_Timer_timeout():
	call_deferred("_box_state", false, true)

func _box_state(_shape, _box):
	shape.disabled = _shape
	box.visible = _box
