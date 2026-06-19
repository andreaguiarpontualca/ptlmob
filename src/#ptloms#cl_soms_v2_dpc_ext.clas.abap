class /PTLOMS/CL_SOMS_V2_DPC_EXT definition
  public
  inheriting from /PTLOMS/CL_SOMS_V2_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_EXPANDED_ENTITYSET
    redefinition .
  methods /IWBEP/IF_MGW_CONV_SRV_RUNTIME~SET_HEADER
    redefinition .
protected section.

  methods ASSOCIACAOSET_GET_ENTITYSET
    redefinition .
  methods ASSOCIARSET_GET_ENTITYSET
    redefinition .
  methods CENTROCUSTOSET_GET_ENTITYSET
    redefinition .
  methods CHECKLISTANALISE_CREATE_ENTITY
    redefinition .
  methods CHECKLISTRESPOST_GET_ENTITYSET
    redefinition .
  methods DADOSUSERTRACKIN_GET_ENTITYSET
    redefinition .
  methods DESPACHOCESTOSET_GET_ENTITYSET
    redefinition .
  methods DETALHEOPERACAOS_GET_ENTITYSET
    redefinition .
  methods HISTORICOASSINAT_GET_ENTITYSET
    redefinition .
  methods HISTORICOATENDIM_GET_ENTITYSET
    redefinition .
  methods HISTORICOUSERTRA_GET_ENTITYSET
    redefinition .
  methods LISTACHECKLIST03_GET_ENTITYSET
    redefinition .
  methods LISTAUSUARIOSET_GET_ENTITYSET
    redefinition .
  methods MOTIVODESASSOCIA_GET_ENTITYSET
    redefinition .
  methods NOTAORDEMCLIENTE_GET_ENTITYSET
    redefinition .
  methods NOTAORDEMEQUIPAM_GET_ENTITYSET
    redefinition .
  methods OPERACAOSIMPLIFI_GET_ENTITYSET
    redefinition .
  methods PERFILCENTROSET_GET_ENTITYSET
    redefinition .
  methods TIMELINECOMPLETA_GET_ENTITYSET
    redefinition .
  methods TIMELINEFIORISET_GET_ENTITYSET
    redefinition .
  methods RELATORIOANALITI_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS /PTLOMS/CL_SOMS_V2_DPC_EXT IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN.
    cv_defer_mode = 'X'.

  endmethod.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_end.
    COMMIT WORK AND WAIT.

  ENDMETHOD.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS.

  endmethod.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.

    DATA: ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request.

*----------------------------------*
* Area auxiliar ASSOCIAR           *
*----------------------------------*

    DATA: BEGIN OF t_associar.
            INCLUDE          TYPE /ptloms/cl_soms_v2_mpc=>ts_associar.
            DATA: retornoset TYPE /ptloms/cl_soms_v2_mpc=>tt_retorno,
          END OF t_associar.
*
    DATA: BEGIN OF t_lista_associar.
            INCLUDE            TYPE /ptloms/cl_soms_v2_mpc=>ts_listaassociar.
            DATA:  associarset LIKE TABLE OF t_associar,
          END OF t_lista_associar.

    DATA: lt_associar LIKE TABLE OF t_lista_associar,
          ls_associar LIKE LINE OF lt_associar,
          lt_lista    LIKE t_associar.

*----------------------------------*
* Area auxiliar DETALHE OPERAÇÃO   *
*----------------------------------*

    DATA: BEGIN OF t_lista_detalhe.
            INCLUDE            TYPE /ptloms/cl_soms_v2_mpc=>ts_listaoperacao.
            DATA:  detalheset TYPE /ptloms/cl_soms_v2_mpc=>ts_detalheoperacao,
          END OF t_lista_detalhe.

    DATA: BEGIN OF t_lista_oper.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_listaoperacao.
            DATA:  detalheoperacaoset TYPE /ptloms/cl_soms_v2_mpc=>tt_detalheoperacao,
          END OF t_lista_oper.

*----------------------------------*
* Area auxiliar ANEXO EQUIPAMENTO  *
*----------------------------------*

    DATA: BEGIN OF t_lista_anexo.
            INCLUDE            TYPE /ptloms/cl_soms_v2_mpc=>ts_listaanexoequipamento.
            DATA:  anexoset TYPE /ptloms/cl_soms_v2_mpc=>ts_anexoequipamento,
          END OF t_lista_anexo.

    DATA: BEGIN OF t_lista_anexo_equip.
            INCLUDE                    TYPE /ptloms/cl_soms_v2_mpc=>ts_listaanexoequipamento.
            DATA:  anexoequipamentoset TYPE /ptloms/cl_soms_v2_mpc=>tt_anexoequipamento,
          END OF t_lista_anexo_equip.

    DATA: lt_listaanexo LIKE TABLE OF t_lista_anexo_equip,
          ls_listaanexo LIKE LINE OF  lt_listaanexo,
          es_anexo      LIKE t_lista_anexo.

*---------------------------------------*
* Area auxiliar ANEXO LOCAL INSTALAÇÃO  *
*---------------------------------------*

    DATA: BEGIN OF t_lista_instal.
            INCLUDE            TYPE /ptloms/cl_soms_v2_mpc=>ts_listaanexolocalinstalacao.
            DATA:  instalset TYPE /ptloms/cl_soms_v2_mpc=>ts_anexolocalinstalacao,
          END OF t_lista_instal.

    DATA: BEGIN OF t_lista_anexo_instal.
            INCLUDE                        TYPE /ptloms/cl_soms_v2_mpc=>ts_listaanexolocalinstalacao.
            DATA:  anexolocalinstalacaoset TYPE /ptloms/cl_soms_v2_mpc=>tt_anexolocalinstalacao,
          END OF t_lista_anexo_instal.

    DATA: lt_listainstal LIKE TABLE OF t_lista_anexo_instal,
          ls_listainstal LIKE LINE OF  lt_listainstal,
          es_instal      LIKE t_lista_instal.

*---------------------------------------*
* Area auxiliar ANEXO ORDEM             *
*---------------------------------------*

    DATA: BEGIN OF t_lista_anexoordem.
            INCLUDE            TYPE /ptloms/cl_soms_v2_mpc=>ts_listaanexoordem.
            DATA:  ordemset TYPE /ptloms/cl_soms_v2_mpc=>ts_anexoordem,
          END OF t_lista_anexoordem.

    DATA: BEGIN OF t_lista_anexo_ordem.
            INCLUDE              TYPE /ptloms/cl_soms_v2_mpc=>ts_listaanexoordem.
            DATA:  anexoordemset TYPE /ptloms/cl_soms_v2_mpc=>tt_anexoordem,
          END OF t_lista_anexo_ordem.

    DATA: lt_listaanexoordem LIKE TABLE OF t_lista_anexo_ordem,
          ls_listaanexoordem LIKE LINE OF  lt_listaanexoordem,
          es_ordem           LIKE t_lista_anexoordem.

*---------------------------------------*
* Area auxiliar LISTA DETALHE DA NOTA   *
*---------------------------------------*

    DATA:
      BEGIN OF t_lista_detalhenota.
        INCLUDE                 TYPE /ptloms/cl_soms_v2_mpc=>ts_listadetalhenota.
        DATA:  detalhenota TYPE /ptloms/cl_soms_v2_mpc=>ts_detalhenota1,
      END OF t_lista_detalhenota.

    DATA:
      BEGIN OF t_lista_detalhe_nota.
        INCLUDE                 TYPE /ptloms/cl_soms_v2_mpc=>ts_listadetalhenota.
        DATA:  detalhenota1set TYPE /ptloms/cl_soms_v2_mpc=>tt_detalhenota1,
*        DATA:  detalhenota1set LIKE TABLE OF t_lista_detalhenota,
      END OF t_lista_detalhe_nota.

    DATA: lt_listadetalhenota LIKE TABLE OF t_lista_detalhe_nota,
          ls_listadetalhenota LIKE LINE OF  lt_listadetalhenota.

*----------------------------------*
* Area auxiliar DETALHE ORDEM      *
*----------------------------------*

    DATA: BEGIN OF t_detalheordem.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_detalheordem.
            DATA: operacoesordemset   TYPE /ptloms/cl_soms_v2_mpc=>tt_operacoesordem,
            componentesordemset TYPE /ptloms/cl_soms_v2_mpc=>tt_componentesordem,
          END OF t_detalheordem.

    DATA: BEGIN OF t_lista_ordem.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_listaordem.
            DATA:  detalheordemset LIKE TABLE OF t_detalheordem,
          END OF t_lista_ordem.

    DATA: lt_listaoper     LIKE TABLE OF t_lista_oper,
          ls_listaoper     LIKE LINE OF  lt_listaoper,
          lt_listaordem    LIKE TABLE OF t_lista_ordem,
          ls_listaordem    LIKE LINE OF  lt_listaordem,
          es_detalhe       LIKE t_lista_oper,
          es_detalhe_ordem LIKE t_lista_ordem.

*--------------------------------------------*
* Area auxiliar LISTA CONFIRMACAO ORDEM      *
*--------------------------------------------*

    DATA: BEGIN OF t_confirmacao.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_confirmacao.
            DATA:  retornoset TYPE /ptloms/cl_soms_v2_mpc=>tt_retorno,
          END OF t_confirmacao.

    DATA: BEGIN OF t_lista_confirmacao.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_listaconfirmacao.
            DATA:  confirmacaoset LIKE TABLE OF t_confirmacao,
          END OF t_lista_confirmacao.

    DATA: BEGIN OF i_lista_confirmacao.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_listaconfirmacao.
            DATA:  confirmacaoset TYPE /ptloms/cl_soms_v2_mpc=>tt_confirmacao,
          END OF i_lista_confirmacao.

    DATA: lt_listaconfir     LIKE TABLE OF i_lista_confirmacao,
          ls_listaconfir_in  LIKE  i_lista_confirmacao,
          lt_listaconfir_out LIKE TABLE OF t_lista_confirmacao,
          ls_listaconfir_out LIKE LINE OF lt_listaconfir_out,
          s_confirmacao      TYPE /ptloms/cl_soms_v2_mpc=>ts_confirmacao.

*--------------------------------------------*
* Area auxiliar LISTA DESASSOCIAR            *
*--------------------------------------------*

    DATA: BEGIN OF t_desassociacao.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_desassociacao.
            DATA:  retornoset TYPE /ptloms/cl_soms_v2_mpc=>tt_retorno,
          END OF t_desassociacao.

    DATA: BEGIN OF t_lista_desassociacao.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_listadesassociar.
            DATA:  desassociacaoset LIKE TABLE OF t_desassociacao,
          END OF t_lista_desassociacao.

    DATA: BEGIN OF i_lista_desassociacao.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_listadesassociar.
            DATA:  desassociacaoset TYPE /ptloms/cl_soms_v2_mpc=>tt_desassociacao,
          END OF i_lista_desassociacao.

    DATA: lt_desassociacao     LIKE TABLE OF i_lista_desassociacao,
          ls_desassociacao_in  LIKE  i_lista_desassociacao,
          lt_desassociacao_out LIKE TABLE OF t_lista_desassociacao,
          ls_desassociacao_out LIKE LINE OF lt_desassociacao_out.

*----------------------------------*
* Area auxiliar DETALHE CLIENTE    *
*----------------------------------*

    DATA: BEGIN OF t_lista_cliente.
            INCLUDE            TYPE /ptloms/cl_soms_v2_mpc=>ts_listacliente.
            DATA:  clienteset TYPE /ptloms/cl_soms_v2_mpc=>ts_cliente,
          END OF t_lista_cliente.

    DATA: BEGIN OF t_lista_det.
            INCLUDE            TYPE /ptloms/cl_soms_v2_mpc=>ts_listacliente.
            DATA:  clienteset TYPE /ptloms/cl_soms_v2_mpc=>tt_cliente,
          END OF t_lista_det.

    DATA: lt_listacliente LIKE TABLE OF t_lista_det,
          ls_listacliente LIKE LINE OF  lt_listacliente,
          es_cliente      LIKE t_lista_det.

*----------------------------------*
*   Area auxiliar para RECUSA      *
*----------------------------------*

    DATA: BEGIN OF t_recusa.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_recusa.
            DATA:  retornoset TYPE /ptloms/cl_soms_v2_mpc=>tt_retorno,
          END OF t_recusa.

    DATA: BEGIN OF t_lista_recusa.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_listarecusa.
            DATA:  recusaset LIKE TABLE OF t_recusa,
          END OF t_lista_recusa.

    DATA: BEGIN OF i_lista_recusa.
            INCLUDE                   TYPE /ptloms/cl_soms_v2_mpc=>ts_listarecusa.
            DATA:  recusaset TYPE /ptloms/cl_soms_v2_mpc=>tt_recusa,
          END OF i_lista_recusa.

    DATA: lt_recusa     LIKE TABLE OF i_lista_recusa,
          ls_recusa_in  LIKE  i_lista_recusa,
          lt_recusa_out LIKE TABLE OF t_lista_recusa,
          ls_recusa_out LIKE LINE OF lt_recusa_out.

*----------------------------------*
* Area auxiliar Comum              *
*----------------------------------*

    DATA: lv_usuario     TYPE xubname,
          lv_rfcdest     TYPE bdbapidst,
          lv_usuario_sap TYPE flag,
          lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: rt_usuarioapp TYPE /iwbep/t_cod_select_options,
          ls_usuarioapp LIKE LINE OF rt_usuarioapp.

* Busca Conexão
    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
    IF sy-subrc EQ 0.
*Verifica se conexão está ativa
      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
        EXPORTING
          rfcdestination = lv_rfcdest
        IMPORTING
          msgv1          = lv_msgv1
          msgv2          = lv_msgv2
          rfc_subrc      = lv_subrc.

      IF lv_subrc NE 0.
        IF lv_subrc = 3.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
        ENDIF.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.
    ELSE.
      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL )  "Se usuário SAP, então SAME_USER deve estar marcado
    OR ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.

    ENDIF.

    CASE iv_entity_name.

      WHEN 'ListaAssociar'.

        io_data_provider->read_entry_data(
          IMPORTING
            es_data = ls_associar ).

        IF ls_associar IS NOT INITIAL.

          DATA:
            lt_temp     TYPE /ptloms/ct123,
            ls_temp     LIKE LINE OF lt_temp,
            es_associar LIKE LINE OF ls_associar-associarset.

          CALL FUNCTION '/PTLOMS/MF115'
            DESTINATION lv_rfcdest
            EXPORTING
              it_lista = ls_associar-associarset
            IMPORTING
              et_lista = lt_temp.

          IF  lt_temp[]  IS NOT INITIAL.
            LOOP AT lt_temp INTO ls_temp.

              CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
                EXPORTING
                  input  = ls_temp-aufnr
                IMPORTING
                  output = ls_temp-aufnr.

              READ TABLE ls_associar-associarset INTO es_associar WITH KEY aufnr = ls_temp-aufnr
                                                                           vornr = ls_temp-vornr.
              IF  sy-subrc    EQ 0.
                MOVE ls_temp-tiporetorno TO es_associar-tiporetorno.
                MOVE ls_temp-retorno[]   TO es_associar-retornoset[].
                MODIFY ls_associar-associarset FROM es_associar INDEX sy-tabix.
              ENDIF.

            ENDLOOP.

          ENDIF.

        ENDIF.

        copy_data_to_ref(
              EXPORTING
                 is_data = ls_associar
              CHANGING
                 cr_data = er_deep_entity ).

      WHEN 'ListaOperacao'.

        DATA:
          i_detoper TYPE /ptloms/ct127,
          w_detoper LIKE LINE OF i_detoper,
          e_detoper TYPE /ptloms/ct126,
          y_detoper LIKE LINE OF e_detoper,
          a_detalhe TYPE /ptloms/et147,
          s_detoper LIKE LINE OF ls_listaoper-detalheoperacaoset.

        io_data_provider->read_entry_data(
          IMPORTING
            es_data = ls_listaoper ).

        IF ls_listaoper IS NOT INITIAL.

          LOOP AT ls_listaoper-detalheoperacaoset  INTO s_detoper.

            MOVE-CORRESPONDING s_detoper    TO w_detoper.
            APPEND w_detoper                TO i_detoper.

          ENDLOOP.

          CALL FUNCTION '/PTLOMS/MF121'
            EXPORTING
              i_detalhe = i_detoper
            IMPORTING
              e_detalhe = e_detoper.

          LOOP AT e_detoper  INTO y_detoper.

            LOOP AT ls_listaoper-detalheoperacaoset INTO s_detoper
              WHERE aufnr = y_detoper-aufnr
                AND vornr = y_detoper-vornr.

              MOVE-CORRESPONDING y_detoper        TO s_detoper.   "a_detalhe.
