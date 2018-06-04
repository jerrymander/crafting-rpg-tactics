var frame
var tile_sprites = load("res://CraftingTactics_Object_Tilesheet.png")
var hframes = 4
var vframes = 4

var description

func _init(item_type):
	match item_type:
		"Boulder":
			frame = _random_item([3, 4, 5])
		"Tree":
			frame = _random_item([9, 10, 11])
		"Empty":
			frame = _random_item([14])
		"Bush":
			frame = _random_item([8, 13])
		"Log":
			frame = _random_item([12])
		"Rock":
			frame = _random_item([6, 7])
	description = item_type

func _random_item(array):
	return array[randi() % array.size()]

func update_sprite(sprite):
	sprite.texture = tile_sprites
	sprite.hframes = 4
	sprite.vframes = 4
	sprite.frame = frame

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
