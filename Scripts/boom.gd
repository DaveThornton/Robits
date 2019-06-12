extends AnimatedSprite

func _ready():
	pass

func _on_boom_animation_finished():
	queue_free()
