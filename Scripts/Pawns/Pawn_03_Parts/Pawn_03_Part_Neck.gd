extends Node2D

onready var back = $Back
onready var light = $Lights

onready var anim = $AnimationPlayer


func _ready():
	anim.play("Idle")

func play(_anim):
	if anim.current_animation != _anim:
		if anim.has_animation(_anim):
			anim.play(_anim)
		else:
			print("pawn 03 neck doesnt have animation ", _anim)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func color(_pri: Color, _sec: Color):
	light.self_modulate = _sec
	back.self_modulate = _pri
