extends Node

var item = "Empty"
var quantity = 0
var neighbors = []

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

func gather():
	if quantity > 0:
		quantity -= 5
		if quantity <= 0:
			item = "Empty"