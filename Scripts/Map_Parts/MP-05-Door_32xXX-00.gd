extends Node2D

export var open_timer = .75
export var open_on_left = true 
export var open_on_right = true 
export var open_on_far_left = false 
export var open_on_far_right = false 
export var open_for_bg = true
export var open_for_player = true

onready var anim = $AnimationPlayer
onready var timer = $Timer
onready var far_left = $Area2D_Left/Far
onready var far_right = $Area2D_Right/Far
onready var area_left = $Area2D_Left
onready var area_right = $Area2D_Right

var bodies = 0
var open = false 
var open_last = false

func _ready():
	timer.wait_time = open_timer
	far_left.disabled = !open_on_far_left
	far_right.disabled = !open_on_far_right
	area_left.set_collision_mask_bit(1,open_for_player)
	area_right.set_collision_mask_bit(1,open_for_player)
	area_left.set_collision_mask_bit(10,open_for_player)
	area_right.set_collision_mask_bit(10,open_for_player)
	area_left.set_collision_mask_bit(11,open_for_bg)
	area_right.set_collision_mask_bit(11,open_for_bg)
	anim.play("Door_Open",0,-1,true)


func _process(_delta):
	if open != open_last:
		print_debug("make door sound in SFX and connect it to the door  MP_5_32_XX")
		open_last = open

func _on_entered(body):
	if body.get_groups().has("player") || body.get_groups().has("badguy"):
		bodies += 1
		if !anim.is_playing():
			if !open:
				anim.play("Door_Open")
				open = true
			else:
				timer.stop()
		else :
			var _anim_pos = anim.current_animation_position
			if !open:
				anim.play("Door_Open")
				anim.seek(_anim_pos)
				open = true
			else:
				timer.stop()

func _on_exited(body):
	if body.get_groups().has("player") || body.get_groups().has("badguy"):
		bodies -= 1
		if bodies <= 0:
			timer.start()


func _on_Area2D_Left_body_entered(body:Node): if open_on_left: _on_entered(body)
func _on_Area2D_Left_body_exited(body:Node): if open_on_left: _on_exited(body)

func _on_Area2D_Right_body_entered(body:Node): if open_on_right: _on_entered(body)
func _on_Area2D_Right_body_exited(body:Node): if open_on_right: _on_exited(body)

func _on_Timer_timeout():
	if open:
		anim.play("Door_Open",0,-1,true)
		open = false
