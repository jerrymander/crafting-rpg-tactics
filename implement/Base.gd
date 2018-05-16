extends Control

var slots

func _ready():
	randomize()
	_reset()
	$Reset.connect("pressed", self, "_reset")

func _reset():
	$Info/Text.bbcode_text = ""
	
	var grid = $Grid
	var previous = grid.get_children()
	for child in previous:
		grid.remove_child(child)
	
	var slot_ui_preload = preload("res://SlotUI.tscn")
	var slot_preload = preload("res://Slot.gd")
	
	slots = []
	for x in range(5):
		slots.append([])
		for y in range(5):
			var slot = slot_preload.new()
			slots[x].append(slot)
	
	_fill_slot("Tree", 3)
	_fill_slot("Boulder", 3)
	_fill_slot("Bush", 2)
	_fill_slot("Log", 1)
	_fill_slot("Rock", 2)
	
	for x in range(5):
		for y in range(5):
			var slot_ui = slot_ui_preload.instance()
			slot_ui.rect_position = Vector2(x*64, y*64)
			slot_ui.get_node("Click").connect("pressed", self, "_select_slot", [slot_ui])
			
			slot_ui.slot = slots[x][y]
			slot_ui.update_sprite()
			
			grid.add_child(slot_ui)

func _fill_slot(item, count):
	for x in range(count):
		var empty_slot = _get_empty_slot()
		empty_slot.item = item
		empty_slot.quantity = randi() % 20 + 20

func _select_slot(slot_ui):
	$Info/Text.bbcode_text = slot_ui.slot.description()

func _get_empty_slot():
	var empty_slots = []
	for x in range (slots.size()):
		for y in range (slots[x].size()):
			if (slots[x][y].item == "Empty"):
				empty_slots.append(slots[x][y])
	return empty_slots[randi() % empty_slots.size()]

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
