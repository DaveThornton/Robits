extends CPUParticles2D

export var death_time = 1
var current_time = 0

func process(delta):
	if current_time >= death_time:
		call_deferred("free")
	current_time += delta