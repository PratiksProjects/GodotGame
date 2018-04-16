/* hpmp.cpp */

#include "hpmp.h"

int Hpmp::stats(int type, int delta) {
     
	if(type==0){hp+=delta; return hp;} 
	else if(type==1){mp+=delta; return mp;} 
	else{} 
	 
}


void Hpmp::_bind_methods() {

    ClassDB::bind_method(D_METHOD("stats", "type","delta"), &Hpmp::stats);
    
}

Hpmp::Hpmp() {
    hp = 100;
	mp = 100;
}