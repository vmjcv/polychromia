extends Node2D

var BASE_GRID_SIZE = UGC.autoload.get_autoload("Global").BASE_SIZE * 3

signal grid_cleared
signal grid_built
signal completed

export  var size:Vector2 = Vector2.ONE * 4 setget set_size, get_size
var reactive_cell_size = BASE_GRID_SIZE / float(size.x)

var cell_node = preload("res://UGCGame/src/Cell/Cell.tscn")
var line_node = preload("res://UGCGame/src/Line/Line.tscn")

var anima = UGC.autoload.get_autoload("Anima").begin(self)

var grid_cells:Dictionary = {}
var move_stack:Array = []
var dragging
var is_completed:bool
var last_mouse_position:Vector2

func _ready():
	pass

func build_grid():
	
	for x in size.x:
		for y in size.y:
			var cell = cell_node.instance()
			$cells.add_child(cell)
			cell.modulate.a = 0
			
			cell.size = reactive_cell_size
			cell.position = grid_to_pixel(Vector2(x, y), cell.size)
			grid_cells[Vector2(x, y)] = cell
	
	fade_in()
	yield (anima, "animation_completed")
	emit_signal("grid_built")

func clear_grid():
	fade_out()
	yield (anima, "animation_completed")
	
	for cell in grid_cells.values():
		if cell and cell.has_method("queue_free"):
			$cells.remove_child(cell)
			cell.queue_free()
	grid_cells.clear()
	
	for line in $lines.get_children():
		$lines.remove_child(line)
		line.queue_free()
	move_stack.clear()
	
	emit_signal("grid_cleared")
	
func check_level_completion():
	for cell in grid_cells.values():
		if cell.lines.empty():
			return false
		if cell.type == UGC.autoload.get_autoload("Global").CELL_TYPES.END and not cell.completed:
			return false
	emit_signal("completed")
	
	return true

func add_color(pos:Vector2, type:int, color:String = ""):
	if not (grid_cells.has(pos) and UGC.autoload.get_autoload("Global").is_valid_type(type)):
		return 
		
	var cell = grid_cells[pos]
	cell.type = type
	
	if UGC.autoload.get_autoload("Global").is_valid_color(color):
		cell.color = color
	
	if type == UGC.autoload.get_autoload("Global").CELL_TYPES.START:
		var line = line_node.instance()
		$lines.add_child(line)
		
		line.position = cell.position
		line.set_point(cell.position, pos, color)
		cell.lines.append(line)
		
		line.set_width(cell.size / 8.0)

func get_lines_at_cell(pos:Vector2):
	var lines = []
	if not grid_cells.has(pos):
		return lines
	for line in grid_cells[pos].lines:
		if pixel_to_grid(line.get_line_end()) == pos:
			lines.append(line)
	return lines

func recalculate_lines(pos:Vector2):
	if not grid_cells.has(pos):
		return 
	var current_cell = grid_cells[pos]
	
	
	var lines_to_check = []
	for cell_line in current_cell.lines:
		lines_to_check.append([cell_line, pos])
	while lines_to_check.size():
		var checking = lines_to_check.pop_front()
		lines_to_check.append_array(checking[0].recalculate_points(checking[1], grid_cells))

