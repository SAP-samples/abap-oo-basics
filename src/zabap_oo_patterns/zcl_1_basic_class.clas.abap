CLASS zcl_1_basic_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
        sample_Table_Type TYPE STANDARD TABLE OF string .

    DATA sample_Internal_Table TYPE sample_Table_Type .

    "! <p class="shorttext synchronized" lang="en">My First Method</p>
    METHODS my_First_Method
      IMPORTING
                !import       TYPE string "Import parameter
      RETURNING VALUE(export) TYPE string.


    methods my_Second_Method
      returning VALUE(sample_Internal_Table) like sample_Internal_Table.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1_basic_class IMPLEMENTATION.

  METHOD my_First_Method.
    export = |${ import } - Plus New Stuff|.
    APPEND INITIAL LINE TO sample_Internal_Table REFERENCE INTO DATA(itab_Line).
    itab_Line->* = export.
  ENDMETHOD.

  method my_Second_Method.
    sample_Internal_Table = me->sample_Internal_Table.
  ENDMETHOD.
ENDCLASS.