**              APPEND  a_detalhe                   TO s_detoper-detalheset .
              MODIFY ls_listaoper-detalheoperacaoset FROM s_detoper.

            ENDLOOP.

          ENDLOOP.

        ENDIF.

        copy_data_to_ref(
              EXPORTING
                 is_data = ls_listaoper
              CHANGING
                 cr_data = er_deep_entity ).

      WHEN 'ListaCliente'.

        DATA:
          i_cliente TYPE /ptloms/ct130,
          w_cliente LIKE LINE OF i_cliente,
          e_cliente TYPE /ptloms/ct129,
          y_cliente LIKE LINE OF e_cliente,
          b_detalhe TYPE /ptloms/et153,
          s_cliente LIKE LINE OF ls_listacliente-clienteset.

        io_data_provider->read_entry_data(
          IMPORTING
            es_data = ls_listacliente ).

        IF ls_listacliente IS NOT INITIAL.

          LOOP AT ls_listacliente-clienteset  INTO s_cliente.

            MOVE-CORRESPONDING s_cliente    TO w_cliente.
            APPEND w_cliente                TO i_cliente.

          ENDLOOP.

          CALL FUNCTION '/PTLOMS/MF123'
            EXPORTING
              i_cliente = i_cliente
            IMPORTING
              e_detalhe = e_cliente.

          LOOP AT e_cliente  INTO y_cliente.

            LOOP AT ls_listacliente-clienteset INTO s_cliente
              WHERE equinr = y_cliente-equinr.

              MOVE-CORRESPONDING y_cliente        TO s_cliente.
              MODIFY ls_listacliente-clienteset FROM s_cliente.

            ENDLOOP.

          ENDLOOP.

        ENDIF.

        copy_data_to_ref(
              EXPORTING
                 is_data = ls_listacliente
              CHANGING
                 cr_data = er_deep_entity ).


      WHEN 'ListaOrdem'.

        DATA:
          i_detordem TYPE /ptloms/ct127,
          w_detordem LIKE LINE OF i_detordem,
          e_detordem TYPE /ptloms/ct132,
          y_detordem LIKE LINE OF e_detordem,
          s_detordem LIKE LINE OF t_lista_ordem-detalheordemset.

        io_data_provider->read_entry_data(
          IMPORTING
           es_data = ls_listaordem ).

        IF ls_listaordem IS NOT INITIAL.

          LOOP AT ls_listaordem-detalheordemset INTO s_detordem.
            MOVE-CORRESPONDING s_detordem    TO w_detordem.
            APPEND w_detordem               TO i_detordem.
          ENDLOOP.

          CALL FUNCTION '/PTLOMS/MF124'
            DESTINATION lv_rfcdest
            EXPORTING
              i_detalhe = i_detordem
            IMPORTING
              e_detalhe = e_detordem.

          LOOP AT e_detordem  INTO y_detordem.

            LOOP AT ls_listaordem-detalheordemset INTO s_detordem
              WHERE aufnr = y_detordem-aufnr.

              MOVE-CORRESPONDING y_detordem TO s_detordem.
              MODIFY ls_listaordem-detalheordemset FROM s_detordem.

            ENDLOOP.

          ENDLOOP.

          copy_data_to_ref(
             EXPORTING
                is_data = ls_listaordem
             CHANGING
                cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'ListaConfirmacao'.

        DATA:
          i_confoper TYPE /ptloms/ct135,
          w_confoper LIKE LINE OF i_confoper,
          e_confoper LIKE TABLE OF t_confirmacao,
          y_confoper TYPE /ptloms/cl_soms_v2_mpc=>ts_confirmacao,
          s_confoper LIKE LINE OF ls_listaconfir_out-confirmacaoset.

        DATA:
          i_confirmacao TYPE /ptloms/ct133,
          w_confirmacao LIKE LINE OF i_confirmacao.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_listaconfir_in ).

        LOOP AT ls_listaconfir_in-confirmacaoset  INTO s_confirmacao.
          MOVE-CORRESPONDING s_confirmacao    TO w_confirmacao.
          APPEND w_confirmacao                TO i_confirmacao.
        ENDLOOP.

        CALL FUNCTION '/PTLOMS/MF125'
          DESTINATION lv_rfcdest
          EXPORTING
            i_detalhe = i_confirmacao
          IMPORTING
            e_detalhe = i_confoper.

        LOOP AT i_confoper  INTO w_confoper.
          MOVE-CORRESPONDING w_confoper TO s_confoper.
          APPEND s_confoper TO ls_listaconfir_out-confirmacaoset.
*          MODIFY ls_listaconfir_out-confirmacaoset FROM s_confoper.
        ENDLOOP.

        copy_data_to_ref(
          EXPORTING
             is_data = ls_listaconfir_out
          CHANGING
             cr_data = er_deep_entity ).

      WHEN 'ListaAnexoEquipamento'.

        DATA:
          i_anexo TYPE /ptloms/ct130,
          w_anexo LIKE LINE OF i_anexo,
          a_anexo TYPE /ptloms/et163,
          b_anexo TYPE /ptloms/ct136,
          e_anexo LIKE LINE OF b_anexo.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_listaanexo ).

        LOOP AT ls_listaanexo-anexoequipamentoset      INTO a_anexo.

          MOVE a_anexo-equnr            TO w_anexo-equinr.
          APPEND w_anexo                TO i_anexo.

        ENDLOOP.
*
        REFRESH:
          b_anexo,
          ls_listaanexo-anexoequipamentoset .

        CALL FUNCTION '/PTLOMS/MF126'
          DESTINATION lv_rfcdest
          EXPORTING
            i_anexo   = i_anexo
          IMPORTING
            e_detalhe = b_anexo.

        LOOP AT b_anexo  INTO e_anexo.
          CLEAR a_anexo.
          MOVE-CORRESPONDING e_anexo TO a_anexo.
          APPEND a_anexo TO ls_listaanexo-anexoequipamentoset .
        ENDLOOP.
*
        copy_data_to_ref(
          EXPORTING
             is_data = ls_listaanexo
          CHANGING
             cr_data = er_deep_entity ).

      WHEN 'ListaDesassociar'.

        DATA:
          i_desassociar TYPE /ptloms/ct138,
          w_desassociar LIKE LINE OF i_desassociar,
          e_desassociar LIKE TABLE OF t_desassociacao,
          y_desassociar TYPE /ptloms/cl_soms_v2_mpc=>ts_desassociacao,
          s_desassociar LIKE LINE OF ls_desassociacao_in-desassociacaoset.


        DATA:
          i_desassociacao TYPE /ptloms/ct139,
          w_desassociacao LIKE LINE OF i_desassociacao,
          s_desassociacao LIKE LINE OF ls_desassociacao_out-desassociacaoset.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_desassociacao_in ).

        LOOP AT ls_desassociacao_in-desassociacaoset  INTO s_desassociar.
          MOVE-CORRESPONDING s_desassociar    TO w_desassociar.
          APPEND w_desassociar                TO i_desassociar.
        ENDLOOP.

        CALL FUNCTION '/PTLOMS/MF127'
          DESTINATION lv_rfcdest
          EXPORTING
            i_detalhe = i_desassociar
          IMPORTING
            e_detalhe = i_desassociacao.

        LOOP AT i_desassociacao  INTO w_desassociacao.
          MOVE-CORRESPONDING w_desassociacao TO s_desassociacao.
          APPEND s_desassociacao TO ls_desassociacao_out-desassociacaoset.
        ENDLOOP.

        copy_data_to_ref(
          EXPORTING
             is_data = ls_desassociacao_out
          CHANGING
             cr_data = er_deep_entity ).


      WHEN 'ListaAnexoLocalInstalacao'.

        DATA:
          i_instal TYPE /ptloms/ct140,
          w_instal LIKE LINE OF i_instal,
          a_instal TYPE /ptloms/et168,
          b_instal TYPE /ptloms/ct141,
          e_instal LIKE LINE OF b_instal.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_listainstal ).

        LOOP AT ls_listainstal-anexolocalinstalacaoset     INTO a_instal.

          MOVE a_instal-tplnr            TO w_instal-tplnr.
          APPEND w_instal                TO i_instal.

        ENDLOOP.
*
        REFRESH:
          b_instal,
          ls_listainstal-anexolocalinstalacaoset .

        CALL FUNCTION '/PTLOMS/MF128'
          DESTINATION lv_rfcdest
          EXPORTING
            i_anexo   = i_instal
          IMPORTING
            e_detalhe = b_instal.

        LOOP AT b_instal  INTO e_instal.
          CLEAR a_instal.
          MOVE-CORRESPONDING e_instal TO a_instal.
          APPEND a_instal TO ls_listainstal-anexolocalinstalacaoset .
        ENDLOOP.
*
        copy_data_to_ref(
          EXPORTING
             is_data = ls_listainstal
          CHANGING
             cr_data = er_deep_entity ).

      WHEN 'ListaAnexoOrdem'.

        DATA:
          i_ordem TYPE /ptloms/ct145,
          w_ordem LIKE LINE OF i_ordem,
          a_ordem TYPE /ptloms/et172,
          b_ordem TYPE /ptloms/ct146,
          e_ordem LIKE LINE OF b_ordem.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_listaanexoordem ).

        LOOP AT ls_listaanexoordem-anexoordemset      INTO a_ordem.

          MOVE a_ordem-aufnr            TO w_ordem-aufnr.
          APPEND w_ordem                TO i_ordem.

        ENDLOOP.
*
        REFRESH:
          b_ordem,
          ls_listaanexoordem-anexoordemset .

        CALL FUNCTION '/PTLOMS/MF129'
          DESTINATION lv_rfcdest
          EXPORTING
            i_anexo   = i_ordem
          IMPORTING
            e_detalhe = b_ordem.

        LOOP AT b_ordem  INTO e_ordem.
          CLEAR a_ordem.
          MOVE-CORRESPONDING e_ordem TO a_ordem.
          APPEND a_ordem TO ls_listaanexoordem-anexoordemset .
        ENDLOOP.
*
        copy_data_to_ref(
          EXPORTING
             is_data = ls_listaanexoordem
          CHANGING
             cr_data = er_deep_entity ).

      WHEN 'ListaRecusa'.

        DATA:
          i_recusar TYPE /ptloms/ct144,
          w_recusar LIKE LINE OF i_recusar,
          e_recusar LIKE TABLE OF t_recusa,
          y_recusar TYPE /ptloms/cl_soms_v2_mpc=>ts_recusa,
          s_recusar LIKE LINE OF ls_recusa_in-recusaset.

        DATA:
          i_recusa TYPE /ptloms/ct142,
          w_recusa LIKE LINE OF i_recusa,
          s_recusa LIKE LINE OF ls_recusa_out-recusaset.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_recusa_in ).

        LOOP AT ls_recusa_in-recusaset INTO s_recusar.
          MOVE-CORRESPONDING s_recusar TO w_recusar.
          APPEND w_recusar TO i_recusar.
        ENDLOOP.

        CALL FUNCTION '/PTLOMS/MF130'
          DESTINATION lv_rfcdest
          EXPORTING
            i_detalhe = i_recusar
          IMPORTING
            e_detalhe = i_recusa.

        LOOP AT i_recusa INTO w_recusa.
          MOVE-CORRESPONDING w_recusa TO s_recusa.
          APPEND s_recusa TO ls_recusa_out-recusaset.
        ENDLOOP.

        copy_data_to_ref(
          EXPORTING
             is_data = ls_recusa_out
          CHANGING
             cr_data = er_deep_entity ).

      WHEN 'ListaDetalheNota'.

        DATA:
          i_detnota TYPE /ptloms/ct147,
          w_detnota LIKE LINE OF i_detnota,
          e_detnota TYPE /ptloms/ct148,
          y_detnota LIKE LINE OF e_detnota,
          a_detnota TYPE /ptloms/et173,
          s_detnota LIKE LINE OF t_lista_detalhe_nota-detalhenota1set.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_listadetalhenota ).

        LOOP AT ls_listadetalhenota-detalhenota1set  INTO a_detnota.

          MOVE a_detnota-notif_no  TO w_detnota-notif_no.
          APPEND w_detnota         TO i_detnota.

        ENDLOOP.

        REFRESH:
          ls_listadetalhenota-detalhenota1set,
          e_detnota.

        CALL FUNCTION '/PTLOMS/MF131'
          DESTINATION lv_rfcdest
          EXPORTING
            it_lista = i_detnota
          IMPORTING
            et_lista = e_detnota.
*
        IF  e_detnota  IS NOT INITIAL.
          LOOP AT e_detnota   INTO y_detnota.

            CLEAR a_detnota.
            MOVE-CORRESPONDING y_detnota TO a_detnota.
            APPEND a_detnota TO ls_listadetalhenota-detalhenota1set .

          ENDLOOP.

        ENDIF.
*
        copy_data_to_ref(
          EXPORTING
             is_data = ls_listadetalhenota
          CHANGING
             cr_data = er_deep_entity ).

      WHEN 'ListaHistoricoConfirmacao'.

        DATA: BEGIN OF i_lista_historconfir.
                INCLUDE   TYPE /ptloms/cl_soms_v2_mpc=>ts_listahistoricoconfirmacao.
                DATA:  historicoconfirmacaoset TYPE TABLE OF /ptloms/et181,
              END OF i_lista_historconfir.

        DATA:
          lt_lista_historconfir    LIKE TABLE OF i_lista_historconfir,
          ls_lista_historconfir    LIKE i_lista_historconfir,
          ls_lista_historconfir_in LIKE LINE OF ls_lista_historconfir-historicoconfirmacaoset,

          lt_historconfir_in       TYPE /ptloms/ct154,
          w_historconfir_in        LIKE LINE OF lt_historconfir_in,

          lt_historconfir_out      TYPE /ptloms/ct154,
          w_historconfir_out       LIKE LINE OF lt_historconfir_out,
          s_historconfir_out       LIKE LINE OF ls_lista_historconfir-historicoconfirmacaoset.

*       Leitura dos dados de Entrada
        io_data_provider->read_entry_data(
          IMPORTING
            es_data = ls_lista_historconfir
            ).

        LOOP AT ls_lista_historconfir-historicoconfirmacaoset INTO ls_lista_historconfir_in.
          MOVE-CORRESPONDING ls_lista_historconfir_in TO w_historconfir_in.
          APPEND w_historconfir_in TO lt_historconfir_in.
        ENDLOOP.

        CALL FUNCTION '/PTLOMS/MF133'
          DESTINATION lv_rfcdest
          EXPORTING
            hist_confir_in  = lt_historconfir_in
          IMPORTING
            hist_confir_out = lt_historconfir_out.

        CLEAR ls_lista_historconfir.
        LOOP AT lt_historconfir_out INTO w_historconfir_out.
          MOVE-CORRESPONDING w_historconfir_out TO s_historconfir_out.
          s_historconfir_out-chave = 'X'.
          APPEND s_historconfir_out TO ls_lista_historconfir-historicoconfirmacaoset.
        ENDLOOP.

        copy_data_to_ref(
          EXPORTING
            is_data = ls_lista_historconfir
          CHANGING
             cr_data = er_deep_entity ).

      WHEN 'ListaChecklistPerguntas'.

        DATA: BEGIN OF i_lista_checklistperguntas.
                INCLUDE   TYPE /ptloms/cl_soms_v2_mpc=>ts_listachecklistperguntas.
                DATA:  checklistperguntasset   TYPE TABLE OF /ptloms/et088,
                retornoset              TYPE TABLE OF /ptloms/et060,
                checklistlistaopcoesset TYPE TABLE OF /ptloms/et089,
              END OF i_lista_checklistperguntas.

        DATA: ls_lista_checklistperguntas    LIKE i_lista_checklistperguntas,
              ls_lista_checklistperguntas_in LIKE LINE OF ls_lista_checklistperguntas-checklistperguntasset.
