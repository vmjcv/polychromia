extends Node

signal creating_level
signal level_creation_finished
signal last_level_completed

var grid setget set_grid, get_grid

var disabled: = false
var dragging
var last_mouse_position:Vector2

func _ready():
	pass
	

func _input(event):
	if not grid or grid.is_completed or disabled:
		return 
	
	var mouse_pos = grid.pixel_to_grid(grid.get_local_mouse_position())
	
	if event is InputEventMouseMotion and dragging and last_mouse_position != mouse_pos:
		var dir = (mouse_pos - last_mouse_position).normalized()
		if not (
			grid.is_in_grid(grid.get_local_mouse_position())
			 and is_valid_direction(dir)
			 and (last_mouse_position - mouse_pos).length() == 1
		):
			return 
			
		var lines = grid.get_lines_at_cell(last_mouse_position)
		last_mouse_position = mouse_pos
			
		if not lines.size():
			return 
		var successful_move = false
		if lines.has(dragging):
			successful_move = grid.move_line_to_cell(dragging, mouse_pos)
		if not successful_move:
			dragging = true
			for line in lines:
				if grid.move_line_to_cell(line, mouse_pos):
					dragging = line
					break
	
	
	if not (event is InputEventMouseButton and event.button_index == BUTTON_LEFT):
		return 

	dragging = event.is_pressed()
	
	last_mouse_position = mouse_pos if dragging else last_mouse_position

func set_grid(_grid:Node2D):
	grid = _grid
	if grid.is_connected("completed", self, "_on_level_completed"):
		grid.disconnect("completed", self, "_on_level_completed")
	grid.connect("completed", self, "_on_level_completed")
	create_level(true)

func get_grid():
	return grid

func save_completed_levels(completed:Array, unlocked:Array):
	var file = File.new()
	var data: = {}
	if file.file_exists(UGC.autoload.get_autoload("Global").save_file):
		file.open(UGC.autoload.get_autoload("Global").save_file, File.READ)
		data = file.get_var(true)
		file.close()
	
	if not data.has("completed_levels"):
		data.completed_levels = {}
	if not data.has("unlocked_levels"):
		data.unlocked_levels = {}
	
	for index in completed:
		data.completed_levels[index] = true
	
	for index in unlocked:
		data.unlocked_levels[index] = false
		
	
	file.open(UGC.autoload.get_autoload("Global").save_file, File.WRITE)
	file.store_var(data, true)
	file.close()
	
func create_level(load_level:bool = false):
	if not grid:
		return 
		
	emit_signal("creating_level")
	
	grid.is_completed = false
	grid.clear_grid()
	yield (grid, "grid_cleared")
	grid.size = UGC.autoload.get_autoload("Levels").levels[UGC.autoload.get_autoload("Global").current_level].grid_size
	grid.build_grid()
	
	for cell in UGC.autoload.get_autoload("Levels").levels[UGC.autoload.get_autoload("Global").current_level].cells:
		grid.add_color(cell.position, cell.type, cell.color)
	
	yield (grid.anima, "animation_completed")
	if load_level:
		load_level_data()
	
	disabled = false
	emit_signal("level_creation_finished")
	
func load_level_data():
	if not UGC.autoload.get_autoload("Levels").saved_level_progress.has(UGC.autoload.get_autoload("Global").current_level):
		return 
	var data = UGC.autoload.get_autoload("Levels").saved_level_progress[UGC.autoload.get_autoload("Global").current_level]
	
	if not grid.size == data.grid_size:
		return 
	
	for cell in grid.get_node("cells").get_children():
		var cell_data = data.cells[cell.get_index()]
		if not UGC.autoload.get_autoload("Global").is_valid_type(cell.type):
			cell.color = cell_data.color
		for line in cell_data.lines:
			cell.lines.append(grid.get_node("lines").get_child(line))
		cell.completed = cell_data.completed
	
	for cell in grid.get_node("cells").get_children():
		var cell_data = data.cells[cell.get_index()]
		if not UGC.autoload.get_autoload("Global").is_valid_type(cell.type):
			cell.color = cell_data.color
		for line in cell_data.lines:
			var _l = grid.get_node("lines").get_child(line)
			if not cell.lines.has(_l):
				cell.lines.append(_l)
		cell.completed = cell_data.completed
	
	for line in grid.get_node("lines").get_children():
		var line_data = data.lines[line.get_index()]
		line.colors = line_data.colors
		line.grid_points = line_data.grid_points
		line.points = line_data.points
		line.gradient = line_data.gradient
	
func is_valid_direction(dir:Vector2):
	return [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN].has(dir)
	


func _on_level_completed():
	UGC.autoload.get_autoload("Levels").levels[UGC.autoload.get_autoload("Global").current_level].completed = true
	UGC.autoload.get_autoload("Levels").levels[UGC.autoload.get_autoload("Global").current_level].locked = false
	
	UGC.autoload.get_autoload("Levels").saved_level_progress.erase(UGC.autoload.get_autoload("Global").current_level)
	var levels = [UGC.autoload.get_autoload("Global").current_level]
	
	UGC.autoload.get_autoload("Global").current_level += 1
	UGC.autoload.get_autoload("Global").current_level = UGC.autoload.get_autoload("Global").current_level if UGC.autoload.get_autoload("Global").current_level < UGC.autoload.get_autoload("Levels").levels.size() else 0
	levels.append(UGC.autoload.get_autoload("Global").current_level)
	
	UGC.autoload.get_autoload("Levels").levels[UGC.autoload.get_autoload("Global").current_level].locked = false
	save_completed_levels([levels[0]], [levels[1]])
	
	if UGC.autoload.get_autoload("Global").current_level:
		create_level()
		return 
	emit_signal("last_level_completed")
	

func _on_Undo_pressed():
	if grid and not disabled:
		grid.undo_move()

func _on_Restart_pressed():
	if not disabled:
		create_level()
