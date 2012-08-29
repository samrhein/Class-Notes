global.winH=window_get_height()
global.winW=window_get_width()

if instance_number(oGame)>1 {
  //instance_destroy()
}
moveableSolidGrav = 1   //how fast moveable solids should accelerate downwards
time = 1

instance_create(0,0,oLightController)
instance_create(0,0,oLightControllerBack)
instance_create(0,0,oPhysicsDebug)

instance_create(0,0,oBestGUI)

//sound
global.stepR[0] = sound_add(working_directory + "\audio\step1.wav", 0, 0);
global.stepR[1] = sound_add(working_directory + "\audio\step2.wav", 0, 0);
global.stepR[2] = sound_add(working_directory + "\audio\step3.wav", 0, 0);
global.stepR[3] = sound_add(working_directory + "\audio\step4.wav", 0, 0);
global.stepR[4] = sound_add(working_directory + "\audio\step5.wav", 0, 0);

global.crumbleR[0] = sound_add(working_directory + "\audio\crumble1.wav", 0, 0);
global.crumbleR[1] = sound_add(working_directory + "\audio\crumble2.wav", 0, 0);

global.jump = sound_add(working_directory + "\audio\skid.wav", 0, 0);

global.treefall[0] = sound_add(working_directory + "\audio\treefall1.wav", 0, 0);
global.treefall[1] = sound_add(working_directory + "\audio\treefall2.wav", 0, 0);

global.dig[0] = sound_add(working_directory + "\audio\dig1.wav", 0, 0);
global.dig[1] = sound_add(working_directory + "\audio\dig2.wav", 0, 0);
