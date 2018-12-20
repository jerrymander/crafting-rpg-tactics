extends Container

const TILE_SIZE = Vector2(88,48)

var tiles = []

var characters = []

var size

var events

func _ready():
	randomize()
	print("Randomized!")
	_generate_tiles(Vector2(8,5))
	pass

func _generate_tiles(map_size):
	
	var tile_offset_x = 0.5 * TILE_SIZE.x - 2
	var tile_offset_y = 0.5 * TILE_SIZE.y - 2
	var tile_preload = preload("res://Tile/TileSprite.tscn")
	
	for j in range(map_size.y):
		tiles.append([])
		for i in range(map_size.x):
			var new_tile = tile_preload.instance()
			new_tile.set("position", Vector2(tile_offset_x*j + tile_offset_x*i, tile_offset_y*i - tile_offset_y*j))
			add_child(new_tile)
			tiles[j].append(new_tile)
	
	var dim = map_size.x + map_size.y
	set("rect_size", Vector2(0.5*dim*TILE_SIZE.x, 0.5*dim*TILE_SIZE.y))