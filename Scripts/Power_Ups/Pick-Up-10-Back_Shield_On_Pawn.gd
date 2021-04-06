extends Node2D

onready var shield = $Shield_Sprite
onready var ray_right = $RayCast2D_Going_Right
onready var ray_left = $RayCast2D_Going_Left
onready var anim = $AnimationPlayer

var player = 0
var going_right = true
var are_right = false
var y_spot
export var shield_distance = 20

func _ready():
	player = get_parent().player
	y_spot = get_parent().arm.global_position.y
	shield.global_position = get_parent().global_position


func _process(_delta):
	going_right = get_parent().is_right
	y_spot = get_parent().arm.global_position.y
	shield.global_position.y = y_spot
	if get_parent().is_right == false:
		are_right = true

	if going_right:
		shield.position.x = -shield_distance
		if !are_right:
			are_right = true
			anim.play("Block_Left")
	elif !going_right:
		shield.position.x = shield_distance
		if are_right:
			are_right = false
			anim.play("Block_Right")

func _on_Timer_timeout():
	call_deferred("free")
