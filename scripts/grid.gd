extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw() -> void:
	draw_rect(Rect2(0, 0, Game.GRID_SIZE.x, Game.GRID_SIZE.y), Colours.WHITE)

	for i in Game.CELL_AMOUNT.x:
		var from := Vector2(i*Game.CELL_SIZE.x, 0)
		var to := Vector2(from.x, Game.GRID_SIZE.y)
		draw_line(from, to, Colours.GREY)
		
	for i in Game.CELL_AMOUNT.y:
		var from := Vector2(0, i*Game.CELL_SIZE.y)
		var to := Vector2(Game.GRID_SIZE.x, from.y)
		draw_line(from, to, Colours.GREY)
