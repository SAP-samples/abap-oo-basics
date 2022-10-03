CLASS zcl_abap_to_json_restore DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ABAP_TO_JSON_RESTORE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT SINGLE * FROM zobject_xml
     WHERE id = 1 INTO @DATA(object_xml).
    DATA context2 TYPE REF TO zcl_oo_tutorial_5.
    CALL TRANSFORMATION id SOURCE XML object_xml-content
                        RESULT flight = context2.
    out->write( context2->get_flight_details(  ) ).
  ENDMETHOD.
ENDCLASS.
