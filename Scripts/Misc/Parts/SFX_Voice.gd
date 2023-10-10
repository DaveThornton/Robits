extends Node2D

var playing = false
var voice_que = []

func play(voice_num):
	if playing:
		add_to_que(voice_num)
	else:
		playing = true
		if (self.get_child_count()-1) >= voice_num:
			self.get_child(voice_num).play()
		else:
			print_debug("error in SFX Voice invalid voice_num ", voice_num, " it should be less than ", self.get_child_count(), "  it will play ROBITS instead")
			self.get_child(0).play()

func add_to_que(voice_num):
	if !voice_que.has(voice_num):
		voice_que.append(voice_num)
		

func voice_finished():
	playing = false
	if !voice_que.empty():
		play(voice_que.pop_front())
