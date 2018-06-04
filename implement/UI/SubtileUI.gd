extends PanelContainer

var subtile_sprites = []

# TODO: combine pretty much entire copy/paste from SlotUI.gd

func _ready():
	pass

func update_detail(player_slot):
	if subtile_sprites.empty():
		_init_subtile_sprite(player_slot.subtiles)
	
	var subtiles = player_slot.subtiles
	var subtiles_height = subtiles.size()
	var subtiles_width = subtiles[0].size()
	for y in range(subtiles_height):
		for x in range(subtiles_width):
			var item = load("res://UI/ObjectUI.gd").new("Empty")
			if !subtiles[x][y].empty():
				item = subtiles[x][y].keys().front()
			item.update_sprite(subtile_sprites[x][y])

func _init_subtile_sprite(subtiles):
	var subtiles_height = subtiles.size()
	var subtiles_width = subtiles[0].size()
	for y in range(subtiles_height):
		var row = []
		for x in range(subtiles_width):
			var sprite = Sprite.new()
			row.append(sprite)
			$TileDetail.add_child(sprite)
		subtile_sprites.append(row)
	
	var scale = 1.0/max(subtiles_height, subtiles_width)
	var slot_rect = $TileDetail.rect_size
	slot_rect *= scale
	for y in range (subtiles_height):
		for x in range(subtiles_width):
			var sprite = subtile_sprites[x][y]
			sprite.scale = Vector2(2*scale, 2*scale)
			sprite.position = Vector2(slot_rect.x * x, slot_rect.y * y)
			sprite.centered = false
