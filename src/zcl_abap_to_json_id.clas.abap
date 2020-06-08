CLASS zcl_abap_to_json_id DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_to_json_id IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(ua_0058) = NEW zcl_oo_tutorial_5(
      carrier_id    = `UA`
      connection_id = `0058`
      flight_date   = `20201214` ).
    DATA(json_writer) = cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE flight = ua_0058
                            RESULT XML data(json_out). "json_writer. DATA(json_out).
    "out->write( json_out ).
    clear ua_0058.
    data object_xml type zobject_xml.
    object_xml-id = 1.
    object_xml-content = json_out.
    MODIFY ZOBJECT_XML from @object_xml.
    data context2 type ref to zcl_oo_tutorial_5.
    CALL TRANSFORMATION id SOURCE XML json_out
                        RESULT flight = context2.
    out->write( context2->get_flight_details(  ) ).

    TRY.
        DATA(reader) = cl_sxml_string_reader=>create( json_writer->get_output(  ) ).
        DATA(writer) = CAST if_sxml_writer(
                              cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ) ).
        writer->set_option( option = if_sxml_writer=>co_opt_linebreaks ).
        writer->set_option( option = if_sxml_writer=>co_opt_indent ).
        reader->next_node( ).
        reader->skip_node( writer ).
        DATA(json_output) = cl_abap_conv_codepage=>create_in(  )->convert( CAST cl_sxml_string_writer( writer )->get_output( ) ).
      CATCH cx_sxml_parse_error into data(error).
        out->write(  error->get_text( ) ).
        RETURN.
    ENDTRY.
    out->write( json_output ).
  ENDMETHOD.

ENDCLASS.
