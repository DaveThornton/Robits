extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
#	pass

func hit(owned, my_name, damage_type, damage1):
	get_parent().hit(owned, my_name, damage_type, damage1)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
