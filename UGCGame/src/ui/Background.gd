extends WorldEnvironment


func _ready():
	UGC.autoload.get_autoload("Global").connect("palette_changed", self, "_on_palette_changed")
	_on_palette_changed()
	


func _on_palette_changed():
	$ColorRect.color = UGC.autoload.get_autoload("Global").BG
	$CenterContainer/Control/particles.process_material.color_ramp.gradient.set_color(2, UGC.autoload.get_autoload("Global").COLORS.RED.hex)
	$CenterContainer/Control/particles.process_material.color_ramp.gradient.set_color(0, UGC.autoload.get_autoload("Global").COLORS.BLUE.hex)
