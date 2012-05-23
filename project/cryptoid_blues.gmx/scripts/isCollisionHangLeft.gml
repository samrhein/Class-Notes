/*
An object can only use this script after calling "setCollisionBounds."
0: Number of pixels right of the collision rectangle to check for a collision
with a solid object.
*/
corner_block=noone
above_corner_block=1

calculateCollisionBounds()

corner_block2 = collision_line( lb-3, tb-6, lb-3, tb-3, oSolid, 0, 1 )
corner_block = collision_line( lb-3, tb-3, lb-3, tb+6, oSolid, 0, 1 )

if corner_block!=noone{
    above_corner_block = collision_line( corner_block.phy_position_x, corner_block.phy_position_y-96, corner_block.phy_position_x, corner_block.phy_position_y-48, oSolid, 0, 1 )
}

if above_corner_block=noone and corner_block2=noone and corner_block!=noone
{
    return 1
}
return 0

