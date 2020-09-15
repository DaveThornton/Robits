extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hit(_by_who, _by_what, _damage_type, _damage):
	get_parent().hit(_by_who, _by_what, _damage_type, _damage)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
