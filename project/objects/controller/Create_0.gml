////	Spawn ladder tiles
//	Left Ladder
var xx = 128
var yy = 0
instance_create_layer(xx,yy,"Instances",ladder) yy += 70
instance_create_layer(xx,yy,"Instances",ladder) yy += 70
instance_create_layer(xx,yy,"Instances",ladder) yy += 70
instance_create_layer(xx,yy,"Instances",ladder) yy += 70
var BottomLeft = instance_create_layer(xx,yy,"Instances",ladder) yy += 70
instance_create_layer(xx,yy,"Instances",ladder) yy += 70

//	Right Ladder
var xx = 416
var yy = 0
instance_create_layer(xx,yy,"Instances",ladder) yy += 70
instance_create_layer(xx,yy,"Instances",ladder) yy += 70
instance_create_layer(xx,yy,"Instances",ladder) yy += 70
instance_create_layer(xx,yy,"Instances",ladder) yy += 70
var BottomRight = instance_create_layer(xx,yy,"Instances",ladder) yy += 70
instance_create_layer(xx,yy,"Instances",ladder) yy += 70

//	Spawn the player
var Player = instance_create_layer(BottomLeft.x + BottomLeft.sprite_width/2 + 5,BottomLeft.y + BottomLeft.sprite_height/2,"Instances",player)


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
			
			debug.log(object_get_name(dice1))
			
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
				}
			}
			draw_sprite_ext(sprite,0,Dice.x,Dice.y,scale,scale,Dice.angle,c_white,1)
			//dicerolling -= 1
			//if dicerolling <= 0 {
			//	dicerolling = -1
			//	Dice.state = -1
			//}
		break
	}
}