*              ls_lista_checklistperguntas_out LIKE LINE OF ls_lista_checklistperguntas-checklistperguntasset.
        DATA: lt_checklistperguntas_in  TYPE /ptloms/ct155,
              w_checklistperguntas_in   LIKE LINE OF lt_checklistperguntas_in,
              lt_checklistperguntas_out TYPE /ptloms/ct155,
              w_checklistperguntas_out  LIKE LINE OF lt_checklistperguntas_out,
              lt_checklistopcoes_out    TYPE /ptloms/ct087.

        DATA: lt_checklistretorno_out TYPE /ptloms/ct156,
              ls_checklistretorno_out TYPE /ptloms/et060.

*       Leitura dos dados de Entrada
        io_data_provider->read_entry_data(
          IMPORTING
            es_data = ls_lista_checklistperguntas
            ).

        LOOP AT ls_lista_checklistperguntas-checklistperguntasset INTO ls_lista_checklistperguntas_in.
          MOVE-CORRESPONDING ls_lista_checklistperguntas_in TO w_checklistperguntas_in.
          APPEND w_checklistperguntas_in TO lt_checklistperguntas_in.
          CLEAR w_checklistperguntas_in.
        ENDLOOP.

        CALL FUNCTION '/PTLOMS/MF135'
          DESTINATION lv_rfcdest
          EXPORTING
            i_perguntas = lt_checklistperguntas_in
          IMPORTING
            e_perguntas = lt_checklistperguntas_out
            e_opcoes    = lt_checklistopcoes_out
            e_retorno   = lt_checklistretorno_out.

        ls_lista_checklistperguntas-checklistperguntasset = lt_checklistperguntas_out.
        ls_lista_checklistperguntas-checklistlistaopcoesset = lt_checklistopcoes_out.
        ls_lista_checklistperguntas-retornoset = lt_checklistretorno_out.

        copy_data_to_ref(
          EXPORTING
            is_data = ls_lista_checklistperguntas
          CHANGING
            cr_data = er_deep_entity ).

      WHEN 'ListaChecklistPayload'.

        DATA: BEGIN OF i_lista_checklistrespostas.
                INCLUDE   TYPE /ptloms/cl_soms_v2_mpc=>ts_listachecklistrespostas.
                DATA:  checklistquestoesset TYPE TABLE OF /ptloms/cl_soms_v2_mpc=>ts_checklistquestoes,
                retornoset           TYPE TABLE OF /ptloms/et060,
              END OF i_lista_checklistrespostas.

        TYPES: ty_lista_checklistrespostas LIKE TABLE OF i_lista_checklistrespostas.

        DATA: BEGIN OF i_lista_checklistpayload.
                INCLUDE   TYPE /ptloms/cl_soms_v2_mpc=>ts_listachecklistpayload.
                DATA:  listachecklistrespostasset TYPE ty_lista_checklistrespostas, "/ptloms/cl_soms_v2_mpc=>tt_listachecklistrespostas,
              END OF i_lista_checklistpayload.

        DATA: ls_lista_checklistrespostas    LIKE i_lista_checklistrespostas,
              ls_lista_checklistpayload      LIKE i_lista_checklistpayload,
              ls_lista_checklistrespostas_in LIKE i_lista_checklistrespostas,
              ls_lista_checklistquestoesset  TYPE /ptloms/et090,
              lt_checklistrespostas_in       TYPE /ptloms/ct088,
              ls_checklistrespostas_in       TYPE /ptloms/et090,
              lt_checklistrespostas_out      TYPE /ptloms/ct088,
              lt_checklistrespostas_out2     TYPE /ptloms/ct088,
              ls_checklistrespostas_out      TYPE /ptloms/et090.

        FIELD-SYMBOLS <fs_lista_checklistrespostas> LIKE i_lista_checklistrespostas.

*       Leitura dos dados de Entrada
        io_data_provider->read_entry_data(
          IMPORTING
            es_data = ls_lista_checklistpayload
            ).

        LOOP AT ls_lista_checklistpayload-listachecklistrespostasset INTO ls_lista_checklistrespostas_in.
          LOOP AT ls_lista_checklistrespostas_in-checklistquestoesset INTO ls_lista_checklistquestoesset.
            MOVE-CORRESPONDING ls_lista_checklistquestoesset TO ls_checklistrespostas_in.
            APPEND ls_checklistrespostas_in TO lt_checklistrespostas_in.
            CLEAR ls_checklistrespostas_in.
          ENDLOOP.
        ENDLOOP.

        CLEAR lt_checklistretorno_out.

        CALL FUNCTION '/PTLOMS/MF136'
          DESTINATION lv_rfcdest
          EXPORTING
            i_respostas = lt_checklistrespostas_in
          IMPORTING
            e_respostas = lt_checklistrespostas_out
            e_retorno   = lt_checklistretorno_out.

        LOOP AT ls_lista_checklistpayload-listachecklistrespostasset ASSIGNING <fs_lista_checklistrespostas>.

          LOOP AT lt_checklistrespostas_out INTO ls_checklistrespostas_out
            WHERE ordem = <fs_lista_checklistrespostas>-orderid
              AND operacao = <fs_lista_checklistrespostas>-activity
              AND usuario = <fs_lista_checklistrespostas>-usuario
              AND tp_vinculo = <fs_lista_checklistrespostas>-tipo.
            APPEND ls_checklistrespostas_out TO lt_checklistrespostas_out2.
          ENDLOOP.

          CLEAR <fs_lista_checklistrespostas>-checklistquestoesset.
          <fs_lista_checklistrespostas>-checklistquestoesset = lt_checklistrespostas_out2.
          <fs_lista_checklistrespostas>-retornoset = lt_checklistretorno_out.

          READ TABLE lt_checklistretorno_out INTO ls_checklistretorno_out INDEX 1.
          IF ls_checklistretorno_out-type = 'S'.
            <fs_lista_checklistrespostas>-status = 'SUCESSO'.
          ELSE.
            <fs_lista_checklistrespostas>-status = 'ERRO'.
          ENDIF.

          CLEAR lt_checklistrespostas_out2.
        ENDLOOP.

        copy_data_to_ref(
          EXPORTING
            is_data = ls_lista_checklistpayload
          CHANGING
            cr_data = er_deep_entity ).


      WHEN 'ListaAssinatura'.

        DATA: BEGIN OF t_lista_assinatura.
                INCLUDE              TYPE /ptloms/cl_soms_v2_mpc=>ts_listaassinatura.
                DATA:  assinaturaset TYPE TABLE OF /ptloms/et182,
                retornoset    TYPE TABLE OF /ptloms/et060,
              END OF t_lista_assinatura.

        DATA: lt_lista_assinatura    LIKE TABLE OF t_lista_assinatura,
              ls_lista_assinatura    LIKE t_lista_assinatura,
              ls_lista_assinatura_in LIKE LINE OF ls_lista_assinatura-assinaturaset,

              lt_assinatura_in       TYPE /ptloms/ct157,
              w_assinatura_in        LIKE LINE OF lt_assinatura_in,

              lt_assinatura_out      TYPE /ptloms/ct157,
              w_assinatura_out       LIKE LINE OF lt_assinatura_out,
              ls_assinatura_out      LIKE LINE OF ls_lista_assinatura-assinaturaset.

        DATA: lt_assinatura_retorno_out TYPE /ptloms/ct156.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_lista_assinatura ).

        "Dados de entrada
        LOOP AT ls_lista_assinatura-assinaturaset INTO ls_lista_assinatura_in.
          MOVE-CORRESPONDING ls_lista_assinatura_in TO w_assinatura_in.
          APPEND w_assinatura_in TO lt_assinatura_in.
        ENDLOOP.

        REFRESH: ls_lista_assinatura-assinaturaset.

        CALL FUNCTION '/PTLOMS/MF137'
          DESTINATION lv_rfcdest
          EXPORTING
            i_assinatura_in  = lt_assinatura_in
          IMPORTING
            e_assinatura_out = lt_assinatura_out
            e_retorno_out    = lt_assinatura_retorno_out.

        "Dados de retorno
        LOOP AT lt_assinatura_out  INTO w_assinatura_out.
          MOVE-CORRESPONDING w_assinatura_out TO ls_assinatura_out.
          APPEND ls_assinatura_out TO ls_lista_assinatura-assinaturaset.
        ENDLOOP.

        ls_lista_assinatura-retornoset = lt_assinatura_retorno_out.

        copy_data_to_ref(
          EXPORTING
             is_data = ls_lista_assinatura
          CHANGING
             cr_data = er_deep_entity ).

      WHEN 'ListaUserTracking'.

        DATA: BEGIN OF t_lista_tracking.
                INCLUDE              TYPE /ptloms/cl_soms_v2_mpc=>ts_listausertracking.
                DATA:  usertrackingset TYPE TABLE OF /ptloms/et191,
                retornoset      TYPE TABLE OF /ptloms/et060,
              END OF t_lista_tracking.

        DATA: lt_lista_tracking    LIKE TABLE OF t_lista_tracking,
              ls_lista_tracking    LIKE t_lista_tracking,
              ls_lista_tracking_in LIKE LINE OF ls_lista_tracking-usertrackingset,

              lt_tracking_in       TYPE /ptloms/ct163,
              w_tracking_in        LIKE LINE OF lt_tracking_in,

              lt_tracking_out      TYPE /ptloms/ct163,
              w_tracking_out       LIKE LINE OF lt_tracking_out,
              ls_tracking_out      LIKE LINE OF ls_lista_tracking-usertrackingset.

        DATA: lt_tracking_retorno_out TYPE /ptloms/ct156.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_lista_tracking ).

        "Dados de entrada
        LOOP AT ls_lista_tracking-usertrackingset INTO ls_lista_tracking_in.
          MOVE-CORRESPONDING ls_lista_tracking_in TO w_tracking_in.
          APPEND w_tracking_in TO lt_tracking_in.
        ENDLOOP.

        REFRESH: ls_lista_tracking-usertrackingset.

        CALL FUNCTION '/PTLOMS/MF143'
          DESTINATION lv_rfcdest
          EXPORTING
            i_rastreamento_usuario_in  = lt_tracking_in
          IMPORTING
            e_rastreamento_usuario_out = lt_tracking_out
            e_retorno_out              = lt_tracking_retorno_out.

        "Dados de retorno
        LOOP AT lt_tracking_out  INTO w_tracking_out.
          MOVE-CORRESPONDING w_tracking_out TO ls_tracking_out.
          APPEND ls_tracking_out TO ls_lista_tracking-usertrackingset.
        ENDLOOP.

        ls_lista_tracking-retornoset = lt_tracking_retorno_out.

        copy_data_to_ref(
          EXPORTING
             is_data = ls_lista_tracking
          CHANGING
             cr_data = er_deep_entity ).


      WHEN 'ListaReservaBaixa'.

        DATA: BEGIN OF t_lista_reserva_baixa.
                INCLUDE TYPE /ptloms/cl_soms_v2_mpc=>ts_listareservabaixa.
                DATA:   baixareservaset TYPE TABLE OF /ptloms/et201,
                retornoset      TYPE TABLE OF /ptloms/et060,
              END OF t_lista_reserva_baixa.

        DATA: ls_lista_reserva_baixa LIKE t_lista_reserva_baixa,
              ls_baixa_reserva_in    LIKE LINE OF ls_lista_reserva_baixa-baixareservaset,
              ls_baixa_reserva_out   LIKE LINE OF ls_lista_reserva_baixa-baixareservaset,
              ls_retorno_out         LIKE LINE OF ls_lista_reserva_baixa-retornoset.

        DATA: lt_baixa_in    TYPE /ptloms/ct171,
              ls_baixa_in    LIKE LINE OF lt_baixa_in,
              lt_dados_out   TYPE /ptloms/ct171,
              ls_dados_out   LIKE LINE OF lt_dados_out,
              lt_retorno_out TYPE /ptloms/ct156.

        CLEAR: ls_lista_reserva_baixa,
               lt_baixa_in,
               lt_dados_out,
               lt_retorno_out.

        io_data_provider->read_entry_data(
          IMPORTING
            es_data = ls_lista_reserva_baixa ).

        "Entrada: BaixaReservaSet -> CT171
        LOOP AT ls_lista_reserva_baixa-baixareservaset INTO ls_baixa_reserva_in.

          CLEAR ls_baixa_in.
          MOVE-CORRESPONDING ls_baixa_reserva_in TO ls_baixa_in.

          IF ls_baixa_in-status IS INITIAL.
            ls_baixa_in-status = 'P'.
          ENDIF.

          APPEND ls_baixa_in TO lt_baixa_in.

        ENDLOOP.

        REFRESH: ls_lista_reserva_baixa-baixareservaset,
                 ls_lista_reserva_baixa-retornoset.

        CALL FUNCTION '/PTLOMS/MF154'
          DESTINATION lv_rfcdest
          EXPORTING
            iv_pstng_date = sy-datum
            iv_testrun    = space
            it_baixa      = lt_baixa_in
          IMPORTING
            et_dados      = lt_dados_out
            et_return     = lt_retorno_out.

        "Retorno dos itens processados preservando dados originais e atualizando STATUS
        LOOP AT lt_baixa_in INTO ls_baixa_in.

          CLEAR ls_baixa_reserva_out.
          MOVE-CORRESPONDING ls_baixa_in TO ls_baixa_reserva_out.

          READ TABLE lt_dados_out INTO ls_dados_out
            WITH KEY rsnum = ls_baixa_in-rsnum
                     rspos = ls_baixa_in-rspos.

          IF sy-subrc = 0.
            ls_baixa_reserva_out-status = ls_dados_out-status.
          ELSE.
            ls_baixa_reserva_out-status = 'E'.
          ENDIF.

          APPEND ls_baixa_reserva_out TO ls_lista_reserva_baixa-baixareservaset.

        ENDLOOP.

        "Retorno de mensagens: CT156 -> RetornoSet
        LOOP AT lt_retorno_out INTO ls_retorno_out.

          APPEND ls_retorno_out TO ls_lista_reserva_baixa-retornoset.

        ENDLOOP.

        copy_data_to_ref(
          EXPORTING
            is_data = ls_lista_reserva_baixa
          CHANGING
            cr_data = er_deep_entity ).

    ENDCASE.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_expanded_entityset.

    " Declarações estruturais gerais
    DATA: lv_rfcdest   TYPE bdbapidst,
          lv_same_user TYPE rfcdisplay-rfcsameusr,
          lv_mensagem  TYPE bapi_msg,
          ls_filter    TYPE /iwbep/s_mgw_select_option,
          ls_sel       TYPE /iwbep/s_cod_select_option.


    "(>>>>> Valida Configuração RFC (Verifica se possui usuário fixo) <<<<<)
    " Busca Conexão
    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'RFC_READ_R3_DESTINATION'
        EXPORTING
          destination             = lv_rfcdest
        IMPORTING
          same_user               = lv_same_user
        EXCEPTIONS
          authority_not_available = 1
          destination_not_exist   = 2
          information_failure     = 3
          internal_failure        = 4
          OTHERS                  = 5.
      IF sy-subrc <> 0.
        CASE sy-subrc.
          WHEN 1.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '006'
              INTO lv_mensagem.
          WHEN 2.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '007'
              INTO lv_mensagem.
          WHEN 3.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '008'
              INTO lv_mensagem.
          WHEN OTHERS.
        ENDCASE.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.

      "(>>>>> Função para validar configuração RFC <<<<<)
      CALL FUNCTION '/PTLOMS/MF108'
        DESTINATION lv_rfcdest
        IMPORTING
          e_rfc              = lv_rfcdest
        EXCEPTIONS
          sem_aut_rfc        = 1
          rfc_nao_existente  = 2
          rfc_nao_cadastrada = 3
          rfc_incompativel   = 4
          OTHERS             = 5.
      IF sy-subrc <> 0.
        CASE sy-subrc.
          WHEN 1.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '009'
              INTO lv_mensagem.
          WHEN 2.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '010'
              INTO lv_mensagem.
          WHEN 3.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '011'
              INTO lv_mensagem.
          WHEN 4.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '012'
              INTO lv_mensagem.
          WHEN OTHERS.
        ENDCASE.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.

    ENDIF.

    CASE iv_entity_name.

      WHEN 'RelatorioStatusExecucaoOperacao'.

        " Declarações especificas do serviço
        DATA: rt_guid_filter      TYPE /iwbep/t_cod_select_options,
              rt_aufnr_filter     TYPE /iwbep/t_cod_select_options,
              lv_data_ini         TYPE /ptloms/et188-datacriacao,
              lv_data_fim         TYPE /ptloms/et188-datadessac,
              lt_associacoes_tree TYPE /ptloms/ct162,
              ls_associacoes_tree LIKE LINE OF lt_associacoes_tree.

        " Declaração estrutura complexa Relatorio Status Execucao Operacao
        DATA: BEGIN OF t_relat_status_exec_oper.
                INCLUDE                        TYPE /ptloms/cl_soms_v2_mpc=>ts_relatoriostatusexecucaooper.
                DATA: historicoassinaturasset        TYPE /ptloms/cl_soms_v2_mpc=>tt_historicoassinaturas,
                listachecklistrespostasusuaset TYPE /ptloms/cl_soms_v2_mpc=>tt_listachecklistrespostasusua,
                historicoconfirmacaoset        TYPE /ptloms/cl_soms_v2_mpc=>tt_historicoconfirmacao,
              END OF t_relat_status_exec_oper.

        DATA: lt_relat_status_exec_oper LIKE TABLE OF t_relat_status_exec_oper,
              ls_relat_status_exec_oper LIKE LINE OF lt_relat_status_exec_oper,
              lv_aufnr                  TYPE /ptloms/et188-aufnr.


        " Carrega filtros
        IF it_filter_select_options[] IS NOT INITIAL.

          CLEAR ls_filter.
          READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'Guid'.
          IF sy-subrc = 0.
            rt_guid_filter = ls_filter-select_options.
          ENDIF.

          CLEAR ls_filter.
          READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'Aufnr'.
          IF sy-subrc = 0.
            LOOP AT ls_filter-select_options ASSIGNING FIELD-SYMBOL(<aufnr>).
              clear lv_aufnr.
              IF <aufnr>-low IS NOT INITIAL.
                lv_aufnr = <aufnr>-low.
                <aufnr>-low = |{ lv_aufnr ALPHA = IN }|.
              ENDIF.
              IF <aufnr>-high IS NOT INITIAL.
                lv_aufnr = <aufnr>-high.
                <aufnr>-high = |{ <aufnr>-high ALPHA = IN }|.
              ENDIF.
            ENDLOOP.
            rt_aufnr_filter = ls_filter-select_options.
          ENDIF.

          CLEAR ls_filter.
          READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'DataIni'.
          IF sy-subrc = 0.
            CLEAR ls_sel.
            READ TABLE ls_filter-select_options INTO ls_sel INDEX 1.
            lv_data_ini = ls_sel-low.
          ENDIF.

          CLEAR ls_filter.
          READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'DataFim'.
          IF sy-subrc = 0.
            CLEAR ls_sel.
            READ TABLE ls_filter-select_options INTO ls_sel INDEX 1.
            lv_data_fim = ls_sel-low.
          ENDIF.

        ENDIF.

        CALL FUNCTION '/PTLOMS/MF141'
          DESTINATION lv_rfcdest
          EXPORTING
            rt_guid        = rt_guid_filter
            rt_aufnr       = rt_aufnr_filter
            i_data_ini     = lv_data_ini
            i_data_fim     = lv_data_fim
          IMPORTING
            et_associacoes = lt_associacoes_tree.

        "Atribui Dados de Saida
        LOOP AT lt_associacoes_tree  INTO ls_associacoes_tree.
          MOVE-CORRESPONDING ls_associacoes_tree TO ls_relat_status_exec_oper.
          ls_relat_status_exec_oper-historicoassinaturasset = ls_associacoes_tree-historicoassinaturas.
          ls_relat_status_exec_oper-historicoconfirmacaoset = ls_associacoes_tree-historicoconfirmacao.
          APPEND ls_relat_status_exec_oper TO lt_relat_status_exec_oper.
        ENDLOOP.

        APPEND 'RelatorioStatusExecucaoOperacaoSet/HistoricoAssinaturasSet'           TO et_expanded_tech_clauses.
        APPEND 'RelatorioStatusExecucaoOperacaoSet/ListaChecklistRespostasUsuarioSet' TO et_expanded_tech_clauses.
        APPEND 'RelatorioStatusExecucaoOperacaoSet/HistoricoConfirmacaoSet'           TO et_expanded_tech_clauses.

        copy_data_to_ref( EXPORTING is_data = lt_relat_status_exec_oper CHANGING cr_data = er_entityset ).

      WHEN OTHERS.

    ENDCASE.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_conv_srv_runtime~set_header.
    DATA: ls TYPE ihttpnvp.

    ls-name = 'Access-Control-Allow-Origin'.
    ls-value = '*'.
    /iwbep/if_mgw_conv_srv_runtime~set_header( is_header = ls ).

