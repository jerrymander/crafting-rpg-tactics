extends PanelContainer

var style_default = preload("res://UI/SlotUI.tres")
var style_selected = preload("res://UI/SlotUI_selected.tres")

var frames = {}

func _ready():
	pass

func _init():
	frames["Boulder"] = [3, 4, 5]
	frames["Tree"] = [9, 10, 11]
	frames["Empty"] = [14]
	frames["Bush"] = [8, 13]
	frames["Log"] = [12]
	frames["Rock"] = [6, 7]

func update_sprite():
	var item_frames = frames[$Slot.item]
	$Sprite.frame = item_frames[randi() % item_frames.size()]
	
	if has_node("PlayerUI"):
		for neighbor in $Slot.neighbors:
			neighbor.get_parent().self_modulate = ColorN("palegreen", 1)

func slot():
	return $Slot

func select():
	_set_style(style_selected)

func deselect():
	_set_style(style_default)

func _set_style(style):
	set("custom_styles/panel", style)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
