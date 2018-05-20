extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	text = "Rest"

func do_action(player):
	player.hp_add(1)
	player.ap_add(1)
	get_tree().call_group("player_update", "player_update", player)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
