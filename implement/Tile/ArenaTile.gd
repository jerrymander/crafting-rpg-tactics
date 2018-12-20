extends Sprite

var num_tiles = 10

func _ready():
	set("frame", randi()%num_tiles)
	#print("[TileSprite.tscn] Tile No. ", get("frame"))