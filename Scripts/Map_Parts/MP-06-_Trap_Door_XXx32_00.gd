extends Node2D

export var open_timer = .75
export var open_on_top = true 
export var open_on_bot = true 
export var open_on_far_top = false 
export var open_on_far_bot = false 
export var open_for_bg = true
export var open_for_player = true

onready var anim = $AnimationPlayer
onready var timer = $Timer
onready var far_top = $Area2D_Top/Far
onready var far_bot = $Area2D_Bot/Far
onready var area_top = $Area2D_Top
onready var area_bot = $Area2D_Bot

var bodies = 0
var open = false 
var open_last = false

func _ready():
	timer.wait_time = open_timer
	far_top.disabled = !open_on_far_top
	far_bot.disabled = !open_on_far_bot
	area_top.set_collision_mask_bit(1,open_for_player)
	area_bot.set_collision_mask_bit(1,open_for_player)
	area_top.set_collision_mask_bit(10,open_for_player)
	area_bot.set_collision_mask_bit(10,open_for_player)
	area_top.set_collision_mask_bit(11,open_for_bg)
	area_bot.set_collision_mask_bit(11,open_for_bg)
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


func _on_Area2D_Top_body_entered(body:Node): if open_on_top: _on_entered(body)
func _on_Area2D_Top_body_exited(body:Node): if open_on_top: _on_exited(body)

func _on_Area2D_Bot_body_entered(body:Node): if open_on_bot: _on_entered(body)
func _on_Area2D_Bot_body_exited(body:Node): if open_on_bot: _on_exited(body)

func _on_Timer_timeout():
	if open:
		anim.play("Door_Open",0,-1,true)
		open = false