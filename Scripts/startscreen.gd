extends Node2D

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	animationPlayer.play("to_next_level")

func _on_credits_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()

func _enter_level():
	get_tree().change_scene_to_file("res://Scenes/cutscene01.tscn")
