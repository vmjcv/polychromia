extends TextureRect

export (String, "RED", "BLUE", "YELLOW", "ORANGE", "GREEN", "PURPLE", "WHITE", "BLACK", "NEGATIVE", "?") var color = "RED" setget set_palette_color, get_palette_color

const negative_sprite = "res://UGCGame/assets/sprites/negative_thin.png"
const any_sprite = "res://UGCGame/assets/sprites/circle_outline.png"

func _ready():
	UGC.autoload.get_autoload("Global").connect("palette_changed", self, "_on_palette_changed")
	UGC.autoload.get_autoload("Global").connect("colorblind_toggled", self, "_on_colorblind_toggled")
	_on_colorblind_toggled()
	
	set_palette_color(color)

func set_palette_color(_color:String):
	color = _color
	_on_palette_changed()
	$Colorblind.text = color.substr(0, 1) if not ["BLACK", "NEGATIVE"].has(color) else ""
	_on_colorblind_toggled()
	if color == "NEGATIVE":
		texture = load(negative_sprite)
	elif color == "?":
		texture = load(any_sprite)
		

	

func get_palette_color():
	return color

func _on_palette_changed():
	var opaque = Color.white
	opaque.a = 0.7
	modulate = UGC.autoload.get_autoload("Global").COLORS[color].hex if UGC.autoload.get_autoload("Global").is_valid_color(color) else opaque

func _on_colorblind_toggled():
	$Colorblind.visible = (color != "BLACK" and not not UGC.autoload.get_autoload("Global").settings.colorblind) or ["WHITE", "?"].has(color)
