CLASS zcl_4_singleton_tester_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_4_singleton_tester_1 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(logger) = zcl_4_singleton=>factory(  ).
    logger->write_to_log( |First Test| ).
    out->write( logger->read_log( ) ).
    clear logger.
    DATA(second_logger) = zcl_4_singleton=>factory(  ).
    second_logger->write_to_log( |Second Test| ).
    out->write( second_logger->read_log( ) ).
  ENDMETHOD.
ENDCLASS.
