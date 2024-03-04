extends Node2D

@export var path = "res://Scenes/startscreen.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer2.play("idle")
	$AnimationPlayer.play("black_start")
	await get_tree().create_timer(10).timeout
	$AnimationPlayer.play("to_next_level")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _enter_level():
	get_tree().change_scene_to_file(path)
