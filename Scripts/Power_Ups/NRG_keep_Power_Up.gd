extends Area2D

export var respawn = true
export var respawn_time = 25
export var how_long = 15
export var how_fast = 35
export var how_much = 99

onready var r_timer = $Respawn_Timer
onready var shape = $CollisionShape2D
onready var dot = $Sprite
onready var dot2 = $Sprite2

func _ready():
	r_timer.wait_time = respawn_time

func _on_NRG_keep_Power_Up_body_entered(body):
	if body.get_groups().has("player"):
		body.put_nrg_regen_speed_up(how_long, how_fast, how_much)
		if respawn:
			r_timer.start()
			dot.visible = false 
			dot2.visible = false
			shape.disabled = true 
		else:
			queue_free()

func _on_Respawn_Timer_timeout():
	dot.visible = true  
	dot2.visible = true
	shape.disabled = false 
