extends HBoxContainer

var value_get_function

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func setup(label):
	$Label.text = label;

func update(value):
	# switch to bars display eventually
	$Value.text = str(value)
