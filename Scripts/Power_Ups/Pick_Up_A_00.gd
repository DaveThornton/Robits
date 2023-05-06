extends Area2D

export var respawn = true
export var respawn_time = 20
# export var ammount = 12

onready var r_timer = $Respawn_Timer
onready var shape = $CollisionShape2D
onready var dot = $Sprite

func _ready():
	r_timer.wait_time = respawn_time

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	pass

func _on_body_entered(_body):
	pass

func _disappear():
	dot.visible = false 
	shape.disabled = true 

func _on_Respawn_Timer_timeout():
	dot.visible = true 
	shape.disabled = false 