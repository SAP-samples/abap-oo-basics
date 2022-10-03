CLASS zcl_3_factory DEFINITION PUBLIC
  CREATE private .

  PUBLIC SECTION.

    class-methods factory importing my_stuff type string
       RETURNING VALUE(my_instance) type ref to zcl_3_factory.
    methods get_stored_stuff
       returning value(results) type string.
  PROTECTED SECTION.
  PRIVATE SECTION.
      methods constructor importing my_stuff type string.
   data stored_my_stuff type string.
ENDCLASS.



CLASS zcl_3_factory IMPLEMENTATION.
    method constructor.
        stored_my_stuff = my_stuff.
    endmethod.

    method factory.
       my_instance = new zcl_3_factory( my_stuff ).
    endmethod.

    method get_stored_stuff.
      results = me->stored_my_stuff.
    ENDMETHOD.
ENDCLASS.
