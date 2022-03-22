extends VBoxContainer

var anima = UGC.autoload.get_autoload("Anima").begin(self)

func _ready():
	fade_in()

func _on_Back_pressed():
	fade_out()
	yield (anima, "animation_completed")
	get_tree().change_scene("res://UGCGame/src/ui/Menu/Menu.tscn")

func fade_in():
	anima.clear()
	anima.then({
		node = self, 
		from = 0, 
		to = 1, 
		property = "opacity", 
		duration = 1
	})
	anima.play()

func fade_out():
	anima.clear()
	anima.then({
		node = self, 
		property = "opacity", 
		to = 0, 
		duration = 0.5
	})
	anima.play()

