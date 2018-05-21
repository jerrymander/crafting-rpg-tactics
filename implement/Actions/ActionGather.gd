extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var slot
var player

func _ready():
	text = "Gather"

func do_action():
	player.ap_add(-1)
	slot.gather()
	get_tree().call_group("player_update", "player_update", player)
	get_tree().call_group("tile_update", "tile_update", slot)
	slot.get_parent().update_sprite()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
