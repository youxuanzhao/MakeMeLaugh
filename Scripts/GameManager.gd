extends Node2D

class_name GameManager
static var instance : GameManager

@onready var audienceView = $AudienceView
@onready var audience = $AudienceView/Audience
@onready var stageManager = $AudienceView/StageManager
@onready var faceView = $FaceView
@onready var timerView = $TimerView
@onready var timer = $TimerView/Timer
@onready var cooldown = $Cooldown

var humor = 0
var isCooldown : bool = false
var gameOver = false
var win = false

@export_group("Values")
@export var base = 1
@export var level_factor = [0.2,0.3,0.5]
@export var level_length = [10,20,30]
@export var level = 0
@export var reduce_each_time = 10
@export var humor_limit = 100
@export var chuckle_cooldown = 1.5


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $TimerView/Timer
	timer.start(level_length[level])
	if(Input.is_action_just_pressed("space")):
		chuckle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gameOver = humor >= humor_limit
	

func chuckle():
	if !(isCooldown):
		gameOver = AudienceManager.instance.detect()
		if humor > reduce_each_time:
			humor -= reduce_each_time
		else:
			humor = 0
		isCooldown = true
		cooldown.start(chuckle_cooldown)




func _on_cooldown_timeout():
	isCooldown = false


func _on_timer_timeout():
	win = true
