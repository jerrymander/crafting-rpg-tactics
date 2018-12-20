extends Container

onready var Map = get_node("Panel/ScrollContainer/Map")
var map_size

func _ready():
	map_size = Map.get("rect_size")
	print("[combatdemo.gd] Map Size: ", Map.get("rect_size"))
	Map.set("rect_position", Vector2(-0.5*map_size.x, 0.5*map_size.y))
	print("[combatdemo.gd] Map Position: ", Map.get("rect_position"))