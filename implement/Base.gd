extends Control

var slots
var player

func _ready():
	randomize()
	_reset()
	$Reset.connect("pressed", self, "_reset")

func _reset():
	slots = []
	
	$Info/Text.bbcode_text = ""
	
	var grid = $Grid
	var previous = grid.get_children()
	for child in previous:
		grid.remove_child(child)
	
	var slot_ui_preload = preload("res://SlotUI.tscn")
	for x in range(5):
		slots.append([])
		for y in range(5):
			var slot_ui = slot_ui_preload.instance()
			slot_ui.rect_position = Vector2(x*64, y*64)
			slot_ui.update_sprite()
			slot_ui.get_node("Click").connect("pressed", self, "_select_slot", [slot_ui])
			grid.add_child(slot_ui)
			slots[x].append(slot_ui.get_node("Slot"))
			
	_link_neighbors()
	
	player = preload("res://Player.gd").new()
	player.name = "Player"
	$Stats/HP.setup("HP", funcref(player, "hp_get"))
	$Stats/AP.setup("AP", funcref(player, "ap_get"))
	$Stats/HP.update()
	$Stats/AP.update()
	slots[2][2].get_node("Entities").add_child(player)
	slots[2][2].get_parent().update_sprite()
	
	_fill_slot("Tree", 3)
	_fill_slot("Boulder", 3)
	_fill_slot("Bush", 2)
	_fill_slot("Log", 1)
	_fill_slot("Rock", 2)

func _link_neighbors():
	for x in range(slots.size()):
		for y in range(slots[x].size()):
			var neighbors = slots[x][y].neighbors
			if x+1 < slots.size():
				neighbors.append(slots[x+1][y])
			if x > 0:
				neighbors.append(slots[x-1][y])
			if y+1 < slots[x].size():
				neighbors.append(slots[x][y+1])
			if y > 0:
				neighbors.append(slots[x][y-1])

func _fill_slot(item, count):
	for x in range(count):
		var empty_slot = _get_empty_slot()
		empty_slot.item = item
		empty_slot.quantity = randi() % 20 + 20
		empty_slot.get_parent().update_sprite()

func _select_slot(slot_ui):
	var bbcode = ""
	for line in slot_ui.get_node("Slot").description():
		bbcode = bbcode + line + "\n"
	$Info/Text.bbcode_text = bbcode

func _get_empty_slot():
	var empty_slots = []
	for x in range (slots.size()):
		for y in range (slots[x].size()):
			if slots[x][y].item == "Empty":
				empty_slots.append(slots[x][y])
	return empty_slots[randi() % empty_slots.size()]

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
