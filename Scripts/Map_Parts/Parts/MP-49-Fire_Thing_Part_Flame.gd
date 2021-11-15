extends Area2D

onready var flame_top = $"Mp-49-FlameDownTop"
onready var flame_back = $"Mp-49-FlameDownBack"
onready var flame_hit = $CollisionShape2D

var my_name = "fire_thing"

func init(_frame, _on):
	flame_top.frame = _frame
	flame_back.frame = _frame
	flame_on(_on)


func change_frame(_flame):
	flame_top.frame = _flame
	flame_back.frame = _flame

func flame_on(_on):
	flame_hit.disabled = !_on
	flame_top.visible = _on
	flame_back.visible = _on

func _on_MP49Fire_Thing_Part_Flame_body_entered(body:Node):
	if body.get_groups().has("player"):
			body.killed_by_map(0, my_name,my_name, 50)
