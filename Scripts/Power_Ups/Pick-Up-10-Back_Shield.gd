extends Area2D
onready var shape = $CollisionShape2D
onready var timer = $Timer
onready var sprite = $Sprite
export(PackedScene) var shield

func _on_PickUp10Back_Shield_body_entered(body):
	if body.get_groups().has("player"):
		call_deferred("add_shield",body)

func _on_Timer_timeout():
	sprite.visible = true
	call_deferred("change_shape",false)

func change_shape(_disable):
	shape.disabled = _disable

func add_shield(_body):
	if is_instance_valid(_body):
		_body.add_back_shield()
		sprite.visible = false
		call_deferred("change_shape",true)
		shape.disabled = true
		timer.start()