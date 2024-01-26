extends Sprite2D

var isLooking : bool = false

@export var wait_interval : Array = [0.5,4.0]
@export var look_interval : Array = [0.1,1.2]

@onready var timer : Timer = $Timer

func _ready():
	timer = $Timer
	timer.start(randf_range(wait_interval[0],wait_interval[1]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if !(isLooking):
		isLooking = true
		timer.start(randf_range(look_interval[0],look_interval[1]))
	else:
		isLooking = false
		timer.start(randf_range(wait_interval[0],wait_interval[1]))
