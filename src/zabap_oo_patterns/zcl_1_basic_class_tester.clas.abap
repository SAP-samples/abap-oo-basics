CLASS zcl_1_basic_class_tester DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES IF_OO_ADT_CLASSRUN.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1_basic_class_tester IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*    out->write( |sample_Internal_Table Starter| ).
*    out->write( zcl_1_basic_class=>sample_Internal_Table ).
*   APPEND INITIAL LINE TO zcl_1_basic_class=>sample_internal_table REFERENCE INTO DATA(line).
*    line->* = `Sneaky Stuff I Injected`.

    out->write( |\nCalling First Method| ).
    data(class_Instance) = new zcl_1_basic_class(  ).
    out->write( class_Instance->my_first_method( `First Call` ) ).

    out->write( class_Instance->my_second_method(  ) ).

    out->write( |\nCalling First Method Again| ).
    out->write( class_Instance->my_first_method( `Second Call` ) ).

    out->write( class_Instance->my_second_method(  ) ).

    clear class_instance.
*    out->write( zcl_1_basic_class=>sample_Internal_Table ).
*    out->write( class_Instance->my_second_method(  ) ).

    out->write( |\nCalling New Instance First Method| ).
    data(class_Instance_New) = new zcl_1_basic_class(  ).
    out->write( class_Instance_New->my_first_method( `First Call Of New Instance` ) ).
    out->write( class_Instance_New->my_second_method(  ) ).
  ENDMETHOD.

ENDCLASS.