*    ls-name  = 'Access-Control-Allow-Methods'.
*    ls-value = 'POST,GET,PUT,PATCH,DELETE,OPTIONS'.
*    /iwbep/if_mgw_conv_srv_runtime~set_header( is_header = ls ).

    ls-name  = 'Access-Control-Allow-Methods'.
    ls-value = '*'.
    /iwbep/if_mgw_conv_srv_runtime~set_header( is_header = ls ).

*    ls-name  = 'Access-Control-Allow-Headers'.    " Name of the header field
*    ls-value = 'Content-Type, X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Date, X-Api-Version, X-File-Name, Authorization, AccessToken, MaxDataServiceVersion'  .
*    /iwbep/if_mgw_conv_srv_runtime~set_header( is_header = ls ).

    ls-name  = 'Access-Control-Allow-Headers'.    " Name of the header field
    ls-value = '*'.
    /iwbep/if_mgw_conv_srv_runtime~set_header( is_header = ls ).

    ls-name  = 'Access-Control-Allow-Credentials'.    " Name of the header field
    ls-value = 'true'.
    /iwbep/if_mgw_conv_srv_runtime~set_header( is_header = ls ).
  ENDMETHOD.


  METHOD associacaoset_get_entityset.

    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap TYPE flag,
          lv_mensagem    TYPE bapi_msg,
          lt_retorno     TYPE /ptloms/ct156,
          wa_filter      TYPE /iwbep/s_mgw_select_option,
          wa_sel         TYPE /iwbep/s_cod_select_option.

    DATA: lt_associacoes TYPE /ptloms/ct166,
          ls_associacoes LIKE LINE OF lt_associacoes,
          lv_data_ini    TYPE /ptloms/et195-data_ini,
          lv_data_fim    TYPE /ptloms/et195-data_fim.

    DATA: lt_associacoes_desassociar TYPE STANDARD TABLE OF /ptloms/cl_soms_v2_mpc=>ts_associacao,
          ls_associacoes_desassociar LIKE LINE OF lt_associacoes_desassociar.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR   "Se usuário SAP, então SAME_USER deve estar marcado
       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

**(>>>>> Tratar filtros <<<<<)
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataIni'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_data_ini = wa_sel-low.
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataFim'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_data_fim = wa_sel-low.
    ENDIF.

    IF lv_data_ini IS NOT INITIAL AND lv_data_fim IS NOT INITIAL.
      CALL FUNCTION '/PTLOMS/MF147'
        DESTINATION lv_rfcdest
        EXPORTING
          i_data_ini    = lv_data_ini
          i_data_fim    = lv_data_fim
        IMPORTING
          e_associacoes = lt_associacoes.
    ENDIF.

    CLEAR ls_associacoes.
    LOOP AT lt_associacoes INTO ls_associacoes.
      CLEAR ls_associacoes_desassociar.
      MOVE-CORRESPONDING ls_associacoes TO ls_associacoes_desassociar.
      APPEND ls_associacoes_desassociar TO lt_associacoes_desassociar.
    ENDLOOP.

    et_entityset = lt_associacoes_desassociar.

  ENDMETHOD.


  METHOD associarset_get_entityset.

    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_mensagem    TYPE bapi_msg,
          wa_filter      TYPE /iwbep/s_mgw_select_option,
          rt_aufnr       TYPE /iwbep/t_cod_select_options,
          rt_uname       TYPE /iwbep/t_cod_select_options,
          lt_associacoes TYPE /ptloms/ct125.

*(>>>>> Valida Configuração RFC (Verifica se possui usuário fixo) <<<<<)
* Busca Conexão
    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'RFC_READ_R3_DESTINATION'
        EXPORTING
          destination             = lv_rfcdest
        IMPORTING
          same_user               = lv_same_user
        EXCEPTIONS
          authority_not_available = 1
          destination_not_exist   = 2
          information_failure     = 3
          internal_failure        = 4
          OTHERS                  = 5.
      IF sy-subrc <> 0.
        CASE sy-subrc.
          WHEN 1.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '006'
              INTO lv_mensagem.
          WHEN 2.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '007'
              INTO lv_mensagem.
          WHEN 3.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '008'
              INTO lv_mensagem.
          WHEN OTHERS.
        ENDCASE.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.

*(>>>>> Função para validar configuração RFC <<<<<)
      CALL FUNCTION '/PTLOMS/MF108'
        DESTINATION lv_rfcdest
        IMPORTING
          e_rfc              = lv_rfcdest
        EXCEPTIONS
          sem_aut_rfc        = 1
          rfc_nao_existente  = 2
          rfc_nao_cadastrada = 3
          rfc_incompativel   = 4
          OTHERS             = 5.
      IF sy-subrc <> 0.
        CASE sy-subrc.
          WHEN 1.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '009'
              INTO lv_mensagem.
          WHEN 2.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '010'
              INTO lv_mensagem.
          WHEN 3.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '011'
              INTO lv_mensagem.
          WHEN 4.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '012'
              INTO lv_mensagem.
          WHEN OTHERS.
        ENDCASE.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.
    ENDIF.

*(>>>>> Tratar filtros <<<<<)
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Aufnr'.
    IF sy-subrc = 0.
      rt_aufnr = wa_filter-select_options.
    ENDIF.

    CLEAR wa_filter.
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Uname'.
    IF sy-subrc = 0.
      rt_uname = wa_filter-select_options.
    ENDIF.

*(>>>>> Função para recuperar lista de associações <<<<<)
    CALL FUNCTION '/PTLOMS/MF118'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_aufnr       = rt_aufnr
        rt_uname       = rt_uname
      IMPORTING
        it_associacoes = lt_associacoes.


    et_entityset = CORRESPONDING /ptloms/cl_soms_v2_mpc=>tt_associar( lt_associacoes ).

  ENDMETHOD.


METHOD centrocustoset_get_entityset.

  DATA: lr_kostl TYPE RANGE OF csks-kostl,
        lr_kokrs TYPE RANGE OF cskt-kokrs,
        lr_ktext TYPE RANGE OF cskt-ktext.

  LOOP AT it_filter_select_options ASSIGNING FIELD-SYMBOL(<ls_filter>).

    CASE to_upper( <ls_filter>-property ).

      WHEN 'KOSTL'.
        lr_kostl = CORRESPONDING #( <ls_filter>-select_options ).

      WHEN 'KOKRS'.
        lr_kokrs = CORRESPONDING #( <ls_filter>-select_options ).

      WHEN 'KTEXT'.
        lr_ktext = CORRESPONDING #( <ls_filter>-select_options ).

    ENDCASE.

  ENDLOOP.

  SELECT csks~kostl,
         csks~kokrs,
         cskt~ktext
    FROM csks AS csks
    LEFT OUTER JOIN cskt AS cskt
      ON cskt~kokrs  = csks~kokrs
     AND cskt~kostl  = csks~kostl
     AND cskt~spras  = @sy-langu
   WHERE csks~datbi >= @sy-datum
     AND csks~kostl IN @lr_kostl
     AND csks~kokrs IN @lr_kokrs
     AND cskt~ktext IN @lr_ktext
   ORDER BY csks~kostl
    INTO CORRESPONDING FIELDS OF TABLE @et_entityset
    UP TO @is_paging-top ROWS
    OFFSET @is_paging-skip.

ENDMETHOD.


METHOD checklistanalise_create_entity.

  DATA:
    ls_input    TYPE /ptloms/cl_soms_v2_mpc=>ts_checklistanalise,
    ls_result   TYPE /ptloms/et203,

    lv_rfcdest  TYPE bdbapidst,
    lv_msgv1    TYPE c LENGTH 50,
    lv_msgv2    TYPE c LENGTH 50,
    lv_subrc    TYPE sy-subrc,
    lv_mensagem TYPE bapi_msg.

  CLEAR:
    ls_input,
    ls_result.

  " 1. Lê dados enviados pelo SAPUI5
  io_data_provider->read_entry_data(
    IMPORTING
      es_data = ls_input ).

  " 2. Busca destino RFC configurado
  SELECT SINGLE rfcdest
    FROM /ptloms/tb036
    INTO lv_rfcdest.

  IF sy-subrc NE 0.
    MESSAGE e003(/ptloms/msg) INTO lv_mensagem.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message = lv_mensagem.
  ENDIF.

  " 3. Valida conexão RFC
  CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
    EXPORTING
      rfcdestination = lv_rfcdest
    IMPORTING
      msgv1          = lv_msgv1
      msgv2          = lv_msgv2
      rfc_subrc      = lv_subrc.

  IF lv_subrc NE 0.
    CONCATENATE 'Falha na conexão RFC:' lv_rfcdest
      INTO lv_mensagem
      SEPARATED BY space.

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message = lv_mensagem.
  ENDIF.

  " 4. Valida entrada mínima
  IF ls_input-json_dados IS INITIAL.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message = 'JSON de dados não informado.'.
  ENDIF.

  " 5. Chama função orquestradora
  CALL FUNCTION '/PTLOMS/MF155'
    DESTINATION lv_rfcdest
    EXPORTING
      iv_prompt_usuario     = ls_input-prompt_usuario
      iv_json_dados         = ls_input-json_dados
    IMPORTING
      rs_result             = ls_result
    EXCEPTIONS
      communication_failure = 1
      system_failure        = 2
      OTHERS                = 3.

  IF sy-subrc NE 0.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message = 'Erro na execução da RFC /PTLOMS/MF155.'.
  ENDIF.

  " 6. Mapeia retorno para entidade OData
  MOVE-CORRESPONDING ls_result TO ls_input.

  er_entity = ls_input.

ENDMETHOD.


