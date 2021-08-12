extends Area2D
onready var timer = $Timer
onready var my_self = $Sprite
var speed = 18
var owned = 1
var wave_dis = 10
var wave_speed = 7
var my_name = "wavey Projectile"
var damage_type = "laser"
var damage = 51
var start_spot
var going_up = true
var first_time = true

#signal kill_square
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func start(_rot, _pos, _scale, _owner):
	timer.start()
	rotation = _rot
	position = _pos
	scale = _scale
	owned = _owner
	start_spot = my_self.position
	
#func _ready():
#	# Called every time the node is added to the scene.
#	# Initialization here
#	pass

func _physics_process(_delta):
	move_local_x(speed)
	if going_up:
		if first_time:
			move_local_y(-wave_speed/2)
		else:
			move_local_y(-wave_speed)
	else:
		move_local_y(wave_speed)
		if first_time:
			first_time = false 
#	if my_self.position.y > (start_spot.y + wave_dis):
#		going_up = false 
#	if my_self.position.y < (start_spot.y - wave_dis):
#		going_up = true 

func _on_Projectile2_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, my_name, damage_type,damage)
		queue_free()
	elif body.get_groups().has("map"):
#		emit_signal("kill_square",self.position)
		queue_free()
	elif body.get_groups().has("projectile"):
		queue_free()

func _on_Wave_Timer_timeout():
	if going_up:
		going_up = false 
	else :
		going_up = true 


func _on_Timer_timeout():
	queue_free()
