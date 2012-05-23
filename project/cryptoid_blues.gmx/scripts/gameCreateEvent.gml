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

instance_create(0,0,oNewGUI)
