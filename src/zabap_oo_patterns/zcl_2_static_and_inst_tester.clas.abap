CLASS zcl_2_static_and_inst_tester DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_2_static_and_inst_tester IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


**** Static
    zcl_2_static=>calculate_flight_price(
      EXPORTING
        carrier_id    = `AA`
        connection_id = `0017`
        flight_date   = `20230222`
      IMPORTING
        price         = DATA(price)
        currency_code = DATA(currency_code) ).
    out->write( |Flight Price for AA-0017 on {  CONV /dmo/flight_date( `20230222` ) DATE = ENVIRONMENT }: | &&
                |{ price CURRENCY = currency_code } { currency_code }| ).

    zcl_2_static=>calculate_flight_price(
      EXPORTING
        carrier_id    = `UA`
        connection_id = `0058`
        flight_date   = `20220426`
      IMPORTING
        price         = DATA(price_bad)
        currency_code = DATA(currency_code_bad) ).
    out->write( |Flight Price for UA-0058 on {  CONV /dmo/flight_date( `20220426` ) DATE = ENVIRONMENT }: | &&
                |{ price_bad CURRENCY = currency_code_bad } { currency_code_bad }| ).

    out->write( zcl_2_static=>get_flight_details(
                  carrier_id    = `AA`
                  connection_id = `0017`
                  flight_date   = `20230222` ) ).

    out->write( zcl_2_static=>get_flight_details(
                  carrier_id    = `UA`
                  connection_id = `0058`
                  flight_date   = `20220426` ) ).

**** Instance
    DATA(aa_0017) = NEW zcl_oo_tutorial_3(
      carrier_id    = `AA`
      connection_id = `0017`
      flight_date   = `20230222` ).

    aa_0017->flight-price = `0.01`.
    aa_0017->calculate_flight_price(
      IMPORTING
        price         = price
        currency_code = currency_code ).

    out->write( |\nFlight Price for AA-0017 on {  CONV /dmo/flight_date( `20230222` ) DATE = ENVIRONMENT }: | &&
                |{ price CURRENCY = currency_code } { currency_code }| ).
    out->write( aa_0017->get_flight_details( ) ).

    out->write( ` ` ).
    DATA(ua_0017) = NEW zcl_oo_tutorial_3(
      carrier_id    = `UA`
      connection_id = `0058`
      flight_date   = `20200426` ).

    ua_0017->calculate_flight_price(
      IMPORTING
        price         = price_bad
        currency_code = currency_code_bad ).

    out->write( |\nFlight Price for UA-0058 on {  CONV /dmo/flight_date( `20200426` ) DATE = ENVIRONMENT }: | &&
                |{ price_bad CURRENCY = currency_code_bad } { currency_code_bad }| ).
    out->write( ua_0017->get_flight_details( ) ).
  ENDMETHOD.
ENDCLASS.
