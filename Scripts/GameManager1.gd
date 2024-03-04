extends Node2D

static var instance : GameManager


@onready var audienceView = $AudienceView
@onready var audience = $AudienceView/Audience
@onready var stageManager = $AudienceView/StageManager
@onready var faceView = $FaceView
@onready var faceViewAnimationPlayer = $FaceView/AnimationPlayer
@onready var timerView = $TimerView
@onready var timer = $TimerView/Timer
@onready var delay = $BarDelay
@onready var cooldown = $Cooldown
@onready var animationTree = $FaceView/AnimationTree
@onready var menu = $Menu
@onready var blackFadeAnimation = $BlackFade/AnimationPlayer

var humor = 0
var chuckleCount = 0
var isCooldown : bool = false
var isChuckle = false
var isMenu = false
var lose = false
var isPaused = false

@export_group("Values")
@export var base : int= 10
@export var level_factor : Array = [0.8,0.3,0.5]
@export var level_friends_number : Array = [1,2,3]
@export var level_length : Array = [10,20,30]
@export var level : int = 0
@export var reduce_each_time : int = 3
@export var humor_limit : int= 100
@export var chuckle_cooldown : float = 0.5
@export var delay_time : float = 0.6
@export var detect_time : float = 1.2


# Called when the node enters the scene tree for the first time.
func _ready():
	blackFadeAnimation = $BlackFade/AnimationPlayer
	Engine.max_fps = 120
	timer = $TimerView/Timer
	timer.start(level_length[level])
	if level == 0:
		pauseEveryThing()
		menu.visible = true
		$Menu/Button.visible = false
		$Menu/Label.visible = true
		
		await get_tree().create_timer(5).timeout
		
		resumeEveryThing()
		menu.visible = false
		$Menu/Button.visible = true
		$Menu/Label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if(Input.is_action_just_pressed("escape")):
		if !isMenu:
			isPaused = true
			isMenu = true
			faceView.isPaused = true
			menu.visible = true
			cooldown.paused = true
			delay.paused = true
			timer.paused = true
			animationTree.active = false
			audience.pause()
			faceViewAnimationPlayer.pause()
		else:
			isPaused = false
			isMenu = false
			faceView.isPaused = false
			menu.visible = false
			cooldown.paused = false
			delay.paused = false
			timer.paused = false
			animationTree.active = true
			audience.resume()
			faceViewAnimationPlayer.play()
			
	if !isPaused:
		animationTree.set("parameters/conditions/chuckleCount",chuckleCount)
		if faceView.percentage >= 100:
			faceView.percentage = 100
		
		if(Input.is_action_pressed("space")):
			isChuckle = true
			chuckle()
		if(Input.is_action_just_released("space")):
			isChuckle = false
			chuckleCount = 0

	

func _physics_process(delta):
	if !isPaused:
		faceView.percentage = float(humor)/float(humor_limit) * 100
		if(!isChuckle):
			humor += base * level_factor[level] * delta

func chuckle():
	if !(isCooldown):
		chuckleCount = chuckleCount + 1
		faceView.chuckle()
		if humor > reduce_each_time:
			humor = humor - reduce_each_time
		else:
			humor = 0
		isCooldown = true
		delay.start(delay_time)
		cooldown.start(chuckle_cooldown)
	await detect()




func _on_cooldown_timeout():
	isCooldown = false


func _on_timer_timeout():
	gameWin()

func gameOver():
	lose=true
	isPaused = true
	blackFadeAnimation.play("black_fade_lose")
	timer.paused = true
	faceView.isPaused = true
	
func gameWin():
	isPaused = true
	blackFadeAnimation.play("black_fade_win")
	timer.paused = true
	faceView.isPaused = true

func next_level():
	get_tree().change_scene_to_file(str("res://Scenes/cutscene03.tscn"))

func return_menu():
	get_tree().change_scene_to_file("res://Scenes/startscreen.tscn")


func _on_bar_delay_timeout():
	faceView.delayTrigger = true


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/startscreen.tscn")

func detect():
	if audience.detect():
		await get_tree().create_timer(detect_time).timeout
		if audience.detect() && isChuckle && !isPaused:
			gameOver()

func pauseEveryThing():
	isPaused = true
	faceView.isPaused = true
	cooldown.paused = true
	delay.paused = true
	timer.paused = true
	animationTree.active = false
	audience.pause()
	faceViewAnimationPlayer.pause()

func resumeEveryThing():
	isPaused = false
	faceView.isPaused = false
	cooldown.paused = false
	delay.paused = false
	timer.paused = false
	animationTree.active = true
	audience.resume()
	faceViewAnimationPlayer.play()
