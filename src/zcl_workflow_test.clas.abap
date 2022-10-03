CLASS zcl_workflow_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WORKFLOW_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_context,
             some_property TYPE string,
           END OF ty_context.

    TRY.
        DATA(cpwf_api) = cl_swf_cpwf_api_factory_a4c=>get_api_instance( ).

        DATA(wf_def) = cpwf_api->get_workflow_definitions( ).
        out->write( `Definitions:` ).
        out->write( wf_def ).
      CATCH cx_swf_cpwf_api INTO DATA(cx_wf_api).
        out->write( cx_wf_api->get_text(  ) ).
    ENDTRY.

*
*    DATA(ls_context) = VALUE ty_context(
*      some_property = 'someValue'
*    ).
*    DATA(lv_context_json) = lo_cpwf_api->get_start_context_from_data(
*      iv_data = ls_context
*    ).
*
*    DATA(lv_cpwf_handle) = lo_cpwf_api->start_workflow(
*      iv_cp_workflow_def_id = 'myprocess'
*      iv_context            = lv_context_json
*      iv_retention_time     = 30
*      iv_callback_class     = 'ZCL_SWF_CPWF_CALLBACK'
*    ).
  ENDMETHOD.
ENDCLASS.
