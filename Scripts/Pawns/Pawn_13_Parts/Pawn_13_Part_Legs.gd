extends Node2D
onready var back = $Back
onready var front = $Front
onready var body = $Body
onready var shield = $Shield
onready var anim = $AnimationPlayer
onready var parts = $CPUParticles2D
func run(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play("Run")

func idle(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play("Idle")

func fall(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play("Fall")

func jump(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play("Jump")

func prone(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play("Prone-Idle")

func crawl(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play("Prone-Crawl")

func sit_down(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play("Sit")

func sit_up(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play_backwards("Sit")

func stun(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play("Stun")

func ladder_move(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.play("Ladder")

func ladder(_right):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
	anim.stop()

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func color(_pri, _sec):
	back.self_modulate = _pri
	front.self_modulate = _pri
	body.self_modulate = _pri
	parts.modulate = _sec
	shield.self_modulate = _sec
