if on {
	
	if instance_exists(player) with player {
		draw_text(15,15,"player.x: "+string(player.x))
		draw_text(15,30,"player.y: "+string(player.y))
		draw_text(15,45,"player.Ladder: "+string(ds_list_find_index(controller.ladders, player.Ladder)))
	}
	
}