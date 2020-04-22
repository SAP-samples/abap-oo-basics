"! <p class="shorttext synchronized" lang="en">ABAP Inline Declaration</p>
CLASS zcl_inline_declare DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_INLINE_DECLARE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    SELECT * FROM /dmo/flight INTO TABLE @DATA(flights).

    LOOP AT flights INTO DATA(flight).
    ENDLOOP.

    READ TABLE flights INTO DATA(flight2) INDEX 1.

    DATA old TYPE i VALUE 6.
    DATA inc TYPE i VALUE 5.
    DATA(new) = old + inc.

    DATA(rnd) = cl_abap_random_int=>create( seed = CONV i( CL_ABAP_CONTEXT_INFO=>GET_SYSTEM_TIME(  ) )
                                             min = 0  max = 500 ).

****Old Way
    FIELD-SYMBOLS: <line1> LIKE LINE OF flights,
                   <line>  LIKE LINE OF flights,
                   <comp>  TYPE t.  "Wrong type - causes program to dump

    READ TABLE flights ASSIGNING <line1> INDEX 1.
    LOOP AT flights ASSIGNING <line>.
*      ASSIGN COMPONENT 1 OF STRUCTURE <line> TO <comp>.
    ENDLOOP.

****New Way
    READ TABLE flights REFERENCE INTO DATA(new_line1) INDEX 1.
    LOOP AT flights REFERENCE INTO DATA(new_line).
      ASSIGN COMPONENT 1 OF STRUCTURE new_line TO FIELD-SYMBOL(<new_comp>).
    ENDLOOP.

****Breakpoint helper
    IF sy-subrc = 0.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
