/*
This script should be placed in the step event for the platform character.
It updates the keys used by the character, moves all of the solids, moves the
character, sets the sprite index, and sets the animation speed for the sprite.
*/
if dead = true {
    dead_timer += 1
    //room_speed = 5
}
if dead_timer > 25 {
    room_restart()
}

kAttack = keyboard_check(ord('R'))
kAttackPressed = keyboard_check_pressed(ord('R'))

if(dead = false){
if(player=1)
{

  //updates the keys
  //key left
  kLeftReleased=0
  if(kLeft)
  {
    kLeft=keyboard_check(ord( 'A' ));
    kLeftPushedSteps+=1;
    kLeftPressed=0;
    if (kLeft=0)
      kLeftReleased=1;
  }
  else
  {
    kLeft=keyboard_check(ord( 'A' ))
    if kLeft
      kLeftPressed=1
    kLeftPushedSteps=0
  }
  //key right
  kRightReleased=0
  if kRight
  {
    kRight=keyboard_check(ord( 'D' ))
    kRightPushedSteps+=1
    kRightPressed=0
    if kRight=0
      kRightReleased=1
  }
  else
  {
    kRight=keyboard_check(ord( 'D' ))
    if kRight
      kRightPressed=1
    kRightPushedSteps=0
  }
  //key up
  kUp=keyboard_check(ord( 'W' ))
  //key down
  kDown=keyboard_check(ord( 'S' ))
  //key "run"
  if canRun
    kRun=keyboard_check(vk_shift)
  else
    kRun=0
  //key "jump"
  if kJump
  {
    kJump=keyboard_check(vk_space)
    kJumpPressed=0
  }
  else
  {
    kJump=keyboard_check(vk_space)
    if kJump
      kJumpPressed=1
  }
}

//deals with the ladderTimer
if state=CLIMBING
  ladderTimer=10
else
{
  if ladderTimer>0
    ladderTimer-=1
}
//allows the character to run left and right
if state!=DUCKING and state!=DIGGINGDOWN and state!=DIGGING and state!=DIGGINGUP and state!=LOOKING_UP and state!=CLIMBING and state!=CLAWING
{
  if kLeft
  {
    if (kLeftPushedSteps>2 or isCollisionMoveableSolidRight(1)) and (facing=LEFT or abs(phy_linear_velocity_x)<0.01){
      if abs(phy_linear_velocity_x) < 150 {
        if platformCharacterIs(IN_AIR){
            physics_apply_force(x, y, -30, 0)
        }else{
            physics_apply_force(x, y, -150, 0)
        }
      }
    }
    facing=LEFT
  }
  if kRight
  {
    if (kRightPushedSteps>2 or isCollisionMoveableSolidLeft(1)) and (facing=RIGHT or abs(phy_linear_velocity_x)<0.01){
      if abs(phy_linear_velocity_x) < 150 {
        if platformCharacterIs(IN_AIR){
            physics_apply_force(x, y, 30, 0)
        }else{
            physics_apply_force(x, y, 150, 0)
        }
      }
    }
    facing=RIGHT
  }
}
if state=CLIMBING and isCollisionLadder()=0
{
  state=FALLING
}
if state=CLIMBING
{
phy_linear_velocity_y=-22
  if kLeft
  {
    physics_apply_force(x, y, -30, 0)
    facing=LEFT  
  } else if kRight
  {
    physics_apply_force(x, y, 30, 0)
    facing=RIGHT
  } else {
    phy_linear_velocity_x *= 0.5
  }
  if kUp {
    phy_linear_velocity_y=-120
  }
  if kDown {
    phy_linear_velocity_y=120
  }
}  
    
    
if (isCollisionBottom(3) or isCollisionPlatformBottom(3) and isCollisionPlatform()=0) and platformCharacterIs(IN_AIR) and phy_linear_velocity_y>=0
{
  //player has just landed
  state=RUNNING
  jumps=0
}
//if the character has just walked off of the edge of a solid
if isCollisionBottom(3)=0 and (isCollisionPlatformBottom(3)=0 or isCollisionPlatform()) and platformCharacterIs(ON_GROUND)
{
  state=FALLING;
}
if isCollisionTop(1) and state=JUMPING
{
}
if (isCollisionLeft(1) and facing=LEFT) or (isCollisionRight(1) and facing=RIGHT)
{
}
//player may jump
if platformCharacterIs(ON_GROUND) and kJumpPressed
{
    physics_apply_force(x, y, 0, -800)

  //the "state" gets changed to JUMPING later on in the code
  state=FALLING
  //"variable jumping" states
  jumpButtonReleased=0
  jumpTime=0
}
if jumpTime<jumpTimeTotal
  jumpTime+=1
//let the character continue to jump
if kJump=0
  jumpButtonReleased=1
if jumpButtonReleased
  jumpTime=jumpTimeTotal
if kUp and platformCharacterIs(ON_GROUND) and isCollisionLadder()=0
{
  state=LOOKING_UP
}
if kUp=0 and (state=LOOKING_UP or state=DIGGINGUP)
{
  state=STANDING
}
if kDown and platformCharacterIs(ON_GROUND) and isCollisionLadder()=0
{
  if isCollisionPlatformBottom(1)
  {
    if isCollisionBottom(1)=0
    {
      state=FALLING
    }
    else
    {
      //the character can't move down because there is a solid in the way
      state=RUNNING
    }
  }
  else
  {
    state=DUCKING
  }
}
if kDown=0 and (state=DUCKING or state=DIGGINGDOWN)
{
  state=STANDING
}
if abs(phy_linear_velocity_x)<0.01 and state=RUNNING
{
  state=STANDING
}
if abs(phy_linear_velocity_x)>=0.01 and state=STANDING
{
  state=RUNNING
}
if phy_linear_velocity_y<0 and platformCharacterIs(IN_AIR)
{
  state=JUMPING
}
if phy_linear_velocity_y>0 and platformCharacterIs(IN_AIR)
{
  state=FALLING
}
if (kUp or kDown) and isCollisionLadder()
{
    if kDown and isCollisionBottom(1) {
        state=DUCKING
    } else {
        state=CLIMBING
    }
}


if isCollisionLadder() and state=CLIMBING and kJumpPressed
{
  state=JUMPING
  jumpButtonReleased=0
  jumpTime=0
}


//HANGING///////////////////////////////////////////////////////////////////////////////////////////////////
if state=FALLING and ((isCollisionHangRight()=1 and facing=RIGHT) or (isCollisionHangLeft()=1 and facing=LEFT)) {
    state=HANGING
    if facing=RIGHT {
        hanging_direc=RIGHT
    } else {
        hanging_direc=LEFT
    }
}
if state=HANGING {
    if hanging_direc!=facing {
        state=FALLING
    }
}
if state=HANGING {
    if image_index<1 {
        phy_linear_velocity_y = -380
    }
    
    if facing=RIGHT
        physics_apply_force(phy_position_x, phy_position_y, 20, 0)
    else
        physics_apply_force(phy_position_x, phy_position_y, -20, 0)
        
    if state=HANGING and image_index>=4 {
       state=STANDING
    }
}
    
//HURT//////////////////////////////////////////////////////////////////////////////
if hurting {
    if hurt_timer = 1 {
        health -= 1
    }
    if bleeding = false {
        blood_spurt = instance_create(x,y,oBloodSpurt)
        bleeding = true
    } else {
        blood_spurt.x = x
        blood_spurt.y = y
    }
    hurt_timer+=1
    if hurt_timer>=60 {
        hurting=false
        hurt_timer=0
    }
} else {
    bleeding = false
}
if health<1 or picture_num >= picture_total {
    dead = true
}

if pic_take {
    pic_timer+=1
    if pic_timer = 1 {
        picture_num+=1
    }
    if pic_timer>=60 {
        pic_take=false
        pic_timer=0
    }
}



//Digging code begins here/////////////////////////////////////////////////////////
kMouseL = mouse_check_button( mb_left )
kMouseR = mouse_check_button( mb_right )

if oBestGUI.drag = true or oBestGUI.build_hover = true {
    kMouseL = 0
}

if kMouseL {
    if oBlockHighlight.dig_side = 0 {
        facing = RIGHT
    } else if oBlockHighlight.dig_side = 2 {
        facing = LEFT
    }
}
if (state=DIGGING or state=DIGGINGUP or state=DIGGINGDOWN or state=CLAWING) and (oBlockHighlight.dig_block != oBlockHighlight.old_dig_block or oBlockHighlight.dig_block2 != oBlockHighlight.old_dig_block2) {
    state = STANDING
}

if (state = STANDING or state = DUCKING) and oBlockHighlight.dig_block != noone and kMouseL {
    if oBlockHighlight.dig_side = 3 {
        state=DIGGINGDOWN
    }
}
if (state = STANDING or state = LOOKING_UP) and oBlockHighlight.dig_block != noone and kMouseL {
    if oBlockHighlight.dig_side = 1 {
        state=DIGGINGUP
    }
}
if (state = STANDING or state = RUNNING) and (oBlockHighlight.dig_block != noone or oBlockHighlight.dig_block2 != noone) and kMouseL {
    if oBlockHighlight.dig_side = 0 or oBlockHighlight.dig_side = 2 {
        state=DIGGING
    }
}
if state=DIGGING {
    if kMouseL = 0
        state=STANDING
}
if state=DIGGINGDOWN {
    if kMouseL = 0
        state=DUCKING
}
if state=DIGGINGUP {
    if kMouseL = 0
        state=LOOKING_UP
}
if state=DIGGINGDOWN or state=DIGGING or state=DIGGINGUP {
    if oBlockHighlight.dig_block != noone {
        oBlockHighlight.dig_block.digtimer += digSpeed;
    }
}
if state=DIGGING {
    if oBlockHighlight.dig_block2 != noone {
        oBlockHighlight.dig_block2.digtimer += digSpeed;
    }
}


//// Building Code starts here ////////////////////////////////////////////////////////////
if state=STANDING or state=RUNNING {
kBuild = keyboard_check_pressed (ord('K'))
if kBuild {
    if facing=RIGHT {
            blocked = collision_line(x+12,y+20,x+60,y+20,oSolid,false,true)
            if blocked = noone {
                oPlayer1.inventory[13]-=1
                instance_create(x+40,y,oCrate)
            }
    } else {
            blocked = collision_line(x-12,y+20,x-60,y+20,oSolid,false,true)
            if blocked = noone {
                oPlayer1.inventory[13]-=1
                instance_create(x-40,y,oCrate)
            }
    }
}
}


// Dynomite code ///////////////////////////////////////////////////////////////////////
/*if state=STANDING or state=RUNNING or state=JUMPING or state=FALLING {
    kDyno = keyboard_check_pressed (ord('O'))
    if kDyno {
        oPlayer1.inventory[11]-=1
        makeDyno = instance_create( x, y, oDyno )
        dyno_timer=0
    }
}
dyno_timer+=1*/

// Boomerang Code /////////////////////////////////////////////////////////////////////////
if state=STANDING or state=RUNNING or state=JUMPING or state=FALLING {
    kBoom = keyboard_check_pressed (ord('B'))
    
    if kBoom {
        if facing = RIGHT {
            oPlayer1.inventory[10]-=1
            makeBoom = instance_create( x+40, y+10, oBoomerang )
            with makeBoom {
                physics_apply_force(x,y,oBoomerang.boom_speed,0)
            }
        } else {
            oPlayer1.inventory[10]-=1
            makeBoom = instance_create( x-40, y+10, oBoomerang )
            with makeBoom {
                physics_apply_force(x,y,-1*oBoomerang.boom_speed,0)
            }
        }
    }
}



//SWITCH CODE///////////////////////////////////////////////////////////////////////////////////////
kSwitchBuild = keyboard_check_pressed (ord('P'))
if state=STANDING {
    if facing=LEFT
        machine_rot = 90
    else
        machine_rot = 270
}

if state=DUCKING
    machine_rot = 0
    
if state=LOOKING_UP
    machine_rot = 180
    
if kSwitchBuild and (state=STANDING or state=LOOKING_UP or state=DUCKING) {
    if build_machine = true {
        new_machine = instance_create (x,y,oPneumaticBase)
        
        with (new_machine) {
            /*if( !place_snapped( 48, 48 ) ) {
                move_snap( 48, 48 );
                if machine_rot=0 {
                    y += 60
                } else if machine_rot=90 {
                    y += 60
                }
                //this_push.x = x
                //this_push.y = y
            }*/
        }
        build_machine = false
        build_switch = true
    } else if build_switch = true {
        new_switch = instance_create (x,y,oSwitch)
        with (new_switch) {
            if( !place_snapped( 48, 48 ) ) {
                move_snap( 48, 48 );
                y += 24
            }
        }
        build_switch = false
        build_machine = true
    }
}
kSwitch = keyboard_check_pressed (ord('L'))
if kSwitch = 1 {
this_switch = instance_position(x,y,oSwitch)
} else {
this_switch = noone
}
if this_switch != noone {
    if  this_switch.switch_activate = false {
        this_switch.switch_activate = true
    } else {
        this_switch.switch_activate = false
    }
}


//claw attack code uggggggg ///////////////////////////////////////////////////////////////////////////
if kMouseL and oBlockHighlight.dig_block2 = noone and oBlockHighlight.block = noone {
    state=CLAWING
}
if state=CLAWING {
    if facing = RIGHT {
        claw_enemy = collision_line(x+17,y-35,x+17,y+35,oEnemy,false,true)
    } else {
        claw_enemy = collision_line(x-17,y-35,x-17,y+35,oEnemy,false,true)
    }
    if claw_enemy!=noone {
        with claw_enemy {
            instance_destroy()
        }
    }
}
if state=CLAWING{
    if kMouseL=0 {
        state=STANDING
    }
}

//build some spikezzz
if state=RUNNING or state=STANDING or state=JUMPING or state=FALLING {
kSpike = keyboard_check_pressed (ord('H'))
    if kSpike {
        if facing=RIGHT {
            blocked = instance_position(x+64,y+20,oSolid)
            if blocked = noone {
                oPlayer1.inventory[12]-=1
                instance_create(x+40,y,oSpike)
            }
        } else {
            blocked = instance_position(x-64,y+20,oSolid)
            if blocked = noone {
                oPlayer1.inventory[12]-=1
                instance_create(x-40,y,oSpike)
            }
        }
    }
}

//general build based on active inv
if oBestGUI.active_inv_length > 0 {
    
}


//close big highlight if
}

