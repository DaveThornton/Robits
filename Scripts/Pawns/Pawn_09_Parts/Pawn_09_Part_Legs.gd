extends Node2D

onready var legs = $Legs
onready var anim = $AnimationPlayer

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

func color(_pri, _sec):
	legs.self_modulate = _pri
