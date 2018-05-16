extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	var slot_preload = preload("res://SlotUI.tscn")
	
	var grid = $Grid
	for x in range(5):
		for y in range(5):
			var slot_ui = slot_preload.instance()
			slot_ui.rect_position = Vector2(x*64, y*64)
			slot_ui.get_node("Click").connect("pressed", self, "_select_slot", [slot_ui])
			grid.add_child(slot_ui)

func _select_slot(slot):
	print(slot)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
