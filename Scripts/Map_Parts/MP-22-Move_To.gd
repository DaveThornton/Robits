extends Area2D

onready var shape = $CollisionShape2D
onready var pos = $Position2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MP22Move_To_body_entered(body):
#	print(body)
	if body.get_groups().has("player") || body.get_groups().has("PickUp")|| body.get_groups().has("BadGuy") || body.get_groups().has("projectile")|| body.get_groups().has("FX"):
		var _this = body.global_position
		body.global_position = pos.global_position# Vector2(this.x - 1980, this.y)
	# elif body.get_groups().has("PickUp"):
	# 	var _this = body.global_position
	# 	body.global_position = Vector2(_this.x - 1980, _this.y)
	# elif body.get_groups().has("BadGuy"):
	# 	var _this = body.global_position
	# 	body.global_position = Vector2(_this.x - 1980, _this.y)
	# elif body.get_groups().has("projectile"):
	# 	var _this = body.global_position
	# 	body.global_position = Vector2(_this.x - 1980, _this.y)


func _on_MP22Move_To_area_shape_entered(area_id, area, area_shape, self_shape):
	var wtfid = area_id
	var wtfarea_shape = area_shape
	var wtfself_shape = self_shape
	if !wtfid || !wtfarea_shape || !wtfself_shape:
		print("error mp 03 roll over hor i dont know weird shape thing dont know wht this error means er el entered")
	if area:
		if area.get_groups().has("projectile"):
			var _this = area.global_position
			area.global_position = pos.global_position# Vector2(this.x - 1980, this.y)