//figures out what the sprite index of the character should be
if facing=LEFT
{
  if state=STANDING
    sprite_index=sStandLeft  
  if state=RUNNING
    sprite_index=sRunLeft
  if state=DUCKING
    sprite_index=sDuckLeft  
  if state=DIGGINGDOWN
    sprite_index=sDigDown
  if state=DIGGINGUP
    sprite_index=sDigUp
  if state=DIGGING
    sprite_index=sDigLeft
  if state=LOOKING_UP
    sprite_index=sLookLeft
  if state=CLIMBING
    sprite_index=sClimbUp
  if state=JUMPING
    sprite_index=sJumpLeft
  if state=FALLING and statePrev=FALLING and statePrevPrev=FALLING
    sprite_index=sFallLeft
  if state=HANGING
    sprite_index=sCornerClimbLeft
  if state=CLAWING
    sprite_index=sClawLeft
  if dead = true
    sprite_index=sDeadLeft
}
if facing=RIGHT
{
  if state=STANDING
    sprite_index=sStandRight 
  if state=RUNNING
    sprite_index=sRunRight
  if state=DUCKING
    sprite_index=sDuckRight
  if state=DIGGINGDOWN
    sprite_index=sDigDown
  if state=DIGGINGUP
    sprite_index=sDigUp
  if state=DIGGING
    sprite_index=sDigRight
  if state=LOOKING_UP
    sprite_index=sLookRight
  if state=CLIMBING
    sprite_index=sClimbUp
  if state=JUMPING
    sprite_index=sJumpRight
  if state=FALLING and statePrev=FALLING and statePrevPrev=FALLING
    sprite_index=sFallRight
  if state=HANGING
    sprite_index=sCornerClimbRight
  if state=CLAWING
    sprite_index=sClawRight
  if dead = true
    sprite_index=sDeadRight
}

