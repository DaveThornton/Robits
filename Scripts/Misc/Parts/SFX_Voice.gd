extends Node2D

var playing = false
var voice_que = []

func play(voice_num:int):
	if playing:
		add_to_que(voice_num)
	else:
		playing = true
		if (self.get_child_count()-1) >= voice_num:
			self.get_child(voice_num).play()
		else:
			print_debug("error in SFX Voice invalid voice_num ", voice_num, " it should be less than ", self.get_child_count(), "  it will play ROBITS instead")
			self.get_child(0).play()

func add_to_que(voice_num:int):
	if !voice_que.has(voice_num):
		voice_que.append(voice_num)
		

func voice_finished():
	playing = false
	if !voice_que.empty():
		play(voice_que.pop_front())

func spell(word:String):
	var l = word.length()
	for p in l:
		print(word.substr(p,1))
		play(letter_number_look_up(word.substr(p,1)))

func letter_number_look_up(letter:String):
	letter = letter.capitalize()
	match letter:
		"A": return 30
		"B": return 31
		"C": return 32
		"D": return 33
		"E": return 34
		"F": return 35
		"G": return 36
		"H": return 37
		"I": return 38
		"J": return 39
		"K": return 40
		"L": return 41
		"M": return 42
		"N": return 43
		"O": return 44
		"P": return 45
		"Q": return 46
		"R": return 47
		"S": return 48
		"T": return 49
		"U": return 50
		"V": return 51
		"W": return 52
		"X": return 53
		"Y": return 54
		"Z": return 55
		"*": return 56
		"!": return 57
		"#": return 58
		"%": return 59
		_:return 28