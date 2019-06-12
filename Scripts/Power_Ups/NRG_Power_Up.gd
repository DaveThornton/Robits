extends Area2D

export var respawn = true
export var respawn_time = 10
export var how_much_nrg = 30

onready var r_timer = $Respawn_Timer
onready var shape = $CollisionShape2D
onready var dot = $Sprite

func _ready():
	r_timer.wait_time = respawn_time

func _on_NRG_Power_Up_body_entered(body):
	if body.get_groups().has("player"):
		body.add_nrg(how_much_nrg)
		if respawn:
			r_timer.start()
			dot.visible = false 
			shape.disabled = true 
		else:
			queue_free()

func _on_Respawn_Timer_timeout():
	dot.visible = true 
	shape.disabled = false 
