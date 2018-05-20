extends Sprite

export(int) var animation_delay = 30

var animation_tick = 0
var current_frame = 0

func animate():
	set_physics_process(true)

func stop():
	set_physics_process(false)

func _ready():
	stop()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	animation_tick += 1
	if (animation_tick > animation_delay):
		animation_tick = 0
		current_frame = (current_frame + 1) % (hframes * vframes)
		call_deferred("_update_sprite_frame")

func _update_sprite_frame():
	frame = current_frame