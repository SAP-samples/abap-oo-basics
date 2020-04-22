"! <p class="shorttext synchronized" lang="en">ABAP Constructor Expression Examples</p>
CLASS ZCL_CONSTRUCTOR_EXPRESSION DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES IF_OO_ADT_CLASSRUN.
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES: BEGIN OF STRUCT,
             C1 TYPE I,
             C2 TYPE C LENGTH 10,
           END OF STRUCT.
    TYPES T_TAB TYPE STANDARD TABLE OF STRUCT WITH EMPTY KEY.
    DATA OTHERTAB TYPE ZCL_SIMPLE_EXAMPLE=>EXAMPLE_TABLE_TYPE.

    constants: EXPORTING type string value 'E'.

ENDCLASS.



CLASS ZCL_CONSTRUCTOR_EXPRESSION IMPLEMENTATION.


  METHOD IF_OO_ADT_CLASSRUN~MAIN.

****Old Way
    DATA DREF TYPE REF TO DATA.
    FIELD-SYMBOLS <FS> TYPE STRUCT.
    CREATE DATA DREF TYPE STRUCT.
    ASSIGN DREF->* TO <FS>.
    <FS>-C1 = 10.
    <FS>-C2 = 'a'.


****New Way
    DATA DREF2 TYPE REF TO DATA.
    DREF2 = NEW STRUCT( C1 = 10 C2 = 'a' ).


****Old Way
    DATA OREF TYPE REF TO ZCL_SIMPLE_EXAMPLE.
    CREATE OBJECT OREF
      EXPORTING
        INPUT1 = 'a1'
        INPUT2 = 'a2'.


****New Way
    DATA(OREF2) = NEW ZCL_SIMPLE_EXAMPLE(
        INPUT1 = 'a1'
        INPUT2 = 'a2' ).

****Old Way
    DATA TAB TYPE ZCL_SIMPLE_EXAMPLE=>EXAMPLE_TABLE_TYPE.
    DATA LINE LIKE LINE OF TAB.
    LINE-C1 = 10.
    LINE-C2 = 'a'.
    APPEND LINE TO TAB.
    LINE-C2 = 'b'.
    APPEND LINE TO TAB.
    APPEND LINES OF OTHERTAB TO TAB.
    ZCL_SIMPLE_EXAMPLE=>METHOD1( TAB ).

****New Way
    DATA(TAB2) =  VALUE ZCL_SIMPLE_EXAMPLE=>EXAMPLE_TABLE_TYPE(
        ( C1 = 10 C2 = 'a' )
        ( C1 = 10 C2 = 'b' )
        ( LINES OF OTHERTAB ) ).
    ZCL_SIMPLE_EXAMPLE=>METHOD1( TAB2 ).

****New Way - Extreme
    ZCL_SIMPLE_EXAMPLE=>METHOD1( VALUE #(
      C1 = 10
        ( C2 = 'a' )
        ( C2 = 'b' )
      ( LINES OF OTHERTAB ) ) ).


****Dynamic Parameter - Somewhat New Way
    DATA DATAREF TYPE REF TO ZCL_SIMPLE_EXAMPLE=>EXAMPLE_TABLE_TYPE.
    GET REFERENCE OF TAB INTO DATAREF.
    DATA(PTAB) = VALUE ABAP_PARMBIND_TAB(
     ( NAME  = 'TABLE'
       KIND  = EXPORTING
       VALUE = DATAREF ) ).
    CALL METHOD ('ZCL_SIMPLE_EXAMPLE')=>('METHOD1') PARAMETER-TABLE PTAB.

