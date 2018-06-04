var grid = []

func _init(width, height):
	for y in range(height):
		var row = []
		for x in range(width):
			row.append({})
		grid.append(row)

func height():
	return grid.size()

func width():
	return grid[0].size()

func has_room():
	return !_empty_subtiles().empty()

func item(x, y):
	if grid[x][y].empty():
		return load("res://UI/ObjectUI.gd").new("Empty")
	else:
		return grid[x][y].keys().front()

func add_random(item, quantity):
	var empty_subtiles = _empty_subtiles()
	var random_empty =  empty_subtiles[randi() % empty_subtiles.size()]
	random_empty[item] = quantity

func _empty_subtiles():
	var empty_subtiles = []
	for x in range (grid.size()):
		for y in range (grid[x].size()):
			if grid[x][y].empty():
				empty_subtiles.append(grid[x][y])
	return empty_subtiles