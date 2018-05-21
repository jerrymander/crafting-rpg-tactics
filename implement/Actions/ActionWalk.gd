extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var target_slot_ui
var player_slot_ui
var player

var distance_map = {}

func _ready():
	_calculate_distance()
	text = "Walk (%s)" % _distance()
	if _distance() > player.ap:
		disabled = true

func do_action():
	player.ap_add(-_distance())
	get_tree().call_group("player_update", "player_update", player)
	var player_ui = player_slot_ui.get_node("PlayerUI")
	player_slot_ui.remove_child(player_ui)
	target_slot_ui.add_child(player_ui)

func _distance():
	return distance_map[target_slot_ui.slot()]

func _calculate_distance():
	var start = player_slot_ui.slot()
	distance_map[start] = 0
	var to_visit = []
	to_visit.append(start)
	
	while !to_visit.empty():
		var current_slot = to_visit.pop_front()
		var current_distance = distance_map[current_slot]
		for neighbor in current_slot.neighbors:
			if !distance_map.has(neighbor):
				distance_map[neighbor] = current_distance+1
				to_visit.append(neighbor)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