func move_line_to_cell(line, cell_pos:Vector2, from_undo:String = ""):
	if not (grid_cells.has(cell_pos) and line):
		return false
	
	var current_pos = line.grid_points.back()
	var current_cell = grid_cells[current_pos]
	var cell = grid_cells[cell_pos]
	var prev_pos = line.grid_points[line.grid_points.size() - 2] if line.grid_points.size() > 1 else null
	
	
	if line.grid_points.size() > 1:
		prev_pos = line.grid_points[line.grid_points.size() - 2]
	
	
	if prev_pos == cell_pos:
		grid_cells[prev_pos].pulse()
		
		current_cell.completed = false
		while current_cell.lines.has(line):
			current_cell.lines.erase(line)
		
		
		line.remove_last_point()
		if not from_undo:
			add_to_move_stack(line, current_pos, current_cell.color if UGC.autoload.get_autoload("Global").is_valid_color(current_cell.color) else "invalid")
			
		if not UGC.autoload.get_autoload("Global").is_valid_type(current_cell.type) and current_cell.color == line.color(current_pos):
			current_cell.color = ""

		
		recalculate_lines(current_pos)
			
		return true
	
	if current_cell.type == UGC.autoload.get_autoload("Global").CELL_TYPES.END:
		return false
	
	if cell.lines.has(line):
		return false
	
	if not cell.lines.empty():
		for cell_line in cell.lines:
			if cell_line.are_points_adjacent(current_pos, cell_pos):
				return false
	
	if cell.type == UGC.autoload.get_autoload("Global").CELL_TYPES.START or (cell.type == UGC.autoload.get_autoload("Global").CELL_TYPES.END and (cell.color != line.color() or cell.completed)):
		return false
	
	if cell.type == UGC.autoload.get_autoload("Global").CELL_TYPES.NEGATIVE:
		line.set_point(cell.position, cell_pos, UGC.autoload.get_autoload("Global").find_negative_color(line.color()))
	elif cell.color and cell.color != line.color():
		line.set_point(cell.position, cell_pos, UGC.autoload.get_autoload("Global").find_derived_color(line.color(), cell.color))
	else :
		line.set_point(cell.position, cell_pos)
	
	if not from_undo:
		add_to_move_stack(line, current_pos, cell.color if UGC.autoload.get_autoload("Global").is_valid_color(cell.color) else "invalid")
			
	elif cell.color != from_undo and UGC.autoload.get_autoload("Global").is_valid_color(from_undo):
		cell.color = from_undo
		cell.lines.insert(0, line)
		recalculate_lines(current_pos)
	
	if not cell.lines.has(line):
		cell.lines.append(line)

	if not (cell.color or UGC.autoload.get_autoload("Global").is_valid_type(cell.type)):
		cell.color = line.color()

	if cell.type == UGC.autoload.get_autoload("Global").CELL_TYPES.END and cell.color == line.color():
		cell.completed = true
		pulse(cell_pos, cell.sprite.modulate)
	
	cell.pulse()
	
	check_level_completion()
	return true
	

func add_to_move_stack(line, pos:Vector2, color:String):
	if move_stack.size() > 500:
		move_stack.pop_front()
	move_stack.append([line, pos, color])
	
func undo_move():
	if not move_stack.size():
		return 
	var last_move = move_stack.pop_back()
	move_line_to_cell(last_move[0], last_move[1], last_move[2])




func grid_to_pixel(pos:Vector2, _size = reactive_cell_size)->Vector2:
	return _size * Vector2(pos.x, pos.y) + Vector2.ONE * _size / 2.0
	
func pixel_to_grid(pos:Vector2, _size = reactive_cell_size)->Vector2:
	return (pos / _size).floor()
	
func is_in_grid(pos:Vector2)->bool:
	return (
		pos.x >= 0
		 and pos.y >= 0
		 and pos.x <= BASE_GRID_SIZE
		 and pos.y <= BASE_GRID_SIZE
	)



func set_size(_size:Vector2):
	size = Vector2.ONE * _size.x
	reactive_cell_size = BASE_GRID_SIZE / float(_size.x)
	
func get_size():
	return size
	


func fade_in():
	anima.clear()
	anima.then({
		grid = $cells, 
		point = Vector2.ZERO, 
		grid_size = size, 
		animation_type = UGC.autoload.get_autoload("Anima").GRID.FROM_POINT, 
		property = "opacity", 
		to = 1, 
		from = 0, 
		items_delay = 0.1, 
		duration = 0.4
	})
	anima.play()

func fade_out():
	anima.clear()
	anima.then({
		grid = $cells, 
		point = Vector2.ZERO, 
		grid_size = size, 
		animation_type = UGC.autoload.get_autoload("Anima").GRID.FROM_POINT, 
		property = "opacity", 
		from = 1, 
		to = 0, 
		items_delay = 0.1, 
		duration = 0.4
	})
	anima.with({
		group = $lines, 
		property = "opacity", 
		from = 1, 
		to = 0, 
		duration = 0.8
	})
	anima.play()

func pulse(point:Vector2, color:Color):
	var _scale = Vector2.ONE * float(reactive_cell_size) / UGC.autoload.get_autoload("Global").BASE_SIZE
	anima.clear()
	anima.then({
		grid = $cells, 
		grid_size = size, 
		animation_type = UGC.autoload.get_autoload("Anima").GRID.FROM_POINT, 
		property = "sprite:scale", 
		from = _scale, 
		to = _scale - Vector2.ONE * 0.1, 
		point = point, 
		duration = 0.1, 
		items_delay = 0.05
	})
	anima.then({
		grid = $cells, 
		grid_size = size, 
		animation_type = UGC.autoload.get_autoload("Anima").GRID.FROM_POINT, 
		property = "sprite:scale", 
		to = _scale, 
		from = _scale - Vector2.ONE * 0.1, 
		point = point, 
		duration = 0.1, 
		items_delay = 0.05
	})
	anima.play()
