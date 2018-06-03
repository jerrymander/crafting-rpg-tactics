extends Node

var x
var y
var item = "Empty"
var quantity = 0
var neighbors = []
var subtiles = []

func _init():
	for y in range(2):
		var row = []
		for x in range(2):
			row.append({})
		subtiles.append(row)

func description():
	var description = []
	for desc_resc in _description_resources():
		description.append(desc_resc)
	for desc_enti in _description_entities():
		description.append(desc_enti)
	if description.size() == 0:
		description.append("Empty")
	return description

func _description_resources():
	var description = []
	if item != "Empty":
		description.append(item+": "+str(quantity))
	return description

func _description_entities():
	var description = []
	for entity in $Entities.get_children():
		description.append(entity.description())
	return description

func has_resource():
	return item != "Empty"

func has_room():
	return !_empty_subtiles().empty()

func add_item(item, quantity):
	self.item = item
	self.quantity = quantity
	
	var empty_subtiles = _empty_subtiles()
	var random_empty =  empty_subtiles[randi() % empty_subtiles.size()]
	random_empty[item] = quantity

func _empty_subtiles():
	var empty_subtiles = []
	for x in range (subtiles.size()):
		for y in range (subtiles[x].size()):
			if subtiles[x][y].empty():
				empty_subtiles.append(subtiles[x][y])
	return empty_subtiles

func gather():
	if quantity > 0:
		quantity -= 5
		if quantity <= 0:
			item = "Empty"