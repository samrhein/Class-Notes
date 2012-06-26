firefly_system = part_system_create();
firefly_emitter = part_emitter_create( firefly_system );
part_emitter_region( firefly_system,firefly_emitter,48,2000,1700,1700,ps_shape_line,ps_distr_linear );
firefly_part = part_type_create();

part_type_sprite( firefly_part, sFirefly, false, false, false );
part_system_depth(firefly_part,-11);
part_type_blend( firefly_part, 1 );
part_type_life( firefly_part, 100, 400 ); 
part_type_speed( firefly_part, 0, 1, 0, 0.7 ); 
part_type_direction( firefly_part, 60, 120, 0, 50 ); 
part_type_alpha3( firefly_part, 0, 1, 0 );

part_emitter_stream( firefly_system, firefly_emitter, firefly_part, -4 );



//distant fireflies

firefly2_system = part_system_create();
firefly2_emitter = part_emitter_create( firefly2_system );
part_emitter_region( firefly2_system,firefly2_emitter,48,1000,1000,1700,ps_shape_rectangle,ps_distr_linear );
firefly2_part = part_type_create();

part_type_sprite( firefly2_part, sFirefly, false, false, false );
part_system_depth(firefly2_part,8);
part_type_blend( firefly2_part, 1 );
part_type_scale( firefly2_part, 0.7, 0.7 ); 
part_type_life( firefly2_part, 100, 400 ); 
part_type_speed( firefly2_part, 0, 1, 0, 0.7 ); 
part_type_direction( firefly2_part, 60, 120, 0, 50 ); 
part_type_alpha3( firefly2_part, 0, 1, 0 );

part_emitter_stream( firefly2_system, firefly2_emitter, firefly2_part, -1 )





