var hspd = input.keyRight - input.keyLeft
var vspd = input.keyDown - input.keyUp

if (hspd != 0 or vspd != 0) {
	var Direction = point_direction(0,0,hspd,vspd)
	setForce(1, Direction)
}

applyMovement()