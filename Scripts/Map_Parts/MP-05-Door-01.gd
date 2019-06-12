extends Node2D

export var open_timer = .75
export var open_on_left = true 
export var open_on_right = true 
export var open_on_far_left = false 
export var open_on_far_right = false 

onready var anim = $AnimationPlayer
onready var timer = $Timer
onready var far_left = $"Area2D-Left/CollisionShape2D-Left-far"
onready var far_right = $"Area2D-Right/CollisionShape2D-Right-far"
onready var sfx = $AudioStreamPlayer

var bodies = 0
var open = false 
var open_last = false

func _ready():
	anim.play("Door_Close")
	timer.wait_time = open_timer
	far_left.disabled = !open_on_far_left
	far_right.disabled = !open_on_far_right

#warning-ignore:unused_argument
func _process(delta):
	if open != open_last:
		sfx.play()
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

func _on_Timer_timeout():
	if open:
		anim.play("Door_Open",0,-1,true)
		open = false
#		sfx.play()

func _on_Area2DLeft_body_entered(body):
	if open_on_left:
		if body.get_groups().has("player") || body.get_groups().has("badguy"):
			_on_entered(body)

func _on_Area2DRight_body_entered(body):
	if open_on_right:
		if body.get_groups().has("player") || body.get_groups().has("badguy"):
			_on_entered(body)

func _on_Area2DLeft_body_exited(body):
	if open_on_left:
		if body.get_groups().has("player") || body.get_groups().has("badguy"):
			_on_exited(body)

func _on_Area2DRight_body_exited(body):
	if open_on_right:
		if body.get_groups().has("player") || body.get_groups().has("badguy"):
			_on_exited(body)