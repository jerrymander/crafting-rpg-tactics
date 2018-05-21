extends PanelContainer

var style_default = preload("res://UI/SlotUI.tres")
var style_selected = preload("res://UI/SlotUI_selected.tres")

var frames = {}

func _ready():
	pass

func _init():
	frames["Boulder"] = [3, 4, 5]
	frames["Tree"] = [9, 10, 11]
	frames["Empty"] = [14]
	frames["Bush"] = [8, 13]
	frames["Log"] = [12]
	frames["Rock"] = [6, 7]

func update_sprite():
	var item_frames = frames[$Slot.item]
	$Sprite.frame = item_frames[randi() % item_frames.size()]
	
	#if _has_player():
	#	for neighbor in $Slot.neighbors:
	#		neighbor.get_parent().self_modulate = ColorN("palegreen", 1)

func slot():
	return $Slot

func select():
	_set_style(style_selected)

func deselect():
	_set_style(style_default)

func _set_style(style):
	set("custom_styles/panel", style)

func available_actions(player_slot_ui):
	var ACTION_REST = preload("res://Actions/ActionRest.gd")
	var ACTION_GATHER = preload("res://Actions/ActionGather.gd")
	var ACTION_WALK = preload("res://Actions/ActionWalk.gd")
	var actions = []
	if has_player():
		var player = get_player()
		var action_rest = _create_action(ACTION_REST)
		action_rest.player = player
		actions.append(action_rest)
		if slot().has_resource():
			var action_gather = _create_action(ACTION_GATHER)
			action_gather.slot = slot()
			action_gather.player = player
			actions.append(action_gather)
	else:
		var action_walk = _create_action(ACTION_WALK)
		action_walk.target_slot_ui = self
		action_walk.player = player_slot_ui.get_player()
		action_walk.player_slot_ui = player_slot_ui
		actions.append(action_walk)
	return actions

func _create_action(action_script):
	var action = preload("res://Actions/ActionUI.tscn").instance()
	action.set_script(action_script)
	return action

func has_player():
	return has_node("PlayerUI")

func get_player():
	return get_node("PlayerUI").player()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
