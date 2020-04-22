"! <p class="shorttext synchronized" lang="en">OO Tutorial #6 - Planetype 747</p>
CLASS ZCL_OO_TUTORIAL_6_747 DEFINITION
  PUBLIC
  INHERITING FROM ZCL_OO_TUTORIAL_6_BASE
  FINAL
  CREATE PROTECTED
  GLOBAL FRIENDS ZCL_OO_TUTORIAL_6_BASE.

  PUBLIC SECTION.

    TYPES:
      BEGIN OF MOVIE,
        MOVIE_TITLE  TYPE string,
        RUNNING_TIME TYPE string,
      END OF MOVIE.
    TYPES:
      MOVIES_TABLE TYPE STANDARD TABLE OF MOVIE WITH EMPTY KEY.

    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    METHODS CONSTRUCTOR
      IMPORTING
        !FLIGHT TYPE /DMO/FLIGHT.


    "! <p class="shorttext synchronized" lang="en">Get a listing of in flight movies</p>
    METHODS GET_INFLIGHT_MOVIES
       returning value(movies) type ZCL_OO_TUTORIAL_6_747=>MOVIES_TABLE.
*      EXPORTING !MOVIES TYPE ZCL_OO_TUTORIAL_6_747=>MOVIES_TABLE.

    METHODS ZIF_OO_TUTORIAL~CALCULATE_FLIGHT_PRICE
        REDEFINITION .
  PROTECTED SECTION.
*"* protected components of class ZCL_OO_TUTORIAL_6_747
*"* do not include other source files here!!!
  PRIVATE SECTION.
*"* private components of class ZCL_OO_TUTORIAL_6_747
*"* do not include other source files here!!!

    "! <p class="shorttext synchronized" lang="en">List of Movies on the Flight</p>
    DATA MOVIES TYPE MOVIES_TABLE.

ENDCLASS.



CLASS ZCL_OO_TUTORIAL_6_747 IMPLEMENTATION.


  METHOD CONSTRUCTOR.
    SUPER->CONSTRUCTOR(
        FLIGHT = FLIGHT ).

    INSERT VALUE #( MOVIE_TITLE = `Transformers: Revenge of the Fallen` RUNNING_TIME = `150 min` ) INTO TABLE me->movies.
    INSERT VALUE #( MOVIE_TITLE = `The Hangover` RUNNING_TIME = `100 min` ) INTO TABLE me->movies.

  ENDMETHOD.


  METHOD GET_INFLIGHT_MOVIES.
    MOVIES = ME->MOVIES.
  ENDMETHOD.


  METHOD ZIF_OO_TUTORIAL~CALCULATE_FLIGHT_PRICE.
    price = SUPER->CALCULATE_FLIGHT_PRICE( ).
    PRICE-PRICE = PRICE-PRICE + 35.

  ENDMETHOD.
ENDCLASS.
