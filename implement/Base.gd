extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var sprite = Sprite.new()
	var texture = load("res://CraftingTactics_Object_Tilesheet.png")
	sprite.texture = texture;
	add_child(sprite)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
