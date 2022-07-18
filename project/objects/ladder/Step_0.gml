//	Shift down
if (goalX != -1 or goalY != -1) {
	if point_distance(x,y, goalX,goalY) > 1 {
		var Direction = point_direction(x,y, goalX,goalY)
		setForce(1, Direction)
	}
	else {
		goalX = -1
		goalY = -1
		controller.ladder_trim()
		
		controller.laddersMoving = false
	}
}

if rotten and sprite_index != s_ladder_tile_rotten sprite_index = s_ladder_tile_rotten

applyMovement()