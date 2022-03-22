extends Button

export var type:String

signal hover_position(pos, size)
signal pressed_type(type)

func _ready():
	UGC.autoload.get_autoload("Global").connect("palette_changed", self, "_on_palette_changed")
	_on_palette_changed()
	


func _on_palette_changed():
	add_color_override("font_color", Color.gray if UGC.autoload.get_autoload("Global").dark_mode else Color("55607d"))
	add_color_override("font_color_disabled", Color.gray if UGC.autoload.get_autoload("Global").dark_mode else Color("55607d"))
	add_color_override("font_color_hover", Color.gray.darkened(0.3) if UGC.autoload.get_autoload("Global").dark_mode else Color("55607d").lightened(0.3))


func _on_mouse_entered():
	emit_signal("hover_position", rect_position, rect_size)


func _on_pressed():
	emit_signal("pressed_type", type)
