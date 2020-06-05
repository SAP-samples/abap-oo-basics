"! <p class="shorttext synchronized" lang="en">Field-Symbol vs. Reference Performance Testing</p>
CLASS zcl_fs_ref_perf_testing DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA flights TYPE /dmo/t_flight.
    METHODS data_test.
    METHODS field_symbols_test.
    METHODS data_ref_test.
ENDCLASS.



CLASS ZCL_FS_REF_PERF_TESTING IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DO 1000 TIMES.
      SELECT * FROM /dmo/flight APPENDING TABLE @flights.
    ENDDO.

    data_test(  ).
    field_symbols_test( ).
    data_ref_test(  ).
  ENDMETHOD.


  METHOD data_ref_test.
    LOOP AT flights REFERENCE INTO DATA(flight).
      IF flight->carrier_id = `AA`.
        flight->price += 35.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD data_test.
    LOOP AT flights INTO DATA(flight).
      IF flight-carrier_id = `SQ`.
        flight-price += 35.
        modify table flights from flight.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD field_symbols_test.
    LOOP AT flights ASSIGNING FIELD-SYMBOL(<flight>).
      IF <flight>-carrier_id = `SQ`.
        <flight>-price += 35.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