METHOD checklistrespost_get_entityset.

  DATA: lt_dados         TYPE /ptloms/ct170,
        ls_dados         LIKE LINE OF lt_dados,
        ls_entity        LIKE LINE OF et_entityset,

        lv_rfcdest       TYPE bdbapidst,
        lv_msgv1(50)     TYPE c,
        lv_msgv2(50)     TYPE c,
        lv_subrc         TYPE sy-subrc,
        lv_mensagem      TYPE bapi_msg,

        lv_ordem         TYPE char12,
        lv_usuario       TYPE char12,
        lv_formulario    TYPE /ptloms/ed059,
        lv_erdat_ini     TYPE erdat,
        lv_erdat_fim     TYPE erdat,

        lv_erdat_char    TYPE char8,
        lv_aedat_char    TYPE char8,

        wa_filter        LIKE LINE OF it_filter_select_options,
        wa_select_option LIKE LINE OF wa_filter-select_options.

  CLEAR et_entityset.

  "====================================================================
  " 1. Busca destino RFC configurado
  "====================================================================
  SELECT SINGLE rfcdest
    FROM /ptloms/tb036
    INTO lv_rfcdest.

  IF sy-subrc NE 0.
    MESSAGE e003(/ptloms/msg) INTO lv_mensagem.

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message = lv_mensagem.
  ENDIF.

  "====================================================================
  " 2. Validação da conexão RFC
  "====================================================================
  CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
    EXPORTING
      rfcdestination = lv_rfcdest
    IMPORTING
      msgv1          = lv_msgv1
      msgv2          = lv_msgv2
      rfc_subrc      = lv_subrc.

  IF lv_subrc NE 0.
    CONCATENATE 'Falha na conexão RFC:' lv_rfcdest
      INTO lv_mensagem
      SEPARATED BY space.

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message = lv_mensagem.
  ENDIF.

  "====================================================================
  " 3. Captura de filtros OData
  "====================================================================
  LOOP AT it_filter_select_options INTO wa_filter.

    READ TABLE wa_filter-select_options INTO wa_select_option INDEX 1.

    IF sy-subrc = 0.

      CASE wa_filter-property.

        WHEN 'Ordem'.
          lv_ordem = wa_select_option-low.

        WHEN 'Usuario'.
          lv_usuario = wa_select_option-low.

        WHEN 'Formulario'.
          lv_formulario = wa_select_option-low.

        WHEN 'IvErdatIni'.
          lv_erdat_ini = wa_select_option-low.

        WHEN 'IvErdatFim'.
          lv_erdat_fim = wa_select_option-low.

      ENDCASE.

    ENDIF.

  ENDLOOP.

  "====================================================================
  " 4. Chamada RFC
  "====================================================================
  CALL FUNCTION '/PTLOMS/MF153' DESTINATION lv_rfcdest
    EXPORTING
      iv_ordem              = lv_ordem
      iv_usuario            = lv_usuario
      iv_formulario         = lv_formulario
      iv_erdat_ini          = lv_erdat_ini
      iv_erdat_fim          = lv_erdat_fim
    IMPORTING
      et_dados              = lt_dados
    EXCEPTIONS
      communication_failure = 1
      system_failure        = 2
      OTHERS                = 3.

  IF sy-subrc NE 0.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message = 'Erro na execução da RFC remota /PTLOMS/MF153'.
  ENDIF.

  "====================================================================
  " 5. Mapeamento para OData
  "====================================================================
  LOOP AT lt_dados INTO ls_dados.

    CLEAR: ls_entity,
           lv_erdat_char,
           lv_aedat_char.

    CONCATENATE ls_dados-guid_associacao
                ls_dados-sequencial
                ls_dados-ordem
                ls_dados-operacao
           INTO ls_entity-chave
      SEPARATED BY '-'.

    ls_entity-guid_associacao  = ls_dados-guid_associacao.
    ls_entity-sequencial       = ls_dados-sequencial.
    ls_entity-aplicacao        = ls_dados-aplicacao.
    ls_entity-descr_vinculo    = ls_dados-descr_vinculo.
    ls_entity-operacao         = ls_dados-operacao.
    ls_entity-ordem            = ls_dados-ordem.
    ls_entity-tp_vinculo       = ls_dados-tp_vinculo.
    ls_entity-usuario          = ls_dados-usuario.
    ls_entity-ordenacao1       = ls_dados-ordenacao1.
    ls_entity-ordenacao2       = ls_dados-ordenacao2.
    ls_entity-descr_grupo      = ls_dados-descr_grupo.
    ls_entity-descricao        = ls_dados-descricao.
    ls_entity-formulario       = ls_dados-formulario.
    ls_entity-grupo            = ls_dados-grupo.
    ls_entity-obrigatorio      = ls_dados-obrigatorio.
    ls_entity-opcao            = ls_dados-opcao.
    ls_entity-resposta         = ls_dados-resposta.
    ls_entity-resposta_logica  = ls_dados-resposta_logica.
    ls_entity-resposta_usuario = ls_dados-resposta_usuario.
    ls_entity-status           = ls_dados-status.
    ls_entity-inf_complementar = ls_dados-inf_complementar.
    ls_entity-ernam            = ls_dados-ernam.
    ls_entity-erzeit           = ls_dados-erzeit.
    ls_entity-aenam            = ls_dados-aenam.
    ls_entity-aezeit           = ls_dados-aezeit.

    "---------------------------------------------------------------
    " Proteção para campos Edm.DateTime
    " Gateway exige data interna DATS válida: YYYYMMDD
    " Se vier truncado, por exemplo 202605, não deve ser enviado.
    "---------------------------------------------------------------
    lv_erdat_char = ls_dados-erdat.

    IF lv_erdat_char IS NOT INITIAL
       AND lv_erdat_char NE '00000000'
       AND strlen( lv_erdat_char ) = 8.

      ls_entity-erdat = lv_erdat_char.

    ELSE.
      CLEAR ls_entity-erdat.
    ENDIF.

    lv_aedat_char = ls_dados-aedat.

    IF lv_aedat_char IS NOT INITIAL
       AND lv_aedat_char NE '00000000'
       AND strlen( lv_aedat_char ) = 8.

      ls_entity-aedat = lv_aedat_char.

    ELSE.
      CLEAR ls_entity-aedat.
    ENDIF.

    "Campos técnicos usados somente como filtro
    IF lv_erdat_ini IS NOT INITIAL
       AND lv_erdat_ini NE '00000000'.
      ls_entity-iv_erdat_ini = lv_erdat_ini.
    ELSE.
      CLEAR ls_entity-iv_erdat_ini.
    ENDIF.

    IF lv_erdat_fim IS NOT INITIAL
       AND lv_erdat_fim NE '00000000'.
      ls_entity-iv_erdat_fim = lv_erdat_fim.
    ELSE.
      CLEAR ls_entity-iv_erdat_fim.
    ENDIF.

    APPEND ls_entity TO et_entityset.

  ENDLOOP.

ENDMETHOD.


  METHOD dadosusertrackin_get_entityset.

    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap TYPE flag,
          lv_mensagem    TYPE bapi_msg,
          lt_retorno     TYPE /ptloms/ct156,
          wa_filter      TYPE /iwbep/s_mgw_select_option,
          wa_sel         TYPE /iwbep/s_cod_select_option.

    DATA: lt_ratreamento TYPE /ptloms/ct165,
          ls_ratreamento LIKE LINE OF lt_ratreamento,
          lv_usuario     TYPE /ptloms/et194-usuario,
          lv_data_ini    TYPE /ptloms/et194-data_ini,
          lv_data_fim    TYPE /ptloms/et194-data_fim.

    DATA: lt_dados_rastreamento TYPE STANDARD TABLE OF /ptloms/cl_soms_v2_mpc=>ts_dadosusertracking,
          ls_dados_rastreamento LIKE LINE OF lt_dados_rastreamento.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR   "Se usuário SAP, então SAME_USER deve estar marcado
       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

**(>>>>> Tratar filtros <<<<<)
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Usuario'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_usuario = wa_sel-low.
    ENDIF.

*    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataIni'.
*    IF sy-subrc = 0.
*      CLEAR wa_sel.
*      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
*      lv_data_ini = wa_sel-low+6(4) && wa_sel-low+3(2) && wa_sel-low(2).
*    ENDIF.
*
*    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataFim'.
*    IF sy-subrc = 0.
*      CLEAR wa_sel.
*      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
*      lv_data_fim = wa_sel-low+6(4) && wa_sel-low+3(2) && wa_sel-low(2).
*    ENDIF.

    CALL FUNCTION '/PTLOMS/MF146'
      DESTINATION lv_rfcdest
      EXPORTING
        i_usuario           = lv_usuario
*       i_data_ini          = lv_data_ini
*       i_data_fim          = lv_data_fim
      IMPORTING
        e_dados_rastrea_usr = lt_ratreamento
        e_retorno           = lt_retorno.

    CLEAR ls_ratreamento.
    LOOP AT lt_ratreamento INTO ls_ratreamento.
      CLEAR ls_dados_rastreamento.
      MOVE-CORRESPONDING ls_ratreamento TO ls_dados_rastreamento.
      APPEND ls_dados_rastreamento TO lt_dados_rastreamento.
    ENDLOOP.

    et_entityset = lt_dados_rastreamento.

  ENDMETHOD.


  METHOD despachocestoset_get_entityset.

    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_mensagem    TYPE bapi_msg,
          wa_filter      TYPE /iwbep/s_mgw_select_option,
          rt_aufnr       TYPE /iwbep/t_cod_select_options,
          rt_guid        TYPE /iwbep/t_cod_select_options,
          rt_uname       TYPE /iwbep/t_cod_select_options,
          rt_vornr       TYPE /iwbep/t_cod_select_options,
          rt_criadopor   TYPE /iwbep/t_cod_select_options,
          rt_datacriacao TYPE /iwbep/t_cod_select_options,
          rt_horacriacao TYPE /iwbep/t_cod_select_options,
          rt_alteradopor TYPE /iwbep/t_cod_select_options,
          rt_datadessac  TYPE /iwbep/t_cod_select_options,
          rt_horadessac  TYPE /iwbep/t_cod_select_options,
          rt_motivo      TYPE /iwbep/t_cod_select_options,
          lt_associacoes TYPE /PTLOMS/CT161.

*(>>>>> Valida Configuração RFC (Verifica se possui usuário fixo) <<<<<)
* Busca Conexão
    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'RFC_READ_R3_DESTINATION'
        EXPORTING
          destination             = lv_rfcdest
        IMPORTING
          same_user               = lv_same_user
        EXCEPTIONS
          authority_not_available = 1
          destination_not_exist   = 2
          information_failure     = 3
          internal_failure        = 4
          OTHERS                  = 5.
      IF sy-subrc <> 0.
        CASE sy-subrc.
          WHEN 1.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '006'
              INTO lv_mensagem.
          WHEN 2.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '007'
              INTO lv_mensagem.
          WHEN 3.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '008'
              INTO lv_mensagem.
          WHEN OTHERS.
        ENDCASE.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.

*(>>>>> Função para validar configuração RFC <<<<<)
      CALL FUNCTION '/PTLOMS/MF108'
        DESTINATION lv_rfcdest
        IMPORTING
          e_rfc              = lv_rfcdest
        EXCEPTIONS
          sem_aut_rfc        = 1
          rfc_nao_existente  = 2
          rfc_nao_cadastrada = 3
          rfc_incompativel   = 4
          OTHERS             = 5.
      IF sy-subrc <> 0.
        CASE sy-subrc.
          WHEN 1.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '009'
              INTO lv_mensagem.
          WHEN 2.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '010'
              INTO lv_mensagem.
          WHEN 3.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '011'
              INTO lv_mensagem.
          WHEN 4.
            MESSAGE ID '/PTLOMS/CM002' TYPE 'E' NUMBER '012'
              INTO lv_mensagem.
          WHEN OTHERS.
        ENDCASE.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.
    ENDIF.

*(>>>>> Tratar filtros <<<<<)
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Aufnr'.
    IF sy-subrc = 0.
      rt_aufnr = wa_filter-select_options.
    ENDIF.

    CLEAR wa_filter.
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Uname'.
    IF sy-subrc = 0.
      rt_uname = wa_filter-select_options.
    ENDIF.

    CLEAR wa_filter.
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Vornr'.
    IF sy-subrc = 0.
      rt_uname = wa_filter-select_options.
    ENDIF.

    CLEAR wa_filter.
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Guid'.
    IF sy-subrc = 0.
      rt_guid = wa_filter-select_options.
    ENDIF.

*(>>>>> Função para recuperar lista de associações <<<<<)
    CALL FUNCTION '/PTLOMS/MF119'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_guid        = rt_guid
        rt_aufnr       = rt_aufnr
        rt_uname       = rt_uname
        rt_vornr       = rt_vornr
        rt_criadopor   = rt_criadopor
        rt_datacriacao = rt_datacriacao
        rt_horacriacao = rt_horacriacao
        rt_alteradopor = rt_alteradopor
        rt_datadessac  = rt_datadessac
        rt_horadessac  = rt_horadessac
        rt_motivo      = rt_motivo
      IMPORTING
        it_associacoes = lt_associacoes.

    et_entityset = CORRESPONDING /ptloms/cl_soms_v2_mpc=>tt_despachocesto( lt_associacoes ).


  ENDMETHOD.


  METHOD detalheoperacaos_get_entityset.

    DATA: ls_detalhe     TYPE /ptloms/et147,
          lv_usuario     TYPE xubname,
          lv_rfcdest     TYPE bdbapidst,
          lv_usuario_sap TYPE flag,
          lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          v_aufnr        TYPE aufnr,
          v_vornr        TYPE vornr,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: rt_usuarioapp TYPE /iwbep/t_cod_select_options,
          rt_aufnr      TYPE /iwbep/t_cod_select_options,
          rt_vornr      TYPE /iwbep/t_cod_select_options,
          wa_filter     TYPE /iwbep/s_mgw_select_option,
          wa_sel        TYPE /iwbep/s_cod_select_option,
          ls_usuarioapp LIKE LINE OF rt_usuarioapp.

* Busca Conexão
    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
    IF sy-subrc EQ 0.
*Verifica se conexão está ativa
      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
        EXPORTING
          rfcdestination = lv_rfcdest
        IMPORTING
          msgv1          = lv_msgv1
          msgv2          = lv_msgv2
          rfc_subrc      = lv_subrc.

      IF lv_subrc NE 0.
        IF lv_subrc = 3.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
        ENDIF.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.
    ELSE.
      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL )  "Se usuário SAP, então SAME_USER deve estar marcado
    OR ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.

    ENDIF.

*(>>>>> Tratar filtros <<<<<)
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Aufnr'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      v_aufnr = wa_sel-low.
    ENDIF.

    CLEAR wa_filter.
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Vornr'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      v_vornr = wa_sel-low.
    ENDIF.

    CALL FUNCTION '/PTLOMS/MF116'
      DESTINATION lv_rfcdest
      EXPORTING
        i_aufnr   = v_aufnr
        i_vornr   = v_vornr
      IMPORTING
        e_detalhe = ls_detalhe.

    APPEND ls_detalhe TO et_entityset.

  ENDMETHOD.


  METHOD historicoassinat_get_entityset.

    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap TYPE flag,
          lv_mensagem    TYPE bapi_msg,
          lt_retorno     TYPE /ptloms/ct156,
          wa_filter      TYPE /iwbep/s_mgw_select_option,
          wa_sel         TYPE /iwbep/s_cod_select_option.

    DATA: lt_assinaturas TYPE /ptloms/ct159,
          ls_assinatura  LIKE LINE OF lt_assinaturas,
          lv_usuario     TYPE /ptloms/et184-usuario_app,
          lv_operacao    TYPE /ptloms/et184-activity,
          lv_ordem       TYPE /ptloms/et184-orderid,
          lv_data_ini    TYPE /ptloms/et184-data_criacao_app,
          lv_data_fim    TYPE /ptloms/et184-data_criacao_app.

    DATA: lt_historico_assinaturas TYPE STANDARD TABLE OF /ptloms/cl_soms_v2_mpc=>ts_historicoassinaturas,
          ls_historico_assinaturas LIKE LINE OF lt_historico_assinaturas.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR   "Se usuário SAP, então SAME_USER deve estar marcado
       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

