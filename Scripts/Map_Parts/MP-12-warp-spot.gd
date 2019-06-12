extends Node2D
export var warp_spot = Vector2(0,0)


#func _ready():
#	pass # Replace with function body.

#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	body.global_position = warp_spot
	pass # Replace with function body.
