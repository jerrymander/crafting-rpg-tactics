extends Control

var slots_ui
var player_ui

var selected_slot

onready var tileInfoText = $Info/TileInfo/Text

func _ready():
	randomize()
	add_to_group("player_update")
	add_to_group("tile_update")
	_reset()
	$Reset.connect("pressed", self, "_reset")

func _reset():
	slots_ui = []
	
	tileInfoText.bbcode_text = ""
	
	var grid = $Grid
	_remove_and_free_children(grid)
	
	selected_slot = null
	_remove_and_free_children($Info/ActionMenu/ActionList)
	
	var slot_ui_preload = preload("res://SlotUI.tscn")
	for x in range(5):
		slots_ui.append([])
		for y in range(5):
			var slot_ui = slot_ui_preload.instance()
			slot_ui.name = "SlotUI(%s,%s)" % [x, y]
			slot_ui.rect_position = Vector2(x*64, y*64)
			slot_ui.update_sprite()
			slot_ui.get_node("Click").connect("pressed", self, "_select_slot", [slot_ui])
			var slot = slot_ui.slot()
			slot.x = x
			slot.y = y
			
			grid.add_child(slot_ui)
			slots_ui[x].append(slot_ui)
			
	_link_neighbors()
	
	player_ui = preload("res://Player/PlayerUI.tscn").instance()
	$Stats/HP.setup("HP")
	$Stats/AP.setup("AP")
	_update_stats(player_ui.player())
	slots_ui[2][2].add_child(player_ui)
	get_tree().call_group("player_update", "player_update", player_ui.player())
	slots_ui[2][2].update_sprite()
	
	_fill_slot("Tree", 6)
	_fill_slot("Boulder", 6)
	_fill_slot("Bush", 4)
	_fill_slot("Log", 2)
	_fill_slot("Rock", 4)
	
	_update_action_menu()

func _link_neighbors():
	for x in range(slots_ui.size()):
		for y in range(slots_ui[x].size()):
			var neighbors = slots_ui[x][y].slot().neighbors
			if x+1 < slots_ui.size():
				neighbors.append(slots_ui[x+1][y].slot())
			if x > 0:
				neighbors.append(slots_ui[x-1][y].slot())
			if y+1 < slots_ui[x].size():
				neighbors.append(slots_ui[x][y+1].slot())
			if y > 0:
				neighbors.append(slots_ui[x][y-1].slot())

func _fill_slot(item, count):
	for x in range(count):
		var empty_slot = _get_empty_slot().slot()
		var quantity = randi() % 20 + 20
		empty_slot.add_item(item, quantity)
		empty_slot.get_parent().update_sprite()

func _select_slot(slot_ui):
	if selected_slot == slot_ui:
		slot_ui.deselect()
		selected_slot = null
		_update_tile_info(null)
	else:
		if selected_slot != null:
			selected_slot.deselect()
		selected_slot = slot_ui
		slot_ui.select()
		_update_tile_info(selected_slot.slot())
	_update_action_menu()

func tile_update(slot):
	_update_tile_info(slot)

func _update_tile_info(slot):
	if slot == null:
		tileInfoText.bbcode_text = ""
	else:
		var bbcode = "[center]Tile %s,%s - Dirt[/center]\n" % [slot.x, slot.y]
		for line in slot.description():
			bbcode = bbcode + line + "\n"
		tileInfoText.bbcode_text = bbcode

func _update_action_menu():
	var player_slot_ui = player_ui.get_parent()
	if selected_slot == null:
		_show_actions(player_slot_ui.available_actions(player_slot_ui))
	else:
		_show_actions(selected_slot.available_actions(player_slot_ui))

func _show_actions(actions):
	var action_list = $Info/ActionMenu/ActionList
	_remove_and_free_children(action_list)
	for action in actions:
		action.connect("pressed", self, "_pre_action", [action])
		$Info/ActionMenu/ActionList.add_child(action)

func _pre_action(action):
	action.do_action()

func _get_empty_slot():
	var empty_slots = []
	for x in range (slots_ui.size()):
		for y in range (slots_ui[x].size()):
			if slots_ui[x][y].slot().has_room():
				empty_slots.append(slots_ui[x][y])
	return empty_slots[randi() % empty_slots.size()]

func _remove_and_free_children(parent):
	var children = parent.get_children()
	for child in children:
		parent.remove_child(child)
		child.queue_free()

func player_update(player):
	_update_stats(player)
	_update_action_menu()
	
	var player_slot = player.get_parent().get_parent().slot()
	$Subtile.update_detail(player_slot)

func _update_stats(player):
	$Stats/HP.update(player.hp)
	$Stats/AP.update(player.ap)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