*(>>>>> Tratar filtros <<<<<)
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'UsuarioApp'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_usuario = wa_sel-low.
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Activity'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_operacao = wa_sel-low.
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Orderid'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_ordem = wa_sel-low.
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataIni'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_data_ini = wa_sel-low+6(4) && wa_sel-low+3(2) && wa_sel-low(2).
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataFim'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_data_fim = wa_sel-low+6(4) && wa_sel-low+3(2) && wa_sel-low(2).
    ENDIF.

    CALL FUNCTION '/PTLOMS/MF139'
      DESTINATION lv_rfcdest
      EXPORTING
        i_usuario              = lv_usuario
        i_operacao             = lv_operacao
        i_ordem                = lv_ordem
        i_data_ini             = lv_data_ini
        i_data_fim             = lv_data_fim
      IMPORTING
        e_historico_assinatura = lt_assinaturas
        e_retorno              = lt_retorno.

    CLEAR ls_assinatura.
    LOOP AT lt_assinaturas INTO ls_assinatura.
      CLEAR ls_historico_assinaturas.
      MOVE-CORRESPONDING ls_assinatura TO ls_historico_assinaturas.
      APPEND ls_historico_assinaturas TO lt_historico_assinaturas.
    ENDLOOP.

    et_entityset = lt_historico_assinaturas.

  ENDMETHOD.


  METHOD historicoatendim_get_entityset.

    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap TYPE flag,
          lv_mensagem    TYPE bapi_msg.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR   "Se usuário SAP, então SAME_USER deve estar marcado
       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

* Declarações especificas do serviço
    DATA: rt_aufnr_filter TYPE /iwbep/t_cod_select_options,
          rt_data_criacao TYPE /iwbep/t_cod_select_options,
          lt_historico    TYPE /ptloms/cl_soms_v2_mpc=>tt_historicoatendimento,
          lt_historico_in TYPE /ptloms/ct162,
          ls_filter       TYPE /iwbep/s_mgw_select_option,
          lv_aufnr        TYPE /ptloms/et188-aufnr.

    " Carrega filtros
    IF it_filter_select_options[] IS NOT INITIAL.

      CLEAR ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'Aufnr'.
      IF sy-subrc = 0.
        LOOP AT ls_filter-select_options ASSIGNING FIELD-SYMBOL(<aufnr>).
          clear lv_aufnr.
          IF <aufnr>-low IS NOT INITIAL.
            lv_aufnr = <aufnr>-low.
            <aufnr>-low = |{ lv_aufnr ALPHA = IN }|.
          ENDIF.
          IF <aufnr>-high IS NOT INITIAL.
            lv_aufnr = <aufnr>-high.
            <aufnr>-high = |{ <aufnr>-high ALPHA = IN }|.
          ENDIF.
        ENDLOOP.
        rt_aufnr_filter = ls_filter-select_options.
      ENDIF.

      CLEAR ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'Datacriacao'.
      IF sy-subrc = 0.
        rt_data_criacao = ls_filter-select_options.
      ENDIF.

    ENDIF.

    CALL FUNCTION '/PTLOMS/MF148'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_aufnr        = rt_aufnr_filter
        rt_data_criacao = rt_data_criacao
      IMPORTING
        et_historico    = lt_historico_in.

    LOOP AT lt_historico_in ASSIGNING FIELD-SYMBOL(<historico>).
      APPEND INITIAL LINE TO et_entityset ASSIGNING FIELD-SYMBOL(<entidade>).
      MOVE-CORRESPONDING <historico> TO <entidade>.
    ENDLOOP.

  ENDMETHOD.


  METHOD historicousertra_get_entityset.

    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap TYPE flag,
          lv_mensagem    TYPE bapi_msg,
          lt_retorno     TYPE /ptloms/ct156,
          wa_filter      TYPE /iwbep/s_mgw_select_option,
          wa_sel         TYPE /iwbep/s_cod_select_option.

    DATA: lt_trackings TYPE /ptloms/ct164,
          ls_tracking  LIKE LINE OF lt_trackings,
          lv_usuario   TYPE /ptloms/et192-usuario,
          lv_matricula TYPE /ptloms/et192-matricula,
          lv_guid      TYPE /ptloms/et192-guid,
          lv_perfil    TYPE /ptloms/et192-perfil,
          lv_data_ini  TYPE /ptloms/et192-data_ini,
          lv_data_fim  TYPE /ptloms/et192-data_fim.

    DATA: lt_historico_trackings TYPE STANDARD TABLE OF /ptloms/cl_soms_v2_mpc=>ts_historicousertracking,
          ls_historico_trackings LIKE LINE OF lt_historico_trackings.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR   "Se usuário SAP, então SAME_USER deve estar marcado
       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

**(>>>>> Tratar filtros <<<<<)
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Usuario'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_usuario = wa_sel-low.
    ENDIF.
*
*    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Matricula'.
*    IF sy-subrc = 0.
*      CLEAR wa_sel.
*      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
*      lv_matricula = wa_sel-low.
*    ENDIF.
*
*    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Guid'.
*    IF sy-subrc = 0.
*      CLEAR wa_sel.
*      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
*      lv_guid = wa_sel-low.
*    ENDIF.
*
*    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Perfil'.
*    IF sy-subrc = 0.
*      CLEAR wa_sel.
*      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
*      lv_perfil = wa_sel-low.
*    ENDIF.
*
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataIni'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_data_ini = wa_sel-low+6(4) && wa_sel-low+3(2) && wa_sel-low(2).
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataFim'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      lv_data_fim = wa_sel-low+6(4) && wa_sel-low+3(2) && wa_sel-low(2).
    ENDIF.

    CALL FUNCTION '/PTLOMS/MF144'
      DESTINATION lv_rfcdest
      EXPORTING
        i_usuario               = lv_usuario
*       i_matricula             = lv_matricula
*       i_guid                  = lv_guid
*       i_perfil                = lv_perfil
        i_data_ini              = lv_data_ini
        i_data_fim              = lv_data_fim
      IMPORTING
        e_historico_rastrea_usr = lt_trackings
        e_retorno               = lt_retorno.

    CLEAR ls_tracking.
    LOOP AT lt_trackings INTO ls_tracking.
      CLEAR ls_historico_trackings.
      MOVE-CORRESPONDING ls_tracking TO ls_historico_trackings.
      APPEND ls_historico_trackings TO lt_historico_trackings.
    ENDLOOP.

    et_entityset = lt_historico_trackings.

  ENDMETHOD.


  METHOD listachecklist03_get_entityset.

    DATA: lt_retorno     TYPE  /ptloms/ct156,
          lt_respostas   TYPE  /ptloms/ct089,
          ls_respostas   TYPE  /ptloms/et092,
          lv_usuario     TYPE xubname,
          lv_rfcdest     TYPE bdbapidst,
          lv_usuario_sap TYPE flag,
          lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          v_codigo,
          v_usuario      TYPE /ptloms/et092-usuario,
          v_operacao     TYPE /ptloms/et092-operacao,
          v_ordem        TYPE /ptloms/et092-ordem,
          v_data_ini     TYPE /ptloms/et092-data_ini,
          v_data_fim     TYPE /ptloms/et092-data_fim,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: rt_usuarioapp TYPE /iwbep/t_cod_select_options,
          wa_filter     TYPE /iwbep/s_mgw_select_option,
          wa_sel        TYPE /iwbep/s_cod_select_option,
          ls_usuarioapp LIKE LINE OF rt_usuarioapp.

* Busca Conexão
    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
    IF sy-subrc EQ 0.
*Verifica se conexão está ativa
      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
        EXPORTING
          rfcdestination = lv_rfcdest
        IMPORTING
          msgv1          = lv_msgv1
          msgv2          = lv_msgv2
          rfc_subrc      = lv_subrc.

      IF lv_subrc NE 0.
        IF lv_subrc = 3.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
        ENDIF.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.
    ELSE.
      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL )  "Se usuário SAP, então SAME_USER deve estar marcado
    OR ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.

    ENDIF.

*(>>>>> Tratar filtros <<<<<)
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Usuario'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      v_usuario = wa_sel-low.
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Operacao'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      v_operacao = wa_sel-low.
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Ordem'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      v_ordem = wa_sel-low.
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataIni'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      v_data_ini = wa_sel-low+6(4) && wa_sel-low+3(2) && wa_sel-low(2).
    ENDIF.

    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'DataFim'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      v_data_fim = wa_sel-low+6(4) && wa_sel-low+3(2) && wa_sel-low(2).
    ENDIF.

    CALL FUNCTION '/PTLOMS/MF138'
      DESTINATION lv_rfcdest
      EXPORTING
        i_usuario   = v_usuario
        i_operacao  = v_operacao
        i_ordem     = v_ordem
        i_data_ini  = v_data_ini
        i_data_fim  = v_data_fim
      IMPORTING
        e_respostas = lt_respostas
        e_retorno   = lt_retorno.

    LOOP AT lt_respostas INTO ls_respostas.
      APPEND ls_respostas TO et_entityset.
    ENDLOOP.

  ENDMETHOD.


  METHOD listausuarioset_get_entityset.

* Variáveis para criação da sessão
    DATA: lv_senha          TYPE char32,
          lv_confsenha      TYPE char32,
          lv_usuario        TYPE xubname,
          lv_autenticado    TYPE char1,
          lv_sessao_criada  TYPE char1,
          lv_guid           TYPE char32,
          lv_senha_alterada TYPE char1,
          lv_usuario_sap    TYPE flag,
          lv_same_user      TYPE rfcdisplay-rfcsameusr.

* Variável para retornar texto de exceção
    DATA: lv_mensagem TYPE bapi_msg.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc.

    DATA: lv_rfcdest TYPE bdbapidst,
          lt_filtro  TYPE /ptloms/ct122.

    DATA: t_dados_usuario TYPE STANDARD TABLE OF /ptloms/cl_soms_v2_mpc=>ts_listausuario.

    DATA: lt_dados_usuario_app TYPE /ptloms/ct122.

    DATA: ls_usuario_app   TYPE /iwbep/s_cod_select_option,
          ls_dados_usuario LIKE LINE OF t_dados_usuario.

* Busca Conexão
    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
    IF sy-subrc EQ 0.
*Verifica se conexão está ativa
      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
        EXPORTING
          rfcdestination = lv_rfcdest
        IMPORTING
          msgv1          = lv_msgv1
          msgv2          = lv_msgv2
          rfc_subrc      = lv_subrc.
      IF lv_subrc NE 0.
        IF lv_subrc = 3.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
        ENDIF.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.
    ELSE.
      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR "Se usuário SAP, então SAME_USER deve estar marcado
       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

* Cria Sessão para usuário
    READ TABLE it_filter_select_options INTO DATA(ls_usuarioapp) WITH KEY property = 'Usuario'.
    IF sy-subrc = 0.
      DATA(rt_usuarioapp) = ls_usuarioapp-select_options.
    ENDIF.
    READ TABLE rt_usuarioapp INTO DATA(ls_usuarioapp_aux) INDEX 1.

    READ TABLE it_filter_select_options INTO DATA(ls_senha) WITH KEY property = 'Senha'.
    IF sy-subrc = 0.
      DATA(rt_senha) = ls_senha-select_options.
    ENDIF.
    READ TABLE rt_senha INTO DATA(ls_senha_aux) INDEX 1.

    READ TABLE it_filter_select_options INTO DATA(ls_confsenha) WITH KEY property = 'ConfSenha'.
    IF sy-subrc = 0.
      DATA(rt_confsenha) = ls_confsenha-select_options.
    ENDIF.
    READ TABLE rt_confsenha INTO DATA(ls_confsenha_aux) INDEX 1.

* Define Usuário
    IF ls_usuarioapp_aux-low IS NOT INITIAL.
      lv_usuario = ls_usuarioapp_aux-low.
      TRANSLATE lv_usuario TO UPPER CASE.
    ELSE.
      lv_usuario = sy-uname.
    ENDIF.

    CALL FUNCTION '/PTLOMS/MF044'
      DESTINATION lv_rfcdest
      EXPORTING
        im_usuario = lv_usuario
      IMPORTING
        ex_usuario = lv_usuario.

    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    CALL FUNCTION '/PTLOMS/MF034'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_usuario_app       = rt_usuarioapp
      IMPORTING
        it_dados_usuario_app = lt_dados_usuario_app.

    LOOP AT lt_dados_usuario_app INTO DATA(ls_dados_usuario_app).
      MOVE-CORRESPONDING ls_dados_usuario_app TO ls_dados_usuario.
      APPEND ls_dados_usuario TO t_dados_usuario.
    ENDLOOP.

    et_entityset = CORRESPONDING /ptloms/cl_soms_v2_mpc=>tt_listausuario( t_dados_usuario ).

  ENDMETHOD.


  method MOTIVODESASSOCIA_GET_ENTITYSET.

    DATA: ls_motivo      TYPE /ptloms/et117,
          lt_motivo      TYPE /ptloms/ct086,
          lv_usuario     TYPE xubname,
          lv_rfcdest     TYPE bdbapidst,
          lv_usuario_sap TYPE flag,
          lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          v_codigo       TYPE /ptloms/et117-codigo,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: rt_usuarioapp TYPE /iwbep/t_cod_select_options,
          wa_filter     TYPE /iwbep/s_mgw_select_option,
          wa_sel        TYPE /iwbep/s_cod_select_option,
          ls_usuarioapp LIKE LINE OF rt_usuarioapp.

* Busca Conexão
    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
    IF sy-subrc EQ 0.
*Verifica se conexão está ativa
      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
        EXPORTING
          rfcdestination = lv_rfcdest
        IMPORTING
          msgv1          = lv_msgv1
          msgv2          = lv_msgv2
          rfc_subrc      = lv_subrc.

      IF lv_subrc NE 0.
        IF lv_subrc = 3.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
        ENDIF.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.
    ELSE.
      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL )  "Se usuário SAP, então SAME_USER deve estar marcado
    OR ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.

    ENDIF.

*(>>>>> Tratar filtros <<<<<)
    READ TABLE it_filter_select_options INTO wa_filter WITH KEY property = 'Codigo'.
    IF sy-subrc = 0.
      CLEAR wa_sel.
      READ TABLE wa_filter-select_options INTO wa_sel INDEX 1.
      v_codigo = wa_sel-low.
    ENDIF.

    CALL FUNCTION '/PTLOMS/MF120'
      DESTINATION lv_rfcdest
      EXPORTING
        i_codigo = v_codigo
      IMPORTING
        e_motivo = lt_motivo.

    LOOP AT lt_motivo INTO ls_motivo.

      APPEND ls_motivo  TO et_entityset.

    ENDLOOP.

  endmethod.


