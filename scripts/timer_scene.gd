extends Node2D
@onready var live_container: HBoxContainer = $LiveContainer
@onready var live: TextureRect = $LiveContainer/Live
@onready var live_2: TextureRect = $LiveContainer/Live2
@onready var live_3: TextureRect = $LiveContainer/Live3
@onready var live_4: TextureRect = $LiveContainer/Live4
@onready var live_5: TextureRect = $LiveContainer/Live5
@onready var level_counter: RichTextLabel = $LevelCounter
@onready var timer: RichTextLabel = $Timer

@onready var time = 0

func _ready() -> void:
	await Timer(1) # using the function created
	
	Global.minigames_done = Global.minigames_done +1
	var i = RandomNumberGenerator.new().randi_range(1,4)
	while i == Global.lastMinigame:
		i = RandomNumberGenerator.new().randi_range(1,4)
	
	Global.lastMinigame = i
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Trasition.change_scene("res://Scenes/minigame_" + str(i) + ".tscn") # changes your scene by arranging this frankenstein path. 
	
# Above, your script is being told to go to the next minigame. If the 
# current minigame is Level 1, then you would be on minigame 1. If you 
# complete that level, you have the minigames_done add one, and then you 
# look for the scene titled `minigame_` and then whatever minigame number 
# should be next. Make sure you name your minigame saves appropriately.
	

func _process(delta: float) -> void: # runs EVERY FRAME
	match Global.lives: # asks or checks if lives is equal to one of 
#these values, cool hack. by the way this is a horrid way to illustrate the 
#lives visually so later you can always find alternative code. Now, dw abt it.

		4:
			live.hide()
		3:
			live.hide()
			live_2.hide()
		2:
			live.hide()
			live_2.hide()
			live_3.hide()
		1:
			live.hide()
			live_2.hide()
			live_3.hide()
			live_4.hide()
		0:
			live_container.hide() # just hides everything
		-1:
			Trasition.change_scene("res://Scenes/gameover.tscn")
	
	timer.text = str(time) # make ths text reflect the value of the time variable. this makes names easier. the str() converts the int to a String
	level_counter.text = "Level " + str(Global.minigames_done) # this tells you want minigame you're on using concatenation (google the word yo)

func Timer(start_time: float): # making a new function for timer countdown!
	# we want the timer to go down, and when it reaches 0 it transitions 
	# to the next scene!
	
	time = start_time # make the timer, which is reflected through the timer text, start at your desired number
	
	while time > 0.0: # run if timer hasnt reached 0
		await wait(0.1) # asks script to wait on this function. the 'wait' name for the function does nothing here, as await is just telling the scrpit to wait for the function to complete before progressing
		time -= 0.1 # remove 0.1
		# progressively get the value smaller and smaller
	
	#when timer reaches 0
	return

func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout # makes u wait, dw abt this being complex '''
