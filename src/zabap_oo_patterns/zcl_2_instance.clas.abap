CLASS zcl_2_instance DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   "! <p class="shorttext synchronized" lang="en">Flight</p>
    DATA flight TYPE /dmo/flight.

    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    METHODS constructor
      IMPORTING
        !carrier_id    TYPE /dmo/carrier_id
        !connection_id TYPE /dmo/connection_id
        !flight_date   TYPE /dmo/flight_date.

    "! <p class="shorttext synchronized" lang="en">Get Booking Details</p>
    METHODS get_flight_details
      RETURNING VALUE(flight) TYPE /dmo/flight .

    "! <p class="shorttext synchronized" lang="en">Calculate Flight Price</p>
    METHODS calculate_flight_price
      EXPORTING
        !price         TYPE /dmo/flight_price
        !currency_code TYPE /dmo/currency_code.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_2_instance IMPLEMENTATION.

  METHOD calculate_flight_price.

    price = me->flight-price.
    currency_code = me->flight-currency_code.

    CASE me->flight-plane_type_id.
      WHEN `747-400`.
        PRICE = PRICE + 40.
      WHEN `A321-200`.
        PRICE = PRICE + 25.
      WHEN OTHERS.
        PRICE = PRICE + 10.
    ENDCASE.
  ENDMETHOD.


  METHOD constructor.
    SELECT SINGLE * FROM /dmo/flight
      WHERE carrier_id = @carrier_id
        AND connection_id = @connection_id
        AND flight_date = @flight_date
       INTO @flight.
  ENDMETHOD.


  METHOD get_flight_details.
    flight = me->flight.
  ENDMETHOD.
ENDCLASS.
