class ZCX_5_COMPOSITE definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

  public section.

    interfaces IF_T100_DYN_MSG .
    interfaces IF_T100_MESSAGE .
    data CARRID type /DMO/CARRIER_ID .
    constants:
      begin of ZCX_5_COMPOSITE,
        MSGID type SYMSGID value 'ZOO_PATTERNS',
        MSGNO type SYMSGNO value '001',
        ATTR1 type SCX_ATTRNAME value '',
        ATTR2 type SCX_ATTRNAME value '',
        ATTR3 type SCX_ATTRNAME value '',
        ATTR4 type SCX_ATTRNAME value '',
      end of ZCX_5_COMPOSITE.

    constants:
      begin of FLIGHT_NOT_FOUND,
        MSGID type SYMSGID value 'ZOO_PATTERNS',
        MSGNO type SYMSGNO value '002',
        ATTR1 type SCX_ATTRNAME value 'CARRID',
        ATTR2 type SCX_ATTRNAME value '',
        ATTR3 type SCX_ATTRNAME value '',
        ATTR4 type SCX_ATTRNAME value '',
      end of FLIGHT_NOT_FOUND.

    methods CONSTRUCTOR
      importing
        !TEXTID   like IF_T100_MESSAGE=>T100KEY optional
        !PREVIOUS like PREVIOUS optional
        !CARRID   type /DMO/CARRIER_ID optional .
  protected section.
  private section.
ENDCLASS.



CLASS ZCX_5_COMPOSITE IMPLEMENTATION.


  method CONSTRUCTOR ##ADT_SUPPRESS_GENERATION.
    call method SUPER->CONSTRUCTOR
      exporting
        PREVIOUS = PREVIOUS.
    clear ME->TEXTID.
    if TEXTID is initial.
      IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
    else.
      IF_T100_MESSAGE~T100KEY = TEXTID.
    endif.
    ME->CARRID = CARRID .
  endmethod.
ENDCLASS.
