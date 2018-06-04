extends Node

var x
var y
var item
var quantity
var neighbors = []
var subtiles

func _init():
	subtiles = load("res://Tile/Subtiles.gd").new(2, 2)

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
	if item != null:
		description.append(item.description+": "+str(quantity))
	return description

func _description_entities():
	var description = []
	for entity in $Entities.get_children():
		description.append(entity.description())
	return description

func has_resource():
	return item != null

func has_room():
	return subtiles.has_room()

func add_item(item, quantity):
	self.item = load("res://UI/ObjectUI.gd").new(item)
	self.quantity = quantity
	
	subtiles.add_random(self.item, quantity)

func gather():
	if quantity > 0:
		quantity -= 5
		if quantity <= 0:
			item = null