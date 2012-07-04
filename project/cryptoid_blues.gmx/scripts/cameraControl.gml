//Camera control
winH = window_get_height()
winW = window_get_width()
topbound = winH*(1/3)
botbound = winH*(2/3)
leftbound = winW*(1/3)
rightbound= winW*(2/3)
view_currentx=view_xview[0]
view_currenty=view_yview[0]
player_viewposx=oPlayer1.x-view_xview[0]
player_viewposy=oPlayer1.y-view_yview[0]

//set camera target based on player position
if player_viewposx > rightbound {
    view_targetx=oPlayer1.x-rightbound
} else if player_viewposx < leftbound {
    view_targetx=oPlayer1.x-leftbound
} else {
    view_targetx=view_currentx
}
    
if player_viewposy > botbound {
    view_targety=oPlayer1.y-botbound
} else if player_viewposy < topbound {
    view_targety=oPlayer1.y-topbound
} else {
    view_targety=view_currenty
}

//check if gauntlet instance exists
if (global.gauntlet != noone) {
    //check if gauntlet is activated
    if (global.gauntlet.fixedCamera = true) {
        //set camera target based on gauntlet position
        //view_targetx = global.gauntlet.x-24
        //view_targety = global.gauntlet.y+496
        if player_viewposx > rightbound and view_currentx+winW >= global.gauntlet.x+global.BLOCK_WIDTH*global.CHUNK_WIDTH {
            view_targetx=view_currentx
        }
        if player_viewposx < leftbound and view_currentx <= global.gauntlet.x {
            view_targetx=view_currentx
        }
    }
}

//update camera position with smoothing
view_xview[0] += (view_targetx-view_currentx)/15
view_yview[0] += (view_targety-view_currenty)/15
