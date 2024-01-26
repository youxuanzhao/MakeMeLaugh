extends Node2D

@onready var face : Sprite2D = $Face
@onready var humorFrame : Sprite2D = $HumorDisplay/HumorFrame
@onready var humorBar : TextureProgressBar = $HumorDisplay/HumorBar
@onready var emotion : Sprite2D = $HumorDisplay/Emotion
@onready var label : Label = $HumorDisplay/HumorBar/PercentageLabel

var percentage:float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	humorBar.value = percentage
	emotion.position.x = percentage
	label.text = str(int(percentage)) + "%"

func chuckle():
	pass

func laugh():
	pass
