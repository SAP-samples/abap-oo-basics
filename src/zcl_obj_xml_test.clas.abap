CLASS zcl_obj_xml_test DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_OBJ_XML_TEST IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    CASE request->get_method(  ).
      WHEN CONV string( if_web_http_client=>get ).
        TRY.
            DATA(key) = request->get_form_field( 'key' ).
            IF key IS INITIAL.
              response->set_status( i_code = if_web_http_status=>bad_request i_reason = `Key Not Supplied` ).
              response->set_text( `Key Not Supplied`  ).
              RETURN.
            ENDIF.
            SELECT SINGLE * FROM zobject_xml
                   WHERE id = @( CONV #( key ) ) INTO @DATA(object_xml).
            if sy-subrc ne 0.
              response->set_status( i_code = if_web_http_status=>bad_request i_reason = `Invalid Key` ).
              response->set_text( `Invalid Key` ).
              RETURN.
            endif.

            DATA context2 TYPE REF TO zcl_oo_tutorial_5.

            CALL TRANSFORMATION id SOURCE XML object_xml-content
                                RESULT flight = context2.
            DATA(json_writer) = cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ).
            CALL TRANSFORMATION id SOURCE flight = context2
                                       RESULT XML json_writer. "DATA(json_out).
*              response->set_header_field( i_name = 'Content-Type' i_value = 'application/xml'  ).
*              response->set_binary( object_xml-content ).

            TRY.
                DATA(reader) = cl_sxml_string_reader=>create( json_writer->get_output(  ) ).
                DATA(writer) = CAST if_sxml_writer(
                                      cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ) ).
                writer->set_option( option = if_sxml_writer=>co_opt_linebreaks ).
                writer->set_option( option = if_sxml_writer=>co_opt_indent ).
                reader->next_node( ).
                reader->skip_node( writer ).
                DATA(json_output) = cl_abap_conv_codepage=>create_in(  )->convert( CAST cl_sxml_string_writer( writer )->get_output( ) ).
                response->set_header_field( i_name = 'Content-Type' i_value = 'application/json'  ).
                response->set_text( json_output ).
              CATCH cx_sxml_parse_error INTO DATA(error).
                response->set_status( i_code = if_web_http_status=>bad_request i_reason = error->get_text(  ) ).
                response->set_text( error->get_text(  ) ).
                RETURN.
            ENDTRY.
          CATCH cx_web_message_error INTO DATA(web_error).
            response->set_status( i_code = if_web_http_status=>bad_request i_reason = web_error->get_text(  ) ).
            response->set_text( web_error->get_text(  ) ).
        ENDTRY.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
