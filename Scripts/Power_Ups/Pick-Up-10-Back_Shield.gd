extends Area2D
onready var shape = $CollisionShape2D
onready var timer = $Timer
onready var sprite = $Sprite
export(PackedScene) var shield

func _ready():
	pass # Replace with function body.

func _on_PickUp10Back_Shield_body_entered(body):
	if body.get_groups().has("player"):
		call_deferred("add_shield",body)
		# var x = shield.instance()
		# body.add_child(x)
		# x.global_position = body.global_position
		# sprite.visible = false
		# call_deferred("change_shape",true)
		# shape.disabled = true
		# timer.start()

func _on_Timer_timeout():
	sprite.visible = true
	call_deferred("change_shape",false)
	# shape.disabled = false

func change_shape(_disable):
	shape.disabled = _disable

func add_shield(_body):
	var x = shield.instance()
	_body.add_child(x)
	x.global_position = _body.global_position
	sprite.visible = false
	call_deferred("change_shape",true)
	shape.disabled = true
	timer.start()
