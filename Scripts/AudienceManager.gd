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
	return $BackRow/Friend.isLooking

func pause():
	$BackRow/Friend/AnimationTree.active = false
	$BackRow/Friend/AnimationPlayer.pause()
	
func resume():
	$BackRow/Friend/AnimationTree.active = true
	$BackRow/Friend/AnimationPlayer.play()
