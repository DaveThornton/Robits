extends Area2D

export var activation_num = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MP25Activate_Area_body_entered(body):
	if body.get_groups().has("player"):
		self.get_tree().get_current_scene().map.activate_BG(activation_num, body)
		print("calling for BG to hunt in MP-25")
