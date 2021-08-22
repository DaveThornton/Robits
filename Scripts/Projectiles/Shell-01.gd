extends RigidBody2D
#onready var sfx = $SFX_Lib

func _ready():
	self.apply_impulse(self.position,Vector2(0,-100))

func _on_Timer_timeout():
	call_deferred("free") #queue_free()

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
#	print("ding shell")
	SFX.shell()
