class_name Snake extends Node2D

const Utils = preload("utils.gd")

var head := Minisnake.new()
var body := [head] as Array[Minisnake]

var dead: bool = false

var current_direction := Vector2.RIGHT
var next_direction := Vector2.RIGHT

var _timer: Timer
var speed := 0.15

@onready var game_over = %game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	head.size = Game.CELL_SIZE
	head.colour = Colours.BLUE_DARK
	
	_timer = Timer.new()
	add_child(_timer)
	
	_timer.connect("timeout", move)
	_timer.set_wait_time(speed)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	
func _draw():
	draw_rect(head.get_rect(), head.colour)
	for minisnake in body:
		draw_rect(minisnake.get_rect(), minisnake.colour)

func _input(event):
	if event.is_action_pressed("move_left") and current_direction != Vector2.RIGHT:
		next_direction = Vector2.LEFT
	if event.is_action_pressed("move_right") and current_direction != Vector2.LEFT:
		next_direction = Vector2.RIGHT
	if event.is_action_pressed("move_up") and current_direction != Vector2.DOWN:
		next_direction = Vector2.UP
	if event.is_action_pressed("move_down") and current_direction != Vector2.UP:
		next_direction = Vector2.DOWN
		
	if event.is_action_pressed("restart") and dead:
		restart()


func move() -> void:
	if dead:
		return
	current_direction = next_direction
	var next_position = head.current_position + (current_direction*Game.CELL_SIZE)
	# Loops the snake on the grid
	next_position.x = fposmod(next_position.x, Game.GRID_SIZE.x)
	next_position.y = fposmod(next_position.y, Game.GRID_SIZE.y)
	head.current_position = next_position
	
	for i in range(1, body.size()):
		body[i].current_position = body[i-1].previous_position
	
	if Utils.position_occupied(head.get_rect(), body.slice(2, body.size())):
		dead = true
		game_over.visible = true
	

func grow() -> void:
	var minisnake := Minisnake.new()
	var last_minisnake := body.back() as Minisnake
	
	minisnake.current_position = last_minisnake.current_position
	minisnake.colour = Colours.BLUE
	minisnake.size = Game.CELL_SIZE
	body.push_back(minisnake)
	if speed > 0.01:
		speed = speed - 0.005
		_timer.set_wait_time(speed)
		

func restart():
	%spawner_food.spawn_food()
	speed = 0.15
	_timer.set_wait_time(speed)
	body = [head]
	head.current_position.x = 0
	head.current_position.y = 0
	dead = false
	game_over.visible = false
