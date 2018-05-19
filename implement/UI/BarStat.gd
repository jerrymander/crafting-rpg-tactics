extends HBoxContainer

var value_get_function

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func setup(label, value_get_function):
	$Label.text = label;
	self.value_get_function = value_get_function

func update():
	# switch to bars display eventually
	$Value.text = str(value_get_function.call_func())
