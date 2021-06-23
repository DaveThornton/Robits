extends RigidBody2D

export(PackedScene) var boom
export(PackedScene) var smoke

onready var timer = $Timer
onready var timer_boom = $Timer_Boom
onready var anim1 = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var label= $"FX-21-Timer_Label"

var player = 0
var my_name = "Bomb-Man"
var damage = 100
var time = 4.45
var gun_num = 23
var ammo = 1
var ready = false
# warning-ignore:unused_class_variable
var just_shot = false

#warning-ignore:unused_argument
func _process(delta):
	time = timer_boom.time_left
	label.set_time(time)
	rotation = 0

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	player = _player
	if _ammo == 0:
		ammo = 0
		label.visible = true
		_armed(_time)
	else:
		label.visible = false
		timer.wait_time = 30
		timer.start()

func _on_Timer_Boom_timeout():
	var b = boom.instance()
	Map_Hand.add_kid_to_map(b)
#	self.get_tree().get_current_scene().add_child(b)
	b.position = self.global_position
	b.init(player, self.global_position, my_name, 0, damage)
	call_deferred("free")

func _on_WeapPick20Grenade_body_exited(body):
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:
#		self.set_collision_layer_bit( 1, false)
		self.set_collision_mask_bit( 1, false)

func _armed(_time):
	anim2.play("Lit")
	anim1.play("Armed")
	anim2.seek((time -_time))
	timer_boom.wait_time = _time
	timer_boom.start()

#warning-ignore:unused_argument
#warning-ignore:unused_argument
#warning-ignore:unused_argument
func hit(_owned, _my_name, _damage_type, _damage1):
	if ready:
		_armed(time)
		player =  _owned

func _on_Timer_timeout():
	fade_out()

func fade_out():
	var s = smoke.instance()
	Map_Hand.add_kid_to_map(s)
#	get_tree().get_current_scene().add_child(s)
	s.start( 0 , self.global_position, 0, 0)
	call_deferred("free")


func _on_Timer_start_timeout():
	ready = true

func dont_hit_player():
	self.set_collision_mask_bit( 1, false)
