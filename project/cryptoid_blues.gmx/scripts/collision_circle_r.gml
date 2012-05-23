// collision_circle_r(x, y, r, obj, prec, notme)
//    argument ->     0  1  2  3    4     5
// Idential to collision_circle, but will add matching
// instances to result[] array. Zero-index element will
// indicate length of array.
// Returns: if anything was found
global.circle_result[0] = 0;
with (argument3) {
    // handle 'notme' argument:
    if (argument5) if (id == other.id) continue;
    // skip to next instance if not colliding:
    if (!collision_circle(argument0, argument1, argument2, id, argument4, false)) continue;
    // add to results:
    global.circle_result[0] += 1;
    global.circle_result[global.circle_result[0]] = id;
    show_debug_message(argument3)
}
return (global.circle_result[0] > 0);
