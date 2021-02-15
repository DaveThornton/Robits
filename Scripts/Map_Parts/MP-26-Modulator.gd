extends Node2D
export var one_color = true
export var start_color = Color(255, 0, 0, 255)
export var step_speed = 1
export var kid01 = -1
export var kid02 = -1
export var kid03 = -1
export var kid04 = -1
var current_color = Color(255, 255, 255, 255)
var dir = 1

func _ready():
	current_color = start_color
	print(current_color)

func _process(delta):
	call_deferred("change_color")
#	if kid01 != -1:
#		Map_Hand.map.get_child(kid01).modulate = current_color
##		Map_Hand.map.get_child(kid01).modulate = current_color
##		print(current_color)
#		print("kid 01")
#	if kid02 != -1:
#		Map_Hand.map.get_child(kid02).modulate = current_color
#	if kid03 != -1:
#		Map_Hand.map.get_child(kid03).modulate = current_color
#	if kid04 != -1:
#		Map_Hand.map.get_child(kid04).modulate = current_color

func change_color():
	print(current_color.r,current_color.g, current_color.b)
	if current_color.r == 255 && current_color.g < 255 && current_color.b == 0:
		current_color.g += step_speed
	elif current_color.g == 255 && current_color.r <= 255 && current_color.r > 0:
		current_color.r -= step_speed
	elif current_color.g == 255 && current_color.r == 0 && current_color.b < 255:
		current_color.b += step_speed
	elif current_color.b == 255 && current_color.g <= 255 && current_color.g > 0:
		current_color.g -= step_speed
	elif current_color.b == 255 && current_color.g == 0 && current_color.r < 255:
		current_color.r += step_speed
	elif current_color.b <= 255 && current_color.g == 0 && current_color.r == 255:
		current_color.b -= step_speed

	if kid01 != -1:
		Map_Hand.map.get_child(kid01).modulate = current_color
	if kid02 != -1:
		Map_Hand.map.get_child(kid02).modulate = current_color
	if kid03 != -1:
		Map_Hand.map.get_child(kid03).modulate = current_color
	if kid04 != -1:
		Map_Hand.map.get_child(kid04).modulate = current_color



func _on_Timer_timeout():
	if kid01 != -1:
		Map_Hand.map.get_child(kid01).modulate = current_color
	if kid02 != -1:
		Map_Hand.map.get_child(kid02).modulate = current_color
	if kid03 != -1:
		Map_Hand.map.get_child(kid03).modulate = current_color
	if kid04 != -1:
		Map_Hand.map.get_child(kid04).modulate = current_color
