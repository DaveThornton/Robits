extends Node2D
#test upload from laptop
export(PackedScene) var projectile

onready var sfx = $SFX_Lib
onready var sprite = $Sprite
onready var shoot_cast_left = $"Casts/Shoot-Cast-Left"
onready var shoot_cast_right = $"Casts/Shoot-Cast-Right"
onready var shoot_cast_up = $"Casts/Shoot-Cast-Up"
onready var shoot_cast_up_left = $"Casts/Shoot-Cast-Up-Left"
onready var shoot_cast_up_right = $"Casts/Shoot-Cast-Up-Right"
onready var shoot_pos_left = $"Shoot_Spots/Position2D-Left"
onready var shoot_pos_right = $"Shoot_Spots/Position2D-Right"
onready var shoot_pos_up = $"Shoot_Spots/Position2D-Up"
onready var shoot_pos_up_left = $"Shoot_Spots/Position2D-Up-Left"
onready var shoot_pos_up_right = $"Shoot_Spots/Position2D-Up-Right"
onready var shoot_timer = $Timer_shoot

var current_shoot_pos
var can_shoot = true
var player = -1
var damage = 34

#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _shoot(_pos):
	can_shoot = false 
	var new_projectile = projectile.instance()
	get_tree().get_current_scene().add_child(new_projectile)
	var _ss = _pos.global_position
	var _sr = _pos.global_rotation
#	if is_right:
	_sr = _pos.global_rotation
#	else:
#		_sr = _pos.global_rotation * -1
	var _sss = _pos.scale
	new_projectile.start(_sr , _ss, _sss, player, damage)
	sfx.play("Laser_Shoot")
	shoot_timer.start()

func _on_Timer_shoot_timeout():
	_shoot(shoot_pos_left)
