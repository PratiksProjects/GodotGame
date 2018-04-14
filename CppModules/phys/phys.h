/* phys.h */
#ifndef PHYS_H
#define PHYS_H

#include "reference.h"

class Phys : public Reference {
    GDCLASS(Phys, Reference);

    float newVal;

protected:
    static void _bind_methods();

public:
    float grav(float velocityY,double delta,int gravity);
    
    Phys();
};

#endif