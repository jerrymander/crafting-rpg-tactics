extends PanelContainer

var subtile_sprites = []
var frames = {}

func _init():
	frames["Boulder"] = [3, 4, 5]
	frames["Tree"] = [9, 10, 11]
	frames["Empty"] = [14]
	frames["Bush"] = [8, 13]
	frames["Log"] = [12]
	frames["Rock"] = [6, 7]

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
			var item = "Empty"
			if !subtiles[x][y].empty():
				item = subtiles[x][y].keys().front()
			var item_frames = frames[item]
			subtile_sprites[x][y].frame = item_frames[randi() % item_frames.size()]

func _init_subtile_sprite(subtiles):
	var tile_sprites = load("res://CraftingTactics_Object_Tilesheet.png")
	
	var subtiles_height = subtiles.size()
	var subtiles_width = subtiles[0].size()
	for y in range(subtiles_height):
		var row = []
		for x in range(subtiles_width):
			var sprite = Sprite.new()
			sprite.texture = tile_sprites
			sprite.hframes = 4
			sprite.vframes = 4
			sprite.frame = frames["Log"][0]
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
