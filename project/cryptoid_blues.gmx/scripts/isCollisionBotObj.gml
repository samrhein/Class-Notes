/*
An object can only use this script after calling "setCollisionBounds."
0: Number of pixels below the collision rectangle to check for a collision
1: object we're colliding with
*/
calculateCollisionBounds()
if collision_line(round(lb),round(bb+argument0-1),round(rb-1),round(bb+argument0-1),argument1,0,1)>0
  return 1
return 0
