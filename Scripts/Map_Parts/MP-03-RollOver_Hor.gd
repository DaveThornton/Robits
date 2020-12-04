extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization hereddddddddhfdtwfd
#	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_EL_ER_body_entered(body):
#	print(body)
	if body.get_groups().has("player"):
		var _this = body.global_position
		body.global_position = Vector2(_this.x + 1980, _this.y)
	elif body.get_groups().has("PickUp"):
		var _this = body.global_position
		body.global_position = Vector2(_this.x + 1980, _this.y)
	elif body.get_groups().has("BadGuy"):
		var _this = body.global_position
		body.global_position = Vector2(_this.x + 1980, _this.y)
	elif body.get_groups().has("projectile"):
		var _this = body.global_position
		body.global_position = Vector2(_this.x + 1980, _this.y)

func _on_ER_EL_body_entered(body):
#	print(body)
	if body.get_groups().has("player"):
		var _this = body.global_position
		body.global_position = Vector2(_this.x - 1980, _this.y)
	elif body.get_groups().has("PickUp"):
		var _this = body.global_position
		body.global_position = Vector2(_this.x - 1980, _this.y)
	elif body.get_groups().has("BadGuy"):
		var _this = body.global_position
		body.global_position = Vector2(_this.x - 1980, _this.y)
	elif body.get_groups().has("projectile"):
		var _this = body.global_position
		body.global_position = Vector2(_this.x - 1980, _this.y)

func _on_EL_ER_area_shape_entered(area_id, area, area_shape, self_shape):
	var wtfid = area_id
	var wtfarea_shape = area_shape
	var wtfself_shape = self_shape
	if !wtfid || !wtfarea_shape || !wtfself_shape:
		print("error mp 03 roll over hor i dont know weird shape thing dont know wht this error means el er entered")
	if area:
		if area.get_groups().has("projectile"):
			var _this = area.global_position
			area.global_position = Vector2(_this.x + 1980, _this.y)

func _on_ER_EL_area_shape_entered(area_id, area, area_shape, self_shape):
	var wtfid = area_id
	var wtfarea_shape = area_shape
	var wtfself_shape = self_shape
	if !wtfid || !wtfarea_shape || !wtfself_shape:
		print("error mp 03 roll over hor i dont know weird shape thing dont know wht this error means er el entered")
	if area:
		if area.get_groups().has("projectile"):
			var _this = area.global_position
			area.global_position = Vector2(_this.x - 1980, _this.y)
