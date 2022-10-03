CLASS zcl_5_composite_base DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PROTECTED.

  PUBLIC SECTION.
    INTERFACES zif_5_composite.

    ALIASES calculate_flight_price
      FOR  zif_5_composite~calculate_flight_price .
    ALIASES get_flight_details
      FOR  zif_5_composite~get_flight_details .
    ALIASES cost
      FOR  zif_5_composite~cost .

    CONSTANTS:
      "! <p class="shorttext synchronized" lang="en">Plane Type Enumerator</p>
      BEGIN OF plane_type,
        b747 TYPE /dmo/plane_type_id VALUE `747`,
        a340 TYPE /dmo/plane_type_id VALUE `A340`,
      END OF plane_type .

    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    METHODS constructor
      IMPORTING
        !flight TYPE /dmo/flight .

    "! <p class="shorttext synchronized" lang="en">Get Filght Object</p>
    CLASS-METHODS factory
      IMPORTING
        !carrier_id    TYPE /dmo/carrier_id
        !connection_id TYPE /dmo/connection_id
        !flight_date   TYPE /dmo/flight_date
      RETURNING
        VALUE(flight)  TYPE REF TO zcl_5_composite_base
      RAISING
        zcx_5_composite.
  PROTECTED SECTION.
    "! <p class="shorttext synchronized" lang="en">Flight</p>
    DATA flight TYPE /dmo/flight .

  PRIVATE SECTION.
    "! <p class="shorttext synchronized" lang="en">Base Class Name</p>
    CONSTANTS class_base_name TYPE string VALUE `ZCL_5_COMPOSITE_`. "#EC NOTEXT
    "! <p class="shorttext synchronized" lang="en">Class Name Other</p>
    CONSTANTS class_other TYPE string VALUE `OTHER`.        "#EC NOTEXT
ENDCLASS.



CLASS zcl_5_composite_base IMPLEMENTATION.
  METHOD constructor.
    me->flight = flight.
  ENDMETHOD.

  METHOD factory.

    SELECT SINGLE * FROM /dmo/flight
    WHERE carrier_id = @carrier_id
      AND connection_id = @connection_id
      AND flight_date = @flight_date
     INTO @DATA(flight_temp).
    IF sy-subrc NE 0.
      RAISE EXCEPTION NEW zcx_5_composite( textid = zcx_5_composite=>flight_not_found
                                           carrid = carrier_id ).
    ENDIF.

    DATA class_name TYPE string.
    IF flight_temp-plane_type_id CS ZCL_5_COMPOSITE_BASE=>plane_type-b747.
      class_name = ZCL_5_COMPOSITE_BASE=>class_base_name &&
                   ZCL_5_COMPOSITE_BASE=>plane_type-b747.

    ELSEIF flight_temp-plane_type_id CS ZCL_5_COMPOSITE_BASE=>plane_type-a340.
      class_name = ZCL_5_COMPOSITE_BASE=>class_base_name &&
                   ZCL_5_COMPOSITE_BASE=>plane_type-a340.
    ELSE.
      class_name = ZCL_5_COMPOSITE_BASE=>class_base_name &&
                   ZCL_5_COMPOSITE_BASE=>class_other.
    ENDIF.

    CREATE OBJECT flight TYPE (class_name)
      EXPORTING
        flight = flight_temp.

  ENDMETHOD.


  METHOD zif_5_composite~calculate_flight_price.

    price-price = me->flight-price + 100.
    price-currency = me->flight-currency_code.

  ENDMETHOD.


  METHOD zif_5_composite~get_flight_details.
    flight = me->flight.
  ENDMETHOD.

ENDCLASS.
