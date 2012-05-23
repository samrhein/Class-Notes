/*
An object can only use this script after calling "setCollisionBounds."
0: Number of pixels right of the collision rectangle to check for a collision
with a solid object.
*/
corner_block=noone
above_corner_block=1

calculateCollisionBounds()

//corner_block = instance_position(rb+3,tb+10,oSolid)
corner_block2 = collision_line( rb+3, tb-6, rb+3, tb-3, oSolid, 0, 1 )
corner_block = collision_line( rb+3, tb-3, rb+3, tb+6, oSolid, 0, 1 )
//corner_block2 = instance_position(rb+3,tb+4,oSolid)

if corner_block!=noone{
    //above_corner_block = instance_position(corner_block.x+1,corner_block.y-1,oSolid)
    above_corner_block = collision_line( corner_block.phy_position_x, corner_block.phy_position_y-96, corner_block.phy_position_x, corner_block.phy_position_y-48, oSolid, 0, 1 )
}

if above_corner_block=noone and corner_block!=noone and corner_block2=noone
{
    return 1
}
return 0

