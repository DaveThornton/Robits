extends Label

export var count = 10 
var current_count = 10
var time = 0.0
var started = false

signal time_out

func _ready():
	current_count = count
	pass # Replace with function body

func init():
	started = true
	visible = true
	current_count = count

func  _process(_delta):
	if started:
		time += _delta 
		if time >= 1:
			if current_count == 0:
				zero()
			else:
				current_count -= 1
			print(count)
			self.text = str(current_count)
			time = 0.0

func change_count(_amount):
	current_count += _amount
	self.text = str(current_count)

func zero():
	visible = false
	current_count = count
	started = false
	emit_signal("time_out")