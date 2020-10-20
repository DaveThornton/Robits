extends Node2D

onready var names = $HBoxContainer/VBox_Names
onready var scores = $HBoxContainer/VBox_Scores

func update_scores(_scores):#2d aray [name][score]
	for s in _scores.size():
		names.get_child(s).text = _scores[s][0]
		scores.get_child(s).text = str(_scores[s][1])
#		names.get_child(s).text = _scores[s].x
#		scores.get_child(s).text = _scores[s].y
