extends StaticBody2D

onready var anim = $AnimationPlayer
onready var body = $"MP-73-Truck"
onready var glass = $"MP-73-Truck/MP-73-Truck_Glass"

export var body_color = Color8(189,33,33,255)
export var glass_color = Color8(0,132,255,255)
export var health = 200
export var points = 2

var dead = false
var player = -1

func _ready():
	body.self_modulate = body_color
	glass.self_modulate = glass_color

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= _damage
	if health <= 0 && !dead:
		Player_Stats.add_score(_by_who, points)
		print("Open Gunner dead windown guy")
		dead = true
		FX.explode(2, -1, self.global_position, "Truck Explosion", -1, 0)
		anim.play("Death")

# func explode():
# 	FX.explode(2, -1, self.global_position, "Truck Explosion", -1, 0)
# 	# var x = explode.instance()
# 	# Map_Hand.add_kid_to_map(x)
# 	# x.init(player, self.global_position, str("player ", x, "'s destruct system"), player, 0)
# 	death()

# func death():
# 	anim.play("Death")