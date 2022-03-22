extends CheckButton


func _ready():
	UGC.autoload.get_autoload("Global").connect("palette_changed", self, "_on_palette_changed")
	_on_palette_changed()

func _on_palette_changed():
	modulate = Color.gray if UGC.autoload.get_autoload("Global").dark_mode else Color("55607d")
