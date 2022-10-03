CLASS zcl_5_composite_747 DEFINITION
  PUBLIC
  INHERITING FROM zcl_5_composite_base
  FINAL
  CREATE PROTECTED
  GLOBAL FRIENDS zcl_5_composite_base.

  PUBLIC SECTION.

    TYPES:
      BEGIN OF movie,
        movie_title  TYPE string,
        running_time TYPE string,
      END OF movie.
    TYPES:
      movies_table TYPE STANDARD TABLE OF movie WITH EMPTY KEY.

    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    METHODS constructor
      IMPORTING
        !flight TYPE /dmo/flight.

    "! <p class="shorttext synchronized" lang="en">Get a listing of in flight movies</p>
    METHODS get_inflight_movies
      RETURNING VALUE(movies) TYPE zcl_5_composite_747=>movies_table.
*      EXPORTING !MOVIES TYPE ZCL_OO_TUTORIAL_6_747=>MOVIES_TABLE.

    METHODS zif_5_composite~calculate_flight_price
        REDEFINITION .

  PROTECTED SECTION.
  PRIVATE SECTION.
      "! <p class="shorttext synchronized" lang="en">List of Movies on the Flight</p>
    DATA MOVIES TYPE MOVIES_TABLE.
ENDCLASS.



CLASS zcl_5_composite_747 IMPLEMENTATION.

  METHOD CONSTRUCTOR.
    SUPER->CONSTRUCTOR(
        FLIGHT = FLIGHT ).

    INSERT VALUE #( MOVIE_TITLE = `Transformers: Revenge of the Fallen` RUNNING_TIME = `150 min` ) INTO TABLE me->movies.
    INSERT VALUE #( MOVIE_TITLE = `The Hangover` RUNNING_TIME = `100 min` ) INTO TABLE me->movies.

  ENDMETHOD.

  METHOD GET_INFLIGHT_MOVIES.
    MOVIES = ME->MOVIES.
  ENDMETHOD.


  METHOD zif_5_composite~CALCULATE_FLIGHT_PRICE.
    price = SUPER->CALCULATE_FLIGHT_PRICE( ).
    PRICE-PRICE = PRICE-PRICE + 35.

  ENDMETHOD.
ENDCLASS.