METHOD notaordemcliente_get_entityset.
*"----------------------------------------------------------------------
*" Interface local do SAP Gateway (Herdada automaticamente)
*"----------------------------------------------------------------------

  " --- TABELAS E VARIÁVEIS LOCAIS ---
  DATA: lt_dados         TYPE /ptloms/ct167, " Tipo retornado pela função
        wa_dados         LIKE LINE OF lt_dados,
        wa_entity        LIKE LINE OF et_entityset,

        " Tipagem dinâmica baseada diretamente na assinatura do OData
        wa_filter        LIKE LINE OF it_filter_select_options,
        wa_select_option LIKE LINE OF wa_filter-select_options,

        " Variáveis para capturar os filtros do Frontend
        lv_name          TYPE string,
        lv_cnpj          TYPE string,
        lv_cpf           TYPE string,
        lv_kunnr         TYPE string,
        lv_status        TYPE string,
        lv_rfcdest       TYPE bdbapidst,
        lv_same_user     TYPE rfcdisplay-rfcsameusr,
        lv_mensagem      TYPE bapi_msg,
        lv_msgv1(50)     TYPE c,
        lv_msgv2(50)     TYPE c,
        lv_subrc         TYPE sy-subrc,

        " Flag dinâmico para otimizar busca de dados pesados de endereço
        lv_dados_end     TYPE char1.

  CLEAR et_entityset.

  " =====================================================================
  " CONFIGURAÇÃO E VALIDAÇÃO DA CONEXÃO RFC (ECC/S4 BACKEND)
  " =====================================================================
  SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
  IF sy-subrc EQ 0.
    " Verifica se conexão está ativa
    CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
      EXPORTING
        rfcdestination = lv_rfcdest
      IMPORTING
        msgv1          = lv_msgv1
        msgv2          = lv_msgv2
        rfc_subrc      = lv_subrc.
    IF lv_subrc NE 0.
      IF lv_subrc = 3.
        CONCATENATE 'Usuário Sem Autorização para RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
      ELSE.
        CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
      ENDIF.

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.
  ELSE.
    lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid  = /iwbep/cx_mgw_busi_exception=>business_error
        message = lv_mensagem.
  ENDIF.

  " Valida Configuração RFC (Verifica se possui usuário fixo)
  CALL FUNCTION 'RFC_READ_R3_DESTINATION'
    EXPORTING
      destination             = lv_rfcdest
    IMPORTING
      same_user               = lv_same_user
    EXCEPTIONS
      authority_not_available = 1
      destination_not_exist   = 2
      information_failure     = 3
      internal_failure        = 4
      OTHERS                  = 5.

  " =====================================================================
  " STEP 1: CAPTURA DINÂMICA DOS FILTROS (OData Query Options)
  " =====================================================================
  LOOP AT it_filter_select_options INTO wa_filter.

    READ TABLE wa_filter-select_options INTO wa_select_option INDEX 1.
    IF sy-subrc = 0.
      CASE wa_filter-property.
        WHEN 'Name1' OR 'Name2'.
          lv_name   = wa_select_option-low.
        WHEN 'Cnpj'.
          lv_cnpj   = wa_select_option-low.
        WHEN 'Cpf'.
          lv_cpf    = wa_select_option-low.
        WHEN 'Kunnr'.
          lv_kunnr  = wa_select_option-low.
        WHEN 'StatusRel'.
          lv_status = wa_select_option-low.
      ENDCASE.
    ENDIF.

  ENDLOOP.

  " =====================================================================
  " STEP 1.1: LEITURA INTELIGENTE (Otimização de Performance)
  " =====================================================================
  IF io_tech_request_context IS BOUND.
    " Ajustado para usar o método GET_SELECT existente na sua classe
    DATA(lt_select) = io_tech_request_context->get_select( ).
    lv_dados_end = 'X'.
  ELSE.
    lv_dados_end = 'X'. " Fallback de segurança
  ENDIF.

  " =====================================================================
  " STEP 2: EXECUÇÃO DA FUNÇÃO ORQUESTRADORA NO DESTINO RFC
  " =====================================================================
  CALL FUNCTION '/PTLOMS/MF149' DESTINATION lv_rfcdest
    EXPORTING
      iv_name           = lv_name
      iv_cnpj           = lv_cnpj
      iv_cpf            = lv_cpf
      iv_kunnr          = lv_kunnr
      iv_status         = lv_status
      iv_dados_endereco = lv_dados_end
    IMPORTING
      et_dados          = lt_dados.

  " =====================================================================
  " STEP 3: MAPEAMENTO EXPLICITO PARA AS PROPRIEDADES DO GATEWAY
  " =====================================================================
  LOOP AT lt_dados INTO wa_dados.
    CLEAR wa_entity.

    " Propriedades Simples e Chave
    wa_entity-tipo           = wa_dados-tipo.
    wa_entity-documento      = wa_dados-documento.
    wa_entity-auart_qmart    = wa_dados-auart_qmart.
    wa_entity-ktext          = wa_dados-ktext.
    wa_entity-erdat          = wa_dados-erdat.

    " Ativos e Localização
    wa_entity-equnr          = wa_dados-equnr.
    wa_entity-eqktx          = wa_dados-eqktx.
    wa_entity-tplnr          = wa_dados-tplnr.
    wa_entity-pltxt          = wa_dados-pltxt.
    wa_entity-aufnr_rel      = wa_dados-aufnr_rel.

    " Novo mapeamento do código do Inventário Técnico do Ativo
    wa_entity-invnr     = wa_dados-invnr.

    " Status Inteligentes
    wa_entity-status_rel     = wa_dados-status_rel.
    wa_entity-status_sistema = wa_dados-status_sistema.

    " Ficha Cadastral do Cliente acoplada
    wa_entity-kunnr          = wa_dados-kunnr.
    wa_entity-cnpj           = wa_dados-cnpj.
    wa_entity-cpf            = wa_dados-cpf.
    wa_entity-name1          = wa_dados-name1.
    wa_entity-name2          = wa_dados-name2.

    " Novos mapeamentos de localização física e contato direto
    wa_entity-endereco_completo = wa_dados-endereco_completo.
    wa_entity-telefones         = wa_dados-telefones.
    wa_entity-email             = wa_dados-email.

    " Montagem da Chave Única Combinada (Indispensável para o OData e tabelas SAPUI5)
    CONCATENATE wa_dados-tipo '-' wa_dados-documento INTO wa_entity-chave.

    APPEND wa_entity TO et_entityset.
  ENDLOOP.

ENDMETHOD.


METHOD notaordemequipam_get_entityset.

  DATA: lt_dados         TYPE /ptloms/ct167,
        wa_dados         LIKE LINE OF lt_dados,
        wa_entity        LIKE LINE OF et_entityset,

        wa_filter        LIKE LINE OF it_filter_select_options,
        wa_select_option LIKE LINE OF wa_filter-select_options,

        lv_equnr         TYPE char18,
        lv_eqktx         TYPE char40,
        lv_invnr         TYPE char25,
        lv_tplnr         TYPE char30,
        lv_pltxt         TYPE char40,
        lv_status        TYPE string,

        lv_rfcdest       TYPE bdbapidst,
        lv_same_user     TYPE rfcdisplay-rfcsameusr,
        lv_mensagem      TYPE bapi_msg,
        lv_msgv1(50)     TYPE c,
        lv_msgv2(50)     TYPE c,
        lv_subrc         TYPE sy-subrc.

  CLEAR et_entityset.

  "====================================================================
  " Validação da conexão RFC
  "====================================================================
  SELECT SINGLE rfcdest
    FROM /ptloms/tb036
    INTO lv_rfcdest.

  IF sy-subrc EQ 0.

    CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
      EXPORTING
        rfcdestination = lv_rfcdest
      IMPORTING
        msgv1          = lv_msgv1
        msgv2          = lv_msgv2
        rfc_subrc      = lv_subrc.

    IF lv_subrc NE 0.

      IF lv_subrc = 3.
        CONCATENATE 'Usuário Sem Autorização para RFC'(001)
                    lv_rfcdest
               INTO lv_mensagem
          SEPARATED BY space.
      ELSE.
        CONCATENATE 'RFC'
                    lv_rfcdest
                    'não existe ou indisponível'(002)
               INTO lv_mensagem
          SEPARATED BY space.
      ENDIF.

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.

    ENDIF.

  ELSE.

    lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid  = /iwbep/cx_mgw_busi_exception=>business_error
        message = lv_mensagem.

  ENDIF.

  CALL FUNCTION 'RFC_READ_R3_DESTINATION'
    EXPORTING
      destination             = lv_rfcdest
    IMPORTING
      same_user               = lv_same_user
    EXCEPTIONS
      authority_not_available = 1
      destination_not_exist   = 2
      information_failure     = 3
      internal_failure        = 4
      OTHERS                  = 5.

  "====================================================================
  " Captura dos filtros OData
  "====================================================================
  LOOP AT it_filter_select_options INTO wa_filter.

    READ TABLE wa_filter-select_options INTO wa_select_option INDEX 1.

    IF sy-subrc = 0.

      CASE wa_filter-property.

        WHEN 'Equnr'.
          lv_equnr = wa_select_option-low.

        WHEN 'Eqktx'.
          lv_eqktx = wa_select_option-low.

        WHEN 'Invnr'.
          lv_invnr = wa_select_option-low.

        WHEN 'Tplnr'.
          lv_tplnr = wa_select_option-low.

        WHEN 'Pltxt'.
          lv_pltxt = wa_select_option-low.

        WHEN 'StatusRel'.
          lv_status = wa_select_option-low.

      ENDCASE.

    ENDIF.

  ENDLOOP.

  "====================================================================
  " Execução RFC no backend
  "====================================================================
  CALL FUNCTION '/PTLOMS/MF152' DESTINATION lv_rfcdest
    EXPORTING
      iv_equnr  = lv_equnr
      iv_eqktx  = lv_eqktx
      iv_invnr  = lv_invnr
      iv_tplnr  = lv_tplnr
      iv_pltxt  = lv_pltxt
      iv_status = lv_status
    IMPORTING
      et_dados  = lt_dados.

  "====================================================================
  " Mapeamento para EntitySet NotaOrdemEquipamentoLocal
  "====================================================================
  LOOP AT lt_dados INTO wa_dados.

    CLEAR wa_entity.

    wa_entity-tipo              = wa_dados-tipo.
    wa_entity-documento         = wa_dados-documento.
    wa_entity-auart_qmart       = wa_dados-auart_qmart.
    wa_entity-ktext             = wa_dados-ktext.
    wa_entity-erdat             = wa_dados-erdat.

    wa_entity-equnr             = wa_dados-equnr.
    wa_entity-eqktx             = wa_dados-eqktx.
    wa_entity-invnr             = wa_dados-invnr.
    wa_entity-tplnr             = wa_dados-tplnr.
    wa_entity-pltxt             = wa_dados-pltxt.
    wa_entity-aufnr_rel         = wa_dados-aufnr_rel.

    wa_entity-status_rel        = wa_dados-status_rel.
    wa_entity-status_sistema    = wa_dados-status_sistema.

    wa_entity-kunnr             = wa_dados-kunnr.
    wa_entity-cnpj              = wa_dados-cnpj.
    wa_entity-cpf               = wa_dados-cpf.
    wa_entity-name1             = wa_dados-name1.
    wa_entity-name2             = wa_dados-name2.

    wa_entity-endereco_completo = wa_dados-endereco_completo.
    wa_entity-telefones         = wa_dados-telefones.
    wa_entity-email             = wa_dados-email.

    CONCATENATE wa_dados-tipo
                '-'
                wa_dados-documento
           INTO wa_entity-chave.

    APPEND wa_entity TO et_entityset.

  ENDLOOP.

ENDMETHOD.


  METHOD operacaosimplifi_get_entityset.

    DATA: lv_rfcdest              TYPE bdbapidst,
          lv_subrc                TYPE sy-subrc,
          lv_mensagem             TYPE bapi_msg,
          lv_same_user            TYPE rfcdisplay-rfcsameusr,
          lv_quantidade_registros TYPE int4,
          lt_despacho             TYPE /ptloms/ct119,
          lt_filtro               TYPE /ptloms/ct103,
          lv_usuario_sap          TYPE flag.

    DATA:
      t_opersimplificada TYPE STANDARD TABLE OF /ptloms/cl_soms_v2_mpc=>ts_operacaosimplificada,
      s_opersimplificada LIKE LINE OF t_opersimplificada.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR "Se usuário SAP, então SAME_USER deve estar marcado
       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

    " Carrega filtros
    IF it_filter_select_options[] IS NOT INITIAL.
      READ TABLE it_filter_select_options INTO DATA(ls_werks_filter) WITH KEY property = 'Werks'.
      IF sy-subrc = 0.
        DATA(rt_werks_filter) = ls_werks_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_aufnr_filter) WITH KEY property = 'Aufnr'.
      IF sy-subrc = 0.
        DATA(rt_aufnr_filter) = ls_aufnr_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_vornr_filter) WITH KEY property = 'Vornr'.
      IF sy-subrc = 0.
        DATA(rt_vornr_filter) = ls_vornr_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_auart_filter) WITH KEY property = 'Auart'.
      IF sy-subrc = 0.
        DATA(rt_auart_filter) = ls_auart_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_qmnum_filter) WITH KEY property = 'Qmnum'.
      IF sy-subrc = 0.
        DATA(rt_qmnum_filter) = ls_qmnum_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_priok_filter) WITH KEY property = 'Priok'.
      IF sy-subrc = 0.
        DATA(rt_priok_filter) = ls_priok_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_tplnr_filter) WITH KEY property = 'Tplnr'.
      IF sy-subrc = 0.
        DATA(rt_tplnr_filter) = ls_tplnr_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_equnr_filter) WITH KEY property = 'Equnr'.
      IF sy-subrc = 0.
        DATA(rt_equnr_filter) = ls_equnr_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_kostlequnr_filter) WITH KEY property = 'KostlEqunr'.
      IF sy-subrc = 0.
        DATA(rt_kostlequnr_filter) = ls_kostlequnr_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_kostlfuncl_filter) WITH KEY property = 'KostlFuncl'.
      IF sy-subrc = 0.
        DATA(rt_kostlfuncl_filter) = ls_kostlfuncl_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_iwerk_filter) WITH KEY property = 'Iwerk'.
      IF sy-subrc = 0.
        DATA(rt_iwerk_filter) = ls_iwerk_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_usuapp_filter) WITH KEY property = 'Usuario'.
      IF sy-subrc = 0.
        DATA(rt_usuapp_filter) = ls_usuapp_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_ingpr_filter) WITH KEY property = 'Ingpr'.
      IF sy-subrc = 0.
        DATA(rt_ingpr_filter) = ls_ingpr_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_ilart_filter) WITH KEY property = 'Ilart'.
      IF sy-subrc = 0.
        DATA(rt_ilart_filter) = ls_ilart_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_gewrk_filter) WITH KEY property = 'Gewrk'.
      IF sy-subrc = 0.
        DATA(rt_gewrk_filter) = ls_gewrk_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_gstrp_ini_filter) WITH KEY property = 'GstrpIni'.
      IF sy-subrc = 0.
        DATA(rt_gstrp_ini_filter) = ls_gstrp_ini_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_gstrp_fim_filter) WITH KEY property = 'GstrpFim'.
      IF sy-subrc = 0.
        DATA(rt_gstrp_fim_filter) = ls_gstrp_fim_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_datope_ini_filter) WITH KEY property = 'Datopeini'.
      IF sy-subrc = 0.
        DATA(rt_datope_ini_filter) = ls_datope_ini_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_datope_fim_filter) WITH KEY property = 'Datopefim'.
      IF sy-subrc = 0.
        DATA(rt_datope_fim_filter) = ls_datope_fim_filter-select_options.
      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_vlsch_filter) WITH KEY property = 'Vlsch'.
      IF sy-subrc = 0.
        DATA(rt_vlsch_filter) = ls_vlsch_filter-select_options.
      ENDIF.

    ENDIF.

    IF  rt_gstrp_ini_filter       IS NOT INITIAL
    AND rt_gstrp_fim_filter       IS NOT INITIAL.
      FIELD-SYMBOLS <fs_dti>    LIKE LINE OF rt_gstrp_ini_filter.
      READ TABLE rt_gstrp_ini_filter ASSIGNING <fs_dti> INDEX 1.
      FIELD-SYMBOLS <fs_dtf>    LIKE LINE OF rt_gstrp_fim_filter.
      READ TABLE rt_gstrp_fim_filter ASSIGNING <fs_dtf> INDEX 1.
      <fs_dti>-option    = 'BT'.
      <fs_dti>-high      = <fs_dtf>-low.
      REFRESH rt_gstrp_fim_filter.
    ENDIF.

    IF  rt_datope_ini_filter       IS NOT INITIAL
    AND rt_datope_fim_filter       IS NOT INITIAL.
      READ TABLE rt_datope_ini_filter ASSIGNING <fs_dti> INDEX 1.
      READ TABLE rt_datope_fim_filter ASSIGNING <fs_dtf> INDEX 1.
      <fs_dti>-option    = 'BT'.
      <fs_dti>-high      = <fs_dtf>-low.
      REFRESH rt_datope_fim_filter.
    ENDIF.

    CLEAR lv_quantidade_registros.

    CALL FUNCTION '/PTLOMS/MF114'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_werks      = rt_werks_filter
        rt_aufnr      = rt_aufnr_filter
        rt_vornr      = rt_vornr_filter
        rt_usuapp     = rt_usuapp_filter
        rt_auart      = rt_auart_filter
        rt_qmnum      = rt_qmnum_filter
        rt_priok      = rt_priok_filter
        rt_tplnr      = rt_tplnr_filter
        rt_equnr      = rt_equnr_filter
        rt_iwerk      = rt_iwerk_filter
        rt_ingpr      = rt_ingpr_filter
        rt_ilart      = rt_ilart_filter
        rt_gewrk      = rt_gewrk_filter
        rt_gstrp_ini  = rt_gstrp_ini_filter
        rt_datope_ini = rt_datope_ini_filter
        rt_gstrp_fim  = rt_gstrp_fim_filter
        rt_datope_fim = rt_datope_fim_filter
        rt_vlsch      = rt_vlsch_filter
        rt_kostlequnr = rt_kostlequnr_filter
        rt_kostlfuncl = rt_kostlfuncl_filter
      IMPORTING
        it_despacho   = lt_despacho
        it_filtro     = lt_filtro.

    LOOP AT lt_despacho INTO DATA(ls_despacho).
      CLEAR s_opersimplificada.
      MOVE-CORRESPONDING ls_despacho TO s_opersimplificada.
      APPEND s_opersimplificada TO t_opersimplificada.
    ENDLOOP.

    et_entityset = CORRESPONDING /ptloms/cl_soms_v2_mpc=>tt_operacaosimplificada( t_opersimplificada ).

  ENDMETHOD.


  METHOD perfilcentroset_get_entityset.
    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_mensagem    TYPE bapi_msg,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lt_tb014       TYPE /ptloms/ct160,
          lt_filtro      TYPE /ptloms/ct103,
          lv_usuario_sap TYPE flag.

    DATA: lt_perfilcentro TYPE STANDARD TABLE OF /ptloms/cl_soms_v2_mpc=>ts_perfilcentro,
          ls_perfilcentro LIKE LINE OF lt_perfilcentro.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR   "Se usuário SAP, então SAME_USER deve estar marcado
       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

