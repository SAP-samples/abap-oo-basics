CLASS zcl_5_composite_a340 DEFINITION
  PUBLIC
  INHERITING FROM zcl_5_composite_base
  FINAL
  CREATE PROTECTED
  GLOBAL FRIENDS zcl_5_composite_base.

  PUBLIC SECTION.
    METHODS zif_5_composite~calculate_flight_price
        REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_5_composite_a340 IMPLEMENTATION.
  METHOD zif_5_composite~calculate_flight_price.
    price = super->calculate_flight_price( ).
    price-price = price-price + 15.
  ENDMETHOD.
ENDCLASS.
