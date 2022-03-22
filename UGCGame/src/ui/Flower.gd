extends Node2D

var anima = UGC.autoload.get_autoload("Anima").begin(self)

var base_color:Color

func _ready():
	pass

func set_color(color:Color):
	base_color = color
	color.a = 0.7
	$petal1.modulate = color
	$petal2.modulate = color

func hide_flower():
	anima.clear()
	anima.then({
		node = self, 
		property = "scale", 
		duration = 0.3, 
		to = Vector2.ZERO, 
		easing = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_BACK
	})
	anima.play()

func show_flower(size = UGC.autoload.get_autoload("Global").BASE_SIZE):
	anima.clear()
	anima.then({
		node = self, 
		property = "scale", 
		duration = 1, 
		from = Vector2.ZERO, 
		to = Vector2.ONE * 0.9 * float(size) / UGC.autoload.get_autoload("Global").BASE_SIZE, 
		easing = UGC.autoload.get_autoload("Anima").EASING.EASE_OUT_ELASTIC
	})
	anima.play()
