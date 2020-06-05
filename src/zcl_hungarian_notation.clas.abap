"! <p class="shorttext synchronized" lang="en">ABAP Class examples with and without Hungarian Notation</p>
CLASS zcl_hungarian_notation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
     INTERFACES if_oo_adt_classrun.
     methods mu_export_flights
       exporting
           !et_flights type /dmo/t_flight.
     methods get_flights
       exporting
           !flights type /dmo/t_flight.
  PROTECTED SECTION.
  PRIVATE SECTION.
"! <p class="shorttext synchronized" lang="en">All Flights</p>
   DATA flights TYPE /dmo/t_flight.
"! <p class="shorttext synchronized" lang="en">All Flights</p>
   data git_flights TYPE /dmo/t_flight.


ENDCLASS.



CLASS ZCL_HUNGARIAN_NOTATION IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    select * from /dmo/flight into table @flights.
    select * from /dmo/flight into table @git_flights.
    select * from @git_flights as FLIGHTS where carrier_id = 'AA' into table @data(lt_flights) .
    select * from @flights as FLIGHTS where carrier_id = 'AA' into table @data(flights_american).

    loop at lt_flights REFERENCE INTO data(lr_flight).
      if lr_flight->connection_id = '0017'.
      endif.
    endloop.

    loop at flights_american REFERENCE INTO data(flight).
      if flight->connection_id = '0017'.
      endif.
    endloop.

    mu_export_flights(
      IMPORTING
        et_flights = data(li_flights)
    ).

    get_flights(
      IMPORTING
        flights = data(processed_flights)
    ).

  ENDMETHOD.


  METHOD mu_export_flights.
    et_flights = git_flights.
  ENDMETHOD.


  METHOD get_flights.
    flights = me->flights.
  ENDMETHOD.
ENDCLASS.
