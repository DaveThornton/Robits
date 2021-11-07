extends StaticBody2D

export var activation_number = 0
export var activated = false
export var damage = 20
export var health = 5
export var armor = 3
export var points = 2
export var body_color: = Color8(255, 255, 255, 255)
export var gun_color: = Color8(255, 255, 255, 255)
export var accent_color: = Color8(255, 255, 255, 255)

onready var anim_window = $AnimationPlayer
onready var anim_guy = $AnimationPlayer2
onready var shoot_spot = $Position2D
onready var ray_shoot_right = $Raycasts/Shoot_Right
onready var ray_shoot_left = $Raycasts/Shoot_Left
onready var ray_shoot_up = $Raycasts/Shoot_Up
onready var ray_shoot_down = $Raycasts/Shoot_Down
onready var ray_shoot_up_right = $Raycasts/Shoot_Right_Up
onready var ray_shoot_up_left = $Raycasts/Shoot_Left_Up
onready var ray_shoot_down_right = $Raycasts/Shoot_Right_Down
onready var ray_shoot_down_left = $Raycasts/Shoot_Left_Down
onready var ray_shoot_up_right_right = $Raycasts/Shoot_Right_Up2
onready var ray_shoot_up_left_left = $Raycasts/Shoot_Left_Up2
onready var ray_shoot_down_right_right = $Raycasts/Shoot_Right_Down2
onready var ray_shoot_down_left_left = $Raycasts/Shoot_Left_Down2
onready var shoot_timer = $Timer

onready var bg_body = $Window_01_BG
onready var bg_top = $Window_01_BG/Window_01_BG_Top
onready var bg_gun = $Window_01_BG/Window_01_BG_Gun
onready var bg_body_2 = $Window_01_BG_2
onready var bg_top_2 = $Window_01_BG_2/Window_01_BG_Top_2

onready var c_shape = $CollisionShape2D

var dead = false
var player = -1
var opened = false
var can_shoot = true
var shoot = false
var gun_num = 4

func _ready():
	bg_body.self_modulate = body_color
	bg_body_2.self_modulate = body_color
	bg_top.self_modulate = accent_color
	bg_top_2.self_modulate = accent_color
	bg_gun.self_modulate = gun_color
	Map_Hand.map.connect("activate", self, "activate")

func _process(_delta):
	if activated:
		if shoot:
			_shoot()
		if opened && can_shoot:
			_shoot_spot()

func _shoot_spot():
	if ray_shoot_up.is_colliding():
		var body = ray_shoot_up.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Up")
				shoot = true
	if ray_shoot_up_right.is_colliding():
		var body = ray_shoot_up_right.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Right_Up")
				shoot = true
	if ray_shoot_up_left.is_colliding():
		var body = ray_shoot_up_left.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Left_Up")
				shoot = true
	if ray_shoot_up_right_right.is_colliding():
		var body = ray_shoot_up_right_right.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Right_R_Up")
				shoot = true
	if ray_shoot_up_left_left.is_colliding():
		var body = ray_shoot_up_left_left.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Left_L_Up")
				shoot = true
	if ray_shoot_down_right_right.is_colliding():
		var body = ray_shoot_down_right_right.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Right_R_Down")
				shoot = true
	if ray_shoot_down_left_left.is_colliding():
		var body = ray_shoot_down_left_left.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Left_L_Down")
				shoot = true		
	if ray_shoot_down_right.is_colliding():
		var body = ray_shoot_down_right.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Right_Down")
				shoot = true
	if ray_shoot_down_left.is_colliding():
		var body = ray_shoot_down_left.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Left_Down")
				shoot = true
	if ray_shoot_down.is_colliding():
		var body = ray_shoot_down.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Down")
				shoot = true
	if ray_shoot_right.is_colliding():
		var body = ray_shoot_right.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Right")
				shoot = true
	if ray_shoot_left.is_colliding():
		var body = ray_shoot_left.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				anim_guy.play("Left")
				shoot = true
func _shoot():
	if shoot:
		var _ss = shoot_spot.global_position
		var _sr = shoot_spot.global_rotation
		var _sss = shoot_spot.scale
		FX.proj_bad(gun_num, _sr , _ss, _sss, -1, damage)
		SFX.play("Laser_Shoot")
		shoot_timer.start()
		can_shoot = false
		shoot = false

func activate(activation_num, _body):
	if activation_number == activation_num && !dead:
		if !activated:
			activated = true
			anim_window.play("Open")
			can_shoot = true

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= (_damage - armor)
	if health <= 0 && !dead:
		Player_Stats.add_score(_by_who, points)
		print("Open Gunner dead windown guy")
		shoot_timer.stop()
		can_shoot = false
		shoot = false
		call_deferred("set_shape_disabled",true)
		dead = true
		FX.explode(9, player, self.global_position, "BG 09 Self Destruction", player, 0)

func set_shape_disabled(_disabled):
	c_shape.disabled = _disabled

func death():
	anim_guy.play("Death")

func set_opened(_opened):
	opened = _opened

func _on_Timer_timeout():
	print("timer")
	can_shoot = true

func _on_AnimationPlayer_animation_finished(_animation):
	if _animation == "Open":
		c_shape.disabled = false
		set_opened(true)
