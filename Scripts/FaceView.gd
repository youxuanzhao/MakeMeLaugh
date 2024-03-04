extends Node2D

@onready var face : Sprite2D = $Face
@onready var humorBar : TextureProgressBar = $HumorDisplay/HumorBar
@onready var delayBar : TextureProgressBar = $HumorDisplay/DelayBar
@onready var emotion : Sprite2D = $HumorDisplay/Emotion
@onready var label : Label = $HumorDisplay/HumorBar/PercentageLabel

var percentage:float = 0.0
var isPaused = false
@export var delayDecrease = 50
var delayTrigger = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isPaused:
		if percentage > delayBar.value:
			delayBar.value = percentage
		humorBar.value = percentage
		emotion.position.x = percentage
		label.text = str(int(percentage)) + "%"

func _physics_process(delta):
	if !isPaused:
		if delayTrigger && delayBar.value > percentage:
			delayBar.value = delayBar.value - (delayDecrease * delta)
		elif delayTrigger && delayBar.value <= percentage:
			delayTrigger = false

func chuckle():
	pass

func laugh():
	pass
