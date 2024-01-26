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

@export_group("Values")
@export var base = 10
@export var level_factor = [0.8,0.3,0.5]
@export var level_friends_number = [1,2,3]
@export var level_length = [10,20,30]
@export var level = 0
@export var reduce_each_time = 10
@export var humor_limit = 100
@export var chuckle_cooldown = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $TimerView/Timer
	timer.start(level_length[level])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	faceView.percentage = float(humor)/float(humor_limit) * 100
	if faceView.percentage >= 100:
		faceView.percentage = 100
	
	if(Input.is_action_just_pressed("space")):
		chuckle()
	if humor >= humor_limit:
		faceView.laugh()
	

func _physics_process(delta):
	humor += base * level_factor[level] * delta

func chuckle():
	if !(isCooldown):
		faceView.chuckle()
		if audience.detect():
			gameOver()
		if humor > reduce_each_time:
			humor = humor - reduce_each_time
		else:
			humor = 0
		isCooldown = true
		cooldown.start(chuckle_cooldown)




func _on_cooldown_timeout():
	isCooldown = false


func _on_timer_timeout():
	gameWin()

func gameOver():
	pass
	
func gameWin():
	pass
