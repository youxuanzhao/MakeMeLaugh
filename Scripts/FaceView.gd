extends Node2D

@onready var face : Sprite2D = $Face
@onready var humorFrame : Sprite2D = $HumorFrame
@onready var humorCover : Sprite2D = $HumorCover
@onready var humorUnder : Sprite2D = $HumorUnder
@onready var emotion : Sprite2D = $Emotion

var percentage:float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	humorCover.position.x = percentage
	emotion.position.x = percentage

func chuckle():
	pass

func laugh():
	pass
