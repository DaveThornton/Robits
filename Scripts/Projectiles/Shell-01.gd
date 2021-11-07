extends RigidBody2D

func _ready():
	self.apply_impulse(self.position,Vector2(0,-100))

func _on_Timer_timeout():
	call_deferred("free")

func _on_Area2D_body_entered(_body):
	SFX.shell()
