extends Label


func _ready():
	UGC.autoload.get_autoload("Global").connect("palette_changed", self, "_on_palette_changed")
	_on_palette_changed()


func _on_palette_changed():
	var _color = Color.gray if UGC.autoload.get_autoload("Global").dark_mode else Color("55607d")
	add_color_override("font_color", _color)
