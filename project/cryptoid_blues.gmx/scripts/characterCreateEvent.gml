/*
This script should be placed in the "Create Event" of the platform character.
It sets the variables needed for the platform character.

You can edit the "user variables" if you don't want to use the default values.  

This script sets the collision bounds using this code: setCollisionBounds(-5,-7,5,8)
You can modify the arguments to make a collsion bounds that fits your own sprites.
If you are just going to use the default Mario sprites, there is no reason to edit
the arguments.
*/
testing = 0

//constant states that the platform character may be (don't edit)
STANDING=10
RUNNING=11
DUCKING=12
LOOKING_UP=13
CLIMBING=14
JUMPING=15
FALLING=16
DYING=17
LEFT=18
RIGHT=19
ON_GROUND=20
IN_AIR=21
ON_LADDER=22
DIGGINGDOWN=23
DIGGING=24
DIGGINGUP=25
BUILDING=26
HANGING=27
CLAWING=28

dead = false
dead_timer=0

digableID=noone
digableID2=noone

buildableID=noone
buildableID2=noone
unbuildable=true
buildbase=noone

this_switch=noone

dyno_cooldown=120
dyno_timer=dyno_cooldown

hurting=false
hurt_timer=0
hurt_flash=0
bleeding = false

picture_num = 0
picture_total = 5
pic_timer = 0
pic_take=false


health=5
potential_health=health

new_machine = noone
build_machine = true
build_switch = false

whoosh = false
digR = noone
dig_sound = false

//inventory array: 1st num as 0 is item/as 1 is quantity
/*potential_inv=10
inventory[0,0]=oCharcoalIcon
inventory[0,1]=oDirtIcon
inventory[0,2]=oFireIcon
inventory[0,3]=oGunpowderIcon
inventory[0,4]=oIronoreIcon
inventory[0,5]=oPebbleIcon
inventory[0,6]=oWoodIcon
inventory[0,7]=oSandIcon
inventory[0,8]=oStickIcon
inventory[0,9]=oTwineIcon

//random quanitity for each inventory item
for(i=0;i<10;i+=1){
    inventory[1,i]=irandom(30)
}*/

//new inventory
//materials
inventory[0]=5 //coal
inventory[1]=5 //gunpowder
inventory[2]=5 //wood
inventory[3]=5 //iron
//weapons
inventory[10]=7 //boomerang
inventory[11]=7 //dynomite
inventory[12]=7 //spikes
inventory[13]=7 //crate


//the keys that the platform character will use (don't edit)
kLeft=0
kRight=0
kUp=0
kDown=0
kJump=0
kJumpPressed=0
kRun=0

//user variables (you can edit these)
player=1                   //player number (player 2 uses different keyboard keys than player 1)
state=FALLING              //the character state, must be one of the following: STANDING, RUNNING, DUCKING, LOOKING_UP, CLIMBING, JUMPING, or FALLING
facing=RIGHT               //which direction the character is facing, must be either LEFT or RIGHT
initialJumpAcc=-100          //relates to how high the character will jump
jumpTimeTotal=14           //how long the user must hold the jump button to get the maximum jump height
runAnimSpeed=0.002          //relates to the how fast the running animation should go
climbAnimSpeed=0.0015
idleAnimSpeed=0.04
digAnimSpeed=0.3           
canRun=0                   //when the user presses the shift button, should the character be allowed to run?
canFly=0                   //whether the character can do a fly jump when running at full speed
canFlyJump=0               //whether the character can do continuous fly jumps (mid-air)
flyMaxJumps=5              //the maximum number of jumps the character can perform while flying
digSpeed=0.1

//sets the collision bounds to fit the default sprites (you can edit the arguments of the script)
setCollisionBounds(-12,-37,12,37)

//hidden variables (don't edit)
statePrev=state
statePrevPrev=statePrev
jumpTime=jumpTimeTotal     //current time of the jump (0=start of jump, jumpTimeTotal=end of jump)
jumpButtonReleased=0       //whether the jump button was released. (Stops the user from pressing the jump button many times to get extra jumps)
ladderTimer=0              //relates to whether the character can climb a ladder
jumps=0


var fix, inst;
fix = physics_fixture_create()
//physics_fixture_set_box_shape(fix, 12, 37)

physics_fixture_set_polygon_shape(fix)
physics_fixture_add_point(fix, -12,36)
physics_fixture_add_point(fix, -11, -37)
physics_fixture_add_point(fix, 11, -37)
physics_fixture_add_point(fix, 12, 36)
physics_fixture_add_point(fix, 11, 37)
physics_fixture_add_point(fix, -11, 37)

physics_fixture_set_density(fix, 0.3)
physics_fixture_set_restitution(fix, 0)
physics_fixture_set_linear_damping(fix, 0.4)
physics_fixture_set_angular_damping(fix, 1)
physics_fixture_set_collision_group(fix, 1)
inst = id
physics_fixture_bind(fix, inst)
physics_fixture_delete(fix)

phy_fixed_rotation = true

