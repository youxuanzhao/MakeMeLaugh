extends Node2D

class_name AudienceManager
static var instance: AudienceManager


# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func detect():
	for i in get_children():
		if i.isLooking:
			return true
	return false
