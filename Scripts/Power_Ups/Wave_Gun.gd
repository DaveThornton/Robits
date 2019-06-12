extends Area2D

export var respawn = true
export var respawn_time = 30
export var projectile_type = 2
export var shoot_speed = .25

onready var r_timer = $Respawn_Timer
onready var shape = $CollisionShape2D
onready var sprite = $Sprite

func _ready():
	r_timer.wait_time = respawn_time

func _on_Wave_Gun_body_entered(body):
	if body.get_groups().has("player"):
		body.weapon_change(projectile_type, shoot_speed)
		if respawn:
			r_timer.start()
			sprite.visible = false 
			shape.disabled = true 
		else:
			queue_free()

func _on_Respawn_Timer_timeout():
	sprite.visible = true 
	shape.disabled = false 
