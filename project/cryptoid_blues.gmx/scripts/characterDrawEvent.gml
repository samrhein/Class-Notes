/*
This event should be placed in the draw event of the platform character.
It draws the "flySpeed" bar and the character sprite.
*/
//draws the sprite

if hurting or pic_take {
    hurt_flash+=1
    if hurt_flash<4 {
        draw_sprite_ext( sprite_index, -1, x, y, image_xscale, image_yscale, image_angle, make_color_rgb(255,100,100), image_alpha );
    } else if hurt_flash<8 {
        draw_sprite(sprite_index,-1,x,y )
    } else {
        hurt_flash=0
    }
} else {
    draw_sprite(sprite_index,-1,x,y )
}
