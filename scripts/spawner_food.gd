extends Node2D
const Utils = preload("utils.gd")

var food := Food.new()
@onready var snake = %snake as Snake


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_food()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	

func _draw():
	draw_rect(food.get_rect(), food.colour)
	
	if food.get_rect().intersects(snake.head.get_rect()):
		snake.grow()
		spawn_food()
		

func spawn_food() -> void:
	food.position = Utils.random_position()
	
	while Utils.position_occupied(food.get_rect(), snake.body):
		food.position = Utils.random_position()
