extends AnimatedSprite

var player

func start( _sr , _ss, _sss, _player):
	player = _player
	self.position = _ss
	self.play()

func _on_Smoke_Blank_animation_finished():
	queue_free()
