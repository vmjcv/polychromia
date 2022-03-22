extends TextureButton

signal btn_pressed(custom_value)

const size = 64
export  var animate: = false
export  var change_color: = true
export  var custom_value:String

func _ready():
	UGC.autoload.get_autoload("Global").connect("palette_changed", self, "_on_palette_changed")
	_on_palette_changed()


func _on_mouse_entered():
	if not animate:
		return 
	$Tween.interpolate_property(
		self, 
		"rect_scale", 
			Vector2.ONE, 
			Vector2.ONE * 1.2, 
		0.2, 
		Tween.TRANS_BACK, Tween.EASE_OUT
	)
	$Tween.start()


func _on_mouse_exited():
	if not animate:
		return 
	$Tween.interpolate_property(
		self, 
			"rect_scale", 
			Vector2.ONE * 1.2, 
		Vector2.ONE, 0.2, 
		Tween.TRANS_BACK, 
			Tween.EASE_OUT
	)
	$Tween.start()

func _on_palette_changed():
	if change_color:
		modulate = Color.gray if UGC.autoload.get_autoload("Global").dark_mode else Color("55607d")


func _on_pressed():
	emit_signal("btn_pressed", custom_value)