*   Carrega filtro
    IF it_filter_select_options[] IS NOT INITIAL.

      READ TABLE it_filter_select_options INTO DATA(ls_perfil_filter) WITH KEY property = 'Perfil'.
      IF sy-subrc = 0.
        DATA(rt_perfil_filter) = ls_perfil_filter-select_options.
      ENDIF.

    ENDIF.

    CALL FUNCTION '/PTLOMS/MF140'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_perfil             = rt_perfil_filter
      IMPORTING
        et_dado_centro_perfil = lt_tb014.

    LOOP AT lt_tb014 INTO DATA(ls_tb014).
      CLEAR ls_perfilcentro.
      MOVE-CORRESPONDING ls_tb014 TO ls_perfilcentro.
      APPEND ls_perfilcentro TO lt_perfilcentro.
    ENDLOOP.

    et_entityset = lt_perfilcentro.

  ENDMETHOD.


  METHOD relatorioanaliti_get_entityset.
**TRY.
*CALL METHOD SUPER->RELATORIOANALITI_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
*****    SELECT DISTINCT
*****           tb65~uname,
*****           via~aufnr,
*****           via~gstrs,
*****           via~aufpl,
*****           afvc~aplzl,
*****           afvc~vornr,
*****           afvv~arbei,
*****           afvv~arbeh,
*****           afru~ismne,
*****           afru~ismnw
*****      INTO TABLE @DATA(lt_base)
*****      FROM viaufks AS via
*****     INNER JOIN afvc
*****        ON afvc~aufpl = via~aufpl
*****     INNER JOIN /ptloms/tb065 AS tb65
*****        ON tb65~aufnr = via~aufnr
*****       AND tb65~vornr = afvc~vornr
*****     INNER JOIN afvv
*****        ON afvv~aufpl = afvc~aufpl
*****       AND afvv~aplzl = afvc~aplzl
*****     LEFT OUTER JOIN afru
*****        ON afru~aufnr = via~aufnr
*****       AND tb65~vornr = tb65~vornr
*****       AND afru~stokz = ''
*****     WHERE via~gstrs BETWEEN '20260601' AND '20260605'
*****       AND afvc~loekz  = ''
*****       AND afvv~arbeh <> ''
*****     ORDER BY via~aufnr, afvc~vornr, tb65~uname.
*****
*****    LOOP AT lt_base ASSIGNING FIELD-SYMBOL(<base>).
*****      APPEND INITIAL LINE TO et_entityset ASSIGNING FIELD-SYMBOL(<linha>).
*****      <linha>-usuario     = <base>-uname.
*****      <linha>-ordem       = <base>-aufnr.
*****      <linha>-operacao    = <base>-vornr.
*****      <linha>-data_inicio = sy-datum.
*****      <linha>-total_plan  = <base>-arbei.
*****    ENDLOOP.


    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap TYPE flag,
          lv_mensagem    TYPE bapi_msg.

* Valida Configuração RFC (Verifica se possui usuário fixo)
    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
      EXPORTING
        destination             = lv_rfcdest
      IMPORTING
        same_user               = lv_same_user
      EXCEPTIONS
        authority_not_available = 1
        destination_not_exist   = 2
        information_failure     = 3
        internal_failure        = 4
        OTHERS                  = 5.

* Verifica se é Usuário SAP
    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.

    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR   "Se usuário SAP, então SAME_USER deve estar marcado
       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio

      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = lv_mensagem.
    ENDIF.

* Declarações especificas do serviço
    DATA: rt_ordem   TYPE /iwbep/t_cod_select_options,
          rt_data    TYPE /iwbep/t_cod_select_options,
          lt_retorno TYPE /ptloms/ct173,
          ls_filter  TYPE /iwbep/s_mgw_select_option,
          lv_aufnr   TYPE /ptloms/et204-ordem.

    " Carrega filtros
    IF it_filter_select_options[] IS NOT INITIAL.

      CLEAR ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'Operacao'.
      IF sy-subrc = 0.
        LOOP AT ls_filter-select_options ASSIGNING FIELD-SYMBOL(<aufnr>).
          CLEAR lv_aufnr.
          IF <aufnr>-low IS NOT INITIAL.
            lv_aufnr = <aufnr>-low.
            <aufnr>-low = |{ lv_aufnr ALPHA = IN }|.
          ENDIF.
          IF <aufnr>-high IS NOT INITIAL.
            lv_aufnr = <aufnr>-high.
            <aufnr>-high = |{ <aufnr>-high ALPHA = IN }|.
          ENDIF.
        ENDLOOP.
        rt_ordem = ls_filter-select_options.
      ENDIF.

      CLEAR ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'DataInicio'.
      IF sy-subrc = 0.
        rt_data = ls_filter-select_options.
      ENDIF.

    ENDIF.

    CALL FUNCTION '/PTLOMS/MF156'
      DESTINATION lv_rfcdest
      EXPORTING
        it_data    = rt_data
      IMPORTING
        et_retorno = lt_retorno.

    LOOP AT lt_retorno ASSIGNING FIELD-SYMBOL(<programacao>).
      APPEND INITIAL LINE TO et_entityset ASSIGNING FIELD-SYMBOL(<entidade>).
      MOVE-CORRESPONDING <programacao> TO <entidade>.
    ENDLOOP.

  ENDMETHOD.


METHOD timelinecompleta_get_entityset.

  DATA: lt_timeline      TYPE /ptloms/ct169,
        ls_timeline      TYPE /ptloms/et199,
        ls_entity        LIKE LINE OF et_entityset,

        " Variáveis de controle RFC
        lv_rfcdest       TYPE bdbapidst,
        lv_msgv1(50)     TYPE c,
        lv_msgv2(50)     TYPE c,
        lv_subrc         TYPE sy-subrc,
        lv_mensagem      TYPE bapi_msg,

        " Filtros
        lv_qmnum         TYPE char12,
        lv_aufnr         TYPE char12,
        wa_filter        LIKE LINE OF it_filter_select_options,
        wa_select_option LIKE LINE OF wa_filter-select_options.

  CLEAR et_entityset.

  " 1. BUSCA DESTINO RFC CONFIGURADO
  SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
  IF sy-subrc NE 0.
    MESSAGE e003(/ptloms/msg) INTO lv_mensagem. " RFC não cadastrada
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception EXPORTING message = lv_mensagem.
  ENDIF.

  " 2. VALIDAÇÃO DE CONEXÃO
  CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
    EXPORTING
      rfcdestination = lv_rfcdest
    IMPORTING
      msgv1          = lv_msgv1
      msgv2          = lv_msgv2
      rfc_subrc      = lv_subrc.

  IF lv_subrc NE 0.
    CONCATENATE 'Falha na conexão RFC:' lv_rfcdest INTO lv_mensagem SEPARATED BY space.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception EXPORTING message = lv_mensagem.
  ENDIF.

  " 3. CAPTURA DE FILTROS
  LOOP AT it_filter_select_options INTO wa_filter.
    READ TABLE wa_filter-select_options INTO wa_select_option INDEX 1.
    IF sy-subrc = 0.
      CASE wa_filter-property.
        WHEN 'Qmnum'. lv_qmnum = wa_select_option-low.
        WHEN 'Aufnr'. lv_aufnr = wa_select_option-low.
      ENDCASE.
    ENDIF.
  ENDLOOP.

  " 4. CHAMADA DA FUNÇÃO ORQUESTRADORA NO DESTINO
  CALL FUNCTION '/PTLOMS/MF150' DESTINATION lv_rfcdest
    EXPORTING
      iv_qmnum              = lv_qmnum
      iv_aufnr              = lv_aufnr
    IMPORTING
      et_timeline           = lt_timeline
    EXCEPTIONS
      communication_failure = 1
      system_failure        = 2
      OTHERS                = 3.

  IF sy-subrc NE 0.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception EXPORTING message = 'Erro na execução da RFC remota'.
  ENDIF.

  " 5. MAPEAMENTO PARA ODATA
  LOOP AT lt_timeline INTO ls_timeline.
    CLEAR ls_entity.

    ls_entity-aufnr         = lv_aufnr.
    ls_entity-qmnum         = lv_qmnum.
    ls_entity-chave         = ls_timeline-chave.
    ls_entity-tipo          = ls_timeline-tipo.
    ls_entity-docnum        = ls_timeline-docnum.
    ls_entity-doctipo       = ls_timeline-doctipo.
    ls_entity-doctipodesc   = ls_timeline-doctipodesc.
    ls_entity-docdesc       = ls_timeline-docdesc.
    ls_entity-status_sistema = ls_timeline-status_sistema.
    ls_entity-status_usuario = ls_timeline-status_usuario.
    ls_entity-data_cria      = ls_timeline-data_cria.
    ls_entity-hora_cria       = ls_timeline-hora_cria.
    ls_entity-criado_por      = ls_timeline-criado_por.
    ls_entity-data_fim        = ls_timeline-data_fim.
    ls_entity-hora_fim        = ls_timeline-hora_fim.

    " --- AJUSTE AQUI ---
    " Se a data for '00000000', limpamos para o OData tratar como nulo (null)
    IF ls_timeline-data_fim <> '00000000'.
      ls_entity-data_fim = ls_timeline-data_fim.
      ls_entity-hora_fim = ls_timeline-hora_fim.
    ELSE.
      CLEAR: ls_entity-data_fim, ls_entity-hora_fim.
    ENDIF.

    APPEND ls_entity TO et_entityset.
  ENDLOOP.

ENDMETHOD.


METHOD timelinefioriset_get_entityset.

  DATA: lt_timeline      TYPE /ptloms/ct169,
        ls_timeline      TYPE /ptloms/et199,
        ls_entity        LIKE LINE OF et_entityset,

        " Variáveis de controle RFC
        lv_rfcdest       TYPE bdbapidst,
        lv_msgv1(50)     TYPE c,
        lv_msgv2(50)     TYPE c,
        lv_subrc         TYPE sy-subrc,
        lv_mensagem      TYPE bapi_msg,

        " Filtros
        lv_qmnum         TYPE char12,
        lv_aufnr         TYPE char12,
        wa_filter        LIKE LINE OF it_filter_select_options,
        wa_select_option LIKE LINE OF wa_filter-select_options.

  CLEAR et_entityset.

  " 1. BUSCA DESTINO RFC CONFIGURADO
  SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
  IF sy-subrc NE 0.
    MESSAGE e003(/ptloms/msg) INTO lv_mensagem.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception EXPORTING message = lv_mensagem.
  ENDIF.

  " 2. VALIDAÇÃO DE CONEXÃO
  CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
    EXPORTING
      rfcdestination = lv_rfcdest
    IMPORTING
      msgv1          = lv_msgv1
      msgv2          = lv_msgv2
      rfc_subrc      = lv_subrc.

  IF lv_subrc NE 0.
    CONCATENATE 'Falha na conexão RFC:' lv_rfcdest INTO lv_mensagem SEPARATED BY space.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception EXPORTING message = lv_mensagem.
  ENDIF.

  " 3. CAPTURA DE FILTROS
  LOOP AT it_filter_select_options INTO wa_filter.
    READ TABLE wa_filter-select_options INTO wa_select_option INDEX 1.
    IF sy-subrc = 0.
      CASE wa_filter-property.
        WHEN 'Qmnum'. lv_qmnum = wa_select_option-low.
        WHEN 'Aufnr'. lv_aufnr = wa_select_option-low.
      ENDCASE.
    ENDIF.
  ENDLOOP.

  " 4. CHAMADA DA FUNÇÃO ORQUESTRADORA (A que chama a lógica de ordenação e montagem)
  CALL FUNCTION '/PTLOMS/MF151' DESTINATION lv_rfcdest
    EXPORTING
      iv_qmnum              = lv_qmnum
      iv_aufnr              = lv_aufnr
    IMPORTING
      et_timeline           = lt_timeline
    EXCEPTIONS
      communication_failure = 1
      system_failure        = 2
      OTHERS                = 3.

  IF sy-subrc NE 0.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception EXPORTING message = 'Erro na execução da RFC remota'.
  ENDIF.

  " 5. MAPEAMENTO PARA ODATA
  LOOP AT lt_timeline INTO ls_timeline.
    CLEAR ls_entity.

    ls_entity-aufnr         = lv_aufnr.
    ls_entity-qmnum         = lv_qmnum.
    ls_entity-chave         = ls_timeline-chave.
    ls_entity-tipo          = ls_timeline-tipo.
    ls_entity-docnum        = ls_timeline-docnum.
    ls_entity-doctipo       = ls_timeline-doctipo.
    ls_entity-doctipodesc   = ls_timeline-doctipodesc.
    ls_entity-docdesc       = ls_timeline-docdesc.
    ls_entity-status_sistema = ls_timeline-status_sistema.
    ls_entity-status_usuario = ls_timeline-status_usuario.
    ls_entity-data_cria      = ls_timeline-data_cria.
    ls_entity-hora_cria      = ls_timeline-hora_cria.
    ls_entity-criado_por      = ls_timeline-criado_por.

    " --- AJUSTE AQUI ---
    " Se a data for '00000000', limpamos para o OData tratar como nulo (null)
    IF ls_timeline-data_fim <> '00000000'.
      ls_entity-data_fim = ls_timeline-data_fim.
      ls_entity-hora_fim = ls_timeline-hora_fim.
    ELSE.
      CLEAR: ls_entity-data_fim, ls_entity-hora_fim.
    ENDIF.

    APPEND ls_entity TO et_entityset.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
