CLASS zcl_4_singleton DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
    CLASS-METHODS factory RETURNING VALUE(results) TYPE REF TO zcl_4_singleton.
    METHODS write_to_log IMPORTING log_entry TYPE string.
    methods read_log returning value(results) type string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: self TYPE REF TO zcl_4_singleton.
    DATA: log TYPE STANDARD TABLE OF string.
ENDCLASS.



CLASS zcl_4_singleton IMPLEMENTATION.
  METHOD factory.
    IF self IS NOT BOUND.
      self = NEW zcl_4_singleton(  ).
    ENDIF.
    results = self.
  ENDMETHOD.

  METHOD write_to_log.
    IF log_entry IS NOT INITIAL.
      APPEND INITIAL LINE TO log REFERENCE INTO DATA(log_line).
      log_line->* = log_entry.
    ENDIF.
  ENDMETHOD.

  method read_log.
   results = log.
  endmethod.
ENDCLASS.
