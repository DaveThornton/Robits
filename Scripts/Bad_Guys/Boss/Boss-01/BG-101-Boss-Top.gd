extends StaticBody2D

# export(PackedScene) var explode
export var light_color = Color8(255, 255, 255, 255)
export var hit_color = Color8(255, 255, 255, 255)
export var speed = 6500
export var damage = 20
export var health = 150
export var armor = 3

onready var anim_s = $AnimationPlayer_Static
onready var backplaces = $"BG-101-Boss-Top-Back-Places"
onready var backstatic = $"BG-101-Boss-Top-Back-Static"
onready var warden = $"BG-101-Boss-Top-Back-Warden"
onready var frame = $"BG-101-Boss-Top-Frame"

var dead = false
var activated = false
var hit_time = 0.0

signal dead

func _ready():
	anim_s.play("Static")

func activate():
	if !activated:
		activated = true
		warden.visible = true
		backstatic.visible = false
	
func _process(delta):
	if hit_time > 0:
		backstatic.visible = true
		hit_time -= delta
	else:
		backstatic.visible = false

func hit(_by_who, _by_what, _damage_type, _damage):
	if activated:
		if !dead:
			hit_time = .1
			health -= (_damage - armor)
			if health <= 0:
				print("top box in bg 101 boss killed")
				broken()
				FX.explode(5, -1, self.position, str(self, "'s destruct system"), 0, 0)
				# call_deferred("_explode")

# func _explode():
# 	var e = explode.instance()
# 	Map_Hand.add_kid_to_map(e)
# 	e.init(9, self.position, str("player ", e, "'s destruct system"), 0, 0)

func broken():
	dead = true
	anim_s.play("Broken")
	emit_signal("dead")
