extends CPUParticles2D
export var time = 5.0
onready var timer = $Timer

func time_out():
	timer.start(time)

func _on_Timer_timeout():
	call_deferred("free")
