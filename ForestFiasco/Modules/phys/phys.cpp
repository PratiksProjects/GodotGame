/* phys.cpp */

#include "phys.h"

float Phys::grav(float velocityY, double delta, int gravity) {
     velocityY += delta * gravity;
    return velocityY;
}


void Phys::_bind_methods() {

    ClassDB::bind_method(D_METHOD("grav", "value","delta","gravity"), &Phys::grav);
    
}

Phys::Phys() {
    float newVal = 0;
}