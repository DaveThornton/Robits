extends Node2D
onready var anim = $AnimationPlayer
onready var point_label = $Position2D/Point_Label

var how_much_nrg = 50
var travel_distace = 120
var speed = 60
var middle_point 
var is_right = true
var im_popped = false

func _ready():
	anim.play("Bounce")
	middle_point = self.global_position.x

func _process(delta):
	if !im_popped:
		self.global_position.y += -speed * delta
		if is_right && self.global_position.x < middle_point + travel_distace:
			self.global_position.x += speed * delta * 2
		elif !is_right && self.global_position.x > middle_point - travel_distace:
			self.global_position.x += -speed * delta * 2
		else:
			is_right = !is_right
			print_debug("bubble changing direction")

func done():
	pass

func _on_Pop_Area2D_body_entered(body):
	if body.get_groups().has("player") && !im_popped:
		im_popped = true
		body.add_nrg(how_much_nrg)
		point_label.self_modulate = Player_Stats.get_body_color(body.player)
		anim.play("Popped")

func _on_Timer_timeout():
	if !im_popped:
		anim.play("Popped_Time_Out")