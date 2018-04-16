/* register_types.cpp */

#include "register_types.h"
#include "class_db.h"
#include "hpmp.h"

void register_hpmp_types() {

        ClassDB::register_class<Hpmp>();
}

void unregister_hpmp_types() {
   //nothing to do here
}