/* register_types.cpp */

#include "register_types.h"
#include "class_db.h"
#include "summator.h"

void register_summator_types() {

        ClassDB::register_class<Summator>();
}

void unregister_summator_types() {
   //nothing to do here
}