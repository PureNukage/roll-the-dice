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
var Player = instance_create_layer(BottomLeft.x + BottomLeft.sprite_width/2,BottomLeft.y + BottomLeft.sprite_height/2,"Instances",player)

dice = {
	x : -1,
	y : -1,
	angle: 0,
	value : -1,
	state : -1
}
function diceroll() {
	dice.state = 0
	dice.value = irandom_range(1,6)
}

function _diceroll() {
	var scale = 0.5
	switch(dice.state) {
		//	Init
		case 0:
			dice.x = 600
			dice.y = 60
			dice.angle = 0
			draw_sprite_ext(s_dice_blank,0,dice.x,dice.y,scale,scale,dice.angle,c_white,1)
			dice.state += 1
		break
		//	Roll into the center of the screen
		case 1:
			dice.angle += 2
			dice.x -= 2
			draw_sprite_ext(s_dice_blank,0,dice.x,dice.y,scale,scale,dice.angle,c_white,1)
			
			if dice.x <= display_get_gui_width()/2 {
				dice.state += 1
				dice.angle = 0
			}
		break
		//	Pause for a bit with the dice on screen
		case 2:
			draw_sprite_ext(asset_get_index("s_dice_"+string(dice.value)),0,dice.x,dice.y,scale,scale,dice.angle,c_white,1)
		break
	}
}

