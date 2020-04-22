"! <p class="shorttext synchronized" lang="en">XML To JSON via CALL Transformation</p>
CLASS zcl_xml_to_json_call DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_XML_TO_JSON_CALL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(xml) = `<object><str name="TEXT">JSON</str></object>`.
    DATA(json_writer) = cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML json_writer.


    TRY.
        DATA(reader) = cl_sxml_string_reader=>create( json_writer->get_output(  ) ).
        DATA(writer) = CAST if_sxml_writer(
                              cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ) ).
        writer->set_option( option = if_sxml_writer=>co_opt_linebreaks ).
        writer->set_option( option = if_sxml_writer=>co_opt_indent ).
        reader->next_node( ).
        reader->skip_node( writer ).
        data(json_output) = CL_ABAP_CONV_CODEPAGE=>CREATE_IN(  )->CONVERT( CAST cl_sxml_string_writer( writer )->get_output( ) ).

      CATCH cx_sxml_parse_error.
        RETURN.
    ENDTRY.
    out->write( json_output ).
  ENDMETHOD.
ENDCLASS.
