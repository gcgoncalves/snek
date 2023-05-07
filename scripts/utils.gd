static func random_position() -> Vector2:
	var random_position := Vector2()
	random_position.x = randi_range(0, Game.CELL_AMOUNT.x-1) * Game.CELL_SIZE.x
	random_position.y = randi_range(0, Game.CELL_AMOUNT.y-1) * Game.CELL_SIZE.y
	return random_position

static func position_occupied(position: Rect2, minisnakes: Array[Minisnake]) -> bool:
	var is_on_occupied_position = false
	for minisnake in minisnakes:
		if position.intersects(minisnake.get_rect()):
			is_on_occupied_position = true
	return is_on_occupied_position
