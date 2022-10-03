CLASS zcl_5_composite_tester DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_5_composite_tester IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    SELECT * FROM /dmo/flight
        WHERE carrier_id = `LH`
        INTO TABLE @DATA(flights).

    LOOP AT flights REFERENCE INTO DATA(flight).
      TRY.
          DATA(flight_obj) = zcl_5_composite_base=>factory(
            carrier_id    = flight->carrier_id
            connection_id = flight->connection_id
            flight_date   = flight->flight_date ).
          out->write( flight_obj->get_flight_details( ) ).
          out->write( flight_obj->calculate_flight_price( ) ).
          IF flight->plane_type_id CS zcl_5_composite_base=>plane_type-b747.
            DATA(flight_747) = CAST zcl_5_composite_747( flight_obj ).
            out->write( flight_747->get_inflight_movies( ) ).
          ENDIF.
          out->write( ` ` ).
        CATCH zcx_5_composite INTO DATA(cx_flight).
          out->write( cx_flight->get_text( ) ).
      ENDTRY.
    ENDLOOP.

    IF sy-subrc = 0.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