****Dynamic Parameter - Really New Way
    DATA(PTAB2) = VALUE ABAP_PARMBIND_TAB(
     (  NAME = 'TABLE'
        KIND  = EXPORTING
        VALUE = REF #( TAB ) ) ).
    CALL METHOD ('ZCL_SIMPLE_EXAMPLE')=>('METHOD1') PARAMETER-TABLE PTAB2.


****Old Way
    DATA HELPER TYPE STRING.
    HELPER =  CL_ABAP_CONTEXT_INFO=>GET_USER_FORMATTED_NAME(  ).
    DATA(XSTR) = CL_ABAP_CONV_CODEPAGE=>CREATE_OUT(  )->CONVERT( SOURCE = HELPER ).

****New Way
    DATA(XSTR2) = CL_ABAP_CONV_CODEPAGE=>CREATE_OUT(  )->CONVERT( SOURCE = CONV #( CL_ABAP_CONTEXT_INFO=>GET_USER_FORMATTED_NAME(  ) ) ).

****Old
    DATA(I) =  1 / 4.
    OUT->WRITE( I ).  "output 0

****New
    DATA(DF) = CONV DECFLOAT34( 1 / 4 ).
    OUT->WRITE( DF ). "output .25


*****Old
*  CHECK ` ` = abap_false.
*
*****New
*  CHECK CONV abap_bool( ` ` ) = abap_false.

****New
    DATA(SQSIZE) = CONV I( LET S = ZCL_SIMPLE_EXAMPLE=>GET_SIZE( )
                            IN S * S ).

****Old
*    DATA STRUCTDESCR TYPE REF TO CL_ABAP_STRUCTDESCR.
*    STRUCTDESCR ?= CL_ABAP_TYPEDESCR=>DESCRIBE_BY_NAME( 'T100' ).
*    DATA(COMPONENTS) = STRUCTDESCR->COMPONENTS.

****New
*    DATA(COMPONENTS2) = CAST CL_ABAP_STRUCTDESCR(
*      CL_ABAP_TYPEDESCR=>DESCRIBE_BY_NAME( 'T100' ) )->COMPONENTS.

****Old
    TYPES NUMTEXT TYPE N LENGTH 255.
    DATA NUMBER TYPE NUMTEXT.
    TRY.
*       MOVE EXACT '4 Apples + 3 Oranges' TO number. "Not allowed in Steampunk
      CATCH CX_SY_CONVERSION_ERROR INTO DATA(EXC).
        OUT->WRITE( 'Caught Exact #1' ).
    ENDTRY.

****New
    TRY.
        DATA(NUMBER2) = EXACT NUMTEXT( '4 Apples + 3 Oranges' ).
      CATCH CX_SY_CONVERSION_ERROR INTO DATA(EXC2).
        OUT->WRITE( 'Caught Exact #2' ).
    ENDTRY.


***Old
    DATA TIME TYPE STRING.
    DATA(NOW) = CL_ABAP_CONTEXT_INFO=>GET_SYSTEM_TIME(  ). " sy-timlo.
    IF NOW < '120000'.
      TIME = |{ NOW TIME = ISO } AM |.
    ELSEIF  NOW > '120000'.
      TIME = |{ CONV T( NOW - 12 * 3600 ) TIME = ISO } PM|.
    ELSEIF NOW = '120000'.
      TIME = `High Noon`.
    ELSE.
      TIME = `Call The Doctor, the Tardis is broken`.
    ENDIF.
    OUT->WRITE( TIME ).

***New
    DATA(TIME2) =
      COND STRING(
       LET NOW2 = CL_ABAP_CONTEXT_INFO=>GET_SYSTEM_TIME(  ) IN
       WHEN NOW2 < '120000' THEN
          |{ NOW2 TIME = ISO } AM |
       WHEN NOW2 > '120000' THEN
          |{ CONV T( NOW2 - 12 * 3600 ) TIME = ISO } PM|
       WHEN NOW2 = '120000' THEN
          `High Noon`
       ELSE
         `Call The Doctor, the Tardis is broken` ).
    OUT->WRITE(  TIME2 ).

****Old
    DATA NUMBER3 TYPE STRING.
    CASE SY-INDEX.
      WHEN 1.
        NUMBER3 = 'one'.
      WHEN 2.
        NUMBER3 = 'two'.
      WHEN 3.
        NUMBER3 = 'three'.
      WHEN OTHERS.
        NUMBER3 = `Who cares?`.
    ENDCASE.
    OUT->WRITE( NUMBER3 ).

****New
    DATA(NUMBER4) = SWITCH STRING(  SY-INDEX
      WHEN 1 THEN 'one'
      WHEN 2 THEN 'two'
      WHEN 3 THEN 'three'
      ELSE `Who cares?` ).
    OUT->WRITE( NUMBER4 ).

    DATA FLIGHTS  TYPE STANDARD TABLE OF /DMO/FLIGHT.
    DATA FLIGHTS2 TYPE STANDARD TABLE OF /DMO/FLIGHT.
    DATA LINE2 LIKE LINE OF FLIGHTS2.
    SELECT * FROM /DMO/FLIGHT INTO TABLE @FLIGHTS.
****Old
    LOOP AT FLIGHTS ASSIGNING FIELD-SYMBOL(<FLIGHT>).
      MOVE-CORRESPONDING <FLIGHT> TO LINE2.
      LINE2-SEATS_MAX = <FLIGHT>-SEATS_MAX - 10. "Make more room in plane
      INSERT LINE2 INTO TABLE FLIGHTS2.
    ENDLOOP.

    CLEAR: FLIGHTS2, LINE2.
****New
    FLIGHTS2 = CORRESPONDING #( FLIGHTS
                                   MAPPING SEATS_MAX = SEATS_MAX  "Entire flight is now business class
                                   EXCEPT  SEATS_OCCUPIED ). "Empty the plane


****Breakpoint helper
    IF SY-SUBRC = 0.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
