/* hpmp.h */
#ifndef HPMP_H
#define HPMP_H

#include "reference.h"

class Hpmp : public Reference {
    GDCLASS(Hpmp, Reference);

    int hp;
	int mp;

protected:
    static void _bind_methods();

public:
    
	int stats (int type, int delta);
    
    Hpmp();
};

#endif