CLASS zcl_2_static DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "! <p class="shorttext synchronized" lang="en">Get Booking Details</p>
    CLASS-METHODS get_flight_details
      IMPORTING
                !carrier_id    TYPE /dmo/carrier_id
                !connection_id TYPE /dmo/connection_id
                !flight_date   TYPE /dmo/flight_date
      RETURNING VALUE(flight)  TYPE /dmo/flight.


    "! <p class="shorttext synchronized" lang="en">Calculate Flight Price</p>
    CLASS-METHODS calculate_flight_price
      IMPORTING
        !carrier_id    TYPE /dmo/carrier_id
        !connection_id TYPE /dmo/connection_id
        !flight_date   TYPE /dmo/flight_date
      EXPORTING
        !price         TYPE /dmo/flight_price
        !currency_code TYPE /dmo/currency_code.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_2_static IMPLEMENTATION.
  METHOD calculate_flight_price.
    DATA plane_type TYPE /dmo/plane_type_id.

    SELECT SINGLE price, currency_code, plane_type_id FROM /dmo/flight
      WHERE carrier_id = @carrier_id
        AND connection_id = @connection_id
        AND flight_date = @flight_date
       INTO (@price, @currency_code, @plane_type).

    CASE plane_type.
      WHEN `747-400`.
        price = price + 40.
      WHEN `A321-200`.
        price = price + 25.
      WHEN OTHERS.
        price = price + 10.
    ENDCASE.
  ENDMETHOD.


  METHOD get_flight_details.

    SELECT SINGLE * FROM /dmo/flight
      WHERE carrier_id = @carrier_id
        AND connection_id = @connection_id
        AND flight_date = @flight_date
       INTO @flight.
  endmethod.
ENDCLASS.
