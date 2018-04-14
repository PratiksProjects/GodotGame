/* register_types.cpp */

#include "register_types.h"
#include "class_db.h"
#include "phys.h"

void register_phys_types() {

        ClassDB::register_class<Phys>();
}

void unregister_phys_types() {
   //nothing to do here
}