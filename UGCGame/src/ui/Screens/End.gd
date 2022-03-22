extends Node

var anima = UGC.autoload.get_autoload("Anima").begin(self)

func _ready():
	
	anima.then({
		node = $congrats, 
		delay = 1, 
		duration = 1, 
		property = "opacity", 
		to = 1
	})
	anima.then({
		node = $completed, 
		delay = 0.5, 
		duration = 1, 
		property = "opacity", 
		to = 1
	})
	anima.then({
		node = $congrats, 
		delay = 2, 
		duration = 1, 
		property = "opacity", 
		to = 0
	})
	anima.with({
		node = $completed, 
		duration = 1, 
		property = "opacity", 
		to = 0
	})
	anima.then({
		node = $thank_you, 
		delay = 0.5, 
		duration = 1, 
		property = "opacity", 
		to = 1
	})
	anima.play()


func _on_back_pressed():
	anima.clear()
	anima.then({
		group = self, 
		duration = 0.5, 
		property = "opacity", 
		to = 0
	})
	anima.play()
	yield (anima, "animation_completed")
	get_tree().change_scene("res://UGCGame/src/ui/Menu/Menu.tscn")
