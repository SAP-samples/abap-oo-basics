CLASS zcl_oo_tutorial_5 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_serializable_object.

    TYPES:
      BEGIN OF cost,
        price    TYPE /dmo/flight_price,
        currency TYPE /dmo/currency_code,
      END OF cost .
   DATA nested TYPE zcl_simple_example=>example_table_type.
    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    METHODS constructor
      IMPORTING
                !carrier_id    TYPE /dmo/carrier_id
                !connection_id TYPE /dmo/connection_id
                !flight_date   TYPE /dmo/flight_date
      RAISING   zcx_oo_tutorial.

    "! <p class="shorttext synchronized" lang="en">Get Booking Details</p>
    METHODS get_flight_details
      RETURNING VALUE(flight) TYPE /dmo/flight.

    "! <p class="shorttext synchronized" lang="en">Calculate Flight Price</p>
    METHODS calculate_flight_price
      RETURNING
        VALUE(price) TYPE cost.

    "! <p class="shorttext synchronized" lang="en">Flight</p>

    DATA test TYPE c LENGTH 10 VALUE 'HI'.
    DATA test_string_table TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA flight TYPE /dmo/flight.
    DATA obj3 TYPE REF TO zcl_oo_tutorial_3.
    "DATA nested TYPE zcl_simple_example=>example_table_type.

ENDCLASS.



CLASS ZCL_OO_TUTORIAL_5 IMPLEMENTATION.


  METHOD calculate_flight_price.

    price-price = me->flight-price.
    price-currency = me->flight-currency_code.

    CASE me->flight-plane_type_id.
      WHEN '747-400'.
        price-price =  price-price + 40.
      WHEN `A321-200`.
        price-price =  price-price + 25.
      WHEN OTHERS.
        price-price =  price-price + 10.
    ENDCASE.
  ENDMETHOD.


  METHOD constructor.

    SELECT * FROM /dmo/connection WHERE carrier_id = 'AA' INTO CORRESPONDING FIELDS OF TABLE @nested.
    LOOP AT nested REFERENCE INTO DATA(connection).
      SELECT * FROM /dmo/flight
        WHERE carrier_id = @connection->carrier_id AND connection_id = @connection->connection_id
         INTO CORRESPONDING FIELDS OF TABLE @connection->flight.
      LOOP AT connection->flight REFERENCE INTO DATA(flightTemp).
        SELECT * FROM /dmo/booking
            WHERE carrier_id = @connection->carrier_id AND connection_id = @connection->connection_id AND flight_date = @flightTemp->flight_date
            INTO CORRESPONDING FIELDS OF TABLE @flightTemp->booking.
      ENDLOOP.
    ENDLOOP.

    SELECT SINGLE * FROM /dmo/flight
      WHERE carrier_id = @carrier_id
        AND connection_id = @connection_id
        AND flight_date = @flight_date
       INTO @flight.
    IF sy-subrc NE 0.
      RAISE EXCEPTION NEW zcx_oo_tutorial(
        textid   = zcx_oo_tutorial=>flight_not_found
        carrid   = carrier_id ).
    ELSE.
      me->obj3 = NEW zcl_oo_tutorial_3(
        carrier_id    = flight-carrier_id
        connection_id = flight-connection_id
        flight_date   = flight-flight_date ).
    ENDIF.
  ENDMETHOD.


  METHOD get_flight_details.
    flight = me->flight.
  ENDMETHOD.
ENDCLASS.
