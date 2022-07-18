////	Spawn ladder tiles

ladders = ds_list_create()
laddersMoving = false

function ladder_trim() {
	while ds_list_size(ladders) > 6 {
		var Ladder = ladders[| 6]
		ds_list_delete(ladders,6)
		instance_destroy(Ladder)
	}
	debug.log("ladders size: "+string(ds_list_size(ladders)))
}

//	Left Ladder
var xx = 128
var yy = 0
var Ladder = instance_create_layer(xx,yy,"Instances",ladder) yy += 70 ds_list_add(ladders, Ladder)
var Ladder = instance_create_layer(xx,yy,"Instances",ladder) yy += 70 ds_list_add(ladders, Ladder)
var Ladder = instance_create_layer(xx,yy,"Instances",ladder) yy += 70 ds_list_add(ladders, Ladder)
var Ladder = instance_create_layer(xx,yy,"Instances",ladder) yy += 70 ds_list_add(ladders, Ladder)
var BottomLeft = instance_create_layer(xx,yy,"Instances",ladder) yy += 70 ds_list_add(ladders, BottomLeft)
var Ladder = instance_create_layer(xx,yy,"Instances",ladder) yy += 70 ds_list_add(ladders, Ladder)

////	Right Ladder
//var xx = 416
//var yy = 0
//instance_create_layer(xx,yy,"Instances",ladder) yy += 70
//instance_create_layer(xx,yy,"Instances",ladder) yy += 70
//instance_create_layer(xx,yy,"Instances",ladder) yy += 70
//instance_create_layer(xx,yy,"Instances",ladder) yy += 70
//var BottomRight = instance_create_layer(xx,yy,"Instances",ladder) yy += 70
//instance_create_layer(xx,yy,"Instances",ladder) yy += 70

//	Spawn the player
var Player = instance_create_layer(BottomLeft.x + BottomLeft.sprite_width/2 + 5,BottomLeft.y + BottomLeft.sprite_height/2,"Instances",player)
Player.Ladder = BottomLeft


dicerolling = -1

function dice() constructor {
	x = -1;
	y = -1;
	angle = 0;
	value = -1;
	state = -1;
}

dice1 = new dice()
dice2 = new dice()

function diceroll(Dice, _x, _y) {
	Dice.state = 0
	Dice.value = irandom_range(1,6)
	Dice.x = _x
	Dice.y = _y
	dicerolling = 120
}

function _diceroll(Dice, x_mod) {
	var scale = 0.5
	switch(Dice.state) {
		//	Init
		case 0:
			Dice.angle = 0
			draw_sprite_ext(s_dice_blank,0,Dice.x,Dice.y,scale,scale,Dice.angle,c_white,1)
			Dice.state += 1
		break
		//	Roll into the center of the screen
		case 1:
			Dice.angle += 3 * x_mod
			Dice.x -= 3 * x_mod
			draw_sprite_ext(s_dice_blank,0,Dice.x,Dice.y,scale,scale,Dice.angle,c_white,1)
			
			if x_mod == -1 {
				if Dice.x >= display_get_gui_width()/2 {
					Dice.state += 1
					Dice.angle = 0
				}
			}
			else {
				if Dice.x <= display_get_gui_width()/2 {
					Dice.state += 1
					Dice.angle = 0
				}
			}
		break
		//	Pause for a bit with the dice on screen
		case 2:
			var sprite = asset_get_index("s_dice_"+string(Dice.value))
			var spriteWidth = sprite_get_width(sprite) * scale
			var spriteHeight = sprite_get_height(sprite) * scale
			draw_set_color(c_yellow)
			if point_in_rectangle(mouse_gui_x,mouse_gui_y,Dice.x-spriteWidth/2,Dice.y-spriteHeight/2,Dice.x+spriteWidth/2,Dice.y+spriteHeight/2) {
				var border = 5
				draw_rectangle(Dice.x-spriteWidth/2-border,Dice.y-spriteHeight/2-border,Dice.x+spriteWidth/2+border,Dice.y+spriteHeight/2+border,false)
				
				if input.mouseLeftPress {
					dicerolling = -1
					dice1.state = -1
					dice2.state = -1
					
					//	Find index of current player ladder in ladders list
					var Index = ds_list_find_index(ladders, player.Ladder)
					var newIndex = Index-Dice.value
					
					//	Find the difference between the segments and spawn in new ladder pieces
					var difference = Index - newIndex
					var xx = ladders[| 0].x
					var yy = ladders[| 0].y - 70
					
					for(var i=0;i<difference;i++) {
						var Ladder = instance_create_layer(xx,yy,"Instances",ladder) 
						yy -= 70
						
						//	Does this ladder segment get anything?
						var defaultRottenBananaOrTomato = choose(0,0,0,0,0, 1,1, 2,2, 3)
						
						switch(defaultRottenBananaOrTomato) {
							//	Default
							case 0:
								
							break
							//	Rotten
							case 1:
								Ladder.rotten = true
							break
							//	Banana
							case 2:
								Ladder.banana = true
							break
							//	Tomato
							case 3:
								Ladder.tomato = true
							break
						}
						
						
						ds_list_insert(ladders, 0, Ladder)
					}
					
					//	Set all ladders new goalX and goalY
					for(var i=0;i<ds_list_size(ladders);i++) {
						var Ladder = ladders[| i]
						Ladder.goalX = Ladder.x
						Ladder.goalY = Ladder.y + (difference * 70)
					}
					
					//	Refind players current ladder index and then find the new index
					var Index = ds_list_find_index(ladders, player.Ladder)
					var newIndex = Index-Dice.value
					player.Ladder = ladders[| newIndex]
					
					laddersMoving = true
					
				}
			}
			draw_sprite_ext(sprite,0,Dice.x,Dice.y,scale,scale,Dice.angle,c_white,1)
		break
	}
}

