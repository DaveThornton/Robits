extends KinematicBody2D

export var speed = 1500
export var from_left = 1400
export var from_right = 200
onready var tracks = $"BG-103-Body/Tracks"
onready var cannons = $"BG-103-Body/Cannons"
onready var turret = $"BG-103-Body/BG-103-Turret"
onready var anim = $AnimationPlayer
onready var anim_hit = $AnimationPlayer_Hit

var deadtrack_count = 0
var deadcannon_count = 0

func _ready():
	turret.connect("hit_turret",self, "hit_turret")
	turret.connect("dead_turret",self, "dead_turret")
	anim.play("Idle")
	for t in tracks.get_child_count():
		var tr = tracks.get_child(t)
		var c = tr.connect("dead_track", self, "dead_track")
		if !c:
			print("didnt connect dead track in BG-103")
		else:
			print("connect worked dead track in BG-103")
	
	for c in cannons.get_child_count():
		var ca = cannons.get_child(c)
		var d = ca.connect("dead_cannon", self, "dead_cannon")
		if !d:
			print("didnt connect dead cannon in BG-103")
		else:
			print("connect worked dead cannon in BG-103")

func _process(delta):
	pass
func _physics_process(delta):
	var campos = FX.CAMERA.global_position.x
	var vel = Vector2(0,-10000 * delta)
	if campos + from_left < self.position.x:
		vel = Vector2( -speed * delta, -10000 * -delta)
		move_tracks(false)
	if campos + from_left > self.position.x + - from_right:
		vel = Vector2( speed * delta, -10000 * -delta)
		move_tracks(true)
	else:
		stop_tracks()
	move_and_slide(vel)

func move_tracks(_right):
	for t in tracks.get_child_count():
		var tr = tracks.get_child(t)
		tr.move(_right)

func stop_tracks():
	for t in tracks.get_child_count():
		var tr = tracks.get_child(t)
		tr.stop()

func hit_turret():
	anim_hit.play("Hit")

func dead_turret ():
	print("dead turret BG 103")

func dead_track():
	deadtrack_count += 1
	if deadtrack_count == 1:
		speed = speed / 2
	if deadtrack_count == 2:
		speed = 0
#	print("dead track BG 103")

func dead_cannon():
	print("dead cannon BG 103")
