extends RigidBody2D
export var how_much = 30

#onready var pick_area = $Area2D/CollisionShape2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	pass

func _on_Area2D_body_entered(body):
		if body.get_groups().has("player"):
#			print(body)
			if body.take_ammo:
#				print(body.take_ammo)
				body.add_ammo(how_much)
				call_deferred("free")
#				queue_free()
