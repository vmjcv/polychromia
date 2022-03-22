extends Line2D

var colors:Array = []
var grid_points:Array = []

func _ready():
	UGC.autoload.get_autoload("Global").connect("palette_changed", self, "_on_palette_changed")
	UGC.autoload.get_autoload("Global").connect("colorblind_toggled", self, "_on_colorblind_toggled")
	
	_on_colorblind_toggled()
	_on_palette_changed()
	
	set_gradient(Gradient.new())
	gradient.colors = []
	gradient.offsets = []
	
	$Palette_color.rect_position = - position - $Palette_color.rect_size * $Palette_color.rect_scale / 2.0
	
func get_line_end():
	return position + get_point_position(get_point_count() - 1)

func get_point_coords(index:int):
	return position + get_point_position(index)

func are_points_adjacent(point1:Vector2, point2:Vector2):
	if grid_points.size() < 2:
		return false
	for index in grid_points.size():
		if grid_points[index] == point1:
			return (
				(index > 0 and grid_points[index - 1] == point2)
				 or (index < grid_points.size() - 1 and grid_points[index + 1] == point2)
			)
	return false

func set_point(pos:Vector2, grid_pos:Vector2, color:String = ""):
	add_point(pos - position)
	
	add_color(color if color else colors[colors.size() - 1])
	grid_points.append(grid_pos)
	
	$Palette_color.rect_position = get_line_end() - position - $Palette_color.rect_size * $Palette_color.rect_scale / 2.0
	$Palette_color.set_palette_color(color())

func recalculate_points(position:Vector2, grid_cells:Dictionary):
	var index = grid_points.find(position)
	if index < 1 or not grid_cells.has(position):
		return []
	var lines_to_check = []
	for idx in range(index, grid_points.size()):
		var cell = grid_cells[grid_points[idx]]
		var Global = UGC.autoload.get_autoload("Global")
		match cell.type:
			Global.CELL_TYPES.NEGATIVE:
				colors[idx] = Global.find_negative_color(colors[idx - 1])
			Global.CELL_TYPES.END:
				if cell.color != colors[idx - 1]:
					remove_last_point()
					cell.completed = false
					cell.lines.erase(self)
					break
			_:
				if cell.lines[0] == self:
					for cell_line in cell.lines:
						if cell_line != self:
							lines_to_check.append([cell_line, grid_points[idx]])
						
					cell.color = colors[idx - 1]
					colors[idx] = colors[idx - 1]
					continue
				colors[idx] = UGC.autoload.get_autoload("Global").find_derived_color(colors[idx - 1], cell.color)
				
	recalculate_colors()
	return lines_to_check

func recalculate_colors():
	
	gradient.colors = []
	gradient.offsets = []

	for color in colors:
		gradient.add_point(1, UGC.autoload.get_autoload("Global").COLORS[color].hex)
	
	$Palette_color.set_palette_color(color())
	calculate_gradient()
	
func remove_last_point():
	remove_point(get_point_count() - 1)
	remove_color()
	grid_points.pop_back()
	
	$Palette_color.rect_position = get_line_end() - position - $Palette_color.rect_size * $Palette_color.rect_scale / 2.0
	$Palette_color.set_palette_color(color())
	
func add_color(color:String):
	if not UGC.autoload.get_autoload("Global").is_valid_color(color):
		return 
		
	colors.append(color)
	gradient.add_point(1, UGC.autoload.get_autoload("Global").COLORS[color].hex)
	
	calculate_gradient()

func remove_color(index:int = - 1):
	if colors.size() < 2:
		return 
		
	if index == - 1:
		colors.pop_back()
		gradient.remove_point(colors.size())
	else :
		colors.remove(index)
		gradient.remove_point(index)
	
	calculate_gradient()

func color(cell_pos:Vector2 = - Vector2.ONE):
	if cell_pos != - Vector2.ONE:
		for idx in grid_points.size():
			if cell_pos == grid_points[idx]:
				return colors[idx]
	
	return "" if not colors.size() else colors[colors.size() - 1]

func set_width(_w:float):
	.set_width(_w)
	$Palette_color.rect_scale = _w * 2.0 * Vector2.ONE / 32
	$Palette_color.rect_position = get_line_end() - position - $Palette_color.rect_size * $Palette_color.rect_scale / 2.0

func calculate_gradient():
	if not colors.size() > 1:
		gradient.set_offset(0, 0)
		return 
	
	var offsets = []
	for index in colors.size():
		offsets.append(float(index) / (colors.size() - 1))
	gradient.set_offsets(offsets)
	
func _on_palette_changed():
	for index in colors.size():
		gradient.set_color(index, UGC.autoload.get_autoload("Global").COLORS[colors[index]].hex)

func _on_colorblind_toggled():
	$Palette_color.visible = not not UGC.autoload.get_autoload("Global").settings.colorblind

