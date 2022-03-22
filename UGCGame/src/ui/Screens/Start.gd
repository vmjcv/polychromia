extends Node

var anima = UGC.autoload.get_autoload("Anima").begin(self)

func _ready():
	anima.then({
		node = $question, 
		delay = 0.5, 
		duration = 1, 
		property = "opacity", 
		to = 1
	})
	anima.then({
		node = $question, 
		delay = 1, 
		duration = 0.5, 
		property = "opacity", 
		to = 0
	})
	anima.then({
		node = $made_by, 
		delay = 0.5, 
		duration = 1, 
		property = "opacity", 
		to = 1
	})
	anima.then({
		node = $made_by, 
		delay = 1, 
		duration = 0.5, 
		property = "opacity", 
		to = 0
	})
	anima.play()
	yield (anima, "animation_completed")
	get_tree().change_scene("res://UGCGame/src/ui/Menu/Menu.tscn")
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		get_tree().change_scene("res://UGCGame/src/ui/Menu/Menu.tscn")