//calculates the image_speed based on the character's velocity
if state=RUNNING {
  image_speed=abs(phy_linear_velocity_x)*runAnimSpeed+0.1
  if (sound_isplaying(global.stepR[0])=0 and sound_isplaying(global.stepR[1])=0 and sound_isplaying(global.stepR[2])=0 and sound_isplaying(global.stepR[3])=0 and sound_isplaying(global.stepR[4])=0) and (floor(image_index) = 1 or floor(image_index) = 7)  {
    sound_play(global.stepR[irandom(4)]);
  }
}

if state=CLIMBING
  image_speed=(phy_linear_velocity_y+phy_linear_velocity_x)*climbAnimSpeed
  
//limit the image_speed at 1 so the animation always looks good
if image_speed>1
  image_speed=1
  
if state=DIGGING or state=DIGGINGDOWN or state=DIGGINGUP or state=HANGING or state=CLAWING
    image_speed=digAnimSpeed
if state=STANDING
    image_speed=idleAnimSpeed

if kJump {
  if whoosh = false  {
    sound_play(global.jump);
    whoosh = true
  }
} else if platformCharacterIs(ON_GROUND) {
    whoosh = false
}

if state=DIGGING or state=DIGGINGDOWN or state=DIGGINGUP {
    if dig_sound = false {
        digR = global.dig[irandom(1)]
        sound_play(digR)
        dig_sound = true
    }
} else if statePrev=DIGGING or statePrev=DIGGINGDOWN or statePrev=DIGGINGUP {
    dig_sound = false
    sound_stop(digR)
}


//sets the previous state and the previously previous state
statePrevPrev=statePrev
statePrev=state
