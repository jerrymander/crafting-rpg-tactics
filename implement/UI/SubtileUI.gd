extends PanelContainer

var subtile_sprites = []

# TODO: combine pretty much entire copy/paste from SlotUI.gd

func _ready():
	pass

func update_detail(player_slot):
	if subtile_sprites.empty():
		_init_subtile_sprite(player_slot.subtiles)
	
	var subtiles = player_slot.subtiles
	for y in range(subtiles.height()):
		for x in range(subtiles.width()):
			subtiles.item(x, y).update_sprite(subtile_sprites[x][y])

func _init_subtile_sprite(subtiles):
	for y in range(subtiles.height()):
		var row = []
		for x in range(subtiles.width()):
			var sprite = Sprite.new()
			row.append(sprite)
			$TileDetail.add_child(sprite)
		subtile_sprites.append(row)
	
	var scale = 1.0/max(subtiles.height(), subtiles.width())
	var slot_rect = $TileDetail.rect_size
	slot_rect *= scale
	for y in range (subtiles.height()):
		for x in range(subtiles.width()):
			var sprite = subtile_sprites[x][y]
			sprite.scale = Vector2(2*scale, 2*scale)
			sprite.position = Vector2(slot_rect.x * x, slot_rect.y * y)
			sprite.centered = false
