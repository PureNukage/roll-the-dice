if dicerolling == -1 {

	var width = 128
	var height = 64
	var xx = display_get_gui_width()/2 - width/2
	var yy = display_get_gui_height()/2 - height/2
	var text = "Move"
	var border = 3

	draw_set_color(c_black)
	draw_roundrect(xx-border,yy-border,xx+width+border,yy+height+border,false)
	if point_in_rectangle(mouse_gui_x,mouse_gui_y,xx-border,yy-border,xx+width+border,yy+height+border) {
		draw_set_color(c_lime)
	
		if input.mouseLeftPress {
			diceroll(dice1, 600, 50)
			diceroll(dice2, 0, 140)
		}
	}
	else {
		draw_set_color(c_green)
	}
	draw_roundrect(xx,yy,xx+width,yy+height,false)

	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_color(c_black)
	draw_text(xx+width/2,yy+height/2,text)
	draw_reset()
	
}

if dice1.state > -1 _diceroll(dice1, 1)
if dice2.state > -1 _diceroll(dice2, -1)