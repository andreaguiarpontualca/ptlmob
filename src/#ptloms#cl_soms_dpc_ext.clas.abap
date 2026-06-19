class /PTLOMS/CL_SOMS_DPC_EXT definition
  public
  inheriting from /PTLOMS/CL_SOMS_DPC
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

  methods OUT_ASSOCIACOESS_GET_ENTITYSET
    redefinition .
  methods OUT_AUTORIZACAOS_GET_ENTITYSET
    redefinition .
  methods OUT_CATALOGOSET_GET_ENTITYSET
    redefinition .
  methods OUT_CONFIGURACAO_GET_ENTITYSET
    redefinition .
  methods OUT_CONFIG_PERFI_GET_ENTITYSET
    redefinition .
  methods OUT_DOCUMENTO_ME_GET_ENTITYSET
    redefinition .
  methods OUT_EQUIPAMENTOS_GET_ENTITYSET
    redefinition .
  methods OUT_LAYOUT_CABSE_GET_ENTITYSET
    redefinition .
  methods OUT_LAYOUT_ITEMS_GET_ENTITYSET
    redefinition .
  methods OUT_LISTA_TECN03_GET_ENTITYSET
    redefinition .
  methods OUT_LISTA_TECNIC_GET_ENTITYSET
    redefinition .
  methods OUT_LOCAL_INSTAL_GET_ENTITYSET
    redefinition .
  methods OUT_LOGSET_GET_ENTITYSET
    redefinition .
  methods OUT_LOG_RESERVAS_GET_ENTITYSET
    redefinition .
  methods OUT_MATERIALSET_GET_ENTITYSET
    redefinition .
  methods OUT_NOTA_PERFIL__GET_ENTITYSET
    redefinition .
  methods OUT_ORDEMSET_GET_ENTITYSET
    redefinition .
  methods OUT_ORDEM_CATALO_GET_ENTITYSET
    redefinition .
  methods OUT_ORDEM_PERFIL_GET_ENTITYSET
    redefinition .
  methods OUT_PARCEIRO_NEG_GET_ENTITYSET
    redefinition .
  methods OUT_PONTO_MEDICA_GET_ENTITYSET
    redefinition .
  methods OUT_SALDO_MATERI_GET_ENTITYSET
    redefinition .
  methods OUT_USUARIOSET_GET_ENTITYSET
    redefinition .
  methods OUT_VARIANTSET_CREATE_ENTITY
    redefinition .
  methods OUT_VARIANTSET_DELETE_ENTITY
    redefinition .
  methods OUT_VARIANTSET_GET_ENTITY
    redefinition .
  methods OUT_VARIANTSET_GET_ENTITYSET
    redefinition .
  methods OUT_VARIANTSET_UPDATE_ENTITY
    redefinition .
  methods OUT_VARIANT_VALU_DELETE_ENTITY
    redefinition .
  methods OUT_VARIANT_VALU_GET_ENTITYSET
    redefinition .
  methods ROOT_OUT_VARIANT_GET_ENTITY
    redefinition .
  methods OUT_LISTA_TAREFA_GET_ENTITYSET
    redefinition .
private section.

  data GV_USUARIO_APP type XUBNAME .
ENDCLASS.



CLASS /PTLOMS/CL_SOMS_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_begin.

    cv_defer_mode = 'X'.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_end.

    COMMIT WORK AND WAIT.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_process.

    DATA: lv_rfcdest TYPE bdbapidst.

* Declarações Default
    DATA: ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response.
    DATA: ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request.
    DATA: ls_context_details    TYPE /iwbep/if_mgw_core_srv_runtime=>ty_s_mgw_request_context.
    DATA: lr_context            TYPE REF TO /iwbep/cl_mgw_request.

* Declaração referente a entidade IN_NOTA
    DATA: BEGIN OF ls_in_notas.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_nota.
            DATA: in_texto_notaset     TYPE /ptloms/cl_soms_mpc=>tt_in_texto_nota,
            in_item_notaset      TYPE /ptloms/cl_soms_mpc=>tt_in_item_nota,
            in_item_causaset     TYPE /ptloms/cl_soms_mpc=>tt_in_item_causa,
            in_item_medidasset   TYPE /ptloms/cl_soms_mpc=>tt_in_item_medidas,
            in_item_atividadeset TYPE /ptloms/cl_soms_mpc=>tt_in_item_atividade,
            in_item_tarefaset    TYPE /ptloms/cl_soms_mpc=>tt_in_item_tarefa,
            in_anexoset          TYPE /ptloms/cl_soms_mpc=>tt_in_anexo,
            in_retornoset        TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
          END OF ls_in_notas.

* Declaração referente a entidade IN_NOTA
    DATA: BEGIN OF ls_in_ordem_catalogo.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_ordem_catalogo.
            DATA: in_retornoset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
          END OF ls_in_ordem_catalogo.

    DATA: ls_ordem_catalogo TYPE /ptloms/et128.

* Declaração referente a entidade IN_ORDEM_LISTA_TAREFA
    DATA: BEGIN OF ls_in_ordem_lista_tarefa.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_ordem_lista_tarefa.
            DATA: in_retorno_ordemset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
            in_anexoset         TYPE /ptloms/cl_soms_mpc=>tt_in_anexo,
          END OF ls_in_ordem_lista_tarefa.

    DATA:
      ls_ordem_lista_tarefa TYPE /ptloms/et087.

* Declaração referente a entidade IN_NOTA_ORDEM
    DATA: BEGIN OF ls_in_nota_ordem.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_nota_ordem.
            DATA: in_texto_notaset     TYPE /ptloms/cl_soms_mpc=>tt_in_texto_nota,
            in_item_notaset      TYPE /ptloms/cl_soms_mpc=>tt_in_item_nota,
            in_item_causaset     TYPE /ptloms/cl_soms_mpc=>tt_in_item_causa,
            in_item_medidasset   TYPE /ptloms/cl_soms_mpc=>tt_in_item_medidas,
            in_item_atividadeset TYPE /ptloms/cl_soms_mpc=>tt_in_item_atividade,
            in_item_tarefaset    TYPE /ptloms/cl_soms_mpc=>tt_in_item_tarefa,
            in_anexoset          TYPE /ptloms/cl_soms_mpc=>tt_in_anexo,
            in_retornoset        TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
            in_operacao_ordemset TYPE /ptloms/cl_soms_mpc=>tt_in_operacao_ordem,
          END OF ls_in_nota_ordem.

* Declaração referente a entidade IN_CONFIRMACAO
    DATA: BEGIN OF ls_in_confirmacao.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_confirmacao.
            DATA: in_retorno_confirmacaoset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_confirmacao,
          END OF ls_in_confirmacao.

* Declaração IN Ordem
    DATA: BEGIN OF ls_in_ordem.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_ordem.
            DATA: in_operacao_ordemset TYPE /ptloms/cl_soms_mpc=>tt_in_operacao_ordem,
            in_texto_ordemset    TYPE /ptloms/cl_soms_mpc=>tt_in_texto_ordem,
            in_anexoset          TYPE /ptloms/cl_soms_mpc=>tt_in_anexo,
            in_retorno_ordemset  TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_confirmacao,
          END OF ls_in_ordem.

* Declaração IN Documento Medição
    DATA: BEGIN OF ls_in_documento_medicao.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_documento_medicao.
            DATA: in_retorno_doc_medset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_doc_med,
          END OF ls_in_documento_medicao.

* Declaração IN Operação Ordem INSR
    DATA: BEGIN OF ls_in_operacao_ordem_insr.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_operacao_ordem_insr.
            DATA: in_retorno_operacao_insrset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_operacao_insr,
          END OF ls_in_operacao_ordem_insr.

* Declaração IN Componente Ordem
    DATA: BEGIN OF ls_in_componente_ordem.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_componente_ordem.
            DATA: in_retorno_componenteset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_componente,
          END OF ls_in_componente_ordem.

* Declaração IN Reserva
    DATA: BEGIN OF ls_in_reserva.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_reserva.
            DATA: in_retorno_reservaset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_reserva,
          END OF ls_in_reserva.

* Declaração IN Finalizar Sessao
    DATA: ls_in_finalizar_sessao TYPE /ptloms/cl_soms_mpc=>ts_in_finalizar_sessao.

* Declaração IN Anexo
    DATA: BEGIN OF ls_in_anexo.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_anexo.
            DATA: in_retorno_anexoset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_anexo,
          END OF ls_in_anexo.

* Declarações para o método IN_NOTA
    DATA: ls_nota           TYPE /ptloms/cl_soms_mpc=>ts_in_nota,
          lt_texto_nota     TYPE /ptloms/cl_soms_mpc=>tt_in_texto_nota,
          lt_item_nota      TYPE /ptloms/cl_soms_mpc=>tt_in_item_nota,
          lt_item_causa     TYPE /ptloms/cl_soms_mpc=>tt_in_item_causa,
          lt_item_medidas   TYPE /ptloms/cl_soms_mpc=>tt_in_item_medidas,
          lt_item_atividade TYPE /ptloms/cl_soms_mpc=>tt_in_item_atividade,
          lt_item_tarefa    TYPE /ptloms/cl_soms_mpc=>tt_in_item_tarefa,
          lt_anexo          TYPE /ptloms/cl_soms_mpc=>tt_in_anexo,
          lt_return_nota    TYPE /ptloms/ct060.

* Declarações para o método IN_CONFIRMACAO
    DATA: ls_confirmacao        TYPE /ptloms/et051,
          lt_texto_confirmacao  TYPE /ptloms/ct061,
          lt_return_confirmacao TYPE /ptloms/ct062.

* Declarações para o método IN_ORDEM
    DATA: ls_ordem          TYPE /ptloms/et057,
          lt_operacao_ordem TYPE /ptloms/ct058,
          lt_texto_ordem    TYPE /ptloms/ct059,
          lt_return_ordem   TYPE /ptloms/ct063.

* Declaração para o método IN_DOCUMENTO_MEDICAO
    DATA: ls_documento_medicao TYPE /ptloms/et050,
          lt_retorno_doc_med   TYPE /ptloms/ct063.

* Declaração para o método IN_OPERACAO_ORDEM
    DATA: ls_operacao         TYPE /ptloms/et067,
          lt_retorno_operacao TYPE /ptloms/ct063.

* Declaração para o método IN_COMPONENTE_ORDEM
    DATA: ls_componente         TYPE /ptloms/et039,
          lt_retorno_componente TYPE /ptloms/ct063.

* Declaração para o método IN_RESERVA
    DATA: lt_retorno_reserva TYPE /ptloms/ct063.

* Declaração para o método IN_COMPONENTE_ORDEM_DELE
    DATA: ls_componente_dele         TYPE /ptloms/et039,
          lt_retorno_componente_dele TYPE /ptloms/ct063.

* Declaração para o método IN_FINALIZAR_SESSAO
    DATA: ls_finalizar_sessao         TYPE /ptloms/et107,
          lt_retorno_finalizar_sessao TYPE /ptloms/ct063.

* Declarações para o método IN_ANEXO
    DATA: lt_retorno_anexo    TYPE /ptloms/ct063,
          lt_retorno_catalogo TYPE /ptloms/ct063,
          ls_anexo            TYPE /ptloms/et072,
          lt_anexo_ordem      TYPE /ptloms/ct072,
          lv_aufnr            TYPE aufnr,
          lv_objkey           TYPE swo_typeid,
          lv_user             TYPE sy-uname.

* Variáveis para controle da sessão
    DATA: lv_guid    TYPE char32,
          lv_usuario TYPE xubname.

* Variável para retornar texto de exceção
    DATA: lv_mensagem    TYPE bapi_msg,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc.

    DATA: ls_controle TYPE /ptloms/tb048.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    LOOP AT it_changeset_request INTO ls_changeset_request.
      lr_context          ?= ls_changeset_request-request_context.
      ls_context_details   = lr_context->get_request_details( ).

      " Controle de acessos
      ls_controle-entity_name     = ls_context_details-target_entity_set.
      ls_controle-metodo          = 'CHANGESET_PROCESS'.
      ls_controle-usuario_sistema = sy-uname.
      ls_controle-aplicacao       = 'OMS'.
      ls_controle-usuario_app     = gv_usuario_app.

      " Controle de acessos
      /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

      IF ls_changeset_request-operation_type = 'CD'.

        CASE ls_context_details-target_entity_set.

          WHEN 'in_notaSet'.

            CLEAR ls_in_notas.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_notas ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_notas-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.
*            lv_usuario = /ptloms/cl006=>busca_usuario( ls_in_notas-usuario_app ).

            CLEAR lv_guid.
            CALL FUNCTION '/PTLOMS/MF042'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = lv_usuario
              IMPORTING
                ex_guid    = lv_guid.

            CLEAR ls_nota.
            REFRESH: lt_texto_nota[], lt_item_nota[], lt_item_causa[], lt_item_medidas[], lt_item_atividade[],
                     lt_item_tarefa[], lt_anexo[].
            MOVE-CORRESPONDING ls_in_notas TO ls_nota.
            ls_nota-pm_wkctr  = ls_nota-pm_wkctr_objid.
            lt_texto_nota     = ls_in_notas-in_texto_notaset.
            lt_item_nota      = ls_in_notas-in_item_notaset.
            lt_item_causa     = ls_in_notas-in_item_causaset.
            lt_item_medidas   = ls_in_notas-in_item_medidasset.
            lt_item_atividade = ls_in_notas-in_item_atividadeset.
            lt_item_tarefa    = ls_in_notas-in_item_tarefaset.
            lt_anexo          = ls_in_notas-in_anexoset.

            REFRESH lt_return_nota[].

            CALL FUNCTION '/PTLOMS/MF009'
              DESTINATION lv_rfcdest
              EXPORTING
                wa_nota           = ls_nota
                it_texto          = lt_texto_nota
                it_item           = lt_item_nota
                it_item_causa     = lt_item_causa
                it_item_atividade = lt_item_atividade
                it_item_medidas   = lt_item_medidas
                it_item_tarefa    = lt_item_tarefa
                it_anexo          = lt_anexo
              IMPORTING
                ex_notf_no        = ls_in_notas-qmnum
                it_return         = lt_return_nota.

            ls_in_notas-in_retornoset = lt_return_nota.

            READ TABLE lt_return_nota TRANSPORTING NO FIELDS WITH KEY type = 'E'.
            IF sy-subrc NE 0.
              ls_in_notas-deleted = 'X'.
            ENDIF.

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.
            ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_notas
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN 'in_nota_ordemSet'.

            CLEAR ls_in_nota_ordem.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_nota_ordem ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_nota_ordem-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.

            CLEAR lv_guid.
            CALL FUNCTION '/PTLOMS/MF042'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = lv_usuario
              IMPORTING
                ex_guid    = lv_guid.

* Simula criação da Ordem
            CLEAR ls_ordem.
            REFRESH: lt_operacao_ordem[], lt_texto_ordem[], lt_anexo[].
            MOVE-CORRESPONDING ls_in_nota_ordem TO ls_ordem.
            ls_ordem-mn_wk_ctr   = ls_in_nota_ordem-pm_wkctr.
            ls_ordem-mn_wk_plant = ls_in_nota_ordem-pm_wkctr_plant.
            lt_operacao_ordem    = ls_in_nota_ordem-in_operacao_ordemset.
            lt_texto_ordem       = ls_in_nota_ordem-in_texto_notaset.
            lt_anexo             = ls_in_nota_ordem-in_anexoset.

            REFRESH lt_return_ordem[].

            CALL FUNCTION '/PTLOMS/MF012'
              DESTINATION lv_rfcdest
              EXPORTING
                wa_ordem          = ls_ordem
                im_nota           = ls_in_nota_ordem-qmnum
                im_nocommit       = 'X'
                it_texto_ordem    = lt_texto_nota
                it_anexo          = lt_anexo
              IMPORTING
                ex_aufnr          = ls_in_nota_ordem-aufnr
                it_return_ordem   = lt_return_ordem
              CHANGING
                it_operacao_ordem = lt_operacao_ordem.

            READ TABLE lt_return_ordem WITH KEY type = 'E' TRANSPORTING NO FIELDS.
            IF sy-subrc EQ 0.
              ls_in_nota_ordem-in_retornoset = lt_return_ordem.
*              ls_in_nota_ordem-deleted = 'X'.
            ELSE.

* Cria Nota
              CLEAR ls_nota.
              REFRESH: lt_texto_nota[], lt_item_nota[], lt_item_causa[], lt_item_atividade[],
                       lt_item_tarefa[], lt_anexo[].
              MOVE-CORRESPONDING ls_in_nota_ordem TO ls_nota.
              ls_nota-pm_wkctr  = ls_nota-pm_wkctr_objid.
              ls_nota-breakdown = ls_in_nota_ordem-parada_tecnica.
              lt_texto_nota     = ls_in_nota_ordem-in_texto_notaset.
              lt_item_nota      = ls_in_nota_ordem-in_item_notaset.
              lt_item_causa     = ls_in_nota_ordem-in_item_causaset.
              lt_item_atividade = ls_in_nota_ordem-in_item_atividadeset.
              lt_item_tarefa    = ls_in_nota_ordem-in_item_tarefaset.

              REFRESH lt_return_nota[].

              CALL FUNCTION '/PTLOMS/MF009'
                DESTINATION lv_rfcdest
                EXPORTING
                  wa_nota           = ls_nota
                  it_texto          = lt_texto_nota
                  it_item           = lt_item_nota
                  it_item_causa     = lt_item_causa
                  it_item_atividade = lt_item_atividade
                  it_item_tarefa    = lt_item_tarefa
                  it_anexo          = lt_anexo
                IMPORTING
                  ex_notf_no        = ls_in_nota_ordem-qmnum
                  it_return         = lt_return_nota.

              ls_in_nota_ordem-in_retornoset = lt_return_nota.

              IF ls_in_nota_ordem-qmnum IS NOT INITIAL.

                lt_anexo            = ls_in_nota_ordem-in_anexoset.

                REFRESH lt_return_ordem[].

                CALL FUNCTION '/PTLOMS/MF012'
                  DESTINATION lv_rfcdest
                  EXPORTING
                    wa_ordem          = ls_ordem
                    im_nota           = ls_in_nota_ordem-qmnum
                    it_texto_ordem    = lt_texto_nota
                    it_anexo          = lt_anexo
                  IMPORTING
                    ex_aufnr          = ls_in_nota_ordem-aufnr
                    it_return_ordem   = lt_return_ordem
                  CHANGING
                    it_operacao_ordem = lt_operacao_ordem.

                APPEND LINES OF lt_return_ordem TO ls_in_nota_ordem-in_retornoset.

                READ TABLE lt_return_ordem TRANSPORTING NO FIELDS WITH KEY type = 'E'.
                IF sy-subrc NE 0.
                  ls_in_nota_ordem-deleted = 'X'.
                ENDIF.

              ENDIF.
            ENDIF.

            " Retonar com as operações criadas preenchidas
            ls_in_nota_ordem-in_operacao_ordemset = lt_operacao_ordem.

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.
            ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_nota_ordem
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN 'in_confirmacaoSet'.

            CLEAR ls_in_confirmacao.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_confirmacao ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_confirmacao-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.
*            lv_usuario = /ptloms/cl006=>busca_usuario( ls_in_confirmacao-usuario_app ).

            CLEAR lv_guid.
            CALL FUNCTION '/PTLOMS/MF042'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = lv_usuario
              IMPORTING
                ex_guid    = lv_guid.

            CLEAR ls_confirmacao.
            MOVE-CORRESPONDING ls_in_confirmacao TO ls_confirmacao.

            CALL FUNCTION '/PTLOMS/MF086'
              DESTINATION lv_rfcdest
              EXPORTING
                wa_confirmacao = ls_confirmacao
              CHANGING
                it_retorno     = lt_return_confirmacao
              EXCEPTIONS
                erro_catalogo  = 1
                OTHERS         = 2.

            IF lt_return_confirmacao IS INITIAL.

              REFRESH lt_return_confirmacao[].

              CALL FUNCTION '/PTLOMS/MF011'
                DESTINATION lv_rfcdest
                EXPORTING
                  wa_confirmacao        = ls_confirmacao
                  it_texto_confirmacao  = lt_texto_confirmacao
                IMPORTING
                  it_return_confirmacao = lt_return_confirmacao.

            ENDIF.

            ls_in_confirmacao-in_retorno_confirmacaoset = lt_return_confirmacao.

            READ TABLE lt_return_confirmacao WITH KEY type = 'E' TRANSPORTING NO FIELDS.
            IF sy-subrc EQ 0.
              IF ls_in_confirmacao-status_mobile = 5.
                ls_in_confirmacao-status_mobile = 10.
              ELSE.
                ls_in_confirmacao-status_mobile = 8.
              ENDIF.
            ELSE.
              ls_in_confirmacao-status_mobile = 7.
            ENDIF.

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.
            ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_confirmacao
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR: ls_changeset_request, lt_return_confirmacao.

          WHEN 'in_ordemSet'.

            CLEAR ls_in_ordem.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_ordem ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_ordem-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.
*            lv_usuario = /ptloms/cl006=>busca_usuario( ls_in_ordem-usuario_app ).

            CLEAR lv_guid.
            CALL FUNCTION '/PTLOMS/MF042'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = lv_usuario
              IMPORTING
                ex_guid    = lv_guid.

            CLEAR ls_ordem.
            REFRESH: lt_operacao_ordem[], lt_texto_ordem[], lt_anexo[].
            MOVE-CORRESPONDING ls_in_ordem TO ls_ordem.
            lt_operacao_ordem  = ls_in_ordem-in_operacao_ordemset.
            lt_anexo           = ls_in_ordem-in_anexoset.

            REFRESH lt_return_ordem[].

            CALL FUNCTION '/PTLOMS/MF012'
              DESTINATION lv_rfcdest
              EXPORTING
                wa_ordem          = ls_ordem
                im_nota           = space
                it_texto_ordem    = lt_texto_ordem
                it_anexo          = lt_anexo
              IMPORTING
                ex_aufnr          = ls_in_ordem-aufnr
                it_return_ordem   = lt_return_ordem
              CHANGING
                it_operacao_ordem = lt_operacao_ordem.

            " Retonar com as operações criadas preenchidas
            ls_in_ordem-in_operacao_ordemset = lt_operacao_ordem.
            ls_in_ordem-in_retorno_ordemset  = lt_return_ordem.

            READ TABLE lt_return_ordem TRANSPORTING NO FIELDS WITH KEY type = 'E'.
            IF sy-subrc NE 0.
              ls_in_ordem-deleted = 'X'.
            ENDIF.

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.
            ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_ordem
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN 'in_documento_medicaoSet'.

            CLEAR ls_in_documento_medicao.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_documento_medicao ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_documento_medicao-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.

            CLEAR lv_guid.
            CALL FUNCTION '/PTLOMS/MF042'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = lv_usuario
              IMPORTING
                ex_guid    = lv_guid.

            CLEAR ls_documento_medicao.

            ls_in_documento_medicao-measurement_point = ls_in_documento_medicao-point.
            IF ls_in_documento_medicao-usuario_app IS INITIAL.
              ls_in_documento_medicao-reader = sy-uname.
            ELSE.
              ls_in_documento_medicao-reader = ls_in_documento_medicao-usuario_app.
            ENDIF.
            ls_in_documento_medicao-recorded_value = ls_in_documento_medicao-valor_medido.

            ls_in_documento_medicao-reading_date = ls_in_documento_medicao-data_hora_inicio+6(4) &&
                                                   ls_in_documento_medicao-data_hora_inicio+3(2) &&
                                                   ls_in_documento_medicao-data_hora_inicio(2).

            ls_in_documento_medicao-reading_time = ls_in_documento_medicao-data_hora_inicio+11(2) &&
                                                   ls_in_documento_medicao-data_hora_inicio+14(2) &&
                                                   ls_in_documento_medicao-data_hora_inicio+17(2).

            MOVE-CORRESPONDING ls_in_documento_medicao TO ls_documento_medicao.

            REFRESH lt_retorno_doc_med[].

            CALL FUNCTION '/PTLOMS/MF010'
              DESTINATION lv_rfcdest
              IMPORTING
                it_retorno_doc_med   = lt_retorno_doc_med
              CHANGING
                wa_documento_medicao = ls_documento_medicao.

            MOVE-CORRESPONDING ls_documento_medicao TO ls_in_documento_medicao.

            READ TABLE lt_retorno_doc_med TRANSPORTING NO FIELDS WITH KEY type = 'E'.
            IF sy-subrc NE 0.
              ls_in_documento_medicao-deleted = 'X'.
            ENDIF.

            ls_in_documento_medicao-in_retorno_doc_medset = lt_retorno_doc_med.

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.
            ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_documento_medicao
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN 'in_operacao_ordem_insrSet'.

            CLEAR ls_in_operacao_ordem_insr.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_operacao_ordem_insr ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_operacao_ordem_insr-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.

            CLEAR lv_guid.
            CALL FUNCTION '/PTLOMS/MF042'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = lv_usuario
              IMPORTING
                ex_guid    = lv_guid.

            CLEAR ls_operacao.
            MOVE-CORRESPONDING ls_in_operacao_ordem_insr TO ls_operacao.
            ls_operacao-objectkey = ls_operacao-orderid.
*            ls_operacao-work_cntr = ls_operacao-work_cntr_objid.

            REFRESH lt_retorno_operacao[].

            CALL FUNCTION '/PTLOMS/MF013'
              DESTINATION lv_rfcdest
              EXPORTING
                wa_operacao         = ls_operacao
              IMPORTING
                it_retorno_operacao = lt_retorno_operacao
                e_operacao          = ls_operacao.


            READ TABLE lt_retorno_operacao TRANSPORTING NO FIELDS WITH KEY type = 'E'.
            IF sy-subrc NE 0.
              ls_in_operacao_ordem_insr-deleted = 'X'.
              ls_in_operacao_ordem_insr-status  = 'Criado'.
              ls_in_operacao_ordem_insr-activity = ls_operacao-activity.
            ELSEIF ls_in_operacao_ordem_insr-orderid IS NOT INITIAL.
              ls_in_operacao_ordem_insr-status  = 'Erro'.
            ENDIF.

            ls_in_operacao_ordem_insr-in_retorno_operacao_insrset = lt_retorno_operacao.

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.
            ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_operacao_ordem_insr
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN 'in_reservaSet'. " Novo sincronismos

            CLEAR ls_in_reserva.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_reserva ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_reserva-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.

            CLEAR lv_guid.
            CALL FUNCTION '/PTLOMS/MF042'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = lv_usuario
              IMPORTING
                ex_guid    = lv_guid.

            REFRESH lt_retorno_reserva[].

            IF ls_in_reserva-created = 'X'.

              " 13/04/2023 - No TILE de "Correções pendentes" estava enviando a UM e gerando erro na BAPI para criação do componente
              "CLEAR: ls_in_reserva-requirement_quantity_unit.

              CALL FUNCTION '/PTLOMS/MF096'
                DESTINATION lv_rfcdest
                IMPORTING
                  it_retorno_componente = lt_retorno_reserva
                CHANGING
                  wa_componente         = ls_in_reserva.

              ls_in_reserva-in_retorno_reservaset = lt_retorno_reserva.

            ELSEIF ls_in_reserva-deleted = 'X'.

              CALL FUNCTION '/PTLOMS/MF097'
                DESTINATION lv_rfcdest
                IMPORTING
                  it_retorno_componente = lt_retorno_reserva
                CHANGING
                  wa_componente         = ls_in_reserva.

              ls_in_reserva-in_retorno_reservaset = lt_retorno_reserva.

            ENDIF.

            READ TABLE lt_retorno_reserva TRANSPORTING NO FIELDS WITH KEY type = 'E'.
            IF sy-subrc NE 0.
              ls_in_reserva-backend_updated = 'X'.
            ENDIF.

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.
            ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_reserva
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN 'in_componente_ordemSet'.

            CLEAR ls_in_componente_ordem.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_componente_ordem ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_componente_ordem-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.

            CLEAR lv_guid.
            CALL FUNCTION '/PTLOMS/MF042'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = lv_usuario
              IMPORTING
                ex_guid    = lv_guid.

            CLEAR ls_componente.
            MOVE-CORRESPONDING ls_in_componente_ordem TO ls_componente.

            REFRESH lt_retorno_componente[].

            IF ls_in_componente_ordem-created = 'X'.

              " 13/04/2023 - No TILE de "Correções pendentes" estava enviando a UM e gerando erro na BAPI para criação do componente
              CLEAR: ls_componente-requirement_quantity_unit.

              CALL FUNCTION '/PTLOMS/MF015'
                DESTINATION lv_rfcdest
                EXPORTING
                  wa_componente         = ls_componente
                IMPORTING
                  it_retorno_componente = lt_retorno_componente.

              ls_in_componente_ordem-in_retorno_componenteset = lt_retorno_componente.

            ELSEIF ls_in_componente_ordem-deleted = 'X'.

              CALL FUNCTION '/PTLOMS/MF014'
                DESTINATION lv_rfcdest
                EXPORTING
                  wa_componente         = ls_componente
                IMPORTING
                  it_retorno_componente = lt_retorno_componente.

              ls_in_componente_ordem-in_retorno_componenteset = lt_retorno_componente.

            ENDIF.

            READ TABLE lt_retorno_componente TRANSPORTING NO FIELDS WITH KEY type = 'E'.
            IF sy-subrc NE 0.
              ls_in_componente_ordem-backend_updated = 'X'.
            ENDIF.

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.
            ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_componente_ordem
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN 'in_anexoSet'.

            CLEAR ls_in_anexo.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_anexo ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_anexo-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.

            CLEAR lv_guid.
            CALL FUNCTION '/PTLOMS/MF042'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = lv_usuario
              IMPORTING
                ex_guid    = lv_guid.

            CLEAR ls_anexo.
            MOVE-CORRESPONDING ls_in_anexo TO ls_anexo.

            REFRESH lt_anexo_ordem[].
            APPEND ls_anexo TO lt_anexo_ordem.

* Anexar arquivos
            CLEAR: lv_aufnr, lv_objkey.
            REFRESH lt_retorno_anexo[].
            IF ls_anexo-instid_a IS NOT INITIAL.
              lv_aufnr   = |{ ls_anexo-instid_a ALPHA = IN }|.
              lv_objkey  = lv_aufnr.

              lv_user = ls_in_anexo-usuario_app.

              CALL FUNCTION '/PTLOMS/MF017'
                DESTINATION lv_rfcdest
                EXPORTING
                  im_objkey        = lv_objkey
                  im_user          = lv_user
                  it_anexo_ordem   = lt_anexo_ordem
                IMPORTING
                  it_retorno_anexo = lt_retorno_anexo.

              ls_in_anexo-status = 'Criado'.

            ELSE.
              DATA: lt_return TYPE /ptloms/ct063.
              DATA: ls_return LIKE LINE OF lt_return.
              ls_return-type = 'E'.
              ls_return-type_desc = 'Error'(025).
              ls_return-message = 'Erro ao criar relacionamento do anexo com a Ordem ou Nota. Sincronize a Ordem ou Nota antes de enviar o anexo.'(019).
              APPEND ls_return TO lt_retorno_anexo.

              ls_in_anexo-status = 'Erro'.

            ENDIF.

            ls_in_anexo-in_retorno_anexoset = lt_retorno_anexo.

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.
            ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_anexo
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN 'in_componente_ordem_insrSet'.

          WHEN 'in_componente_ordem_deleSet'.

          WHEN 'in_ordem_catalogoSet'.

            CLEAR ls_in_ordem_catalogo.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_ordem_catalogo ).

            ls_ordem_catalogo = CORRESPONDING #( ls_in_ordem_catalogo ).
* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_ordem_catalogo-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.

            CALL FUNCTION '/PTLOMS/MF084'
              DESTINATION lv_rfcdest
              IMPORTING
                it_retorno_catalogo = lt_retorno_catalogo
              CHANGING
                wa_ordem_catalogo   = ls_ordem_catalogo.

            ls_in_ordem_catalogo = CORRESPONDING #( ls_ordem_catalogo ).
            ls_in_ordem_catalogo-in_retornoset[] = CORRESPONDING #( lt_retorno_catalogo[] ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_ordem_catalogo
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN 'in_ordem_lista_tarefaSet'.

            CLEAR ls_in_ordem_lista_tarefa.
            ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_ordem_lista_tarefa ).

            ls_ordem_lista_tarefa = CORRESPONDING #( ls_in_ordem_lista_tarefa ).

* Autenticação
            CLEAR lv_usuario.
            CALL FUNCTION '/PTLOMS/MF044'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario = ls_in_ordem_lista_tarefa-usuario_app
              IMPORTING
                ex_usuario = lv_usuario.

            REFRESH lt_return_ordem[].
            lt_anexo[]  = ls_in_ordem_lista_tarefa-in_anexoset[].

            CALL FUNCTION '/PTLOMS/MF112'
              DESTINATION lv_rfcdest
              EXPORTING
                wa_ordem        = ls_ordem_lista_tarefa
                im_nota         = ls_in_ordem_lista_tarefa-aufnr
                im_nocommit     = abap_false
                it_texto_ordem  = lt_texto_nota
                it_anexo        = lt_anexo
              IMPORTING
                ex_aufnr        = ls_in_ordem_lista_tarefa-aufnr
                it_return_ordem = lt_return_ordem.

            READ TABLE lt_return_ordem WITH KEY type = 'E' TRANSPORTING NO FIELDS.
            IF  sy-subrc          EQ 0.
              ls_in_ordem_lista_tarefa-status = 'Erro'.
            ELSE.
              ls_in_ordem_lista_tarefa-status = 'Sucesso'.
            ENDIF.

*            ls_in_ordem_lista_tarefa                 = CORRESPONDING #( ls_ordem_lista_tarefa ).
            ls_in_ordem_lista_tarefa-in_retorno_ordemset[] = CORRESPONDING #( lt_return_ordem[] ).

            copy_data_to_ref(
            EXPORTING
              is_data = ls_in_ordem_lista_tarefa
            CHANGING
              cr_data = ls_changeset_response-entity_data ).

            ls_changeset_response-operation_no = ls_changeset_request-operation_no.

            APPEND ls_changeset_response TO ct_changeset_response.
            CLEAR ls_changeset_request.

          WHEN OTHERS.

        ENDCASE.

      ELSEIF ls_changeset_request-operation_type = 'CE'.

        IF ls_context_details-target_entity_set = 'in_finalizar_sessaoSet'.

          CLEAR ls_in_finalizar_sessao.
          ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_in_finalizar_sessao ).

* Autenticação
          CLEAR lv_usuario.
          CALL FUNCTION '/PTLOMS/MF044'
            DESTINATION lv_rfcdest
            EXPORTING
              im_usuario = ls_in_finalizar_sessao-usuario
            IMPORTING
              ex_usuario = lv_usuario.

          CLEAR lv_guid.
          CALL FUNCTION '/PTLOMS/MF042'
            DESTINATION lv_rfcdest
            EXPORTING
              im_usuario = lv_usuario
            IMPORTING
              ex_guid    = lv_guid.

          CLEAR ls_finalizar_sessao.
          MOVE-CORRESPONDING ls_in_finalizar_sessao TO ls_finalizar_sessao.

          REFRESH lt_retorno_finalizar_sessao[].

          CALL FUNCTION '/PTLOMS/MF016'
            DESTINATION lv_rfcdest
            EXPORTING
              im_usuario                  = lv_usuario
            IMPORTING
              it_retorno_finalizar_sessao = lt_retorno_finalizar_sessao.

          ls_changeset_response-operation_no = ls_changeset_request-operation_no.
          ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

          copy_data_to_ref(
          EXPORTING
            is_data = ls_in_finalizar_sessao
          CHANGING
            cr_data = ls_changeset_response-entity_data ).

          APPEND ls_changeset_response TO ct_changeset_response.
          CLEAR ls_changeset_request.

        ENDIF.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.

    DATA: ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request.

    DATA: BEGIN OF t_root_associar.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_in_associar.
            DATA: out_programacao_associarset TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_associar,
            in_retornoset               TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
          END OF t_root_associar.

    DATA: it_liberar TYPE TABLE OF /ptloms/et085.

    DATA: lt_root_associar           LIKE TABLE OF t_root_associar,
          ls_root_associar           LIKE LINE OF lt_root_associar,
          lt_programacao_associar    TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_associar,
          lt_programacao_desassociar TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_desassociar,
          lt_programacao_liberar     TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_liberar,
          lt_programacao_transferir  TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_transferir.

    DATA: BEGIN OF t_root_desassociar.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_in_desassociar.
            DATA: out_programacao_desassociarset TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_desassociar,
            in_retornoset                  TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
            out_motivos_desassociarset     TYPE /ptloms/cl_soms_mpc=>tt_out_motivos_desassociar,
          END OF t_root_desassociar.

    DATA: lt_root_desassociar LIKE TABLE OF t_root_desassociar,
          ls_root_desassociar LIKE LINE OF lt_root_desassociar.

    DATA: BEGIN OF t_root_liberar.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_in_liberar.
            DATA: out_programacao_liberarset TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_liberar,
            in_retornoset              TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
          END OF t_root_liberar.

    DATA: lt_root_liberar LIKE TABLE OF t_root_liberar,
          ls_root_liberar LIKE LINE OF lt_root_liberar.

    DATA: BEGIN OF t_root_transferir.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_in_transferir.
            DATA: out_programacao_transferirset TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_transferir,
            in_retornoset                 TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
          END OF t_root_transferir.

    DATA: lt_root_transferir LIKE TABLE OF t_root_transferir,
          ls_root_transferir LIKE LINE OF lt_root_transferir.

* Declaração para Usuário
    DATA: BEGIN OF t_out_usuario.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_out_usuario_completo.
            DATA: out_autorizacao_completoset    TYPE /ptloms/cl_soms_mpc=>tt_out_autorizacao_completo,
            out_config_perfil_completoset  TYPE /ptloms/cl_soms_mpc=>tt_out_config_perfil_completo,
            out_config_sistema_completoset TYPE /ptloms/cl_soms_mpc=>tt_out_config_sistema_completo,
          END OF t_out_usuario.
    DATA: lt_out_usuario LIKE TABLE OF t_out_usuario,
          ls_out_usuario LIKE LINE OF lt_out_usuario.

* Declaração de Layout
    DATA: BEGIN OF t_out_layout.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_out_layout_cab.
            DATA: out_layout_itemset TYPE /ptloms/cl_soms_mpc=>tt_out_layout_item,
          END OF t_out_layout.
    DATA: lt_out_layout    LIKE TABLE OF t_out_layout,
          ls_out_layout    LIKE LINE OF lt_out_layout,
          ls_layout        TYPE /ptloms/et082,
          lt_layout_values TYPE /ptloms/ct084.

    DATA: BEGIN OF t_root_out_ponto_medicao.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_ponto_medicao.
            DATA: out_ponto_medicaoset TYPE /ptloms/cl_soms_mpc=>tt_out_ponto_medicao,
          END OF t_root_out_ponto_medicao.

    DATA: BEGIN OF t_root_out_documento_medicao.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_documento_medicao.
            DATA: out_documento_medicaoset TYPE /ptloms/cl_soms_mpc=>tt_out_documento_medicao,
          END OF t_root_out_documento_medicao.

    DATA: BEGIN OF t_root_out_catalogo.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_catalogo.
            DATA: out_catalogoset TYPE /ptloms/cl_soms_mpc=>tt_out_catalogo,
          END OF t_root_out_catalogo.

    DATA: BEGIN OF t_root_out_lista_tecnica.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_lista_tecnica.
            DATA: out_lista_tecnicaset TYPE /ptloms/cl_soms_mpc=>tt_out_lista_tecnica,
          END OF t_root_out_lista_tecnica.

    DATA: BEGIN OF t_root_out_lista_tecnica_local.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_lista_tecnica_loca.
            DATA: out_lista_tecnica_local_instal TYPE /ptloms/cl_soms_mpc=>tt_out_lista_tecnica_local_ins,
          END OF t_root_out_lista_tecnica_local.

    DATA: BEGIN OF t_root_out_saldo_material.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_saldo_material.
            DATA: out_saldo_materialset TYPE /ptloms/cl_soms_mpc=>tt_out_saldo_material,
          END OF t_root_out_saldo_material.

    DATA: lt_root_out_ponto_medicao     LIKE TABLE OF t_root_out_ponto_medicao,
          ls_root_out_ponto_medicao     LIKE LINE OF lt_root_out_ponto_medicao,
          lt_root_out_documento_medicao LIKE TABLE OF t_root_out_documento_medicao,
          ls_root_out_documento_medicao LIKE LINE OF lt_root_out_documento_medicao,
          lt_root_out_catalogo          LIKE TABLE OF t_root_out_catalogo,
          ls_root_out_catalogo          LIKE LINE OF lt_root_out_catalogo,
          lt_root_out_lista_tecnica     LIKE TABLE OF t_root_out_lista_tecnica,
          ls_root_out_lista_tecnica     LIKE LINE OF lt_root_out_lista_tecnica,
          lt_root_out_lista_tecnica_loc LIKE TABLE OF t_root_out_lista_tecnica_local,
          ls_root_out_lista_tecnica_loc LIKE LINE OF lt_root_out_lista_tecnica_loc,
          lt_root_out_saldo_material    LIKE TABLE OF t_root_out_saldo_material,
          ls_root_out_saldo_material    LIKE LINE OF lt_root_out_saldo_material,
          rt_objnr                      TYPE /iwbep/t_cod_select_options,
          ls_objnr                      LIKE LINE OF rt_objnr,
          rt_point                      TYPE /iwbep/t_cod_select_options,
          ls_point                      LIKE LINE OF rt_point,
          rt_rbnr                       TYPE /iwbep/t_cod_select_options,
          ls_rbnr                       LIKE LINE OF rt_rbnr,
          rt_equnr                      TYPE /iwbep/t_cod_select_options,
          ls_equnr                      LIKE LINE OF rt_equnr,
          lt_ponto_medicao              TYPE /ptloms/cl_soms_mpc=>tt_out_ponto_medicao,
          lt_documento_medicao          TYPE /ptloms/cl_soms_mpc=>tt_out_documento_medicao,
          out_saldo_material            TYPE /ptloms/cl_soms_mpc=>tt_out_saldo_material,
          in_saldo_material             TYPE /ptloms/cl_soms_mpc=>tt_out_saldo_material,
          it_saldo_material             TYPE /ptloms/cl_soms_mpc=>tt_out_saldo_material,
          rt_werks                      TYPE /iwbep/t_cod_select_options,
          rt_matnr                      TYPE /iwbep/t_cod_select_options,
          rt_tplnr                      TYPE /iwbep/t_cod_select_options,
          rt_lgort                      TYPE /iwbep/t_cod_select_options,
          ls_matnr                      LIKE LINE OF rt_matnr,
          ls_werks                      LIKE LINE OF rt_werks,
          ls_tplnr                      LIKE LINE OF rt_tplnr,
          lt_lista_tecnica_loc_inst     TYPE /ptloms/ct032,
          lt_retorno_reserva            TYPE /ptloms/ct063,
          lt_retorno_reserva_aux        TYPE /ptloms/ct063.

    DATA: lv_usuario        TYPE xubname,
          lv_rfcdest        TYPE bdbapidst,
          lv_usuario_sap    TYPE flag,
          lv_senha          TYPE char32,
          lv_confsenha      TYPE char32,
          lv_autenticado    TYPE char1,
          lv_senha_alterada TYPE char1,
          lv_guid           TYPE char32,
          lv_perfil         TYPE c LENGTH 10,
          lv_encode         TYPE string,
          lv_decode         TYPE string,
          lv_erro           TYPE char1,
          lv_senha_sap      TYPE char40.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg,
          lv_same_user TYPE rfcdisplay-rfcsameusr.

    DATA: rt_usuarioapp TYPE /iwbep/t_cod_select_options,
          ls_usuarioapp LIKE LINE OF rt_usuarioapp.

    DATA: lt_dados_usuario_app    TYPE /ptloms/ct101,
          lt_autorizacao          TYPE /ptloms/ct076,
          ls_autorizacao          LIKE LINE OF ls_out_usuario-out_autorizacao_completoset,
          lt_configuracao_sistema TYPE /ptloms/ct074,
          ls_configuracao_sistema LIKE LINE OF ls_out_usuario-out_config_sistema_completoset,
          lt_configuracao         TYPE /ptloms/ct078,
          ls_configuracao         LIKE LINE OF ls_out_usuario-out_config_perfil_completoset,
          lt_retorno              TYPE bapiret2_t,
          lt_retorno_aux          TYPE bapiret2_t,
          ls_transferencia        TYPE /ptloms/et129,
          ls_dessasocia           TYPE /ptloms/et129,
          lt_catalogos            TYPE /ptloms/ct002,
          "          lt_lista_tecnica        TYPE /ptloms/ct031.
          lt_lista_tecnica        TYPE /ptloms/ct054.

    DATA: ls_usuario_app LIKE LINE OF rt_usuarioapp.

    DATA: ls_controle TYPE /ptloms/tb048.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    CASE iv_entity_name.
      WHEN 'out_layout_cab'.

        io_data_provider->read_entry_data(
       IMPORTING
       es_data = ls_out_layout ).

        MOVE-CORRESPONDING ls_out_layout TO ls_layout.
        lt_layout_values = ls_out_layout-out_layout_itemset.

        CALL FUNCTION '/PTLOMS/MF067'
          DESTINATION lv_rfcdest
          EXPORTING
            im_layout        = ls_layout
            it_layout_values = lt_layout_values.

        copy_data_to_ref(
                          EXPORTING
                          is_data = ls_out_layout
                          CHANGING
                          cr_data = er_deep_entity
                          ).

      WHEN 'out_usuario_completo'.

        io_data_provider->read_entry_data(
       IMPORTING
       es_data = ls_out_usuario ).

        IF ls_out_usuario-usuario IS INITIAL.

          lv_mensagem = 'Informar usuário'(016).

          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
            EXPORTING
              textid  = /iwbep/cx_mgw_busi_exception=>business_error
              message = lv_mensagem.

        ENDIF.

        IF ls_out_usuario-senha IS INITIAL.

          lv_mensagem = 'Informar senha'(015).

          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
            EXPORTING
              textid  = /iwbep/cx_mgw_busi_exception=>business_error
              message = lv_mensagem.

        ENDIF.

        TRANSLATE ls_out_usuario-usuario TO UPPER CASE.

        lv_encode = ls_out_usuario-senha.
        CALL METHOD cl_http_utility=>if_http_utility~decode_base64    "Method for Decryption
          EXPORTING
            encoded = lv_encode
          RECEIVING
            decoded = lv_decode.
        ls_out_usuario-senha = lv_decode.

* Define Usuário
        IF ls_out_usuario-usuario IS NOT INITIAL.
          lv_usuario = ls_out_usuario-usuario.
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

*Validação removida a pedido da Andina. André Aguiar 27/03/2023
        IF lv_usuario <> ls_out_usuario-usuario.
          lv_mensagem = 'Senha/Usuário inválido'(005).

          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
            EXPORTING
              textid  = /iwbep/cx_mgw_busi_exception=>business_error
              message = lv_mensagem.
        ENDIF.

*    lv_usuario = /ptloms/cl006=>busca_usuario( lv_usuario ).

*        CALL FUNCTION '/PTLOMS/MF049'
*          DESTINATION lv_rfcdest
*          IMPORTING
*            ex_usuario_sap = lv_usuario_sap.

* Cria sessão para usuário Mobile (Ainda não foi autenticado)
*    IF ls_usuarioapp_aux-low IS NOT INITIAL.
        IF lv_usuario_sap IS INITIAL.

*      lv_usuario = ls_usuarioapp_aux-low.
*      TRANSLATE lv_usuario TO UPPER CASE.
          lv_senha     = ls_out_usuario-senha.
          lv_confsenha = ls_out_usuario-conf_senha.

* Verifica se há necessidade de alterar a senha
          IF lv_senha IS NOT INITIAL AND lv_confsenha IS NOT INITIAL.

            CALL FUNCTION '/PTLOMS/MF043'
              DESTINATION lv_rfcdest
              EXPORTING
                im_usuario        = lv_usuario
                im_senha          = lv_senha
                im_confsenha      = lv_confsenha
              IMPORTING
                ex_senha_alterada = lv_senha_alterada.

            IF lv_senha_alterada IS INITIAL.
              RETURN.
            ENDIF.

          ENDIF.

          CALL FUNCTION '/PTLOMS/MF039'
            DESTINATION lv_rfcdest
            EXPORTING
              im_usuario     = lv_usuario
              im_senha       = lv_senha
            IMPORTING
              ex_autenticado = lv_autenticado.

          IF lv_autenticado IS INITIAL.
            lv_mensagem = 'Senha/Usuário inválido'(005).

            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                textid  = /iwbep/cx_mgw_busi_exception=>business_error
                message = lv_mensagem.
          ENDIF.

* Cria sessão para usuário SAP (Já foi autenticado)
        ELSE.
          " Conversão de campo 32 caracteres para 40 caracteres
          DATA(lv_password) = ls_out_usuario-senha.

          CALL FUNCTION 'SUSR_LOGIN_CHECK_RFC'
            EXPORTING
              bname                  = lv_usuario
              password               = CONV xubcode( lv_password )
            EXCEPTIONS
              wait                   = 1
              user_locked            = 2
              user_not_active        = 3
              password_expired       = 4
              wrong_password         = 5
              no_check_for_this_user = 6
              internal_error         = 7.

          CASE sy-subrc.
            WHEN 0. lv_mensagem = 'Usuário/senha OK'(006).
            WHEN 1. lv_mensagem = 'Tempo de espera após tentativas malsucedidas usuário está bloqueado'(007).
            WHEN 2. lv_mensagem = 'O usuário não está ativo (período de validade)'(008).
            WHEN 3. lv_mensagem = 'A senha deve ser alterada'(009).
            WHEN 4. lv_mensagem = 'A senha está errada'(010).
            WHEN 5. lv_mensagem = 'A senha está errada'(010).
            WHEN 6. lv_mensagem = 'Número de logins com senha com falha excedido'(012).
            WHEN 7. lv_mensagem = 'Erro interno'(013).
            WHEN OTHERS.
          ENDCASE.

          IF sy-subrc IS NOT INITIAL.

            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                textid  = /iwbep/cx_mgw_busi_exception=>business_error
                message = lv_mensagem.

          ENDIF.

        ENDIF.

        IF rt_usuarioapp[] IS INITIAL.
          CLEAR ls_usuario_app.
          ls_usuario_app-sign = 'I'.
          ls_usuario_app-option = 'EQ'.
          ls_usuario_app-low = lv_usuario.
          APPEND ls_usuario_app TO rt_usuarioapp.
        ENDIF.

        CALL FUNCTION '/PTLOMS/MF034'
          DESTINATION lv_rfcdest
          EXPORTING
            rt_usuario_app       = rt_usuarioapp
          IMPORTING
            it_dados_usuario_app = lt_dados_usuario_app.

        READ TABLE lt_dados_usuario_app INTO DATA(ls_dados_usuario_app) INDEX 1.
        IF sy-subrc EQ 0.

          IF ls_dados_usuario_app-bloqueado = 'X'.
            lv_mensagem = 'Usuário bloqueado'(014).

            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                textid  = /iwbep/cx_mgw_busi_exception=>business_error
                message = lv_mensagem.
          ENDIF.

          MOVE-CORRESPONDING ls_dados_usuario_app TO ls_out_usuario.
          ls_out_usuario-guid = lv_guid.
          CLEAR: ls_out_usuario-senha, ls_out_usuario-conf_senha.

* Autorização
          CALL FUNCTION '/PTLOMS/MF058'
            DESTINATION lv_rfcdest
            EXPORTING
              im_usuario     = lv_usuario
            IMPORTING
              it_autorizacao = lt_autorizacao.

          LOOP AT lt_autorizacao INTO DATA(ls_autorizacao_aux).
            CLEAR ls_autorizacao.
            MOVE-CORRESPONDING ls_autorizacao_aux TO ls_autorizacao.
            ls_autorizacao-guid = lv_guid.
            APPEND ls_autorizacao TO ls_out_usuario-out_autorizacao_completoset.
          ENDLOOP.

* Configuração Perfil
          lv_perfil = ls_dados_usuario_app-perfil.

          CALL FUNCTION '/PTLOMS/MF060'
            DESTINATION lv_rfcdest
            EXPORTING
              im_perfil       = lv_perfil
            IMPORTING
              it_configuracao = lt_configuracao.

          LOOP AT lt_configuracao INTO DATA(ls_configuracao_aux).
            CLEAR ls_configuracao.
            MOVE-CORRESPONDING ls_configuracao_aux TO ls_configuracao.
            APPEND ls_configuracao TO ls_out_usuario-out_config_perfil_completoset.
            IF ls_configuracao_aux-configuracao = '04'.
              DATA(lv_04) = 'X'.
            ENDIF.
            IF ls_configuracao_aux-configuracao = '05'.
              DATA(lv_05) = 'X'.
            ENDIF.
            IF ls_configuracao_aux-configuracao = '06'.
              DATA(lv_06) = 'X'.
            ENDIF.
            IF ls_configuracao_aux-configuracao = '07'.
              DATA(lv_07) = 'X'.
            ENDIF.
            IF ls_configuracao_aux-configuracao = '08'.
              DATA(lv_08) = 'X'.
            ENDIF.
          ENDLOOP.

* Configuração Sistema
          CALL FUNCTION '/PTLOMS/MF038'
            DESTINATION lv_rfcdest
            IMPORTING
              it_configuracao_sistema = lt_configuracao_sistema.

          LOOP AT lt_configuracao_sistema INTO DATA(ls_configuracao_sistema_aux).
            CLEAR ls_configuracao_sistema.
            MOVE-CORRESPONDING ls_configuracao_sistema_aux TO ls_configuracao_sistema.
            ls_configuracao_sistema-guid = lv_guid.
            IF lv_04 = 'X'.
              ls_configuracao_sistema-despacho_ordem = 'X'.
            ENDIF.
            IF lv_05 = 'X'.
              ls_configuracao_sistema-despacho_oper = 'X'.
            ENDIF.
            IF lv_06 = 'X'.
              ls_configuracao_sistema-chave_modelo = 'X'.
            ENDIF.
            IF lv_07 = 'X'.
              ls_configuracao_sistema-apont_manual = 'X'.
            ENDIF.
            IF lv_08 = 'X'.
              ls_configuracao_sistema-tipo_atividade = 'X'.
            ENDIF.
            APPEND ls_configuracao_sistema TO ls_out_usuario-out_config_sistema_completoset.
          ENDLOOP.
        ENDIF.

        ls_out_usuario-senha = lv_encode.

        copy_data_to_ref(
                          EXPORTING
                          is_data = ls_out_usuario
                          CHANGING
                          cr_data = er_deep_entity
                          ).

        gv_usuario_app = ls_out_usuario-usuario.

      WHEN 'root_in_associar'.

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_associar ).

        IF ls_root_associar IS NOT INITIAL.

          lt_programacao_associar = ls_root_associar-out_programacao_associarset.

          LOOP AT lt_programacao_associar ASSIGNING FIELD-SYMBOL(<fs_ordem>).

            DATA(tabix) = sy-tabix.

            CALL FUNCTION '/PTLOMS/MF082'
              DESTINATION lv_rfcdest
              EXPORTING
                im_aufnr   = <fs_ordem>-aufnr
                origem     = 'APP'
              IMPORTING
                it_retorno = lt_retorno_aux.

            IF lt_retorno_aux IS NOT INITIAL.

              APPEND LINES OF lt_retorno_aux TO lt_retorno.
              DELETE lt_programacao_associar INDEX tabix.

            ENDIF.

          ENDLOOP.

          IF lt_programacao_associar IS NOT INITIAL.

            CLEAR: lt_retorno_aux.
            " Validações
            CALL FUNCTION '/PTLOMS/MF079'
              DESTINATION lv_rfcdest
              IMPORTING
                it_retorno = lt_retorno_aux
              CHANGING
                it_ordem   = lt_programacao_associar.

            APPEND LINES OF lt_retorno_aux TO lt_retorno.

            READ TABLE lt_retorno ASSIGNING FIELD-SYMBOL(<fs_retorno>) WITH KEY parameter = 'ABER'.

            IF lt_programacao_associar IS NOT INITIAL AND <fs_retorno> IS NOT ASSIGNED.
*            IF lt_programacao_associar IS NOT INITIAL AND sy-subrc INITIAL.
              READ TABLE lt_retorno ASSIGNING FIELD-SYMBOL(<fs_retorno2>) WITH KEY number = '008'.

              IF sy-subrc IS NOT INITIAL.
                CLEAR: lt_retorno_aux.

                CALL FUNCTION '/PTLOMS/MF069'
                  DESTINATION lv_rfcdest
                  IMPORTING
                    it_retorno = lt_retorno_aux
                  CHANGING
                    it_ordem   = lt_programacao_associar.

                APPEND LINES OF lt_retorno_aux TO lt_retorno.

              ENDIF.
            ENDIF.

          ENDIF.

          ls_root_associar-in_retornoset = CORRESPONDING #( lt_retorno ).
          CLEAR: ls_root_associar-out_programacao_associarset.

          LOOP AT lt_retorno ASSIGNING FIELD-SYMBOL(<fs_volta>) WHERE number = '008'.

            DATA lv_aufnr   TYPE c LENGTH 12.
            CLEAR lv_aufnr.
            lv_aufnr = |{ <fs_volta>-message_v1 ALPHA = IN }|.

            READ TABLE lt_programacao_associar  ASSIGNING FIELD-SYMBOL(<fs_associar>)
                                                WITH KEY aufnr   = lv_aufnr
                                                         vornr   = <fs_volta>-message_v2.
            IF  sy-subrc           EQ 0.
              <fs_associar>-motivo_associacao = '03'.
              <fs_associar>-usuario_destino = <fs_volta>-parameter.
              <fs_associar>-matricula = <fs_volta>-field.
            ENDIF.

          ENDLOOP.

          ls_root_associar-out_programacao_associarset = CORRESPONDING #( lt_programacao_associar ).

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_associar
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'root_in_desassociar'.

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_desassociar ).

        IF ls_root_desassociar IS NOT INITIAL.

          lt_programacao_desassociar = ls_root_desassociar-out_programacao_desassociarset.

          CALL FUNCTION '/PTLOMS/MF104'
            DESTINATION lv_rfcdest
            EXPORTING
              it_ordem = lt_programacao_desassociar
            IMPORTING
              et_ordem = lt_programacao_desassociar.

          ls_root_desassociar-out_programacao_desassociarset = lt_programacao_desassociar.

          LOOP AT lt_programacao_desassociar ASSIGNING <fs_ordem>.

            tabix = sy-tabix.
            CLEAR: lt_retorno_aux.

            CALL FUNCTION '/PTLOMS/MF082'
              DESTINATION lv_rfcdest
              EXPORTING
                im_aufnr   = <fs_ordem>-aufnr
              IMPORTING
                it_retorno = lt_retorno_aux.

            IF lt_retorno_aux IS NOT INITIAL.

              APPEND LINES OF lt_retorno_aux TO lt_retorno.
              DELETE lt_programacao_desassociar INDEX tabix.
              CONTINUE.

            ENDIF.

            MOVE-CORRESPONDING <fs_ordem> TO ls_dessasocia.
            ls_dessasocia-usuario = <fs_ordem>-usuario_origem.

            " Validar dessasociação
            CALL FUNCTION '/PTLOMS/MF088'
              DESTINATION lv_rfcdest
              EXPORTING
                im_aufnr   = ls_dessasocia
              IMPORTING
                it_retorno = lt_retorno_aux.

            IF lt_retorno_aux IS NOT INITIAL.

              APPEND LINES OF lt_retorno_aux TO lt_retorno.
              DELETE lt_programacao_desassociar INDEX tabix.

            ENDIF.

          ENDLOOP.

          IF lt_programacao_desassociar IS NOT INITIAL.

            CLEAR: lt_retorno_aux.
            " Validações
            CALL FUNCTION '/PTLOMS/MF068'
              DESTINATION lv_rfcdest
              EXPORTING
*               it_ordem   = ls_root_desassociar-out_programacao_desassociarset[]
                it_ordem   = lt_programacao_desassociar
              IMPORTING
                it_retorno = lt_retorno_aux.

            APPEND LINES OF lt_retorno_aux TO lt_retorno.

          ENDIF.

          ls_root_desassociar-in_retornoset = CORRESPONDING #( lt_retorno ).

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_desassociar
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'root_in_liberar'.

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_liberar ).

        IF ls_root_liberar IS NOT INITIAL.

          it_liberar = CORRESPONDING #( ls_root_liberar-out_programacao_liberarset ).
          SORT it_liberar BY aufnr.
          DELETE ADJACENT DUPLICATES FROM it_liberar COMPARING aufnr.

          LOOP AT it_liberar ASSIGNING FIELD-SYMBOL(<fs_ordem_liberar>).

            tabix = sy-tabix.

            CALL FUNCTION '/PTLOMS/MF082'
              DESTINATION lv_rfcdest
              EXPORTING
                im_aufnr   = <fs_ordem_liberar>-aufnr
              IMPORTING
                it_retorno = lt_retorno_aux.

            IF lt_retorno_aux IS NOT INITIAL.

              APPEND LINES OF lt_retorno_aux TO lt_retorno.
              DELETE it_liberar INDEX tabix.

            ENDIF.

          ENDLOOP.

          IF it_liberar IS NOT INITIAL.

            CLEAR: lt_retorno_aux.

            CALL FUNCTION '/PTLOMS/MF072'
              DESTINATION lv_rfcdest
              EXPORTING
                it_ordem   = it_liberar
              IMPORTING
                it_retorno = lt_retorno_aux.

            APPEND LINES OF lt_retorno_aux TO lt_retorno.

          ENDIF.

          ls_root_liberar-in_retornoset = CORRESPONDING #( lt_retorno ).

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_liberar
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'root_in_transferir'.

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_transferir ).

        IF ls_root_transferir IS NOT INITIAL.

          lt_programacao_transferir = ls_root_transferir-out_programacao_transferirset.

          LOOP AT lt_programacao_transferir ASSIGNING <fs_ordem>.

            tabix = sy-tabix.
            CLEAR: lt_retorno_aux.

            " Ler bloqueio da ordem
            CALL FUNCTION '/PTLOMS/MF082'
              DESTINATION lv_rfcdest
              EXPORTING
                im_aufnr   = <fs_ordem>-aufnr
              IMPORTING
                it_retorno = lt_retorno_aux.

            IF lt_retorno_aux IS NOT INITIAL.

              APPEND LINES OF lt_retorno_aux TO lt_retorno.
              DELETE lt_programacao_transferir INDEX tabix.
              CONTINUE.

            ENDIF.

            MOVE-CORRESPONDING <fs_ordem> TO ls_transferencia.
            ls_transferencia-usuario = <fs_ordem>-usuario_origem.

            " Validar transferência
            CALL FUNCTION '/PTLOMS/MF087'
              DESTINATION lv_rfcdest
              EXPORTING
                im_aufnr   = ls_transferencia
              IMPORTING
                it_retorno = lt_retorno_aux.

            IF lt_retorno_aux IS NOT INITIAL.

              APPEND LINES OF lt_retorno_aux TO lt_retorno.
              DELETE lt_programacao_transferir INDEX tabix.

            ENDIF.

          ENDLOOP.

          IF lt_programacao_transferir IS NOT INITIAL.

            CLEAR: lt_retorno_aux.

            CALL FUNCTION '/PTLOMS/MF074'
              DESTINATION lv_rfcdest
              IMPORTING
                it_retorno = lt_retorno_aux
              CHANGING
                it_ordem   = lt_programacao_transferir.

            APPEND LINES OF lt_retorno_aux TO lt_retorno.

          ENDIF.

          ls_root_transferir-in_retornoset = CORRESPONDING #( lt_retorno ).
          CLEAR: ls_root_transferir-out_programacao_transferirset.

          ls_root_transferir-out_programacao_transferirset = lt_programacao_transferir.

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_transferir
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'root_out_ponto_medicao'.

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_out_ponto_medicao ).

        IF ls_root_out_ponto_medicao IS NOT INITIAL.

          CLEAR: rt_usuarioapp.

          LOOP AT ls_root_out_ponto_medicao-out_ponto_medicaoset INTO DATA(wl_out_ponto_medicao).

            CLEAR ls_objnr.
            ls_objnr-sign   = 'I'.
            ls_objnr-option = 'EQ'.
            ls_objnr-low    = wl_out_ponto_medicao-objnr.
            APPEND ls_objnr TO rt_objnr.

            IF rt_usuarioapp[] IS INITIAL AND wl_out_ponto_medicao-usuarioapp IS NOT INITIAL.

              ls_usuarioapp-sign   = 'I'.
              ls_usuarioapp-option = 'EQ'.
              ls_usuarioapp-low    = wl_out_ponto_medicao-usuarioapp.
              APPEND ls_usuarioapp TO rt_usuarioapp.

            ENDIF.

          ENDLOOP.

          CALL FUNCTION '/PTLOMS/MF020'
            DESTINATION lv_rfcdest
            EXPORTING
              rt_objnr                  = rt_objnr
              rt_usuario_app            = rt_usuarioapp
            IMPORTING
              it_ponto_medicao          = lt_ponto_medicao
            EXCEPTIONS
              environment_not_available = 1.

          LOOP AT lt_ponto_medicao ASSIGNING FIELD-SYMBOL(<fs_ponto_medicao>).
            <fs_ponto_medicao>-point = |{ <fs_ponto_medicao>-point ALPHA = OUT }|.
            <fs_ponto_medicao>-equnr = |{ <fs_ponto_medicao>-equnr ALPHA = OUT }|.
          ENDLOOP.

          ls_root_out_ponto_medicao-out_ponto_medicaoset = CORRESPONDING #( lt_ponto_medicao ).

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_out_ponto_medicao
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'root_out_documento_medicao'.

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_out_documento_medicao ).

        IF ls_root_out_documento_medicao IS NOT INITIAL.
          " Point = Chave para selecionar o documento de medição a partir do ponto
          LOOP AT ls_root_out_documento_medicao-out_documento_medicaoset INTO DATA(wl_out_documento_medicao).

            CLEAR ls_point.
            ls_point-sign   = 'I'.
            ls_point-option = 'EQ'.
            ls_point-low    = wl_out_documento_medicao-point.
            APPEND ls_point TO rt_point.

            IF rt_usuarioapp[] IS INITIAL AND wl_out_documento_medicao-usuarioapp IS NOT INITIAL.

              ls_usuarioapp-sign   = 'I'.
              ls_usuarioapp-option = 'EQ'.
              ls_usuarioapp-low    = wl_out_documento_medicao-usuarioapp.
              APPEND ls_usuarioapp TO rt_usuarioapp.

            ENDIF.

          ENDLOOP.

          CALL FUNCTION '/PTLOMS/MF021'
            DESTINATION lv_rfcdest
            EXPORTING
              rt_point             = rt_point
              rt_usuario_app       = rt_usuarioapp
            IMPORTING
              it_documento_medicao = lt_documento_medicao.

          LOOP AT lt_documento_medicao ASSIGNING FIELD-SYMBOL(<fs_documento_medicao>).
            <fs_documento_medicao>-point = |{ <fs_documento_medicao>-point ALPHA = OUT }|.
          ENDLOOP.

          " Retonar somente os registros que tenham ponto de medição
          CLEAR: ls_root_out_documento_medicao-out_documento_medicaoset.

          ls_root_out_documento_medicao-out_documento_medicaoset = CORRESPONDING #( lt_documento_medicao ).

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_out_documento_medicao
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'root_out_catalogo'.

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_out_catalogo ).

        IF ls_root_out_catalogo IS NOT INITIAL.
          " Rbnr = Chave para selecionar o catálogo
          LOOP AT ls_root_out_catalogo-out_catalogoset INTO DATA(wl_out_catalogo).

            CLEAR ls_usuarioapp.
            ls_usuarioapp-sign   = 'I'.
            ls_usuarioapp-option = 'EQ'.
            ls_usuarioapp-low    = wl_out_catalogo-usuarioapp.
            APPEND ls_usuarioapp TO rt_usuarioapp.

            CLEAR ls_rbnr.
            ls_rbnr-sign   = 'I'.
            ls_rbnr-option = 'EQ'.
            ls_rbnr-low    = wl_out_catalogo-rbnr.
            APPEND ls_rbnr TO rt_rbnr.

          ENDLOOP.

          CALL FUNCTION '/PTLOMS/MF019' DESTINATION lv_rfcdest
            EXPORTING
              rt_rbnr        = rt_rbnr
              rt_usuario_app = rt_usuarioapp
            IMPORTING
              it_catalogos   = lt_catalogos.

*Begin of Change - Vidal - 30.05.2025 10:44:00
*---> Não deixar retirar os zeros à esquerda
**          LOOP AT lt_catalogos ASSIGNING FIELD-SYMBOL(<fs_catalogos>).
**            <fs_catalogos>-rbnr = |{ <fs_catalogos>-rbnr ALPHA = OUT }|.
**          ENDLOOP.
*Ended of Change - Vidal - 30.05.2025 10:44:00

          " Retonar somente os registros que tenham catálogos
          CLEAR: ls_root_out_catalogo-out_catalogoset.

          ls_root_out_catalogo-out_catalogoset = CORRESPONDING #( lt_catalogos ).

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_out_catalogo
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'root_out_lista_tecnica'. " Lista técnica de equipamento

*        io_data_provider->read_entry_data(
*          IMPORTING
*          es_data = ls_root_out_lista_tecnica ).
*
*        IF ls_root_out_lista_tecnica IS NOT INITIAL.
*          " Equnr = Chave para selecionar a lista técnica
*          LOOP AT ls_root_out_lista_tecnica-out_lista_tecnicaset INTO DATA(wl_out_lista_tecnica).
*
*            CLEAR ls_equnr.
*            ls_equnr-sign   = 'I'.
*            ls_equnr-option = 'EQ'.
*            ls_equnr-low    = wl_out_lista_tecnica-equnr.
*            APPEND ls_equnr TO rt_equnr.
*
*          ENDLOOP.
*
*          CALL FUNCTION '/PTLOMS/MF091' DESTINATION lv_rfcdest
*            EXPORTING
*              rt_equnr              = rt_equnr
*            IMPORTING
*              it_lista_tecnica_equi = lt_lista_tecnica.
*
*          LOOP AT lt_lista_tecnica ASSIGNING FIELD-SYMBOL(<fs_lista_tecnica>).
*            <fs_lista_tecnica>-equnr = |{ <fs_lista_tecnica>-equnr ALPHA = OUT }|.
*
*            <fs_lista_tecnica>-matnr = <fs_lista_tecnica>-idnrk.
*
*          ENDLOOP.
*
*          " Retonar somente os registros que tenham catálogos
*          CLEAR: ls_root_out_lista_tecnica-out_lista_tecnicaset.
*
*          ls_root_out_lista_tecnica-out_lista_tecnicaset = CORRESPONDING #( lt_lista_tecnica ).
*
*          copy_data_to_ref(
*                            EXPORTING
*                            is_data = ls_root_out_lista_tecnica
*                            CHANGING
*                            cr_data = er_deep_entity ).

*        ENDIF.

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_out_lista_tecnica ).

        IF ls_root_out_lista_tecnica IS NOT INITIAL.
          " Equnr = Chave para selecionar a lista técnica
          LOOP AT ls_root_out_lista_tecnica-out_lista_tecnicaset INTO DATA(wl_out_lista_tecnica).

            CLEAR ls_equnr.
            ls_equnr-sign   = 'I'.
            ls_equnr-option = 'EQ'.
            ls_equnr-low    = wl_out_lista_tecnica-equnr.
            APPEND ls_equnr TO rt_equnr.

          ENDLOOP.

          CLEAR: ls_root_out_lista_tecnica-out_lista_tecnicaset.

          CALL FUNCTION '/PTLOMS/MF091' DESTINATION lv_rfcdest
            EXPORTING
              rt_equnr              = rt_equnr
            IMPORTING
              it_lista_tecnica_equi = lt_lista_tecnica.

          ls_root_out_lista_tecnica-out_lista_tecnicaset = CORRESPONDING #( lt_lista_tecnica ).

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_out_lista_tecnica
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'root_out_saldo_material'.   " Saldo para material e saldo para lista técnica

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_out_saldo_material ).

        IF ls_root_out_saldo_material IS NOT INITIAL.

          CLEAR: rt_matnr, rt_werks, ls_matnr, ls_werks, it_saldo_material, rt_usuarioapp.

          LOOP AT ls_root_out_saldo_material-out_saldo_materialset INTO DATA(wl_out_saldo_material).

            ls_matnr-sign   = 'I'.
            ls_matnr-option = 'EQ'.
            ls_matnr-low    = wl_out_saldo_material-matnr.

            APPEND ls_matnr TO rt_matnr.

            ls_werks-sign   = 'I'.
            ls_werks-option = 'EQ'.
            ls_werks-low    = wl_out_saldo_material-werks.

            APPEND ls_werks TO rt_werks.

            ls_usuarioapp-sign   = 'I'.
            ls_usuarioapp-option = 'EQ'.
            ls_usuarioapp-low    = wl_out_saldo_material-usuarioapp.

            APPEND ls_usuarioapp TO rt_usuarioapp.

          ENDLOOP.

          DELETE ADJACENT DUPLICATES FROM rt_werks COMPARING low.

          CALL FUNCTION '/PTLOMS/MF032'
            DESTINATION lv_rfcdest
            EXPORTING
              rt_matnr       = rt_matnr
              rt_werks       = rt_werks
              rt_lgort       = rt_lgort
              rt_usuario_app = rt_usuarioapp
            IMPORTING
              it_saldo       = it_saldo_material.

          LOOP AT it_saldo_material ASSIGNING FIELD-SYMBOL(<fs_saldo>).
            <fs_saldo>-matnr = |{ <fs_saldo>-matnr ALPHA = OUT }|.
          ENDLOOP.

          APPEND LINES OF it_saldo_material TO out_saldo_material.

          CLEAR: ls_root_out_saldo_material-out_saldo_materialset.

          ls_root_out_saldo_material-out_saldo_materialset = CORRESPONDING #( out_saldo_material ).

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_out_saldo_material
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'root_out_lista_tecnica_local_instal'.

        io_data_provider->read_entry_data(
          IMPORTING
          es_data = ls_root_out_lista_tecnica_loc ).

        IF ls_root_out_lista_tecnica_loc IS NOT INITIAL.

          LOOP AT ls_root_out_lista_tecnica_loc-out_lista_tecnica_local_instal INTO DATA(wl_lista_tecnica).

            ls_tplnr-sign   = 'I'.
            ls_tplnr-option = 'EQ'.
            ls_tplnr-low    = wl_lista_tecnica-tplnr.

            APPEND ls_tplnr TO rt_tplnr.

          ENDLOOP.

          CALL FUNCTION '/PTLOMS/MF092'
            DESTINATION lv_rfcdest
            EXPORTING
              rt_tplnr                  = rt_tplnr
            IMPORTING
              it_lista_tecnica_loc_inst = lt_lista_tecnica_loc_inst.

          " Retonar somente os registros que tenham catálogos
          CLEAR: ls_root_out_lista_tecnica_loc-out_lista_tecnica_local_instal.

          ls_root_out_lista_tecnica_loc-out_lista_tecnica_local_instal = CORRESPONDING #( lt_lista_tecnica_loc_inst ).

          copy_data_to_ref(
                            EXPORTING
                            is_data = ls_root_out_lista_tecnica_loc
                            CHANGING
                            cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'lista_equipamento'.

        DATA: BEGIN OF t_lista_dados_equipamento.
                INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_lista_equipamento.
                DATA: out_equipamentoset TYPE /ptloms/ct019, "/ptloms/cl_soms_mpc=>tt_lista_equipamento,
              END OF t_lista_dados_equipamento.


        DATA: lt_lista_dados_equipamento    LIKE TABLE OF t_lista_dados_equipamento,
              ls_lista_dados_equipamento    LIKE t_lista_dados_equipamento,
              ls_lista_dados_equipamento_in LIKE LINE OF ls_lista_dados_equipamento-out_equipamentoset,

              lt_equipamento_in             TYPE /ptloms/ct019,
              w_equipamento_in              LIKE LINE OF lt_equipamento_in,

              lt_equipamento_out            TYPE /ptloms/ct019,
              w_equipamento_out             LIKE LINE OF lt_equipamento_out,
              ls_equipamento_out            LIKE LINE OF ls_lista_dados_equipamento-out_equipamentoset.

        io_data_provider->read_entry_data(
         IMPORTING
          es_data = ls_lista_dados_equipamento ).

        IF ls_lista_dados_equipamento IS NOT INITIAL.

          "Dados de entrada
          LOOP AT ls_lista_dados_equipamento-out_equipamentoset INTO ls_lista_dados_equipamento_in.
            MOVE-CORRESPONDING ls_lista_dados_equipamento_in TO w_equipamento_in.
            APPEND w_equipamento_in TO lt_equipamento_in.
          ENDLOOP.

          REFRESH: ls_lista_dados_equipamento-out_equipamentoset.

          CALL FUNCTION '/PTLOMS/MF142'
            DESTINATION lv_rfcdest
            EXPORTING
              it_equipamento_in  = lt_equipamento_in
            IMPORTING
              et_equipamento_out = lt_equipamento_out.
*            e_retorno_out    = lt_equipamento_retorno_out.

          "Dados de retorno
          LOOP AT lt_equipamento_out  INTO w_equipamento_out.
            MOVE-CORRESPONDING w_equipamento_out TO ls_equipamento_out.
            APPEND ls_equipamento_out TO ls_lista_dados_equipamento-out_equipamentoset.
          ENDLOOP.

          copy_data_to_ref(
            EXPORTING
               is_data = ls_lista_dados_equipamento
            CHANGING
               cr_data = er_deep_entity ).

        ENDIF.

      WHEN 'in_confirmacao'.

* Declaração referente a entidade IN_CONFIRMACAO
        DATA: BEGIN OF ls_in_confirmacao.
                INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_confirmacao.
                DATA: in_retorno_confirmacaoset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_confirmacao,
              END OF ls_in_confirmacao.

* Declarações para o método IN_CONFIRMACAO
        DATA: ls_confirmacao        TYPE /ptloms/et051,
              lt_texto_confirmacao  TYPE /ptloms/ct061,
              lt_return_confirmacao TYPE /ptloms/ct062.

        CLEAR ls_in_confirmacao.


        io_data_provider->read_entry_data(
          IMPORTING
              es_data = ls_in_confirmacao ).

* Autenticação
        CLEAR lv_usuario.
        CALL FUNCTION '/PTLOMS/MF044'
          DESTINATION lv_rfcdest
          EXPORTING
            im_usuario = ls_in_confirmacao-usuario_app
          IMPORTING
            ex_usuario = lv_usuario.
*            lv_usuario = /ptloms/cl006=>busca_usuario( ls_in_confirmacao-usuario_app ).

        CLEAR lv_guid.
        CALL FUNCTION '/PTLOMS/MF042'
          DESTINATION lv_rfcdest
          EXPORTING
            im_usuario = lv_usuario
          IMPORTING
            ex_guid    = lv_guid.

        CLEAR ls_confirmacao.
        MOVE-CORRESPONDING ls_in_confirmacao TO ls_confirmacao.

        CALL FUNCTION '/PTLOMS/MF086'
          DESTINATION lv_rfcdest
          EXPORTING
            wa_confirmacao = ls_confirmacao
          CHANGING
            it_retorno     = lt_return_confirmacao
          EXCEPTIONS
            erro_catalogo  = 1
            OTHERS         = 2.

        IF lt_return_confirmacao IS INITIAL.

          REFRESH lt_return_confirmacao[].

          CALL FUNCTION '/PTLOMS/MF011'
            DESTINATION lv_rfcdest
            EXPORTING
              wa_confirmacao        = ls_confirmacao
              it_texto_confirmacao  = lt_texto_confirmacao
            IMPORTING
              it_return_confirmacao = lt_return_confirmacao.

        ENDIF.

        ls_in_confirmacao-in_retorno_confirmacaoset = lt_return_confirmacao.

        READ TABLE lt_return_confirmacao WITH KEY type = 'E' TRANSPORTING NO FIELDS.
        IF sy-subrc EQ 0.
          IF ls_in_confirmacao-status_mobile = 5.
            ls_in_confirmacao-status_mobile = 10.
          ELSE.
            ls_in_confirmacao-status_mobile = 8.
          ENDIF.
        ELSE.
          ls_in_confirmacao-status_mobile = 7.
        ENDIF.

*        ls_changeset_response-operation_no = ls_changeset_request-operation_no.
*        ls_changeset_response = CORRESPONDING #( ls_changeset_request ).

        copy_data_to_ref(
        EXPORTING
          is_data = ls_in_confirmacao
        CHANGING
          cr_data = er_deep_entity ).

      WHEN 'in_documento_medicao'.

* Declaração IN Documento Medição
        DATA: BEGIN OF ls_in_documento_medicao.
                INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_documento_medicao.
                DATA: in_retorno_doc_medset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_doc_med,
              END OF ls_in_documento_medicao.

* Declaração para o método IN_DOCUMENTO_MEDICAO
        DATA: ls_documento_medicao TYPE /ptloms/et050,
              lt_retorno_doc_med   TYPE /ptloms/ct063.

        CLEAR ls_in_documento_medicao.


        io_data_provider->read_entry_data(
  IMPORTING
      es_data = ls_in_documento_medicao ).

* Autenticação
        CLEAR lv_usuario.
        CALL FUNCTION '/PTLOMS/MF044'
          DESTINATION lv_rfcdest
          EXPORTING
            im_usuario = ls_in_documento_medicao-usuario_app
          IMPORTING
            ex_usuario = lv_usuario.

        CLEAR lv_guid.
        CALL FUNCTION '/PTLOMS/MF042'
          DESTINATION lv_rfcdest
          EXPORTING
            im_usuario = lv_usuario
          IMPORTING
            ex_guid    = lv_guid.

        CLEAR ls_documento_medicao.

        ls_in_documento_medicao-measurement_point = ls_in_documento_medicao-point.
        IF ls_in_documento_medicao-usuario_app IS INITIAL.
          ls_in_documento_medicao-reader = sy-uname.
        ELSE.
          ls_in_documento_medicao-reader = ls_in_documento_medicao-usuario_app.
        ENDIF.
        ls_in_documento_medicao-recorded_value = ls_in_documento_medicao-valor_medido.

        ls_in_documento_medicao-reading_date = ls_in_documento_medicao-data_hora_inicio+6(4) &&
                                               ls_in_documento_medicao-data_hora_inicio+3(2) &&
                                               ls_in_documento_medicao-data_hora_inicio(2).

        ls_in_documento_medicao-reading_time = ls_in_documento_medicao-data_hora_inicio+11(2) &&
                                               ls_in_documento_medicao-data_hora_inicio+14(2) &&
                                               ls_in_documento_medicao-data_hora_inicio+17(2).

        MOVE-CORRESPONDING ls_in_documento_medicao TO ls_documento_medicao.

        REFRESH lt_retorno_doc_med[].

        CALL FUNCTION '/PTLOMS/MF010'
          DESTINATION lv_rfcdest
          IMPORTING
            it_retorno_doc_med   = lt_retorno_doc_med
          CHANGING
            wa_documento_medicao = ls_documento_medicao.

        MOVE-CORRESPONDING ls_documento_medicao TO ls_in_documento_medicao.

        READ TABLE lt_retorno_doc_med TRANSPORTING NO FIELDS WITH KEY type = 'E'.
        IF sy-subrc NE 0.
          ls_in_documento_medicao-deleted = 'X'.
        ENDIF.

        ls_in_documento_medicao-in_retorno_doc_medset = lt_retorno_doc_med.

        copy_data_to_ref(
EXPORTING
  is_data = ls_in_documento_medicao
CHANGING
  cr_data = er_deep_entity ).


      WHEN OTHERS.

    ENDCASE.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'CREATE_DEEP_ENTITY'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


 METHOD /iwbep/if_mgw_appl_srv_runtime~get_expanded_entityset.

   DATA: lv_rfcdest TYPE bdbapidst.

* Declaração busca centro de trabalho
*   TYPES: BEGIN OF ty_hrp,
*            sobid  TYPE sobid,
*            objid  TYPE hrp1001-objid,
*            objid_ TYPE hrp1001-objid,
*          END OF ty_hrp.
*
*   DATA: lt_hrp  TYPE TABLE OF ty_hrp,
*         lt_hrp_ TYPE TABLE OF ty_hrp.

* Declaração IN Notas
   DATA: BEGIN OF t_in_notas.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_nota.
           DATA: in_texto_notaset     TYPE /ptloms/cl_soms_mpc=>tt_in_texto_nota,
           in_item_notaset      TYPE /ptloms/cl_soms_mpc=>tt_in_item_nota,
           in_item_causaset     TYPE /ptloms/cl_soms_mpc=>tt_in_item_causa,
           in_item_atividadeset TYPE /ptloms/cl_soms_mpc=>tt_in_item_atividade,
           in_item_tarefaset    TYPE /ptloms/cl_soms_mpc=>tt_in_item_tarefa,
           in_retornoset        TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
         END OF t_in_notas.
   DATA: lt_in_notas LIKE TABLE OF t_in_notas.

* Declaração IN Notas Ordem
   DATA: BEGIN OF t_in_nota_ordem.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_nota_ordem.
           DATA: in_texto_notaset     TYPE /ptloms/cl_soms_mpc=>tt_in_texto_nota,
           in_item_notaset      TYPE /ptloms/cl_soms_mpc=>tt_in_item_nota,
           in_item_causaset     TYPE /ptloms/cl_soms_mpc=>tt_in_item_causa,
           in_item_atividadeset TYPE /ptloms/cl_soms_mpc=>tt_in_item_atividade,
           in_item_tarefaset    TYPE /ptloms/cl_soms_mpc=>tt_in_item_tarefa,
           in_retornoset        TYPE /ptloms/cl_soms_mpc=>tt_in_retorno,
           in_operacao_ordemset TYPE /ptloms/cl_soms_mpc=>tt_in_operacao_ordem,
         END OF t_in_nota_ordem.
   DATA: lt_in_nota_ordem LIKE TABLE OF t_in_nota_ordem.

* Declaração IN Confirmação
   DATA: BEGIN OF t_in_confirmacao.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_confirmacao.
         DATA: "in_texto_confirmacaoset   TYPE /ptloms/cl_soms_mpc=>tt_in_texto_confirmacao,
                 in_retorno_confirmacaoset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_confirmacao,
               END OF t_in_confirmacao.
   DATA: lt_in_confirmacao LIKE TABLE OF t_in_confirmacao.

* Declaração IN Ordem
   DATA: BEGIN OF t_in_ordem.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_ordem.
           DATA: in_operacao_ordemset TYPE /ptloms/cl_soms_mpc=>tt_in_operacao_ordem,
           in_texto_ordemset    TYPE /ptloms/cl_soms_mpc=>tt_in_texto_ordem,
           in_retorno_ordemset  TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_confirmacao,
         END OF t_in_ordem.
   DATA: lt_in_ordem LIKE TABLE OF t_in_ordem.

* Declaração IN Documento Medição
   DATA: BEGIN OF t_in_documento_medicao.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_documento_medicao.
           DATA: in_retorno_doc_medset TYPE /ptloms/cl_soms_mpc=>tt_in_documento_medicao,
         END OF t_in_documento_medicao.
   DATA: lt_in_documento_medicao LIKE TABLE OF t_in_documento_medicao.

* Declaração IN Operação Ordem INSR
   DATA: BEGIN OF t_in_operacao_ordem_insr.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_operacao_ordem_insr.
           DATA: in_retorno_operacao_insrset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_operacao_insr,
         END OF t_in_operacao_ordem_insr.
   DATA: lt_in_operacao_ordem_insr LIKE TABLE OF t_in_operacao_ordem_insr.

* Declaração IN Componente Ordem
   DATA: BEGIN OF t_in_componente_ordem.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_componente_ordem.
           DATA: in_retorno_componenteset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_componente,
         END OF t_in_componente_ordem.
   DATA: lt_in_componente_ordem LIKE TABLE OF t_in_componente_ordem.

* Declaração IN Finalizar Sesao
   DATA: lt_in_finalizar_sessao TYPE /ptloms/cl_soms_mpc=>tt_in_finalizar_sessao.

* Declaração IN Anexo
   DATA: BEGIN OF t_in_anexo.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_anexo.
           DATA: in_retorno_anexoset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_anexo,
         END OF t_in_anexo.
   DATA: lt_in_anexo LIKE TABLE OF t_in_anexo.

** Declaração IN Componente Ordem INSR
*    DATA: BEGIN OF t_in_componente_ordem_insr.
*            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_componente_ordem_insr.
*    DATA: in_retorno_componente_insrset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_componente_insr,
*          END OF t_in_componente_ordem_insr.
*    DATA: lt_in_componente_ordem_insr LIKE TABLE OF t_in_componente_ordem_insr.
*
** Declaração IN Componente Ordem DELE
*    DATA: BEGIN OF t_in_componente_ordem_dele.
*            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_in_componente_ordem_dele.
*    DATA: in_retorno_componente_deleset TYPE /ptloms/cl_soms_mpc=>tt_in_retorno_componente_dele,
*          END OF t_in_componente_ordem_dele.
*    DATA: lt_in_componente_ordem_dele LIKE TABLE OF t_in_componente_ordem_dele.

* Declaração para Notas
   DATA: BEGIN OF t_out_notas.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_nota.
           DATA: out_notasset            TYPE /ptloms/cl_soms_mpc=>tt_out_notas,
           out_itens_notaset       TYPE /ptloms/cl_soms_mpc=>tt_out_itens_nota,
*          out_textos_notaset      TYPE /ptloms/cl_soms_mpc=>tt_out_textos_nota,
           out_medidas_notaset     TYPE /ptloms/cl_soms_mpc=>tt_out_medidas_nota,
           out_causas_notaset      TYPE /ptloms/cl_soms_mpc=>tt_out_causas_nota,
           out_atividades_notaset  TYPE /ptloms/cl_soms_mpc=>tt_out_atividades_nota,
           out_parceiro_negocioset TYPE /ptloms/cl_soms_mpc=>tt_out_parceiro_negocio,
*          out_imagemset           TYPE /ptloms/cl_soms_mpc=>tt_out_imagem,
*          contentshexset          TYPE /ptloms/cl_soms_mpc=>tt_contentshex,
           out_anexoset            TYPE /ptloms/cl_soms_mpc=>tt_out_anexo,
         END OF t_out_notas.

* Declaração para Usuário
   DATA: BEGIN OF t_out_usuario.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_out_usuario_completo.
           DATA: out_autorizacao_completoset    TYPE /ptloms/cl_soms_mpc=>tt_out_autorizacao_completo,
           out_config_perfil_completoset  TYPE /ptloms/cl_soms_mpc=>tt_out_config_perfil_completo,
           out_config_sistema_completoset TYPE /ptloms/cl_soms_mpc=>tt_out_config_sistema_completo,
         END OF t_out_usuario.
   DATA: lt_out_usuario LIKE TABLE OF t_out_usuario,
         ls_out_usuario LIKE LINE OF lt_out_usuario.

* Declaração Lista Técnica Auxiliar
   DATA: BEGIN OF t_lista_tecnica_aux.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_out_lista_tecnica.
           DATA: out_saldo_materialset TYPE /ptloms/cl_soms_mpc=>tt_out_saldo_material,
         END OF t_lista_tecnica_aux.

* Declaração OUT Programação Ordens
   DATA: BEGIN OF t_filtro.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_out_filtro.
           DATA: out_filtro_valuesset TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_values,
         END OF t_filtro.
   DATA: BEGIN OF t_programacao_ordens.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_programacao_ordens.
           DATA: out_programacao_lista_operset  TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_lista_oper,
           out_filtroset                  LIKE TABLE OF t_filtro,
           out_programacao_operacoes_deta TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_lista_oper,
           out_usuario_associarset        TYPE /ptloms/cl_soms_mpc=>tt_out_usuario_associar,
           out_motivos_desassociarset     TYPE /ptloms/cl_soms_mpc=>tt_out_motivos_desassociar,
           out_programacao_lista_ordemset TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_lista_oper,
         END OF t_programacao_ordens.

* Declaração OUT Programação Usuários
   DATA: BEGIN OF t_programacao_usuarios.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_programacao_usuari.
           DATA: out_programacao_usuariosset TYPE /ptloms/cl_soms_mpc=>tt_out_programacao_usuarios,
         END OF t_programacao_usuarios.

* Declaração para Ordens
   DATA:  BEGIN OF t_out_ordens.
            INCLUDE  TYPE  /ptloms/cl_soms_mpc=>ts_out_ordem.
            DATA: out_componentes_ordemset       TYPE /ptloms/cl_soms_mpc=>tt_out_componentes_ordem,
            out_operacoes_ordemset         TYPE /ptloms/cl_soms_mpc=>tt_out_operacoes_ordem,
            out_confirmacaoset             TYPE /ptloms/cl_soms_mpc=>tt_out_confirmacao,
*          out_textos_ordemset      TYPE /ptloms/cl_soms_mpc=>tt_out_textos_ordem,
            out_parceiro_negocioset        TYPE /ptloms/cl_soms_mpc=>tt_out_parceiro_negocio,
            out_lista_tecnicaset           LIKE TABLE OF t_lista_tecnica_aux, "TYPE /ptloms/cl_soms_mpc=>tt_out_lista_tecnica,
*          contentshexset           TYPE /ptloms/cl_soms_mpc=>tt_contentshex,
            out_anexoset                   TYPE /ptloms/cl_soms_mpc=>tt_out_anexo,
            out_filtro_op_status_mobileset TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_op_status_mobile,
            out_filtro_op_operacaoset      TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_op_operacao,
            out_filtro_op_empregadoset     TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_op_empregado,
            out_filtro_op_centro_trabset   TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_op_centro_trab,
          END OF t_out_ordens.

   DATA:  BEGIN OF t_expand_so.
            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_ordem.
            DATA: out_ordemset                   LIKE TABLE OF t_out_ordens,
            out_filtro_centro_trabalhoset  TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_centro_trabalho,
            out_filtro_codigo_abcset       TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_codigo_abc,
            out_filtro_equipamentoset      TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_equipamento,
            out_filtro_fim_baseset         TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_fim_base,
            out_filtro_inicio_baseset      TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_inicio_base,
            out_filtro_local_instalacaoset TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_local_instalacao,
            out_filtro_notaset             TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_nota,
            out_filtro_ordemset            TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_ordem,
            out_filtro_plano_manutencaoset TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_plano_manutencao,
            out_filtro_tipo_ordemset       TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_tipo_ordem,
            out_filtro_grupo_planset       TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_grupo_plan,
            out_filtro_tp_atvd_manunset    TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_tp_atvd_manun,
          END OF t_expand_so.

* Declaração para Estoque de Materiais
   DATA:  BEGIN OF t_out_estoque_material.
            INCLUDE  TYPE  /ptloms/cl_soms_mpc=>ts_out_estoque_material.
            DATA: out_saldo_materialset TYPE /ptloms/cl_soms_mpc=>tt_out_saldo_material,
          END OF t_out_estoque_material.
   DATA: lt_out_estoque_material LIKE TABLE OF t_out_estoque_material.

   DATA: lt_expand_so LIKE TABLE OF t_expand_so,
         ls_expand_so LIKE LINE OF lt_expand_so,
         lt_ordemset  LIKE TABLE OF t_out_ordens,
         ls_ordemset  LIKE LINE OF lt_ordemset.

** Declaração para Ordens (OBSOLETO)
*    DATA: BEGIN OF t_out_ordens.
*            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_ordem.
*    DATA: out_ordemset             TYPE /ptloms/cl_soms_mpc=>tt_out_ordem,
*          out_textos_ordemset      TYPE /ptloms/cl_soms_mpc=>tt_out_textos_ordem,
*          out_operacoes_ordemset   TYPE /ptloms/cl_soms_mpc=>tt_out_operacoes_ordem,
*          out_componentes_ordemset TYPE /ptloms/cl_soms_mpc=>tt_out_componentes_ordem,
*          out_parceiro_negocioset  TYPE /ptloms/cl_soms_mpc=>tt_out_parceiro_negocio,
*          END OF t_out_ordens.

* Declaração para Local de Instalação
   DATA: BEGIN OF t_out_local_instalacao.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_local_instalacao.
           DATA: out_local_instalacaoset      TYPE /ptloms/cl_soms_mpc=>tt_out_local_instalacao,
           out_classe_caracteristicaset TYPE /ptloms/cl_soms_mpc=>tt_out_classe_caracteristica,
           out_catalogoset              TYPE /ptloms/cl_soms_mpc=>tt_out_catalogo,
           out_ponto_medicaoset         TYPE /ptloms/cl_soms_mpc=>tt_out_ponto_medicao,
           out_documento_medicaoset     TYPE /ptloms/cl_soms_mpc=>tt_out_documento_medicao,
           out_parceiro_negocioset      TYPE /ptloms/cl_soms_mpc=>tt_out_parceiro_negocio,
*          out_lista_tecnica_equiset     TYPE /ptloms/cl_soms_mpc=>tt_out_lista_tecnica_equi,
*          out_lista_tecnica_matset      TYPE /ptloms/cl_soms_mpc=>tt_out_lista_tecnica_mat,
*          out_lista_tecnica_loc_instset TYPE /ptloms/cl_soms_mpc=>tt_out_lista_tecnica_loc_inst,
           out_lista_tecnicaset         LIKE TABLE OF t_lista_tecnica_aux, "TYPE /ptloms/cl_soms_mpc=>tt_out_lista_tecnica,
         END OF t_out_local_instalacao.

* Declaração para Equipamento
   DATA: BEGIN OF t_out_equipamento.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_equipamento.
           DATA: out_equipamentoset           TYPE /ptloms/cl_soms_mpc=>tt_out_equipamento,
           out_classe_caracteristicaset TYPE /ptloms/cl_soms_mpc=>tt_out_classe_caracteristica,
           out_catalogoset              TYPE /ptloms/cl_soms_mpc=>tt_out_catalogo,
           out_ponto_medicaoset         TYPE /ptloms/cl_soms_mpc=>tt_out_ponto_medicao,
           out_documento_medicaoset     TYPE /ptloms/cl_soms_mpc=>tt_out_documento_medicao,
           out_parceiro_negocioset      TYPE /ptloms/cl_soms_mpc=>tt_out_parceiro_negocio,
*          out_lista_tecnica_equiset    TYPE /ptloms/cl_soms_mpc=>tt_out_lista_tecnica_equi,
           out_lista_tecnicaset         LIKE TABLE OF t_lista_tecnica_aux, "TYPE /ptloms/cl_soms_mpc=>tt_out_lista_tecnica,
           out_filtro_equnrset          TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_equnr,
           out_filtro_eqktxset          TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_eqktx,
           out_filtro_invnrset          TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_invnr,
           out_filtro_tidnrset          TYPE /ptloms/cl_soms_mpc=>tt_out_filtro_tidnr,
         END OF t_out_equipamento.

* Declaração para Material
*    DATA: BEGIN OF t_out_material.
*            INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_material.
*    DATA: out_materialset TYPE /ptloms/cl_soms_mpc=>tt_out_material,
*          END OF t_out_material.

   DATA: BEGIN OF t_out_material_aux.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_out_material.
         DATA: "out_estoque_materialset TYPE /ptloms/cl_soms_mpc=>tt_out_estoque_material, "LIKE TABLE OF t_out_estoque_material,
                 out_saldo_materialset TYPE /ptloms/cl_soms_mpc=>tt_out_saldo_material,
               END OF t_out_material_aux.

   DATA: BEGIN OF t_out_material.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_material.
           DATA: out_materialset LIKE TABLE OF t_out_material_aux,
         END OF t_out_material.

* Declaração para Dados Mestres
   DATA: BEGIN OF t_out_demais_dados_mestres.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_demais_dados_mestr.
           DATA: out_empresa_centroset          TYPE /ptloms/cl_soms_mpc=>tt_out_empresa_centro,
           out_grupo_planejamentoset      TYPE /ptloms/cl_soms_mpc=>tt_out_grupo_planejamento,
           out_area_operacionalset        TYPE /ptloms/cl_soms_mpc=>tt_out_area_operacional,
           out_centro_trabalhoset         TYPE /ptloms/cl_soms_mpc=>tt_out_centro_trabalho,
           out_tipo_notaset               TYPE /ptloms/cl_soms_mpc=>tt_out_tipo_nota,
           out_tipo_ordemset              TYPE /ptloms/cl_soms_mpc=>tt_out_tipo_ordem,
           out_tipo_prioridade_ordemset   TYPE /ptloms/cl_soms_mpc=>tt_out_tipo_prioridade_ordem,
           out_tipo_prioridade_notaset    TYPE /ptloms/cl_soms_mpc=>tt_out_tipo_prioridade_nota,
           out_tipo_atv_manutencaoset     TYPE /ptloms/cl_soms_mpc=>tt_out_tipo_atv_manutencao,
           out_centro_custoset            TYPE /ptloms/cl_soms_mpc=>tt_out_centro_custo,
           out_condicao_inst_ordemset     TYPE /ptloms/cl_soms_mpc=>tt_out_condicao_inst_ordem,
           out_tipo_atv_operacaoset       TYPE /ptloms/cl_soms_mpc=>tt_out_tipo_atv_operacao,
           out_tipo_materialset           TYPE /ptloms/cl_soms_mpc=>tt_out_tipo_material,
           out_categoria_item_materialset TYPE /ptloms/cl_soms_mpc=>tt_out_categoria_item_material,
           out_depositoset                TYPE /ptloms/cl_soms_mpc=>tt_out_deposito,
           out_categoria_equipamentoset   TYPE /ptloms/cl_soms_mpc=>tt_out_categoria_equipamento,
           out_tipo_objetoset             TYPE /ptloms/cl_soms_mpc=>tt_out_tipo_objeto,
           out_categoria_loc_instset      TYPE /ptloms/cl_soms_mpc=>tt_out_categoria_loc_inst,
           out_tipo_atv_ordemset          TYPE /ptloms/cl_soms_mpc=>tt_out_tipo_atv_ordem,
           out_causa_desvioset            TYPE /ptloms/cl_soms_mpc=>tt_out_causa_desvio,
           out_matriculaset               TYPE /ptloms/cl_soms_mpc=>tt_out_matricula,
           out_chave_modeloset            TYPE /ptloms/cl_soms_mpc=>tt_out_chave_modelo,
           out_centro_planejamentoset     TYPE /ptloms/cl_soms_mpc=>tt_out_centro_planejamento,
         END OF t_out_demais_dados_mestres.

* Declaração para Horas Planejada/Realizada
   DATA: BEGIN OF t_out_horas_plan_real.
           INCLUDE TYPE /ptloms/cl_soms_mpc=>ts_root_out_horas_plan_real.
           DATA: out_horas_plan_realset TYPE /ptloms/cl_soms_mpc=>tt_out_horas_plan_real,
         END OF t_out_horas_plan_real.

   DATA: rt_objek     TYPE /iwbep/t_cod_select_options,
         rt_rbnr      TYPE /iwbep/t_cod_select_options,
         rt_objnr     TYPE /iwbep/t_cod_select_options,
         rt_point     TYPE /iwbep/t_cod_select_options,
         rt_tplnr     TYPE /iwbep/t_cod_select_options,
         rt_equnr     TYPE /iwbep/t_cod_select_options,
         rt_matnr     TYPE /iwbep/t_cod_select_options,
         rt_werks     TYPE /iwbep/t_cod_select_options,
         rt_lgort_aux TYPE /iwbep/t_cod_select_options.

   DATA: ls_objek LIKE LINE OF rt_objek,
         ls_rbnr  LIKE LINE OF rt_rbnr,
         ls_objnr LIKE LINE OF rt_objnr,
         ls_point LIKE LINE OF rt_point,
         ls_tplnr LIKE LINE OF rt_tplnr,
         ls_equnr LIKE LINE OF rt_equnr,
         ls_matnr LIKE LINE OF rt_matnr,
         ls_werks LIKE LINE OF rt_werks.

   DATA: lt_out_notas                   LIKE TABLE OF t_out_notas,
         lt_out_local_instalacao        LIKE TABLE OF t_out_local_instalacao,
         lt_out_equipamento             LIKE TABLE OF t_out_equipamento,
         lt_out_material                LIKE TABLE OF t_out_material,
*          lt_out_ordem                LIKE TABLE OF t_out_ordens,
         lt_out_demais_dados_mestres    LIKE TABLE OF t_out_demais_dados_mestres,
         lt_out_horas_plan_real         LIKE TABLE OF t_out_horas_plan_real,
         lt_programacao_ordens          LIKE TABLE OF t_programacao_ordens,
         lt_programacao_usuarios        LIKE TABLE OF t_programacao_usuarios,
         lt_despacho                    TYPE /ptloms/ct079,
         lt_filtro                      TYPE /ptloms/ct103,
         lt_despacho_tree               TYPE /ptloms/ct080,
         lt_notas                       TYPE /ptloms/ct021,
         lt_itens_nota                  TYPE /ptloms/ct022,
         lt_textos_nota                 TYPE /ptloms/ct023,
         lt_medidas_nota                TYPE /ptloms/ct024,
         lt_causas_nota                 TYPE /ptloms/ct025,
         lt_atividades_nota             TYPE /ptloms/ct026,
         lt_caracteristicas             TYPE /ptloms/ct001,
         lt_catalogos                   TYPE /ptloms/ct002,
         lt_ponto_medicao               TYPE /ptloms/ct003,
         lt_documento_medicao           TYPE /ptloms/ct004,
         lt_parceiro_negocio            TYPE /ptloms/ct005,
         lt_lista_tecnica_equi          TYPE /ptloms/ct031,
         lt_lista_tecnica_loc_inst      TYPE /ptloms/ct032,
         lt_lista_tecnica_mat           TYPE /ptloms/ct033,
         lt_ordens                      TYPE /ptloms/ct036,
         lt_textos_ordem                TYPE /ptloms/ct037,
         lt_operacoes_ordem             TYPE /ptloms/ct038,
         lt_componentes_ordem           TYPE /ptloms/ct039,
         lt_confirmacao                 TYPE /ptloms/ct075,
         lt_empresa_centro              TYPE /ptloms/ct006,
         lt_grupo_planejamento          TYPE /ptloms/ct007,
         lt_area_operacional            TYPE /ptloms/ct008,
         lt_centro_trabalho             TYPE /ptloms/ct009,
         lt_centro_planejamento         TYPE /ptloms/ct111,
         lt_tipo_nota                   TYPE /ptloms/ct010,
         lt_tipo_ordem                  TYPE /ptloms/ct011,
         lt_tipo_prioridade_ordem       TYPE /ptloms/ct012,
         lt_tipo_prioridade_nota        TYPE /ptloms/ct013,
         lt_tipo_atv_manutencao         TYPE /ptloms/ct014,
         lt_centro_custo                TYPE /ptloms/ct015,
         lt_condicao_inst_ordem         TYPE /ptloms/ct016,
         lt_tipo_atv_operacao           TYPE /ptloms/ct017,
         lt_tipo_material               TYPE /ptloms/ct027,
         lt_categoria_item_material     TYPE /ptloms/ct028,
         lt_deposito                    TYPE /ptloms/ct029,
         lt_categoria_equipamento       TYPE /ptloms/ct034,
         lt_tipo_objeto                 TYPE /ptloms/ct035,
         lt_categoria_loc_inst          TYPE /ptloms/ct040,
         lt_equipamento                 TYPE /ptloms/ct019,
         lt_imagens_equipamento         TYPE /ptloms/ct072,
         lt_local_inst                  TYPE /ptloms/ct018,
         lt_tipo_atv_ordem              TYPE /ptloms/ct049,
         lt_lista_tecnica               TYPE /ptloms/ct054,
         lt_imagens_local_inst          TYPE /ptloms/ct072,
         lt_imagens_nota                TYPE /ptloms/ct072,
         lt_imagens_ordem               TYPE /ptloms/ct072,
         lt_filtro_ordem                TYPE /ptloms/ct056,
         lt_filtro_nota                 TYPE /ptloms/ct056,
         lt_filtro_tipo_ordem           TYPE /ptloms/ct056,
         lt_filtro_inicio_base          TYPE /ptloms/ct056,
         lt_filtro_fim_base             TYPE /ptloms/ct056,
         lt_filtro_local_instalacao     TYPE /ptloms/ct056,
         lt_filtro_equipamento          TYPE /ptloms/ct056,
         lt_filtro_grupo_planejamento   TYPE /ptloms/ct056,
         lt_filtro_centro_trabalho      TYPE /ptloms/ct056,
         lt_filtro_codigo_abc           TYPE /ptloms/ct056,
         lt_filtro_plano_manutencao     TYPE /ptloms/ct056,
         lt_filtro_ciclo                TYPE /ptloms/ct056,
         lt_filtro_tipo_atvd_manutencao TYPE /ptloms/ct056,
         lt_prioridade                  TYPE /ptloms/ct112,
*          lt_filtro_op_status_mobile     TYPE /ptloms/ct056,
*          lt_filtro_op_operacao          TYPE /ptloms/ct056,
*          lt_filtro_op_sub_operacao      TYPE /ptloms/ct056,
*          lt_filtro_op_empregado         TYPE /ptloms/ct056,
*          lt_filtro_op_centro_trabalho   TYPE /ptloms/ct056,
         lt_filtro_equnr                TYPE /ptloms/ct056,
         lt_filtro_eqktx                TYPE /ptloms/ct056,
         lt_filtro_invnr                TYPE /ptloms/ct056,
         lt_filtro_tidnr                TYPE /ptloms/ct056,
         lt_saldo_material              TYPE /ptloms/ct064,
         lt_horas_plan_rel              TYPE /ptloms/ct070,
         lt_causa_desvio                TYPE /ptloms/ct066,
         lt_matricula                   TYPE /ptloms/ct073,
         lt_chave_modelo                TYPE /ptloms/ct085,
         lt_material                    TYPE /ptloms/ct030.

   DATA: ls_lista_tecnica       LIKE LINE OF lt_lista_tecnica,
         ls_programaca_ordens   LIKE LINE OF lt_programacao_ordens,
         ls_programaca_usuarios LIKE LINE OF lt_programacao_usuarios.

   DATA: ls_out_notas                LIKE t_out_notas,
         ls_out_local_instalacao     LIKE t_out_local_instalacao,
         ls_out_equipamento          LIKE t_out_equipamento,
         ls_out_material             LIKE t_out_material,
*          ls_out_ordem                LIKE t_out_ordens,
         ls_out_demais_dados_mestres LIKE t_out_demais_dados_mestres,
         ls_out_horas_plan_real      LIKE t_out_horas_plan_real,
         ls_out_estoque_material     LIKE t_out_estoque_material,
         ls_usuario                  TYPE /iwbep/s_cod_select_option,
         ls_out_materialset          LIKE LINE OF ls_out_material-out_materialset,
         ls_lista_tecnicaset         LIKE LINE OF ls_ordemset-out_lista_tecnicaset,
         ls_lista_tecnica_loclset    LIKE LINE OF ls_out_local_instalacao-out_lista_tecnicaset,
         ls_lista_tecnica_equiset    LIKE LINE OF ls_out_equipamento-out_lista_tecnicaset.

   DATA: lv_empresa_centro          TYPE char1,
         lv_grupo_planejamento      TYPE char1,
         lv_area_operacional        TYPE char1,
         lv_centro_trabalho         TYPE char1,
         lv_centro_planejamento     TYPE char1,
         lv_tipo_nota               TYPE char1,
         lv_tipo_ordem              TYPE char1,
         lv_tipo_prioridade_ordem   TYPE char1,
         lv_tipo_prioridade_nota    TYPE char1,
         lv_tipo_atv_manutencao     TYPE char1,
         lv_centro_custo            TYPE char1,
         lv_condicao_inst_ordem     TYPE char1,
         lv_tipo_atv_operacao       TYPE char1,
         lv_tipo_material           TYPE char1,
         lv_categoria_item_material TYPE char1,
         lv_deposito                TYPE char1,
         lv_categoria_equipamento   TYPE char1,
         lv_tipo_objeto             TYPE char1,
         lv_categoria_loc_inst      TYPE char1,
         lv_tipo_atv_ordem          TYPE char1,
         lv_causa_desvio            TYPE char1,
         lv_matricula               TYPE char1,
         lv_chave_modelo            TYPE char1,
         lv_prioridade              TYPE char1,
         lv_data                    TYPE sy-datum,
         lv_hora                    TYPE sy-uzeit,
         lv_submt                   TYPE /ptloms/ed100,
         lv_iwerk                   TYPE /ptloms/ed101,
         lv_equipamento_out         TYPE char18,
         lv_equipamento_in          TYPE char18,
         lv_usuario_sap             TYPE flag,
         lv_senha                   TYPE char32,
         lv_confsenha               TYPE char32,
         lv_autenticado             TYPE char1,
         lv_senha_alterada          TYPE char1,
         lv_perfil                  TYPE c LENGTH 10,
         lv_top                     TYPE int4,
         lv_skip                    TYPE int4,
         lv_quantidade_equipamento  TYPE int4,
         lv_quantidade_local_inst   TYPE int4,
         lv_quantidade_material     TYPE int4,
         lv_quantidade_ordem        TYPE int4,
         lv_quantidade_registros    TYPE int4,
         lv_ismnw                   TYPE p DECIMALS 1,
         lv_arbei                   TYPE p DECIMALS 1.

   DATA: lt_dados_usuario_app    TYPE /ptloms/ct101,
         lt_autorizacao          TYPE /ptloms/ct076,
         ls_autorizacao          LIKE LINE OF ls_out_usuario-out_autorizacao_completoset,
         lt_configuracao_sistema TYPE /ptloms/ct074,
         ls_configuracao_sistema LIKE LINE OF ls_out_usuario-out_config_sistema_completoset,
         lt_configuracao         TYPE /ptloms/ct078,
         ls_configuracao         LIKE LINE OF ls_out_usuario-out_config_perfil_completoset,
         ls_filtro               LIKE LINE OF ls_programaca_ordens-out_filtroset.

* Variável para retornar texto de exceção
   DATA: lv_mensagem  TYPE bapi_msg,
         lv_same_user TYPE rfcdisplay-rfcsameusr..

* Variáveis para controle da sessão
   DATA: lv_guid    TYPE char32,
         lv_usuario TYPE xubname.

   DATA: lv_msgv1(50) TYPE c,
         lv_msgv2(50) TYPE c,
         lv_subrc     TYPE sy-subrc.

   DATA: ls_controle TYPE /ptloms/tb048.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
         CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
       ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

*  Autenticação
   READ TABLE it_filter_select_options INTO DATA(ls_usuarioapp) WITH KEY property = 'UsuarioApp'.
   IF sy-subrc = 0.
     DATA(rt_usuario_app) = ls_usuarioapp-select_options.
   ENDIF.

   IF rt_usuario_app[] IS INITIAL.
     ls_usuario-sign   = 'I'.
     ls_usuario-option = 'EQ'.
     ls_usuario-low = sy-uname.
     APPEND ls_usuario TO rt_usuario_app.
   ENDIF.

   READ TABLE rt_usuario_app INTO DATA(ls_usuario_app_aux) INDEX 1.

   READ TABLE it_filter_select_options INTO DATA(ls_guid) WITH KEY property = 'Guid'.
   IF sy-subrc = 0.
     DATA(rt_guid) = ls_guid-select_options.
   ENDIF.

   READ TABLE rt_guid INTO DATA(ls_guid_aux) INDEX 1.

   IF ls_usuario_app_aux-low IS NOT INITIAL.
     lv_usuario = ls_usuario_app_aux-low.
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
*    lv_usuario = /ptloms/cl006=>busca_usuario( lv_usuario ).

   CALL FUNCTION '/PTLOMS/MF042'
     DESTINATION lv_rfcdest
     EXPORTING
       im_usuario = lv_usuario
     IMPORTING
       ex_guid    = lv_guid.
*    o_sessao->busca_sessao( EXPORTING im_usuario = lv_usuario
*                            IMPORTING ex_guid    = lv_guid ).

   CASE iv_entity_name.

     WHEN 'in_nota_ordem'.
       copy_data_to_ref( EXPORTING is_data = lt_in_nota_ordem CHANGING cr_data = er_entityset ).

     WHEN 'in_nota'.
       copy_data_to_ref( EXPORTING is_data = lt_in_notas CHANGING cr_data = er_entityset ).

     WHEN 'in_confirmacao'.
       copy_data_to_ref( EXPORTING is_data = lt_in_confirmacao CHANGING cr_data = er_entityset ).

     WHEN 'in_ordem'.
       copy_data_to_ref( EXPORTING is_data = lt_in_ordem CHANGING cr_data = er_entityset ).

     WHEN 'in_documento_medicao'.
       copy_data_to_ref( EXPORTING is_data = lt_in_documento_medicao CHANGING cr_data = er_entityset ).

     WHEN 'in_operacao_ordem_insr'.
       copy_data_to_ref( EXPORTING is_data = lt_in_operacao_ordem_insr CHANGING cr_data = er_entityset ).

     WHEN 'in_componente_ordem'.
       copy_data_to_ref( EXPORTING is_data = lt_in_componente_ordem CHANGING cr_data = er_entityset ).

     WHEN 'in_finalizar_sessao'.
       copy_data_to_ref( EXPORTING is_data = lt_in_finalizar_sessao CHANGING cr_data = er_entityset ).

     WHEN 'in_anexo'.
       copy_data_to_ref( EXPORTING is_data = lt_in_anexo CHANGING cr_data = er_entityset ).

*      WHEN 'in_componente_ordem_insr'.
*        copy_data_to_ref( EXPORTING is_data = lt_in_componente_ordem_insr CHANGING cr_data = er_entityset ).
*
*      WHEN 'in_componente_ordem_dele'.
*        copy_data_to_ref( EXPORTING is_data = lt_in_componente_ordem_dele CHANGING cr_data = er_entityset ).

     WHEN 'root_out_horas_plan_real'.

** Autenticação - Início
*        IF lv_guid IS INITIAL OR lv_guid NE ls_guid_aux-low.
*          lv_mensagem = 'Favor iniciar uma nova sessão'.
*
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              textid  = /iwbep/cx_mgw_busi_exception=>business_error
*              message = lv_mensagem.
*        ENDIF.
** Autenticação - Fim

       " Carrega filtros
       IF it_filter_select_options[] IS NOT INITIAL.
         READ TABLE it_filter_select_options INTO DATA(ls_data) WITH KEY property = 'Data'.
         IF sy-subrc = 0.
           DATA(rt_data) = ls_data-select_options.
         ENDIF.
       ENDIF.

       CALL FUNCTION '/PTLOMS/MF033'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_usuario_app    = rt_usuario_app
           rt_data           = rt_data
         IMPORTING
           it_horas_plan_rel = lt_horas_plan_rel.
*        o_oms->out_horas_plan_real(
*          EXPORTING
*            rt_usuario_app    = rt_usuario_app
*            rt_data           = rt_data
*          IMPORTING
*            et_horas_plan_rel = lt_horas_plan_rel ).

       ls_out_horas_plan_real-out_horas_plan_realset = lt_horas_plan_rel.
       APPEND ls_out_horas_plan_real TO lt_out_horas_plan_real.

       copy_data_to_ref( EXPORTING is_data = lt_out_horas_plan_real CHANGING cr_data = er_entityset ).

     WHEN 'root_out_nota'.

** Autenticação - Início
*        IF lv_guid IS INITIAL OR lv_guid NE ls_guid_aux-low.
*          lv_mensagem = 'Favor iniciar uma nova sessão'.
*
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              textid  = /iwbep/cx_mgw_busi_exception=>business_error
*              message = lv_mensagem.
*        ENDIF.
** Autenticação - Fim

       " Carrega filtros
       IF it_filter_select_options[] IS NOT INITIAL.
         READ TABLE it_filter_select_options INTO DATA(ls_qmnum) WITH KEY property = 'Qmnum'.
         IF sy-subrc = 0.
           DATA(rt_qmnum) = ls_qmnum-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_qmart) WITH KEY property = 'Qmart'.
         IF sy-subrc = 0.
           DATA(rt_qmart) = ls_qmart-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_iwerk) WITH KEY property = 'Iwerk'.
         IF sy-subrc = 0.
           DATA(rt_iwerk) = ls_iwerk-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_ingrp) WITH KEY property = 'Ingrp'.
         IF sy-subrc = 0.
           DATA(rt_ingrp) = ls_ingrp-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_beber) WITH KEY property = 'Beber'.
         IF sy-subrc = 0.
           DATA(rt_beber) = ls_beber-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_arbpl) WITH KEY property = 'Arbpl'.
         IF sy-subrc = 0.
           DATA(rt_arbpl) = ls_arbpl-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_parnr) WITH KEY property = 'Parnr'.
         IF sy-subrc = 0.
           DATA(rt_parnr) = ls_parnr-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_eqfnr) WITH KEY property = 'Eqfnr'.
         IF sy-subrc = 0.
           DATA(rt_eqfnr) = ls_eqfnr-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_strmn) WITH KEY property = 'Strmn'.
         IF sy-subrc = 0.
           DATA(rt_strmn) = ls_strmn-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_sttxt) WITH KEY property = 'Sttxt'.
         IF sy-subrc = 0.
           DATA(rt_sttxt) = ls_sttxt-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_astex) WITH KEY property = 'Astex'.
         IF sy-subrc = 0.
           DATA(rt_astex) = ls_astex-select_options.
         ENDIF.

       ENDIF.

       CALL FUNCTION '/PTLOMS/MF027'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_qmnum           = rt_qmnum
           rt_qmart           = rt_qmart
           rt_iwerk           = rt_iwerk
           rt_ingrp           = rt_ingrp
           rt_beber           = rt_beber
           rt_arbpl           = rt_arbpl
           rt_parnr           = rt_parnr
           rt_eqfnr           = rt_eqfnr
           rt_strmn           = rt_strmn
           rt_sttxt           = rt_sttxt
           rt_astex           = rt_astex
         IMPORTING
           it_notas           = lt_notas
           it_itens_nota      = lt_itens_nota
           it_textos_nota     = lt_textos_nota
           it_medidas_nota    = lt_medidas_nota
           it_causas_nota     = lt_causas_nota
           it_atividades_nota = lt_atividades_nota
           it_imagens_nota    = lt_imagens_nota.

*        o_oms->out_nota(
*          EXPORTING
*            rt_qmnum           = rt_qmnum
*            rt_qmart           = rt_qmart
*            rt_iwerk           = rt_iwerk
*            rt_ingrp           = rt_ingrp
*            rt_beber           = rt_beber
*            rt_arbpl           = rt_arbpl
*            rt_parnr           = rt_parnr
*            rt_eqfnr           = rt_eqfnr
*            rt_strmn           = rt_strmn
*            rt_sttxt           = rt_sttxt
*            rt_astex           = rt_astex
*          IMPORTING
*            et_notas           = lt_notas
*            et_itens_nota      = lt_itens_nota
*            et_textos_nota     = lt_textos_nota
*            et_medidas_nota    = lt_medidas_nota
*            et_causas_nota     = lt_causas_nota
*            et_atividades_nota = lt_atividades_nota
*            et_imagems_nota    = lt_imagens_nota ).

       ls_out_notas-out_notasset           = lt_notas.
       ls_out_notas-out_itens_notaset      = lt_itens_nota.
*        ls_out_notas-out_textos_notaset     = lt_textos_nota.
       ls_out_notas-out_medidas_notaset    = lt_medidas_nota.
       ls_out_notas-out_causas_notaset     = lt_causas_nota.
       ls_out_notas-out_atividades_notaset = lt_atividades_nota.
*        ls_out_notas-out_imagemset          = lt_imagens_nota.

*        LOOP AT lt_imagens_nota INTO DATA(ls_imagens_nota).
*          ls_out_notas-contentshexset = ls_imagens_nota-contents_hex.
*        ENDLOOP.

       LOOP AT lt_notas INTO DATA(ls_notas).
         " Filtro para método out_ponto_medicao e parceiro de negocio
         CLEAR ls_objnr.
         ls_objnr-sign = 'I'.
         ls_objnr-option = 'EQ'.
         ls_objnr-low = ls_notas-objnr.
         APPEND ls_objnr TO rt_objnr.
       ENDLOOP.

       CALL FUNCTION '/PTLOMS/MF022'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_objnr            = rt_objnr
         IMPORTING
           it_parceiro_negocio = lt_parceiro_negocio.
*        lt_parceiro_negocio = o_oms->out_parceiro_negocio( rt_objnr = rt_objnr ).

       ls_out_notas-out_parceiro_negocioset = lt_parceiro_negocio.

* Retira zeros a esquerda da nota e ordem
       LOOP AT ls_out_notas-out_notasset ASSIGNING FIELD-SYMBOL(<fs_out_notasset>).
         <fs_out_notasset>-notif_no = |{ <fs_out_notasset>-notif_no ALPHA = OUT }|.
         <fs_out_notasset>-orderid  = |{ <fs_out_notasset>-orderid ALPHA = OUT }|.
       ENDLOOP.
       LOOP AT ls_out_notas-out_itens_notaset ASSIGNING FIELD-SYMBOL(<fs_out_itens_notaset>).
         <fs_out_itens_notaset>-notif_no = |{ <fs_out_itens_notaset>-notif_no ALPHA = OUT }|.
       ENDLOOP.
       LOOP AT ls_out_notas-out_medidas_notaset ASSIGNING FIELD-SYMBOL(<fs_out_medidas_notaset>).
         <fs_out_medidas_notaset>-notif_no = |{ <fs_out_medidas_notaset>-notif_no ALPHA = OUT }|.
       ENDLOOP.
       LOOP AT ls_out_notas-out_causas_notaset ASSIGNING FIELD-SYMBOL(<fs_out_causas_notaset>).
         <fs_out_causas_notaset>-notif_no = |{ <fs_out_causas_notaset>-notif_no ALPHA = OUT }|.
       ENDLOOP.
       LOOP AT ls_out_notas-out_atividades_notaset ASSIGNING FIELD-SYMBOL(<fs_out_atividades_notaset>).
         <fs_out_atividades_notaset>-notif_no = |{ <fs_out_atividades_notaset>-notif_no ALPHA = OUT }|.
       ENDLOOP.

       APPEND ls_out_notas TO lt_out_notas.
       copy_data_to_ref( EXPORTING is_data = lt_out_notas CHANGING cr_data = er_entityset ).

     WHEN 'root_out_ordem'.

** Autenticação - Início
*        IF lv_guid IS INITIAL OR lv_guid NE ls_guid_aux-low.
*          lv_mensagem = 'Favor iniciar uma nova sessão'.
*
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              textid  = /iwbep/cx_mgw_busi_exception=>business_error
*              message = lv_mensagem.
*        ENDIF.
** Autenticação - Fim

       " Carrega filtros
       IF it_filter_select_options[] IS NOT INITIAL.
         READ TABLE it_filter_select_options INTO DATA(ls_aufnr) WITH KEY property = 'Aufnr'.
         IF sy-subrc = 0.
           DATA(rt_aufnr) = ls_aufnr-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_auart) WITH KEY property = 'Auart'.
         IF sy-subrc = 0.
           DATA(rt_auart) = ls_auart-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_iwerk WITH KEY property = 'Iwerk'.
         IF sy-subrc = 0.
           rt_iwerk = ls_iwerk-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_ingpr) WITH KEY property = 'Ingpr'.
         IF sy-subrc = 0.
           DATA(rt_ingpr) = ls_ingpr-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_beber WITH KEY property = 'Beber'.
         IF sy-subrc = 0.
           rt_beber = ls_beber-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_arbpl WITH KEY property = 'Arbpl'.
         IF sy-subrc = 0.
           rt_arbpl = ls_arbpl-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_parnr WITH KEY property = 'Parnr'.
         IF sy-subrc = 0.
           rt_parnr = ls_parnr-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_eqfnr WITH KEY property = 'Eqfnr'.
         IF sy-subrc = 0.
           rt_eqfnr = ls_eqfnr-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_gstrp) WITH KEY property = 'Gstrp'.
         IF sy-subrc = 0.
           DATA(rt_gstrp) = ls_gstrp-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_sttxt WITH KEY property = 'Sttxt'.
         IF sy-subrc = 0.
           rt_sttxt = ls_sttxt-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_asttx) WITH KEY property = 'Asttx'.
         IF sy-subrc = 0.
           DATA(rt_asttx) = ls_astex-select_options.
         ENDIF.

*          READ TABLE it_filter_select_options INTO DATA(ls_usuario_app) WITH KEY property = 'UsuarioApp'.
*          IF sy-subrc = 0.
*            DATA(rt_usuario_app) = ls_usuario_app-select_options.
*          ENDIF.

       ENDIF.

       lv_top  = is_paging-top.
       lv_skip = is_paging-skip.

       CLEAR lv_quantidade_ordem.
       CALL FUNCTION '/PTLOMS/MF030'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_aufnr                       = rt_aufnr
           rt_auart                       = rt_auart
           rt_iwerk                       = rt_iwerk
           rt_ingpr                       = rt_ingpr
           rt_beber                       = rt_beber
           rt_arbpl                       = rt_arbpl
           rt_parnr                       = rt_parnr
           rt_eqfnr                       = rt_eqfnr
           rt_gstrp                       = rt_gstrp
           rt_sttxt                       = rt_sttxt
           rt_asttx                       = rt_asttx
           rt_usuario_app                 = rt_usuario_app
           im_top                         = lv_top
           im_skip                        = lv_skip
         IMPORTING
           it_ordens                      = lt_ordens
           it_textos_ordem                = lt_textos_ordem
           it_operacoes_ordem             = lt_operacoes_ordem
           it_componentes_ordem           = lt_componentes_ordem
           it_confirmacoes                = lt_confirmacao
           it_imagens_ordem               = lt_imagens_ordem
           it_filtro_ordem                = lt_filtro_ordem
           it_filtro_nota                 = lt_filtro_nota
           it_filtro_tipo_ordem           = lt_filtro_tipo_ordem
           it_filtro_inicio_base          = lt_filtro_inicio_base
           it_filtro_fim_base             = lt_filtro_fim_base
           it_filtro_local_instalacao     = lt_filtro_local_instalacao
           it_filtro_equipamento          = lt_filtro_equipamento
           it_filtro_grupo_planejamento   = lt_filtro_grupo_planejamento
           it_filtro_centro_trabalho      = lt_filtro_centro_trabalho
           it_filtro_codigo_abc           = lt_filtro_codigo_abc
           it_filtro_plano_manutencao     = lt_filtro_plano_manutencao
           it_filtro_ciclo                = lt_filtro_ciclo
           it_filtro_tipo_atvd_manutencao = lt_filtro_tipo_atvd_manutencao
           ex_quantidade_ordem            = lv_quantidade_ordem.
*        o_oms->out_ordem( EXPORTING rt_aufnr                       = rt_aufnr
*                                    rt_auart                       = rt_auart
*                                    rt_iwerk                       = rt_iwerk
*                                    rt_ingpr                       = rt_ingpr
*                                    rt_beber                       = rt_beber
*                                    rt_arbpl                       = rt_arbpl
*                                    rt_parnr                       = rt_parnr
*                                    rt_eqfnr                       = rt_eqfnr
*                                    rt_gstrp                       = rt_gstrp
*                                    rt_sttxt                       = rt_sttxt
*                                    rt_asttx                       = rt_asttx
*                                    rt_usuario_app                 = rt_usuario_app
*                          IMPORTING et_ordens                      = lt_ordens
*                                    et_textos_ordem                = lt_textos_ordem
*                                    et_operacoes_ordem             = lt_operacoes_ordem
*                                    et_componentes_ordem           = lt_componentes_ordem
*                                    et_imagens_ordem               = lt_imagens_ordem
*                                    et_filtro_ordem                = lt_filtro_ordem
*                                    et_filtro_nota                 = lt_filtro_nota
*                                    et_filtro_tipo_ordem           = lt_filtro_tipo_ordem
*                                    et_filtro_inicio_base          = lt_filtro_inicio_base
*                                    et_filtro_fim_base             = lt_filtro_fim_base
*                                    et_filtro_local_instalacao     = lt_filtro_local_instalacao
*                                    et_filtro_equipamento          = lt_filtro_equipamento
*                                    et_filtro_grupo_planejamento   = lt_filtro_grupo_planejamento
*                                    et_filtro_centro_trabalho      = lt_filtro_centro_trabalho
*                                    et_filtro_codigo_abc           = lt_filtro_codigo_abc
*                                    et_filtro_plano_manutencao     = lt_filtro_plano_manutencao
*                                    et_filtro_ciclo                = lt_filtro_ciclo
*                                    et_filtro_tipo_atvd_manutencao = lt_filtro_tipo_atvd_manutencao ).
**                                    et_filtro_op_status_mobile     = lt_filtro_op_status_mobile
**                                    et_filtro_op_operacao          = lt_filtro_op_operacao
**                                    et_filtro_op_sub_operacao      = lt_filtro_op_sub_operacao
**                                    et_filtro_op_empregado         = lt_filtro_op_empregado
**                                    et_filtro_op_centro_trabalho   = lt_filtro_op_centro_trabalho ).

       LOOP AT lt_ordens INTO DATA(ls_ordens).
         " Filtro para método out_ponto_medicao e parceiro de negocio
         CLEAR ls_objnr.
         ls_objnr-sign = 'I'.
         ls_objnr-option = 'EQ'.
         ls_objnr-low = ls_ordens-objnr.
         APPEND ls_objnr TO rt_objnr.
       ENDLOOP.

       CALL FUNCTION '/PTLOMS/MF022'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_objnr            = rt_objnr
         IMPORTING
           it_parceiro_negocio = lt_parceiro_negocio.
*        lt_parceiro_negocio = o_oms->out_parceiro_negocio( rt_objnr = rt_objnr ).

* Converte Data
       LOOP AT lt_filtro_inicio_base ASSIGNING FIELD-SYMBOL(<fs_filtro_inicio_base>).
         lv_data = <fs_filtro_inicio_base>-key.
         <fs_filtro_inicio_base>-key = lv_data+6(2) && |/| &&
                                       lv_data+4(2) && |/| &&
                                       lv_data(4).
       ENDLOOP.
* Converte Data
       LOOP AT lt_filtro_fim_base ASSIGNING FIELD-SYMBOL(<fs_filtro_fim_base>).
         lv_data = <fs_filtro_fim_base>-key.
         <fs_filtro_fim_base>-key = lv_data+6(2) && |/| &&
                                    lv_data+4(2) && |/| &&
                                    lv_data(4).
       ENDLOOP.
* Converte Data
       LOOP AT lt_ordens ASSIGNING FIELD-SYMBOL(<fs_ordens>).
         lv_data = <fs_ordens>-start_date.
         <fs_ordens>-start_date = lv_data+6(2) && |/| &&
                                  lv_data+4(2) && |/| &&
                                  lv_data(4).
         lv_data = <fs_ordens>-finish_date.
         <fs_ordens>-finish_date = lv_data+6(2) && |/| &&
                                   lv_data+4(2) && |/| &&
                                   lv_data(4).
       ENDLOOP.
* Converte Data
       LOOP AT lt_operacoes_ordem ASSIGNING FIELD-SYMBOL(<fs_operacoes_ordem>).
         lv_data = <fs_operacoes_ordem>-earl_sched_start_date.
         lv_hora = <fs_operacoes_ordem>-earl_sched_start_time.
         <fs_operacoes_ordem>-earl_sched_start_date_conv = lv_data+6(2) && |/| &&
                                                           lv_data+4(2) && |/| &&
                                                           lv_data(4)   && | | &&
                                                           lv_hora(2)   && |:| &&
                                                           lv_hora+2(2) && |:| &&
                                                           lv_hora+4(2).
         lv_data = <fs_operacoes_ordem>-late_sched_start_date.
         lv_hora = <fs_operacoes_ordem>-late_sched_start_time.
         <fs_operacoes_ordem>-late_sched_start_date_conv = lv_data+6(2) && |/| &&
                                                           lv_data+4(2) && |/| &&
                                                           lv_data(4)   && | | &&
                                                           lv_hora(2)   && |:| &&
                                                           lv_hora+2(2) && |:| &&
                                                           lv_hora+4(2).
       ENDLOOP.

* Carrega Filtros da Ordem
       ls_expand_so-out_filtro_ordemset            = lt_filtro_ordem.
       ls_expand_so-out_filtro_notaset             = lt_filtro_nota.
       ls_expand_so-out_filtro_tipo_ordemset       = lt_filtro_tipo_ordem.
       ls_expand_so-out_filtro_inicio_baseset      = lt_filtro_inicio_base.
       ls_expand_so-out_filtro_fim_baseset         = lt_filtro_fim_base.
       ls_expand_so-out_filtro_local_instalacaoset = lt_filtro_local_instalacao.
       ls_expand_so-out_filtro_equipamentoset      = lt_filtro_equipamento.
       ls_expand_so-out_filtro_grupo_planset       = lt_filtro_grupo_planejamento.
       ls_expand_so-out_filtro_centro_trabalhoset  = lt_filtro_centro_trabalho.
       ls_expand_so-out_filtro_codigo_abcset       = lt_filtro_codigo_abc.
       ls_expand_so-out_filtro_plano_manutencaoset = lt_filtro_plano_manutencao.
       ls_expand_so-out_filtro_tp_atvd_manunset    = lt_filtro_tipo_atvd_manutencao.

       LOOP AT lt_ordens INTO DATA(ls_ordens_aux).

* Limpa estruturas
         CLEAR: ls_ordemset .

* Carrega campos da ordem
         MOVE-CORRESPONDING ls_ordens_aux TO ls_ordemset.

* Carrega filtros da ordem
         ls_ordemset-out_filtro_op_status_mobileset = ls_ordemset-et_filtro_op_status_mobile.
         ls_ordemset-out_filtro_op_operacaoset      = ls_ordemset-et_filtro_op_operacao.
         ls_ordemset-out_filtro_op_empregadoset     = ls_ordemset-et_filtro_op_empregado.
         ls_ordemset-out_filtro_op_centro_trabset   = ls_ordemset-et_filtro_op_centro_trabalho.

* Carrega componentes da ordem
         DATA(lt_componentes_ordem_aux) = lt_componentes_ordem.
         DELETE lt_componentes_ordem_aux WHERE orderid NE ls_ordens_aux-orderid.
         ls_ordemset-out_componentes_ordemset = lt_componentes_ordem_aux.

* Carrega operações da ordem
         "Calcula total de horas por usuário
         DATA: it_usuario_app TYPE /ptloms/ct101,
               ls_user_app    TYPE /ptloms/et106.
         DATA lv_tot_user        TYPE /ptloms/et038-work_activity.
         DATA ls_confirmacao     LIKE LINE OF lt_confirmacao.

         CALL FUNCTION '/PTLOMS/MF034'
           DESTINATION lv_rfcdest
           EXPORTING
             rt_usuario_app       = rt_usuario_app
           IMPORTING
             it_dados_usuario_app = it_usuario_app.

         READ TABLE it_usuario_app INTO ls_user_app INDEX 1.

         CLEAR lv_tot_user.
         LOOP AT lt_confirmacao  INTO ls_confirmacao
           WHERE pers_no           EQ ls_user_app-matricula
             AND orderid           EQ ls_ordens_aux-orderid.

           READ TABLE lt_operacoes_ordem ASSIGNING <fs_operacoes_ordem> WITH KEY orderid  = ls_confirmacao-orderid
                                                                                 pers_no  = ls_confirmacao-pers_no
                                                                                 activity = ls_confirmacao-activity.
           IF  sy-subrc            EQ 0.
             <fs_operacoes_ordem>-work_user = <fs_operacoes_ordem>-work_user + ls_confirmacao-act_work.
           ENDIF.

         ENDLOOP.

         DATA(lt_operacoes_ordem_aux) = lt_operacoes_ordem.
         DELETE lt_operacoes_ordem_aux WHERE orderid NE ls_ordens_aux-orderid.
         ls_ordemset-out_operacoes_ordemset = lt_operacoes_ordem_aux.

* Carrega confirmaçõe das operações da ordem
         DATA(lt_confirmacao_aux) = lt_confirmacao.
         DELETE lt_confirmacao_aux WHERE orderid NE ls_ordens_aux-orderid.
         ls_ordemset-out_confirmacaoset = lt_confirmacao_aux.

* Carrega textos da ordem
         DATA(lt_textos_ordem_aux) = lt_textos_ordem.
         DELETE lt_textos_ordem_aux WHERE orderid NE ls_ordens_aux-orderid.
*          ls_ordemset-out_textos_ordemset = lt_textos_ordem_aux.

* Carrega Parceiros de Negócio da ordem
         DATA(lt_parceiro_negocio_aux) = lt_parceiro_negocio.
         DELETE lt_parceiro_negocio_aux WHERE objnr NE ls_ordens_aux-objnr.
         ls_ordemset-out_parceiro_negocioset = lt_parceiro_negocio_aux.

* Carrega Imagens para Ordens
         DATA(lt_imagens_ordem_aux) = lt_imagens_ordem.
         DELETE lt_imagens_ordem_aux WHERE instid_a NE ls_ordens_aux-orderid.
         ls_ordemset-out_anexoset  = lt_imagens_ordem_aux.
*          LOOP AT lt_imagens_ordem INTO DATA(ls_imagens_ordem).
*            ls_ordemset-contentshexset = ls_imagens_ordem-contents_hex.
*          ENDLOOP.

* Carrega Lista Técnia dos objetos (Equipamento ou Local de Instalação) da Ordem
         CLEAR: lv_submt, lv_iwerk.

         REFRESH: rt_equnr[],
                  rt_tplnr[],
                  rt_matnr[].

         IF ls_ordens_aux-equipment IS NOT INITIAL.
           CALL FUNCTION '/PTLOMS/MF045'
             DESTINATION lv_rfcdest
             EXPORTING
               im_equnr = ls_ordens_aux-equipment
             IMPORTING
               ex_submt = lv_submt
               ex_iwerk = lv_iwerk.

*            SELECT SINGLE submt, iwerk FROM equz INTO ( @lv_submt, @lv_iwerk ) WHERE equnr = @ls_ordens_aux-equipment
*                                                                                 AND datbi = '99991231'.
           IF lv_submt IS NOT INITIAL.
             " Filtro para método out_lista_tecnica
             CLEAR ls_matnr.
             ls_matnr-sign = 'I'.
             ls_matnr-option = 'EQ'.
             ls_matnr-low = lv_submt.
             APPEND ls_matnr TO rt_matnr.

             CLEAR ls_werks.
             ls_werks-sign = 'I'.
             ls_werks-option = 'EQ'.
             ls_werks-low = lv_iwerk.
             APPEND ls_werks TO rt_werks.
           ELSE.
             " Filtro para método out_lista_tecnica
             CLEAR ls_equnr.
             ls_equnr-sign = 'I'.
             ls_equnr-option = 'EQ'.
             ls_equnr-low = ls_ordens_aux-equipment.
             APPEND ls_equnr TO rt_equnr.
           ENDIF.
         ELSEIF ls_ordens_aux-funct_loc IS NOT INITIAL.
           CALL FUNCTION '/PTLOMS/MF046'
             DESTINATION lv_rfcdest
             EXPORTING
               im_tplnr = ls_ordens_aux-funct_loc
             IMPORTING
               ex_submt = lv_submt
               ex_iwerk = lv_iwerk.
*            SELECT SINGLE submt, iwerk FROM iflot INTO ( @lv_submt, @lv_iwerk ) WHERE tplnr = @ls_ordens_aux-funct_loc.

           IF lv_submt IS NOT INITIAL.
             " Filtro para método out_lista_tecnica
             CLEAR ls_matnr.
             ls_matnr-sign = 'I'.
             ls_matnr-option = 'EQ'.
             ls_matnr-low = lv_submt.
             APPEND ls_matnr TO rt_matnr.

             CLEAR ls_werks.
             ls_werks-sign = 'I'.
             ls_werks-option = 'EQ'.
             ls_werks-low = lv_iwerk.
             APPEND ls_werks TO rt_werks.
           ELSE.
             " Filtro para método out_lista_tecnica
             CLEAR ls_tplnr.
             ls_tplnr-sign = 'I'.
             ls_tplnr-option = 'EQ'.
             ls_tplnr-low = ls_ordens_aux-funct_loc.
             APPEND ls_tplnr TO rt_tplnr.
           ENDIF.
         ENDIF.

         IF rt_equnr[] IS NOT INITIAL OR
            rt_tplnr[] IS NOT INITIAL OR
            rt_matnr[] IS NOT INITIAL.

           CALL FUNCTION '/PTLOMS/MF029'
             DESTINATION lv_rfcdest
             EXPORTING
               rt_equnr                  = rt_equnr
               rt_tplnr                  = rt_tplnr
               rt_matnr                  = rt_matnr
               rt_werks                  = rt_werks
             IMPORTING
               it_lista_tecnica_equi     = lt_lista_tecnica_equi
               it_lista_tecnica_loc_inst = lt_lista_tecnica_loc_inst
               it_lista_tecnica_mat      = lt_lista_tecnica_mat.

*            o_oms->out_lista_tecnica(
*              EXPORTING
*                rt_equnr                  = rt_equnr
*                rt_tplnr                  = rt_tplnr
*                rt_matnr                  = rt_matnr
*                rt_werks                  = rt_werks
*              IMPORTING
*                et_lista_tecnica_equi     = lt_lista_tecnica_equi
*                et_lista_tecnica_loc_inst = lt_lista_tecnica_loc_inst
*                et_lista_tecnica_mat      = lt_lista_tecnica_mat ).

           REFRESH lt_lista_tecnica[].

           LOOP AT lt_lista_tecnica_equi INTO DATA(ls_lista_tecnica_equi).
             CLEAR ls_lista_tecnica.
             MOVE-CORRESPONDING ls_lista_tecnica_equi TO ls_lista_tecnica.
             ls_lista_tecnica-matnr = ls_lista_tecnica_equi-idnrk.

             CALL FUNCTION '/PTLOMS/MF047'
               DESTINATION lv_rfcdest
               EXPORTING
                 im_matnr = ls_lista_tecnica-matnr
               IMPORTING
                 ex_maktx = ls_lista_tecnica-maktx.
*              SELECT SINGLE maktx
*                FROM makt
*                INTO @ls_lista_tecnica-maktx
*                WHERE matnr = @ls_lista_tecnica-matnr
*                  AND spras = @sy-langu.
             APPEND ls_lista_tecnica TO lt_lista_tecnica.
           ENDLOOP.
           LOOP AT lt_lista_tecnica_loc_inst INTO DATA(ls_lista_tecnica_loc_inst).
             CLEAR ls_lista_tecnica.
             MOVE-CORRESPONDING ls_lista_tecnica_loc_inst TO ls_lista_tecnica.
             ls_lista_tecnica-matnr = ls_lista_tecnica_equi-idnrk.

             CALL FUNCTION '/PTLOMS/MF047'
               DESTINATION lv_rfcdest
               EXPORTING
                 im_matnr = ls_lista_tecnica-matnr
               IMPORTING
                 ex_maktx = ls_lista_tecnica-maktx.

             APPEND ls_lista_tecnica TO lt_lista_tecnica.
           ENDLOOP.
           LOOP AT lt_lista_tecnica_mat INTO DATA(ls_lista_tecnica_mat).
             CLEAR ls_lista_tecnica.
             MOVE-CORRESPONDING ls_lista_tecnica_mat TO ls_lista_tecnica.
             APPEND ls_lista_tecnica TO lt_lista_tecnica.
           ENDLOOP.

*            ls_ordemset-out_lista_tecnicaset = lt_lista_tecnica.

           LOOP AT lt_lista_tecnica INTO DATA(ls_lista_tecnica_aux).
             CLEAR ls_lista_tecnicaset.
             MOVE-CORRESPONDING ls_lista_tecnica_aux TO ls_lista_tecnicaset.

             REFRESH: rt_matnr[], rt_werks[].

             CLEAR ls_matnr.
             ls_matnr-sign = 'I'.
             ls_matnr-option = 'EQ'.
             ls_matnr-low = ls_lista_tecnica_aux-matnr.
             APPEND ls_matnr TO rt_matnr.

             CLEAR ls_werks.
             ls_werks-sign = 'I'.
             ls_werks-option = 'EQ'.
             ls_werks-low = lv_iwerk.
             APPEND ls_werks TO rt_werks.

             REFRESH lt_saldo_material[].
             CALL FUNCTION '/PTLOMS/MF032'
               DESTINATION lv_rfcdest
               EXPORTING
                 rt_matnr       = rt_matnr
                 rt_werks       = rt_werks
                 rt_lgort       = rt_lgort_aux
                 rt_usuario_app = rt_usuario_app
               IMPORTING
                 it_saldo       = lt_saldo_material.

             ls_lista_tecnicaset-out_saldo_materialset = lt_saldo_material.

             ls_lista_tecnicaset-idnrk = |{ ls_lista_tecnicaset-idnrk ALPHA = OUT }|.
             ls_lista_tecnicaset-matnr = |{ ls_lista_tecnicaset-matnr ALPHA = OUT }|.

             APPEND ls_lista_tecnicaset TO ls_ordemset-out_lista_tecnicaset.
           ENDLOOP.

         ENDIF.

         ls_ordemset-quantidade_ordem = lv_quantidade_ordem.
         APPEND ls_ordemset TO ls_expand_so-out_ordemset.

       ENDLOOP.

*        SORT ls_expand_so-out_ordemset BY equnr ASCENDING
*                                          matnr ASCENDING
*                                          stlnr ASCENDING
*                                          idnrk ASCENDING
*                                          posnr ASCENDING.
*
*        DELETE ADJACENT DUPLICATES FROM ls_expand_so-out_ordemset
*                           COMPARING equnr matnr stlnr idnrk posnr.

* Usário do App
       IF rt_usuario_app[] IS NOT INITIAL.
         READ TABLE rt_usuario_app INTO DATA(ls_usuario_app) INDEX 1.
         ls_expand_so-usuario_app = ls_usuario_app-low.
         CALL FUNCTION '/PTLOMS/MF048'
           DESTINATION lv_rfcdest
           EXPORTING
             im_usuario = ls_expand_so-usuario_app
           IMPORTING
             ex_nome    = ls_expand_so-nome_usuario_app.
*          SELECT SINGLE nome FROM /ptloms/tb013 INTO ls_expand_so-nome_usuario_app WHERE usuario = ls_expand_so-usuario_app.
       ENDIF.

* Data e Hora do Sistema
       ls_expand_so-data_hora = sy-datum+6(2) && |/| &&
                                sy-datum+4(2) && |/| &&
                                sy-datum(4)   && | | &&
                                sy-uzeit(2)   && |:| &&
                                sy-uzeit+2(2) && |:| &&
                                sy-uzeit+4(2).

* Retira zeros a esquerda da nota e ordem
       LOOP AT ls_expand_so-out_ordemset ASSIGNING FIELD-SYMBOL(<fs_out_ordemset>).
         <fs_out_ordemset>-notif_no = |{ <fs_out_ordemset>-notif_no ALPHA = OUT }|.
         <fs_out_ordemset>-orderid  = |{ <fs_out_ordemset>-orderid ALPHA = OUT }|.
         LOOP AT <fs_out_ordemset>-out_componentes_ordemset ASSIGNING FIELD-SYMBOL(<fs_out_componentes>).
*            <fs_out_componentes>-orderid = |{ <fs_out_componentes>-orderid ALPHA = OUT }|.
           SHIFT <fs_out_componentes>-orderid LEFT DELETING LEADING '0'.
           SHIFT <fs_out_componentes>-material LEFT DELETING LEADING '0'.
         ENDLOOP.
         LOOP AT <fs_out_ordemset>-out_operacoes_ordemset ASSIGNING FIELD-SYMBOL(<fs_out_operacoes>).
           <fs_out_operacoes>-orderid = |{ <fs_out_operacoes>-orderid ALPHA = OUT }|.
           SHIFT <fs_out_operacoes>-conf_no LEFT DELETING LEADING '0'.
           SHIFT <fs_out_operacoes>-pers_no LEFT DELETING LEADING '0'.
*            <fs_out_operacoes>-conf_no = |{ <fs_out_operacoes>-conf_no ALPHA = OUT }|.
*            <fs_out_operacoes>-pers_no = |{ <fs_out_operacoes>-pers_no ALPHA = OUT }|.
         ENDLOOP.
         LOOP AT <fs_out_ordemset>-out_anexoset ASSIGNING FIELD-SYMBOL(<fs_out_anexo>).
           <fs_out_anexo>-instid_a = |{ <fs_out_anexo>-instid_a ALPHA = OUT }|.
         ENDLOOP.
         LOOP AT <fs_out_ordemset>-out_confirmacaoset ASSIGNING FIELD-SYMBOL(<fs_out_confirmacao>).
           <fs_out_confirmacao>-orderid = |{ <fs_out_confirmacao>-orderid ALPHA = OUT }|.
           SHIFT <fs_out_confirmacao>-conf_no LEFT DELETING LEADING '0'.
           LOOP AT <fs_out_ordemset>-out_lista_tecnicaset ASSIGNING FIELD-SYMBOL(<fs_out_lista_tec>).
             <fs_out_lista_tec>-matnr = |{ <fs_out_lista_tec>-matnr ALPHA = OUT }|.
             <fs_out_lista_tec>-idnrk = |{ <fs_out_lista_tec>-idnrk ALPHA = OUT }|.
           ENDLOOP.
*          LOOP AT <fs_out_ordemset>-out_componentes_ordemset ASSIGNING FIELD-SYMBOL(<fs_out_comp>).
**            <fs_out_comp>-material = |{ <fs_out_comp>-material ALPHA = OUT }|.
*            SHIFT <fs_out_comp>-material LEFT DELETING LEADING '0'.
*          ENDLOOP.
         ENDLOOP.
       ENDLOOP.

       ls_expand_so-quantidade_ordem = lv_quantidade_ordem.
       APPEND ls_expand_so TO lt_expand_so.

       copy_data_to_ref( EXPORTING is_data = lt_expand_so CHANGING cr_data = er_entityset ).

       APPEND 'out_ordemSet/out_componentes_ordemSet'       TO et_expanded_tech_clauses.
       APPEND 'out_ordemSet/out_operacoes_ordemSet'         TO et_expanded_tech_clauses.
*        APPEND 'out_ordemSet/out_textos_ordemSet'          TO et_expanded_tech_clauses.
       APPEND 'out_ordemSet/out_parceiro_negocioSet'        TO et_expanded_tech_clauses.
       APPEND 'out_ordemSet/out_lista_tecnicaSet'           TO et_expanded_tech_clauses.
       APPEND 'out_ordemSet/out_anexoSet'                   TO et_expanded_tech_clauses.
       APPEND 'out_ordemSet/out_filtro_op_status_mobileSet' TO et_expanded_tech_clauses.
       APPEND 'out_ordemSet/out_filtro_op_operacaoSet'      TO et_expanded_tech_clauses.
       APPEND 'out_ordemSet/out_filtro_op_empregadoSet'     TO et_expanded_tech_clauses.
       APPEND 'out_ordemSet/out_filtro_op_centro_trabSet'   TO et_expanded_tech_clauses.
       APPEND 'out_ordemSet/out_lista_tecnicaSet/out_saldo_materialSet' TO et_expanded_tech_clauses.

     WHEN 'root_out_local_instalacao'.

** Autenticação - Início
*        IF lv_guid IS INITIAL OR lv_guid NE ls_guid_aux-low.
*          lv_mensagem = 'Favor iniciar uma nova sessão'.
*
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              textid  = /iwbep/cx_mgw_busi_exception=>business_error
*              message = lv_mensagem.
*        ENDIF.
** Autenticação - Fim

       IF it_filter_select_options[] IS NOT INITIAL.
         READ TABLE it_filter_select_options INTO DATA(ls_bukrs) WITH KEY property = 'Bukrs'.
         IF sy-subrc = 0.
           DATA(rt_bukrs) = ls_bukrs-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_iwerk WITH KEY property = 'Iwerk'.
         IF sy-subrc = 0.
           rt_iwerk = ls_iwerk-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_ingrp WITH KEY property = 'Ingrp'.
         IF sy-subrc = 0.
           rt_ingrp = ls_ingrp-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_beber WITH KEY property = 'Beber'.
         IF sy-subrc = 0.
           rt_beber = ls_beber-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_lgwid) WITH KEY property = 'Lgwid'.
         IF sy-subrc = 0.
           DATA(rt_lgwid) = ls_lgwid-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_eqart) WITH KEY property = 'Eqart'.
         IF sy-subrc = 0.
           DATA(rt_eqart) = ls_eqart-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_fltyp) WITH KEY property = 'Fltyp'.
         IF sy-subrc = 0.
           DATA(rt_fltyp) = ls_fltyp-select_options.
         ENDIF.
       ENDIF.

       lv_top  = is_paging-top.
       lv_skip = is_paging-skip.

       CLEAR lv_quantidade_local_inst.
       CALL FUNCTION '/PTLOMS/MF024'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_bukrs                 = rt_bukrs
           rt_iwerk                 = rt_iwerk
           rt_ingrp                 = rt_ingrp
           rt_beber                 = rt_beber
           rt_lgwid                 = rt_lgwid
           rt_eqart                 = rt_eqart
           rt_fltyp                 = rt_fltyp
           rt_usuario_app           = rt_usuario_app
           im_top                   = lv_top
           im_skip                  = lv_skip
         IMPORTING
           it_local_inst            = lt_local_inst
           it_imagens_local_inst    = lt_imagens_local_inst
           ex_quantidade_local_inst = lv_quantidade_local_inst.
*        o_oms->out_local_instalacao( EXPORTING rt_bukrs                    = rt_bukrs
*                                               rt_iwerk                    = rt_iwerk
*                                               rt_ingrp                    = rt_ingrp
*                                               rt_beber                    = rt_beber
*                                               rt_lgwid                    = rt_lgwid
*                                               rt_eqart                    = rt_eqart
*                                               rt_fltyp                    = rt_fltyp
*                                               rt_usuario_app              = rt_usuario_app
*                                     IMPORTING et_local_instalacao         = lt_local_inst
*                                               et_imagens_local_instalacao = lt_imagens_local_inst ).

       LOOP AT lt_local_inst INTO DATA(ls_local_inst).

         " Filtro para método out_classe_característica
         CLEAR ls_objek.
         ls_objek-sign = 'I'.
         ls_objek-option = 'EQ'.
         ls_objek-low = ls_local_inst-tplnr.
         APPEND ls_objek TO rt_objek.

         " Filtro para método out_catalogo
         IF ls_local_inst-rbnr IS NOT INITIAL.
           CLEAR ls_rbnr.
           ls_rbnr-sign = 'I'.
           ls_rbnr-option = 'EQ'.
           ls_rbnr-low = ls_local_inst-rbnr.
           APPEND ls_rbnr TO rt_rbnr.
         ENDIF.

         " Filtro para método out_ponto_medicao e parceiro de negocio
         CLEAR ls_objnr.
         ls_objnr-sign = 'I'.
         ls_objnr-option = 'EQ'.
         ls_objnr-low = ls_local_inst-objnr.
         APPEND ls_objnr TO rt_objnr.

         IF ls_local_inst-submt IS NOT INITIAL.
           " Filtro para método out_lista_tecnica
           CLEAR ls_matnr.
           ls_matnr-sign = 'I'.
           ls_matnr-option = 'EQ'.
           ls_matnr-low = ls_local_inst-submt.
           APPEND ls_matnr TO rt_matnr.

           CLEAR ls_werks.
           ls_werks-sign = 'I'.
           ls_werks-option = 'EQ'.
           ls_werks-low = ls_local_inst-iwerk.
           APPEND ls_werks TO rt_werks.
         ELSE.
           " Filtro para método out_lista_tecnica
           CLEAR ls_tplnr.
           ls_tplnr-sign = 'I'.
           ls_tplnr-option = 'EQ'.
           ls_tplnr-low = ls_local_inst-tplnr.
           APPEND ls_tplnr TO rt_tplnr.
         ENDIF.
       ENDLOOP.

*        lt_caracteristicas  = o_oms->out_classe_caracterisca( rt_objek = rt_objek ).

       CALL FUNCTION '/PTLOMS/MF019'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_rbnr      = rt_rbnr
         IMPORTING
           it_catalogos = lt_catalogos.
*        lt_catalogos        = o_oms->out_catalogo( rt_rbnr = rt_rbnr ).

*        CALL FUNCTION '/PTLOMS/MF020'
*          DESTINATION lv_rfcdest
*          EXPORTING
*            rt_objnr         = rt_objnr
*          IMPORTING
*            it_ponto_medicao = lt_ponto_medicao.
**        lt_ponto_medicao    = o_oms->out_ponto_medicao( rt_objnr = rt_objnr ).

       LOOP AT lt_ponto_medicao INTO DATA(ls_ponto_medicao).

         " Filtro para método ou_documento_medicao
         CLEAR ls_point.
         ls_point-sign = 'I'.
         ls_point-option = 'EQ'.
         ls_point-low = ls_ponto_medicao-point.
         APPEND ls_point TO rt_point.

       ENDLOOP.

       CALL FUNCTION '/PTLOMS/MF021'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_point             = rt_point
           rt_usuario_app       = rt_usuario_app
         IMPORTING
           it_documento_medicao = lt_documento_medicao.
*        lt_documento_medicao = o_oms->out_documento_medicao( rt_point = rt_point
*                                                             im_qtde  = 10 ).

       CALL FUNCTION '/PTLOMS/MF022'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_objnr            = rt_objnr
         IMPORTING
           it_parceiro_negocio = lt_parceiro_negocio.
*        lt_parceiro_negocio = o_oms->out_parceiro_negocio( rt_objnr = rt_objnr ).

       CALL FUNCTION '/PTLOMS/MF029'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_equnr                  = rt_equnr
           rt_tplnr                  = rt_tplnr
           rt_matnr                  = rt_matnr
           rt_werks                  = rt_werks
         IMPORTING
           it_lista_tecnica_equi     = lt_lista_tecnica_equi
           it_lista_tecnica_loc_inst = lt_lista_tecnica_loc_inst
           it_lista_tecnica_mat      = lt_lista_tecnica_mat.
*        o_oms->out_lista_tecnica(
*          EXPORTING
*            rt_equnr                  = rt_equnr
*            rt_tplnr                  = rt_tplnr
*            rt_matnr                  = rt_matnr
*            rt_werks                  = rt_werks
*          IMPORTING
*            et_lista_tecnica_equi     = lt_lista_tecnica_equi
*            et_lista_tecnica_loc_inst = lt_lista_tecnica_loc_inst
*            et_lista_tecnica_mat      = lt_lista_tecnica_mat ).

* Retira zeros a esquerda
       LOOP AT lt_ponto_medicao ASSIGNING FIELD-SYMBOL(<fs_ponto_medicao>).
         <fs_ponto_medicao>-point = |{ <fs_ponto_medicao>-point ALPHA = OUT }|.
       ENDLOOP.
       LOOP AT lt_documento_medicao ASSIGNING FIELD-SYMBOL(<fs_documento_medicao>).
         <fs_documento_medicao>-point = |{ <fs_documento_medicao>-point ALPHA = OUT }|.
       ENDLOOP.

       ls_out_local_instalacao-out_local_instalacaoset       = lt_local_inst.
       ls_out_local_instalacao-out_classe_caracteristicaset  = lt_caracteristicas.
       ls_out_local_instalacao-out_catalogoset               = lt_catalogos.
       ls_out_local_instalacao-out_ponto_medicaoset          = lt_ponto_medicao.
       ls_out_local_instalacao-out_documento_medicaoset      = lt_documento_medicao.
       ls_out_local_instalacao-out_parceiro_negocioset       = lt_parceiro_negocio.
*        ls_out_local_instalacao-out_lista_tecnica_equiset     = lt_lista_tecnica_equi.
*        ls_out_local_instalacao-out_lista_tecnica_matset      = lt_lista_tecnica_mat.
*        ls_out_local_instalacao-out_lista_tecnica_loc_instset = lt_lista_tecnica_loc_inst.

       LOOP AT lt_lista_tecnica_loc_inst INTO ls_lista_tecnica_loc_inst.
         CLEAR ls_lista_tecnica.
         MOVE-CORRESPONDING ls_lista_tecnica_loc_inst TO ls_lista_tecnica.
         ls_lista_tecnica-matnr = ls_lista_tecnica_equi-idnrk.

         CALL FUNCTION '/PTLOMS/MF047'
           DESTINATION lv_rfcdest
           EXPORTING
             im_matnr = ls_lista_tecnica-matnr
           IMPORTING
             ex_maktx = ls_lista_tecnica-maktx.
*          SELECT SINGLE maktx
*            FROM makt
*            INTO @ls_lista_tecnica-maktx
*            WHERE matnr = @ls_lista_tecnica-matnr
*              AND spras = @sy-langu.
         APPEND ls_lista_tecnica TO lt_lista_tecnica.
       ENDLOOP.
       LOOP AT lt_lista_tecnica_mat INTO ls_lista_tecnica_mat.
         CLEAR ls_lista_tecnica.
         MOVE-CORRESPONDING ls_lista_tecnica_mat TO ls_lista_tecnica.
         APPEND ls_lista_tecnica TO lt_lista_tecnica.
       ENDLOOP.

*        ls_out_local_instalacao-out_lista_tecnicaset = lt_lista_tecnica.

       LOOP AT lt_lista_tecnica INTO DATA(ls_lista_tecnica_locl_aux).
         CLEAR ls_lista_tecnica_loclset.
         MOVE-CORRESPONDING ls_lista_tecnica_locl_aux TO ls_lista_tecnica_loclset.

         REFRESH: rt_matnr[], rt_werks[].

         CLEAR ls_matnr.
         ls_matnr-sign = 'I'.
         ls_matnr-option = 'EQ'.
         ls_matnr-low = ls_lista_tecnica_locl_aux-matnr.
         APPEND ls_matnr TO rt_matnr.

         IF ls_lista_tecnica_locl_aux-tplnr IS NOT INITIAL.
           CLEAR: lv_submt, lv_iwerk.
           CALL FUNCTION '/PTLOMS/MF046'
             DESTINATION lv_rfcdest
             EXPORTING
               im_tplnr = ls_lista_tecnica_locl_aux-tplnr
             IMPORTING
               ex_submt = lv_submt
               ex_iwerk = lv_iwerk.
         ELSE.
           lv_iwerk = ls_lista_tecnica_locl_aux-werks.
         ENDIF.

         CLEAR ls_werks.
         ls_werks-sign = 'I'.
         ls_werks-option = 'EQ'.
         ls_werks-low = lv_iwerk.
         APPEND ls_werks TO rt_werks.

         REFRESH lt_saldo_material[].
         CALL FUNCTION '/PTLOMS/MF032'
           DESTINATION lv_rfcdest
           EXPORTING
             rt_matnr       = rt_matnr
             rt_werks       = rt_werks
             rt_lgort       = rt_lgort_aux
             rt_usuario_app = rt_usuario_app
           IMPORTING
             it_saldo       = lt_saldo_material.

         ls_lista_tecnica_loclset-out_saldo_materialset = lt_saldo_material.

         ls_lista_tecnica_loclset-idnrk = |{ ls_lista_tecnica_loclset-idnrk ALPHA = OUT }|.
         ls_lista_tecnica_loclset-matnr = |{ ls_lista_tecnica_loclset-matnr ALPHA = OUT }|.

         APPEND ls_lista_tecnica_loclset TO ls_out_local_instalacao-out_lista_tecnicaset.
       ENDLOOP.

       ls_out_local_instalacao-quantidade_local_inst = lv_quantidade_local_inst.

       APPEND ls_out_local_instalacao TO lt_out_local_instalacao.

       APPEND 'out_lista_tecnicaSet/out_saldo_materialSet' TO et_expanded_tech_clauses.

       copy_data_to_ref( EXPORTING is_data = lt_out_local_instalacao CHANGING cr_data = er_entityset ).

     WHEN 'root_out_equipamento'.

       DATA: lt_filters TYPE /iwbep/t_mgw_select_option.

       lt_filters = io_tech_request_context->get_filter( )->get_filter_select_options( ).

** Autenticação - Início
*        IF lv_guid IS INITIAL OR lv_guid NE ls_guid_aux-low.
*          lv_mensagem = 'Favor iniciar uma nova sessão'.
*
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              textid  = /iwbep/cx_mgw_busi_exception=>business_error
*              message = lv_mensagem.
*        ENDIF.
** Autenticação - Fim

       IF it_filter_select_options[] IS NOT INITIAL.
         READ TABLE it_filter_select_options INTO ls_bukrs WITH KEY property = 'Bukrs'.
         IF sy-subrc = 0.
           rt_bukrs = ls_bukrs-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_iwerk WITH KEY property = 'Iwerk'.
         IF sy-subrc = 0.
           rt_iwerk = ls_iwerk-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_ingrp WITH KEY property = 'Ingrp'.
         IF sy-subrc = 0.
           rt_ingrp = ls_ingrp-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_beber WITH KEY property = 'Beber'.
         IF sy-subrc = 0.
           rt_beber = ls_beber-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_gewrk) WITH KEY property = 'Gewrk'.
         IF sy-subrc = 0.
           DATA(rt_gewrk) = ls_gewrk-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_eqart WITH KEY property = 'Eqart'.
         IF sy-subrc = 0.
           rt_eqart = ls_eqart-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_eqtyp) WITH KEY property = 'Eqtyp'.
         IF sy-subrc = 0.
           DATA(rt_eqtyp) = ls_eqtyp-select_options.
         ENDIF.

       ENDIF.

       lv_top  = is_paging-top.
       lv_skip = is_paging-skip.

       CLEAR lv_quantidade_equipamento.
       CALL FUNCTION '/PTLOMS/MF025'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_bukrs                  = rt_bukrs
           rt_iwerk                  = rt_iwerk
           rt_ingrp                  = rt_ingrp
           rt_beber                  = rt_beber
           rt_gewrk                  = rt_gewrk
           rt_eqart                  = rt_eqart
           rt_eqtyp                  = rt_eqtyp
           rt_usuario_app            = rt_usuario_app
           im_top                    = lv_top
           im_skip                   = lv_skip
         IMPORTING
           it_imagems_equipamento    = lt_imagens_equipamento
           it_equipamento            = lt_equipamento
           it_filtro_equnr           = lt_filtro_equnr
           it_filtro_eqktx           = lt_filtro_eqktx
           it_filtro_invnr           = lt_filtro_invnr
           it_filtro_tidnr           = lt_filtro_tidnr
           ex_quantidade_equipamento = lv_quantidade_equipamento.

*        o_oms->out_equipamento( EXPORTING rt_bukrs               = rt_bukrs
*                                          rt_iwerk               = rt_iwerk
*                                          rt_ingrp               = rt_ingrp
*                                          rt_beber               = rt_beber
*                                          rt_gewrk               = rt_gewrk
*                                          rt_eqart               = rt_eqart
*                                          rt_eqtyp               = rt_eqtyp
*                                          rt_usuario_app         = rt_usuario_app
*                                IMPORTING et_equipamento         = lt_equipamento
*                                          et_imagems_equipamento = lt_imagens_equipamento
*                                          et_filtro_equnr        = lt_filtro_equnr
*                                          et_filtro_eqktx        = lt_filtro_eqktx
*                                          et_filtro_invnr        = lt_filtro_invnr
*                                          et_filtro_tidnr        = lt_filtro_tidnr ).

       LOOP AT lt_equipamento INTO DATA(ls_equipamento).

         " Filtro para método out_classe_característica
         CLEAR ls_objek.
         ls_objek-sign = 'I'.
         ls_objek-option = 'EQ'.
         ls_objek-low = ls_equipamento-equnr.
         APPEND ls_objek TO rt_objek.

         " Filtro para método out_catalogo
         IF ls_equipamento-rbnr IS NOT INITIAL.
           CLEAR ls_rbnr.
           ls_rbnr-sign = 'I'.
           ls_rbnr-option = 'EQ'.
           ls_rbnr-low = ls_equipamento-rbnr.
           APPEND ls_rbnr TO rt_rbnr.
         ENDIF.

         " Filtro para método out_ponto_medicao e parceiro de negocio
         CLEAR ls_objnr.
         ls_objnr-sign = 'I'.
         ls_objnr-option = 'EQ'.
         ls_objnr-low = ls_equipamento-objnr.
         APPEND ls_objnr TO rt_objnr.

         IF ls_equipamento-submt IS NOT INITIAL.
           " Filtro para método out_lista_tecnica
           CLEAR ls_matnr.
           ls_matnr-sign = 'I'.
           ls_matnr-option = 'EQ'.
           ls_matnr-low = ls_equipamento-submt.
           APPEND ls_matnr TO rt_matnr.

           CLEAR ls_werks.
           ls_werks-sign = 'I'.
           ls_werks-option = 'EQ'.
           ls_werks-low = ls_equipamento-iwerk.
           APPEND ls_werks TO rt_werks.
         ELSE.
           " Filtro para método out_lista_tecnica
           CLEAR ls_equnr.
           ls_equnr-sign = 'I'.
           ls_equnr-option = 'EQ'.
           ls_equnr-low = ls_equipamento-equnr.
           APPEND ls_equnr TO rt_equnr.
         ENDIF.

       ENDLOOP.

*        lt_caracteristicas  = o_oms->out_classe_caracterisca( rt_objek = rt_objek ).

       CALL FUNCTION '/PTLOMS/MF019'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_rbnr      = rt_rbnr
         IMPORTING
           it_catalogos = lt_catalogos.
*        lt_catalogos        = o_oms->out_catalogo( rt_rbnr = rt_rbnr ).

*        CALL FUNCTION 'FUNCTION_EXISTS'
*          DESTINATION lv_rfcdest
*          EXPORTING
*            funcname           = '/PTLOMS/MF020'
*          EXCEPTIONS
*            function_not_exist = 1
*            OTHERS             = 2.

       CALL FUNCTION '/PTLOMS/MF020'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_objnr                  = rt_objnr
           rt_usuario_app            = rt_usuario_app
         IMPORTING
           it_ponto_medicao          = lt_ponto_medicao
         EXCEPTIONS
           environment_not_available = 1.
*        lt_ponto_medicao    = o_oms->out_ponto_medicao( rt_objnr = rt_objnr ).

       LOOP AT lt_ponto_medicao INTO ls_ponto_medicao.

         " Filtro para método ou_documento_medicao
         CLEAR ls_point.
         ls_point-sign = 'I'.
         ls_point-option = 'EQ'.
         ls_point-low = ls_ponto_medicao-point.
         APPEND ls_point TO rt_point.

       ENDLOOP.

       CALL FUNCTION '/PTLOMS/MF021'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_point             = rt_point
           rt_usuario_app       = rt_usuario_app
         IMPORTING
           it_documento_medicao = lt_documento_medicao.
*        lt_documento_medicao = o_oms->out_documento_medicao( rt_point = rt_point
*                                                             im_qtde  = 10 ).

* Verifica se foi encontradao ponto de medição para equipamento
       LOOP AT lt_equipamento ASSIGNING FIELD-SYMBOL(<fs_equipamento_aux>).
         DATA(lv_tabix) = sy-tabix.
         " 01/06/2023
         DATA(lv_equnr) = CONV char18( |{ <fs_equipamento_aux>-equnr ALPHA = IN }| ).
         READ TABLE lt_ponto_medicao TRANSPORTING NO FIELDS WITH KEY equnr = lv_equnr.
         IF sy-subrc EQ 0.
           <fs_equipamento_aux>-ponto_medicao = 'X'.
         ELSE.
*            DELETE lt_equipamento INDEX lv_tabix.
           CLEAR lv_equipamento_out.
           lv_equipamento_out = |{ <fs_equipamento_aux>-equnr ALPHA = OUT }|.
           READ TABLE lt_filtro_equnr ASSIGNING FIELD-SYMBOL(<fs_filtro_equnr>) WITH KEY key = lv_equipamento_out.
           IF sy-subrc EQ 0.
             IF <fs_filtro_equnr>-count > 1.
               <fs_filtro_equnr>-count = <fs_filtro_equnr>-count - 1.
             ELSE.
               DELETE lt_filtro_equnr WHERE key = lv_equipamento_out.
             ENDIF.
           ENDIF.
           READ TABLE lt_filtro_eqktx ASSIGNING FIELD-SYMBOL(<fs_filtro_eqktx>) WITH KEY key = <fs_equipamento_aux>-eqktx.
           IF sy-subrc EQ 0.
             IF <fs_filtro_eqktx>-count > 1.
               <fs_filtro_eqktx>-count = <fs_filtro_eqktx>-count - 1.
             ELSE.
               DELETE lt_filtro_eqktx WHERE key = <fs_equipamento_aux>-eqktx.
             ENDIF.
           ENDIF.
           READ TABLE lt_filtro_invnr ASSIGNING FIELD-SYMBOL(<fs_filtro_invnr>) WITH KEY key = <fs_equipamento_aux>-invnr.
           IF sy-subrc EQ 0.
             IF <fs_filtro_invnr>-count > 1.
               <fs_filtro_invnr>-count = <fs_filtro_invnr>-count - 1.
             ELSE.
               DELETE lt_filtro_invnr WHERE key = <fs_equipamento_aux>-invnr.
             ENDIF.
           ENDIF.
           READ TABLE lt_filtro_tidnr ASSIGNING FIELD-SYMBOL(<fs_filtro_tidnr>) WITH KEY key = <fs_equipamento_aux>-tidnr.
           IF sy-subrc EQ 0.
             IF <fs_filtro_tidnr>-count > 1.
               <fs_filtro_tidnr>-count = <fs_filtro_tidnr>-count - 1.
             ELSE.
               DELETE lt_filtro_tidnr WHERE key = <fs_equipamento_aux>-tidnr.
             ENDIF.
           ENDIF.
         ENDIF.

         <fs_equipamento_aux>-equnr = |{ <fs_equipamento_aux>-equnr ALPHA = OUT }|.

       ENDLOOP.

       CALL FUNCTION '/PTLOMS/MF022'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_objnr            = rt_objnr
         IMPORTING
           it_parceiro_negocio = lt_parceiro_negocio.
*        lt_parceiro_negocio = o_oms->out_parceiro_negocio( rt_objnr = rt_objnr ).

       CALL FUNCTION '/PTLOMS/MF029'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_equnr                  = rt_equnr
           rt_tplnr                  = rt_tplnr
           rt_matnr                  = rt_matnr
           rt_werks                  = rt_werks
         IMPORTING
           it_lista_tecnica_equi     = lt_lista_tecnica_equi
           it_lista_tecnica_loc_inst = lt_lista_tecnica_loc_inst
           it_lista_tecnica_mat      = lt_lista_tecnica_mat.
*        o_oms->out_lista_tecnica(
*          EXPORTING
*            rt_equnr                  = rt_equnr
*            rt_tplnr                  = rt_tplnr
*            rt_matnr                  = rt_matnr
*            rt_werks                  = rt_werks
*          IMPORTING
*            et_lista_tecnica_equi     = lt_lista_tecnica_equi
*            et_lista_tecnica_loc_inst = lt_lista_tecnica_loc_inst
*            et_lista_tecnica_mat      = lt_lista_tecnica_mat ).

       LOOP AT lt_lista_tecnica_equi INTO ls_lista_tecnica_equi.
         CLEAR ls_lista_tecnica.
         MOVE-CORRESPONDING ls_lista_tecnica_equi TO ls_lista_tecnica.
         ls_lista_tecnica-matnr = ls_lista_tecnica_equi-idnrk.

         CALL FUNCTION '/PTLOMS/MF047'
           DESTINATION lv_rfcdest
           EXPORTING
             im_matnr = ls_lista_tecnica-matnr
           IMPORTING
             ex_maktx = ls_lista_tecnica-maktx.
*          SELECT SINGLE maktx
*            FROM makt
*            INTO @ls_lista_tecnica-maktx
*            WHERE matnr = @ls_lista_tecnica-matnr
*              AND spras = @sy-langu.
         APPEND ls_lista_tecnica TO lt_lista_tecnica.
       ENDLOOP.
       LOOP AT lt_lista_tecnica_mat INTO ls_lista_tecnica_mat.
         CLEAR ls_lista_tecnica.
         MOVE-CORRESPONDING ls_lista_tecnica_mat TO ls_lista_tecnica.
         APPEND ls_lista_tecnica TO lt_lista_tecnica.
       ENDLOOP.

* Retira zeros a esquerda
       LOOP AT lt_ponto_medicao ASSIGNING <fs_ponto_medicao>.
         <fs_ponto_medicao>-point = |{ <fs_ponto_medicao>-point ALPHA = OUT }|.
       ENDLOOP.
       LOOP AT lt_documento_medicao ASSIGNING <fs_documento_medicao>.
         <fs_documento_medicao>-point = |{ <fs_documento_medicao>-point ALPHA = OUT }|.
       ENDLOOP.

       LOOP AT lt_filtro_equnr ASSIGNING <fs_filtro_equnr>.
         lv_equipamento_in = <fs_filtro_equnr>-key.
         lv_equipamento_in = |{ lv_equipamento_in ALPHA = IN }|.
         <fs_filtro_equnr>-key = lv_equipamento_in.
         <fs_filtro_equnr>-text = lv_equipamento_in.
       ENDLOOP.

       ls_out_equipamento-out_equipamentoset            = lt_equipamento.
       ls_out_equipamento-out_classe_caracteristicaset  = lt_caracteristicas.
       ls_out_equipamento-out_catalogoset               = lt_catalogos.
       ls_out_equipamento-out_ponto_medicaoset          = lt_ponto_medicao.
       ls_out_equipamento-out_documento_medicaoset      = lt_documento_medicao.
       ls_out_equipamento-out_parceiro_negocioset       = lt_parceiro_negocio.
       ls_out_equipamento-out_filtro_equnrset           = lt_filtro_equnr.
       ls_out_equipamento-out_filtro_eqktxset           = lt_filtro_eqktx.
       ls_out_equipamento-out_filtro_invnrset           = lt_filtro_invnr.
       ls_out_equipamento-out_filtro_tidnrset           = lt_filtro_tidnr.

*        ls_out_equipamento-out_lista_tecnicaset          = lt_lista_tecnica.
       LOOP AT lt_lista_tecnica INTO DATA(ls_lista_tecnica_equi_aux).
         CLEAR ls_lista_tecnica_equiset.
         MOVE-CORRESPONDING ls_lista_tecnica_equi_aux TO ls_lista_tecnica_equiset.

         REFRESH: rt_matnr[], rt_werks[].

         CLEAR ls_matnr.
         ls_matnr-sign = 'I'.
         ls_matnr-option = 'EQ'.
         ls_matnr-low = ls_lista_tecnica_equi_aux-matnr.
         APPEND ls_matnr TO rt_matnr.

         IF ls_lista_tecnica_equi_aux-equnr IS NOT INITIAL.
           CLEAR: lv_submt, lv_iwerk.
           CALL FUNCTION '/PTLOMS/MF045'
             DESTINATION lv_rfcdest
             EXPORTING
               im_equnr = ls_lista_tecnica_equi_aux-equnr
             IMPORTING
               ex_submt = lv_submt
               ex_iwerk = lv_iwerk.
         ELSE.
           lv_iwerk = ls_lista_tecnica_equi_aux-werks.
         ENDIF.

         CLEAR ls_werks.
         ls_werks-sign = 'I'.
         ls_werks-option = 'EQ'.
         ls_werks-low = lv_iwerk.
         APPEND ls_werks TO rt_werks.

         REFRESH lt_saldo_material[].
         CALL FUNCTION '/PTLOMS/MF032'
           DESTINATION lv_rfcdest
           EXPORTING
             rt_matnr       = rt_matnr
             rt_werks       = rt_werks
             rt_lgort       = rt_lgort_aux
             rt_usuario_app = rt_usuario_app
           IMPORTING
             it_saldo       = lt_saldo_material.

         ls_lista_tecnica_equiset-out_saldo_materialset = lt_saldo_material.

         ls_lista_tecnica_equiset-idnrk = |{ ls_lista_tecnica_equiset-idnrk ALPHA = OUT }|.
         ls_lista_tecnica_equiset-matnr = |{ ls_lista_tecnica_equiset-matnr ALPHA = OUT }|.

*          LOOP AT ls_out_equipamento-out_equipamentoset ASSIGNING FIELD-SYMBOL(<fs_out_equipamentoset>).
*            SHIFT <fs_out_equipamentoset>-equnr LEFT DELETING LEADING '0'.
*          ENDLOOP.

         APPEND ls_lista_tecnica_equiset TO ls_out_equipamento-out_lista_tecnicaset.
       ENDLOOP.

       ls_out_equipamento-quantidade_equipamento = lv_quantidade_equipamento.
       APPEND ls_out_equipamento TO lt_out_equipamento.

       APPEND 'out_lista_tecnicaSet/out_saldo_materialSet' TO et_expanded_tech_clauses.

       copy_data_to_ref( EXPORTING is_data = lt_out_equipamento CHANGING cr_data = er_entityset ).

     WHEN 'root_out_material'.

** Autenticação - Início
*        IF lv_guid IS INITIAL OR lv_guid NE ls_guid_aux-low.
*          lv_mensagem = 'Favor iniciar uma nova sessão'.
*
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              textid  = /iwbep/cx_mgw_busi_exception=>business_error
*              message = lv_mensagem.
*        ENDIF.
** Autenticação - Fim

       " Carrega filtros
       IF it_filter_select_options[] IS NOT INITIAL.
         READ TABLE it_filter_select_options INTO DATA(ls_mtart) WITH KEY property = 'Mtart'.
         IF sy-subrc = 0.
           DATA(rt_mtart) = ls_mtart-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_werks_aux) WITH KEY property = 'Werks'.
         IF sy-subrc = 0.
           rt_werks = ls_werks_aux-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_lgort) WITH KEY property = 'Lgort'.
         IF sy-subrc = 0.
           DATA(rt_lgort) = ls_lgort-select_options.
         ENDIF.

*          READ TABLE it_filter_select_options INTO ls_usuario_app WITH KEY property = 'NomeUsuarioApp'.
*          IF sy-subrc = 0.
*            rt_usuario_app = ls_usuario_app-select_options.
*          ENDIF.
       ENDIF.

       lv_top  = is_paging-top.
       lv_skip = is_paging-skip.

       CLEAR lv_quantidade_material.
       CALL FUNCTION '/PTLOMS/MF028'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_mtart               = rt_mtart
           rt_werks               = rt_werks
           rt_lgort               = rt_lgort
           rt_usuario_app         = rt_usuario_app
           im_top                 = lv_top
           im_skip                = lv_skip
         IMPORTING
           rt_materiais           = lt_material
           ex_quantidade_material = lv_quantidade_material.
*        DATA(lt_material) = o_oms->out_material( rt_mtart       = rt_mtart
*                                                 rt_werks       = rt_werks
*                                                 rt_lgort       = rt_lgort
*                                                 rt_usuario_app = rt_usuario_app ).

*        ls_out_material-out_materialset = lt_material.
       LOOP AT lt_material INTO DATA(ls_material).
         MOVE-CORRESPONDING ls_material TO ls_out_materialset.

         REFRESH: rt_matnr[], rt_werks[].

         CLEAR ls_matnr.
         ls_matnr-sign = 'I'.
         ls_matnr-option = 'EQ'.
         ls_matnr-low = ls_material-matnr.
         APPEND ls_matnr TO rt_matnr.

         CLEAR ls_werks.
         ls_werks-sign = 'I'.
         ls_werks-option = 'EQ'.
         ls_werks-low = ls_material-werks.
         APPEND ls_werks TO rt_werks.

         REFRESH lt_saldo_material[].
         CALL FUNCTION '/PTLOMS/MF032'
           DESTINATION lv_rfcdest
           EXPORTING
             rt_matnr       = rt_matnr
             rt_werks       = rt_werks
             rt_lgort       = rt_lgort
             rt_usuario_app = rt_usuario_app
           IMPORTING
             it_saldo       = lt_saldo_material.

         ls_out_materialset-out_saldo_materialset = lt_saldo_material.

*          ls_out_materialset-matnr = |{ ls_out_materialset-matnr ALPHA = IN }|.
         SHIFT ls_out_materialset-matnr LEFT DELETING LEADING '0'.

         APPEND ls_out_materialset TO ls_out_material-out_materialset.
       ENDLOOP.

       ls_out_material-quantidade_material = lv_quantidade_material.

       APPEND ls_out_material TO lt_out_material.

       APPEND 'out_materialSet/out_saldo_materialSet' TO et_expanded_tech_clauses.

       copy_data_to_ref( EXPORTING is_data = lt_out_material CHANGING cr_data = er_entityset ).

     WHEN 'root_out_demais_dados_mestres'.

** Autenticação - Início
*        IF lv_guid IS INITIAL OR lv_guid NE ls_guid_aux-low.
*          lv_mensagem = 'Favor iniciar uma nova sessão'.
*
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              textid  = /iwbep/cx_mgw_busi_exception=>business_error
*              message = lv_mensagem.
*        ENDIF.
** Autenticação - Fim

       " Carrega filtros
       IF it_filter_select_options[] IS NOT INITIAL.
         READ TABLE it_filter_select_options INTO DATA(ls_empresa_centro) WITH KEY property = 'EmpresaCentro'.
         IF sy-subrc = 0.
           lv_empresa_centro = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_grupo_planejamento) WITH KEY property = 'GrupoPlanejamento'.
         IF sy-subrc = 0.
           lv_grupo_planejamento = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_area_operacional) WITH KEY property = 'AreaOperacional'.
         IF sy-subrc = 0.
           lv_area_operacional = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_centro_trabalho) WITH KEY property = 'CentroTrabalho'.
         IF sy-subrc = 0.
           lv_centro_trabalho = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_tipo_nota) WITH KEY property = 'TipoNota'.
         IF sy-subrc = 0.
           lv_tipo_nota = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_tipo_ordem) WITH KEY property = 'TipoOrdem'.
         IF sy-subrc = 0.
           lv_tipo_ordem = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_tipo_prioridade_ordem) WITH KEY property = 'TipoPrioridadeOrdem'.
         IF sy-subrc = 0.
           lv_tipo_prioridade_ordem = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_tipo_prioridade_nota) WITH KEY property = 'TipoPrioridadeNota'.
         IF sy-subrc = 0.
           lv_tipo_prioridade_nota  = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_tipo_atv_manutencao) WITH KEY property = 'TipoAtvManutencao'.
         IF sy-subrc = 0.
           lv_tipo_atv_manutencao = 'X'.
         ENDIF.

***         READ TABLE it_filter_select_options INTO DATA(ls_centro_custo) WITH KEY property = 'CentroCusto'.
***         IF sy-subrc = 0.
***           lv_centro_custo = 'X'.
***         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_condicao_inst_ordem) WITH KEY property = 'CondicaoInstOrdem'.
         IF sy-subrc = 0.
           lv_condicao_inst_ordem = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_tipo_atv_operacao) WITH KEY property = 'TipoAtvOperacao'.
         IF sy-subrc = 0.
           lv_tipo_atv_operacao = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_tipo_material) WITH KEY property = 'TipoMaterial'.
         IF sy-subrc = 0.
           lv_tipo_material = 'X'.
         ENDIF.

***         READ TABLE it_filter_select_options INTO DATA(ls_categoria_item_material) WITH KEY property = 'CategoriaItemMaterial'.
***         IF sy-subrc = 0.
***           lv_categoria_item_material = 'X'.
***         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_deposito) WITH KEY property = 'Deposito'.
         IF sy-subrc = 0.
           lv_deposito = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_categoria_equipamento) WITH KEY property = 'CategoriaEquipamento'.
         IF sy-subrc = 0.
           lv_categoria_equipamento = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_tipo_objeto) WITH KEY property = 'TipoObjeto'.
         IF sy-subrc = 0.
           lv_tipo_objeto = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_categoria_loc_inst) WITH KEY property = 'CategoriaLocInst'.
         IF sy-subrc = 0.
           lv_categoria_loc_inst = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_tipo_atv_ordem) WITH KEY property = 'TipoAtvOrdem'.
         IF sy-subrc = 0.
           lv_tipo_atv_ordem = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_causa_desvio) WITH KEY property = 'CausaDesvio'.
         IF sy-subrc = 0.
           lv_causa_desvio = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_matricula) WITH KEY property = 'Matricula'.
         IF sy-subrc = 0.
           lv_matricula = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_chave_modelo) WITH KEY property = 'ChaveModelo'.
         IF sy-subrc = 0.
           lv_chave_modelo = 'X'.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_centro_planejamento) WITH KEY property = 'CentroPlanejamento'.
         IF sy-subrc = 0.
           lv_centro_planejamento = 'X'.
         ENDIF.

       ENDIF.

       CALL FUNCTION '/PTLOMS/MF023'
         DESTINATION lv_rfcdest
         EXPORTING
           im_empresa_centro          = lv_empresa_centro
           im_grupo_planejamento      = lv_grupo_planejamento
           im_area_operacional        = lv_area_operacional
           im_centro_trabalho         = lv_centro_trabalho
           im_tipo_nota               = lv_tipo_nota
           im_tipo_ordem              = lv_tipo_ordem
           im_tipo_prioridade_ordem   = lv_tipo_prioridade_ordem
           im_tipo_prioridade_nota    = lv_tipo_prioridade_nota
           im_tipo_atv_manutencao     = lv_tipo_atv_manutencao
           im_centro_custo            = lv_centro_custo
           im_condicao_inst_ordem     = lv_condicao_inst_ordem
           im_tipo_atv_operacao       = lv_tipo_atv_operacao
           im_tipo_material           = lv_tipo_material
           im_categoria_item_material = lv_categoria_item_material
           im_deposito                = lv_deposito
           im_categoria_equipamento   = lv_categoria_equipamento
           im_tipo_objeto             = lv_tipo_objeto
           im_categoria_loc_inst      = lv_categoria_loc_inst
           im_tipo_atv_ordem          = lv_tipo_atv_ordem
           im_causa_desvio            = lv_causa_desvio
           im_matricula               = lv_matricula
           im_chave_modelo            = lv_chave_modelo
           rt_usuario_app             = rt_usuario_app
           im_centro_planejamento     = lv_centro_planejamento
           im_prioridade              = lv_prioridade
         IMPORTING
           it_empresa_centro          = lt_empresa_centro
           it_grupo_planejamento      = lt_grupo_planejamento
           it_area_operacional        = lt_area_operacional
           it_centro_trabalho         = lt_centro_trabalho
           it_tipo_nota               = lt_tipo_nota
           it_tipo_ordem              = lt_tipo_ordem
           it_tipo_prioridade_ordem   = lt_tipo_prioridade_ordem
           it_tipo_prioridade_nota    = lt_tipo_prioridade_nota
           it_tipo_atv_manutencao     = lt_tipo_atv_manutencao
           it_centro_custo            = lt_centro_custo
           it_condicao_inst_ordem     = lt_condicao_inst_ordem
           it_tipo_atv_operacao       = lt_tipo_atv_operacao
           it_tipo_material           = lt_tipo_material
           it_categoria_item_material = lt_categoria_item_material
           it_deposito                = lt_deposito
           it_categoria_equipamento   = lt_categoria_equipamento
           it_tipo_objeto             = lt_tipo_objeto
           it_categoria_loc_inst      = lt_categoria_loc_inst
           it_tipo_atv_ordem          = lt_tipo_atv_ordem
           it_causa_desvio            = lt_causa_desvio
           it_matricula               = lt_matricula
           it_chave_modelo            = lt_chave_modelo
           it_centro_planejamento     = lt_centro_planejamento
           it_prioridade              = lt_prioridade.

*        o_oms->out_demais_dados_mestres(
*          EXPORTING
*            im_empresa_centro          = lv_empresa_centro
*            im_grupo_planejamento      = lv_grupo_planejamento
*            im_area_operacional        = lv_area_operacional
*            im_centro_trabalho         = lv_centro_trabalho
*            im_tipo_nota               = lv_tipo_nota
*            im_tipo_ordem              = lv_tipo_ordem
*            im_tipo_prioridade_ordem   = lv_tipo_prioridade_ordem
*            im_tipo_prioridade_nota    = lv_tipo_prioridade_nota
*            im_tipo_atv_manutencao     = lv_tipo_atv_manutencao
*            im_centro_custo            = lv_centro_custo
*            im_condicao_inst_ordem     = lv_condicao_inst_ordem
*            im_tipo_atv_operacao       = lv_tipo_atv_operacao
*            im_tipo_material           = lv_tipo_material
*            im_categoria_item_material = lv_categoria_item_material
*            im_deposito                = lv_deposito
*            im_categoria_equipamento   = lv_categoria_equipamento
*            im_tipo_objeto             = lv_tipo_objeto
*            im_categoria_loc_inst      = lv_categoria_loc_inst
*            im_tipo_atv_ordem          = lv_tipo_atv_ordem
*            im_causa_desvio            = lv_causa_desvio
*            im_matricula               = lv_matricula
*            rt_usuario_app             = rt_usuario_app
*          IMPORTING
*            et_empresa_centro          = lt_empresa_centro
*            et_grupo_planejamento      = lt_grupo_planejamento
*            et_area_operacional        = lt_area_operacional
*            et_centro_trabalho         = lt_centro_trabalho
*            et_tipo_nota               = lt_tipo_nota
*            et_tipo_ordem              = lt_tipo_ordem
*            et_tipo_prioridade_ordem   = lt_tipo_prioridade_ordem
*            et_tipo_prioridade_nota    = lt_tipo_prioridade_nota
*            et_tipo_atv_manutencao     = lt_tipo_atv_manutencao
*            et_centro_custo            = lt_centro_custo
*            et_condicao_inst_ordem     = lt_condicao_inst_ordem
*            et_tipo_atv_operacao       = lt_tipo_atv_operacao
*            et_tipo_material           = lt_tipo_material
*            et_categoria_item_material = lt_categoria_item_material
*            et_deposito                = lt_deposito
*            et_categoria_equipamento   = lt_categoria_equipamento
*            et_tipo_objeto             = lt_tipo_objeto
*            et_categoria_loc_inst      = lt_categoria_loc_inst
*            et_tipo_atv_ordem          = lt_tipo_atv_ordem
*            et_causa_desvio            = lt_causa_desvio
*            et_matriculas              = lt_matricula ).

       ls_out_demais_dados_mestres-out_empresa_centroset          = lt_empresa_centro.
       ls_out_demais_dados_mestres-out_grupo_planejamentoset      = lt_grupo_planejamento.
       ls_out_demais_dados_mestres-out_area_operacionalset        = lt_area_operacional.
       ls_out_demais_dados_mestres-out_centro_trabalhoset         = lt_centro_trabalho.
       ls_out_demais_dados_mestres-out_tipo_notaset               = lt_tipo_nota.
       ls_out_demais_dados_mestres-out_tipo_ordemset              = lt_tipo_ordem.
       ls_out_demais_dados_mestres-out_tipo_prioridade_ordemset   = lt_tipo_prioridade_ordem.
       ls_out_demais_dados_mestres-out_tipo_prioridade_notaset    = lt_tipo_prioridade_nota.
       ls_out_demais_dados_mestres-out_tipo_atv_manutencaoset     = lt_tipo_atv_manutencao.
       ls_out_demais_dados_mestres-out_centro_custoset            = lt_centro_custo.
       ls_out_demais_dados_mestres-out_condicao_inst_ordemset     = lt_condicao_inst_ordem.
       ls_out_demais_dados_mestres-out_tipo_atv_operacaoset       = lt_tipo_atv_operacao.
       ls_out_demais_dados_mestres-out_tipo_materialset           = lt_tipo_material.
***       ls_out_demais_dados_mestres-out_categoria_item_materialset = lt_categoria_item_material.
       ls_out_demais_dados_mestres-out_depositoset                = lt_deposito.
       ls_out_demais_dados_mestres-out_categoria_equipamentoset   = lt_categoria_equipamento.
       ls_out_demais_dados_mestres-out_tipo_objetoset             = lt_tipo_objeto.
       ls_out_demais_dados_mestres-out_categoria_loc_instset      = lt_categoria_loc_inst.
       ls_out_demais_dados_mestres-out_tipo_atv_ordemset          = lt_tipo_atv_ordem.
       ls_out_demais_dados_mestres-out_causa_desvioset            = lt_causa_desvio.
       ls_out_demais_dados_mestres-out_matriculaset               = lt_matricula.
       ls_out_demais_dados_mestres-out_chave_modeloset            = lt_chave_modelo.
       ls_out_demais_dados_mestres-out_centro_planejamentoset     = lt_centro_planejamento.

       APPEND ls_out_demais_dados_mestres TO lt_out_demais_dados_mestres.

       copy_data_to_ref( EXPORTING is_data = lt_out_demais_dados_mestres CHANGING cr_data = er_entityset ).

     WHEN 'out_estoque_material'.

** Autenticação - Início
*        IF lv_guid IS INITIAL OR lv_guid NE ls_guid_aux-low.
*          lv_mensagem = 'Favor iniciar uma nova sessão'.
*
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              textid  = /iwbep/cx_mgw_busi_exception=>business_error
*              message = lv_mensagem.
*        ENDIF.
** Autenticação - Fim

       " Carrega filtros
       IF it_filter_select_options[] IS NOT INITIAL.
         READ TABLE it_filter_select_options INTO DATA(ls_matnr_estoque) WITH KEY property = 'Matnr'.
         IF sy-subrc = 0.
           rt_matnr = ls_matnr_estoque-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_werks_estoque) WITH KEY property = 'Werks'.
         IF sy-subrc = 0.
           rt_werks = ls_werks_estoque-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_lgort_estoque) WITH KEY property = 'LgortD'.
         IF sy-subrc = 0.
           rt_lgort = ls_lgort_estoque-select_options.
         ENDIF.
       ENDIF.

       REFRESH lt_saldo_material[].
       CALL FUNCTION '/PTLOMS/MF032'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_matnr       = rt_matnr
           rt_werks       = rt_werks
           rt_lgort       = rt_lgort
           rt_usuario_app = rt_usuario_app
         IMPORTING
           it_saldo       = lt_saldo_material.
*        o_oms->out_estoque_material(
*          EXPORTING
*            rt_matnr = rt_matnr
*            rt_werks = rt_werks
*            rt_lgort = rt_lgort
*          IMPORTING
*            et_saldo = lt_saldo_material ).

* Retirar zeros a esquerda
       LOOP AT lt_saldo_material ASSIGNING FIELD-SYMBOL(<fs_saldo_material>).
         <fs_saldo_material>-matnr = |{ <fs_saldo_material>-matnr ALPHA = OUT }|.
       ENDLOOP.

       ls_out_estoque_material-out_saldo_materialset = lt_saldo_material.
       APPEND ls_out_estoque_material TO lt_out_estoque_material.

       copy_data_to_ref( EXPORTING is_data = lt_out_estoque_material CHANGING cr_data = er_entityset ).

     WHEN 'out_usuario_completo'.

* Cria Sessão para usuário
       READ TABLE it_filter_select_options INTO ls_usuarioapp WITH KEY property = 'Usuario'.
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
*    lv_usuario = /ptloms/cl006=>busca_usuario( lv_usuario ).

       CALL FUNCTION '/PTLOMS/MF049'
         DESTINATION lv_rfcdest
         IMPORTING
           ex_usuario_sap = lv_usuario_sap.
*    SELECT SINGLE usuario_sap FROM /ptloms/tb033 INTO @DATA(lv_usuario_sap).

* Cria sessão para usuário Mobile (Ainda não foi autenticado)
*    IF ls_usuarioapp_aux-low IS NOT INITIAL.
       IF lv_usuario_sap IS INITIAL.

*      lv_usuario = ls_usuarioapp_aux-low.
*      TRANSLATE lv_usuario TO UPPER CASE.
         lv_senha     = ls_senha_aux-low.
         lv_confsenha = ls_confsenha_aux-low.

* Verifica se há necessidade de alterar a senha
         IF ls_senha_aux-low IS NOT INITIAL AND ls_confsenha_aux-low IS NOT INITIAL.

           CALL FUNCTION '/PTLOMS/MF043'
             DESTINATION lv_rfcdest
             EXPORTING
               im_usuario        = lv_usuario
               im_senha          = lv_senha
               im_confsenha      = lv_confsenha
             IMPORTING
               ex_senha_alterada = lv_senha_alterada.

           IF lv_senha_alterada IS INITIAL.
             RETURN.
           ENDIF.

         ENDIF.

         CALL FUNCTION '/PTLOMS/MF039'
           DESTINATION lv_rfcdest
           EXPORTING
             im_usuario     = lv_usuario
             im_senha       = lv_senha
           IMPORTING
             ex_autenticado = lv_autenticado.

         IF lv_autenticado IS INITIAL.
           lv_mensagem = 'Senha/Usuário inválido'(005).

           RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
             EXPORTING
               textid  = /iwbep/cx_mgw_busi_exception=>business_error
               message = lv_mensagem.
         ENDIF.

* Cria sessão para usuário SAP (Já foi autenticado)
       ELSE.
       ENDIF.

       IF rt_usuarioapp[] IS INITIAL.
         CLEAR ls_usuario_app.
         ls_usuario_app-sign = 'I'.
         ls_usuario_app-option = 'EQ'.
         ls_usuario_app-low = lv_usuario.
         APPEND ls_usuario_app TO rt_usuarioapp.
       ENDIF.

       CALL FUNCTION '/PTLOMS/MF034'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_usuario_app       = rt_usuarioapp
         IMPORTING
           it_dados_usuario_app = lt_dados_usuario_app.

       READ TABLE lt_dados_usuario_app INTO DATA(ls_dados_usuario_app) INDEX 1.
       IF sy-subrc EQ 0.

         IF ls_dados_usuario_app-bloqueado = 'X'.
           lv_mensagem = 'Usuário bloqueado'(014).

           RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
             EXPORTING
               textid  = /iwbep/cx_mgw_busi_exception=>business_error
               message = lv_mensagem.
         ENDIF.

         MOVE-CORRESPONDING ls_dados_usuario_app TO ls_out_usuario.
         ls_out_usuario-guid = lv_guid.
         CLEAR: ls_out_usuario-senha, ls_out_usuario-conf_senha.

* Autorização
         CALL FUNCTION '/PTLOMS/MF058'
           DESTINATION lv_rfcdest
           EXPORTING
             im_usuario     = lv_usuario
           IMPORTING
             it_autorizacao = lt_autorizacao.

         LOOP AT lt_autorizacao INTO DATA(ls_autorizacao_aux).
           CLEAR ls_autorizacao.
           MOVE-CORRESPONDING ls_autorizacao_aux TO ls_autorizacao.
           ls_autorizacao-guid = lv_guid.
           APPEND ls_autorizacao TO ls_out_usuario-out_autorizacao_completoset.
         ENDLOOP.

* Configuração Perfil
         lv_perfil = ls_dados_usuario_app-perfil.

         CALL FUNCTION '/PTLOMS/MF060'
           DESTINATION lv_rfcdest
           EXPORTING
             im_perfil       = lv_perfil
           IMPORTING
             it_configuracao = lt_configuracao.

         LOOP AT lt_configuracao INTO DATA(ls_configuracao_aux).
           CLEAR ls_configuracao.
           MOVE-CORRESPONDING ls_configuracao_aux TO ls_configuracao.
           APPEND ls_configuracao TO ls_out_usuario-out_config_perfil_completoset.
           IF ls_configuracao_aux-configuracao = '04'.
             DATA(lv_04) = 'X'.
           ENDIF.
           IF ls_configuracao_aux-configuracao = '05'.
             DATA(lv_05) = 'X'.
           ENDIF.
           IF ls_configuracao_aux-configuracao = '06'.
             DATA(lv_06) = 'X'.
           ENDIF.
           IF ls_configuracao_aux-configuracao = '07'.
             DATA(lv_07) = 'X'.
           ENDIF.
           IF ls_configuracao_aux-configuracao = '08'.
             DATA(lv_08) = 'X'.
           ENDIF.
         ENDLOOP.

* Configuração Sistema
         CALL FUNCTION '/PTLOMS/MF038'
           DESTINATION lv_rfcdest
           IMPORTING
             it_configuracao_sistema = lt_configuracao_sistema.

         LOOP AT lt_configuracao_sistema INTO DATA(ls_configuracao_sistema_aux).
           CLEAR ls_configuracao_sistema.
           MOVE-CORRESPONDING ls_configuracao_sistema_aux TO ls_configuracao_sistema.
           ls_configuracao_sistema-guid = lv_guid.
           IF lv_04 = 'X'.
             ls_configuracao_sistema-despacho_ordem = 'X'.
           ENDIF.
           IF lv_05 = 'X'.
             ls_configuracao_sistema-despacho_oper = 'X'.
           ENDIF.
           IF lv_06 = 'X'.
             ls_configuracao_sistema-chave_modelo = 'X'.
           ENDIF.
           IF lv_07 = 'X'.
             ls_configuracao_sistema-apont_manual = 'X'.
           ENDIF.
           IF lv_08 = 'X'.
             ls_configuracao_sistema-tipo_atividade = 'X'.
           ENDIF.
           APPEND ls_configuracao_sistema TO ls_out_usuario-out_config_sistema_completoset.
         ENDLOOP.
       ENDIF.

       APPEND ls_out_usuario TO lt_out_usuario.

       APPEND 'out_usuario_completoSet/out_autorizacao_completoSet'    TO et_expanded_tech_clauses.
       APPEND 'out_usuario_completoSet/out_config_perfil_completoSet'  TO et_expanded_tech_clauses.
       APPEND 'out_usuario_completoSet/out_config_sistema_completoSet' TO et_expanded_tech_clauses.

       copy_data_to_ref( EXPORTING is_data = lt_out_usuario CHANGING cr_data = er_entityset ).

     WHEN 'root_out_programacao_ordens'.

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

         READ TABLE it_filter_select_options INTO DATA(ls_iwerk_filter) WITH KEY property = 'Iwerk'.
         IF sy-subrc = 0.
           DATA(rt_iwerk_filter) = ls_iwerk_filter-select_options.
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

         READ TABLE it_filter_select_options INTO DATA(ls_gstrp_filter) WITH KEY property = 'Gstrp'.
         IF sy-subrc = 0.
           DATA(rt_gstrp_filter) = ls_gstrp_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_datope_filter) WITH KEY property = 'Datope'.
         IF sy-subrc = 0.
           DATA(rt_datope_filter) = ls_datope_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_usuapp_filter) WITH KEY property = 'Usuapp'.
         IF sy-subrc = 0.
           DATA(rt_usuapp_filter) = ls_usuapp_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_usuperfil_filter) WITH KEY property = 'Usuperfil'.
         IF sy-subrc = 0.
           DATA(rt_usuperfil_filter) = ls_usuperfil_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_ftree_filter) WITH KEY property = 'FTree'.
         IF sy-subrc = 0.
           DATA(rt_ftree_filter) = ls_ftree_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_matat_filter) WITH KEY property = 'MatAt'.
         IF sy-subrc = 0.
           DATA(rt_matat_filter) = ls_matat_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_oper_filter) WITH KEY property = 'Oper'.
         IF sy-subrc = 0.
           DATA(rt_oper_filter) = ls_oper_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_ordens_filter) WITH KEY property = 'Ordens'.
         IF sy-subrc = 0.
           DATA(rt_ordens_filter) = ls_ordens_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_gstrp_ini_filter) WITH KEY property = 'GstrpIni'.
         IF sy-subrc = 0.
           DATA(rt_gstrp_ini_filter) = ls_gstrp_ini_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_datope_ini_filter) WITH KEY property = 'DatopeIni'.
         IF sy-subrc = 0.
           DATA(rt_datope_ini_filter) = ls_datope_ini_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_gstrp_fim_filter) WITH KEY property = 'GstrpFim'.
         IF sy-subrc = 0.
           DATA(rt_gstrp_fim_filter) = ls_gstrp_fim_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_datope_fim_filter) WITH KEY property = 'DatopeFim'.
         IF sy-subrc = 0.
           DATA(rt_datope_fim_filter) = ls_datope_fim_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_vlsch_filter) WITH KEY property = 'Vlsch'.
         IF sy-subrc = 0.
           DATA(rt_vlsch_filter) = ls_vlsch_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO DATA(ls_ernam_filter) WITH KEY property = 'Ernam'.
         IF sy-subrc = 0.
           DATA(rt_ernam_filter) = ls_ernam_filter-select_options.
         ENDIF.

       ENDIF.

       CLEAR lv_quantidade_registros.
       CALL FUNCTION '/PTLOMS/MF061'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_werks      = rt_werks_filter
           rt_aufnr      = rt_aufnr_filter
           rt_vornr      = rt_vornr_filter
           rt_auart      = rt_auart_filter
           rt_qmnum      = rt_qmnum_filter
           rt_priok      = rt_priok_filter
           rt_tplnr      = rt_tplnr_filter
           rt_equnr      = rt_equnr_filter
           rt_iwerk      = rt_iwerk_filter
           rt_ingpr      = rt_ingpr_filter
           rt_ilart      = rt_ilart_filter
           rt_gewrk      = rt_gewrk_filter
           rt_gstrp      = rt_gstrp_filter
           rt_datope     = rt_datope_filter
           rt_usuapp     = rt_usuapp_filter
           rt_usuperfil  = rt_usuperfil_filter  " Usuário para filtrar documentos cadastrados no perfil
           rt_f_tree     = rt_ftree_filter
           rt_mat_at     = rt_matat_filter
           rt_oper       = rt_oper_filter
           rt_ordens     = rt_ordens_filter
           rt_gstrp_ini  = rt_gstrp_ini_filter
           rt_datope_ini = rt_datope_ini_filter
           rt_gstrp_fim  = rt_gstrp_fim_filter
           rt_datope_fim = rt_datope_fim_filter
           rt_vlsch      = rt_vlsch_filter
           rt_ernam      = rt_ernam_filter
         IMPORTING
           it_despacho   = lt_despacho
           it_filtro     = lt_filtro.

       DESCRIBE TABLE lt_despacho LINES lv_quantidade_registros.

       " Enviar lista de ordens - 08/03/2023
       ls_programaca_ordens-out_programacao_lista_operset = lt_despacho.

       SORT ls_programaca_ordens-out_programacao_lista_operset BY aufnr.

       TYPES:
         BEGIN OF ty_soma,
           aufnr     TYPE aufnr,
           sum_arbei TYPE /ptloms/et078-arbei,
           sum_ismnw TYPE /ptloms/et078-ismnw,
         END OF ty_soma,

         BEGIN OF ty_soma_usr,
           usuarioapp TYPE /ptloms/et078-usuarioapp,
           sum_arbei  TYPE /ptloms/et078-arbei,
           sum_ismnw  TYPE /ptloms/et078-ismnw,
         END OF ty_soma_usr.

       DATA:
         lt_soma        TYPE HASHED TABLE OF ty_soma WITH UNIQUE KEY aufnr,
         lt_soma_usr    TYPE HASHED TABLE OF ty_soma_usr WITH UNIQUE KEY usuarioapp,
         ls_soma        TYPE ty_soma,
         ls_soma_usr    TYPE ty_soma_usr,
         lv_total_arbei TYPE /ptloms/et078-arbei,
         lv_total_ismnw TYPE /ptloms/et078-ismnw,
         wa_arbei       TYPE c LENGTH 15,
         wa_ismnw       TYPE c LENGTH 15.


       LOOP AT ls_programaca_ordens-out_programacao_lista_operset
           INTO DATA(ls_despacho)
           GROUP BY ls_despacho-aufnr.

         ls_soma = VALUE ty_soma( aufnr = ls_despacho-aufnr ).

         LOOP AT GROUP ls_despacho INTO DATA(ls_group).
           ls_soma-sum_arbei = ls_soma-sum_arbei + ls_group-arbei.
           ls_soma-sum_ismnw = ls_soma-sum_ismnw + ls_group-ismnw.
         ENDLOOP.

         INSERT ls_soma INTO TABLE lt_soma.

       ENDLOOP.

       LOOP AT ls_programaca_ordens-out_programacao_lista_operset
         INTO DATA(ls_despacho_usr)
         GROUP BY ls_despacho_usr-usuarioapp.

         ls_soma_usr = VALUE ty_soma_usr( usuarioapp = ls_despacho_usr-usuarioapp ).


         LOOP AT GROUP ls_despacho_usr INTO DATA(ls_group_usr).
           ls_soma_usr-sum_arbei = ls_soma_usr-sum_arbei + ls_group_usr-arbei.
           ls_soma_usr-sum_ismnw = ls_soma_usr-sum_ismnw + ls_group_usr-ismnw.
         ENDLOOP.


         INSERT ls_soma_usr INTO TABLE lt_soma_usr.

       ENDLOOP.

       LOOP AT ls_programaca_ordens-out_programacao_lista_operset
           ASSIGNING FIELD-SYMBOL(<fs_despacho>).

         READ TABLE lt_soma INTO ls_soma
           WITH TABLE KEY aufnr = <fs_despacho>-aufnr.
         IF sy-subrc = 0.
           CLEAR:
             wa_arbei,
             wa_ismnw.

           WRITE ls_soma-sum_arbei TO wa_arbei.
           WRITE ls_soma-sum_ismnw TO wa_ismnw.

           CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
             EXPORTING
               input  = wa_arbei
             IMPORTING
               output = wa_arbei.

           CONDENSE wa_arbei NO-GAPS.
           TRANSLATE wa_arbei USING ',.'.

           CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
             EXPORTING
               input  = wa_ismnw
             IMPORTING
               output = wa_ismnw.

           CONDENSE wa_ismnw NO-GAPS.
           TRANSLATE wa_ismnw USING ',.'.

           CONCATENATE '(P:' wa_arbei 'H ) - (R:' wa_ismnw 'H )'
                  "INTO ls_despacho-horas_trab_real
                  INTO <fs_despacho>-horas_trab_real
                  SEPARATED BY space.
         ENDIF.


         READ TABLE lt_soma_usr INTO ls_soma_usr
   WITH TABLE KEY usuarioapp = <fs_despacho>-usuarioapp.
         IF sy-subrc = 0.
           CLEAR: wa_arbei, wa_ismnw.
           WRITE ls_soma_usr-sum_arbei TO wa_arbei.
           WRITE ls_soma_usr-sum_ismnw TO wa_ismnw.

           CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
             EXPORTING
               input  = wa_arbei
             IMPORTING
               output = wa_arbei.

           CONDENSE wa_arbei NO-GAPS.
           TRANSLATE wa_arbei USING ',.'.

           CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
             EXPORTING
               input  = wa_ismnw
             IMPORTING
               output = wa_ismnw.

           CONDENSE wa_ismnw NO-GAPS.
           TRANSLATE wa_ismnw USING ',.'.

           CONCATENATE '(P:' wa_arbei 'H ) - (R:' wa_ismnw 'H )'
             INTO <fs_despacho>-horas_trab_real_usr
             SEPARATED BY space.
         ENDIF.

       ENDLOOP.

       ls_programaca_ordens-out_programacao_lista_ordemset = lt_despacho.

       " Sumarizar campos de horas real e planejadas
       LOOP AT ls_programaca_ordens-out_programacao_lista_ordemset INTO ls_despacho.

         ADD ls_despacho-arbei TO lv_arbei.
         ADD ls_despacho-ismnw TO lv_ismnw.

         AT END OF aufnr.

           CLEAR: ls_despacho-arbei, ls_despacho-ismnw.
           ls_despacho-arbei = lv_arbei.
           ls_despacho-ismnw = lv_ismnw.

           MODIFY ls_programaca_ordens-out_programacao_lista_ordemset FROM ls_despacho TRANSPORTING arbei ismnw.

           CLEAR: lv_arbei, lv_ismnw.

         ENDAT.

       ENDLOOP.

       " Lista de ordens
       SORT ls_programaca_ordens-out_programacao_lista_ordemset BY aufnr ASCENDING vornr DESCENDING.
       DELETE ADJACENT DUPLICATES FROM ls_programaca_ordens-out_programacao_lista_ordemset COMPARING aufnr.

       LOOP AT ls_programaca_ordens-out_programacao_lista_ordemset ASSIGNING FIELD-SYMBOL(<fs_ordem>).
         CLEAR: <fs_ordem>-vornr.
       ENDLOOP.

       " Enviar lista de ordens - 08/03/2023

       ls_programaca_ordens-quantidade_registros      = lv_quantidade_registros.
*        ls_programaca_ordens-out_filtroset             = lt_filtro.
       LOOP AT lt_filtro INTO DATA(ls_filtro_aux).
         CLEAR ls_filtro.
         MOVE-CORRESPONDING ls_filtro_aux TO ls_filtro.
         ls_filtro-out_filtro_valuesset = ls_filtro_aux-values.
         APPEND ls_filtro TO ls_programaca_ordens-out_filtroset.
       ENDLOOP.

       " Lista de usuários para associação
       CALL FUNCTION '/PTLOMS/MF070'
         DESTINATION lv_rfcdest
         CHANGING
           it_usuarios_associar = ls_programaca_ordens-out_usuario_associarset.

       " Obtem a tabela de descrição do centro de trabalho

       CALL FUNCTION '/PTLOMS/MF101'
         DESTINATION lv_rfcdest
         EXPORTING
           it_usuarios = ls_programaca_ordens-out_usuario_associarset
         IMPORTING
           et_usuarios = ls_programaca_ordens-out_usuario_associarset.

** Inicio: Código movido para função MF101
*       SELECT sobid objid
*         FROM hrp1001
*         INTO TABLE lt_hrp
*         FOR ALL ENTRIES IN ls_programaca_ordens-out_usuario_associarset
*         WHERE otype = 'P'                AND
*               objid = ls_programaca_ordens-out_usuario_associarset-matricula AND
*               sclas = 'A'.
*
*       IF sy-subrc IS INITIAL.
*
*         LOOP AT lt_hrp ASSIGNING FIELD-SYMBOL(<fs_hrp>).
*           <fs_hrp>-objid_ = <fs_hrp>-sobid.
*         ENDLOOP.
*
*         SORT lt_hrp BY objid.
*
*         SELECT sobid objid FROM
*           hrp1001
*           INTO TABLE lt_hrp_
*           FOR ALL ENTRIES IN lt_hrp
*           WHERE otype = 'A'          AND
*                 objid = lt_hrp-objid_ AND
*                 sclas = 'LA'.
*
*         IF sy-subrc IS INITIAL.
*
*           LOOP AT lt_hrp_ ASSIGNING <fs_hrp>.
*             <fs_hrp>-objid_ = <fs_hrp>-sobid.
*           ENDLOOP.
*
*           SORT lt_hrp_ BY objid.
*
*           SELECT * FROM
*             crhd
*             INTO TABLE @DATA(lt_crhdr)
*             FOR ALL ENTRIES IN @lt_hrp_
*             WHERE objty = 'A'         AND
*                   objid = @lt_hrp_-objid_.
*
*         ENDIF.
*
*       ENDIF.
*
*       IF sy-subrc EQ 0.
*         LOOP AT ls_programaca_ordens-out_usuario_associarset ASSIGNING FIELD-SYMBOL(<fs_grupo_planejamento>).
*
*           READ TABLE lt_hrp ASSIGNING <fs_hrp> WITH KEY objid = <fs_grupo_planejamento>-matricula BINARY SEARCH.
*
*           IF sy-subrc IS INITIAL.
*
*             READ TABLE lt_hrp_ ASSIGNING FIELD-SYMBOL(<fs_hrp_>) WITH KEY objid = <fs_hrp>-objid_ BINARY SEARCH.
*
*             IF sy-subrc IS INITIAL.
*
*               READ TABLE lt_crhdr INTO DATA(ls_crhd) WITH KEY objid = <fs_hrp_>-objid_ BINARY SEARCH.
*
*               IF sy-subrc IS INITIAL.
*                 <fs_grupo_planejamento>-arbpl = ls_crhd-arbpl.
*
*
*               ENDIF.
*
*             ENDIF.
*
*           ELSE.
*
*             CLEAR: ls_crhd-arbpl.
*
*           ENDIF.
*
*         ENDLOOP.
*       ENDIF.
** Fim: Código movido para função MF101

       " SELECT objty, objid, arbpl
       "   FROM crhd
       "   INTO TABLE @DATA(lt_crhd)
       "   FOR ALL ENTRIES IN @ls_programaca_ordens-out_usuario_associarset
       "   WHERE objid = @ls_programaca_ordens-out_usuario_associarset-objid.

       "     IF sy-subrc EQ 0.
       "       LOOP AT ls_programaca_ordens-out_usuario_associarset ASSIGNING FIELD-SYMBOL(<fs_grupo_planejamento>).
       "         READ TABLE lt_crhdr INTO DATA(ls_crhd) WITH KEY objid = <fs_grupo_planejamento>-objid BINARY SEARCH.
       "         IF sy-subrc = 0.
       "           <fs_grupo_planejamento>-arbpl = ls_crhd-arbpl.
       "         ENDIF.
       "       ENDLOOP.
       "     ENDIF.

       " Motivos para desassociar ordem
       CALL FUNCTION '/PTLOMS/MF071'
         DESTINATION lv_rfcdest
         CHANGING
           it_motivo_dessassociar = ls_programaca_ordens-out_motivos_desassociarset.

       " Descrição dos status de associação
*       CALL FUNCTION '/PTLOMS/MF083'
*         DESTINATION lv_rfcdest
*         IMPORTING
*           it_status_associacao = ls_programaca_ordens-out_status_associacaoset.

       APPEND ls_programaca_ordens TO lt_programacao_ordens.

       APPEND 'root_out_programacao_ordensSet/out_usuario_associarSet'            TO et_expanded_tech_clauses.
       APPEND 'root_out_programacao_ordensSet/out_programacao_lista_operSet'      TO et_expanded_tech_clauses.
       APPEND 'root_out_programacao_ordensSet/out_filtroSet'                      TO et_expanded_tech_clauses.
       APPEND 'root_out_programacao_ordensSet/out_filtroSet/out_filtro_valuesSet' TO et_expanded_tech_clauses.
       "APPEND 'root_out_programacao_ordensSet/out_status_associacaoSet'           TO et_expanded_tech_clauses.

       copy_data_to_ref( EXPORTING is_data = lt_programacao_ordens CHANGING cr_data = er_entityset ).

     WHEN 'root_out_programacao_usuarios'.

       " Carrega filtros
       IF it_filter_select_options[] IS NOT INITIAL.
         READ TABLE it_filter_select_options INTO ls_werks_filter WITH KEY property = 'Werks'.
         IF sy-subrc = 0.
           rt_werks_filter = ls_werks_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_aufnr_filter WITH KEY property = 'Aufnr'.
         IF sy-subrc = 0.
           rt_aufnr_filter = ls_aufnr_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_auart_filter WITH KEY property = 'Auart'.
         IF sy-subrc = 0.
           rt_auart_filter = ls_auart_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_qmnum_filter WITH KEY property = 'Qmnum'.
         IF sy-subrc = 0.
           rt_qmnum_filter = ls_qmnum_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_priok_filter WITH KEY property = 'Priok'.
         IF sy-subrc = 0.
           rt_priok_filter = ls_priok_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_tplnr_filter WITH KEY property = 'Tplnr'.
         IF sy-subrc = 0.
           rt_tplnr_filter = ls_tplnr_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_equnr_filter WITH KEY property = 'Equnr'.
         IF sy-subrc = 0.
           rt_equnr_filter = ls_equnr_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_iwerk_filter WITH KEY property = 'Iwerk'.
         IF sy-subrc = 0.
           rt_iwerk_filter = ls_iwerk_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_ingpr_filter WITH KEY property = 'Ingpr'.
         IF sy-subrc = 0.
           rt_ingpr_filter = ls_ingpr_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_ilart_filter WITH KEY property = 'Ilart'.
         IF sy-subrc = 0.
           rt_ilart_filter = ls_ilart_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_gewrk_filter WITH KEY property = 'Gewrk'.
         IF sy-subrc = 0.
           rt_gewrk_filter = ls_gewrk_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_gstrp_filter WITH KEY property = 'Gstrp'.
         IF sy-subrc = 0.
           rt_gstrp_filter = ls_gstrp_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_datope_filter WITH KEY property = 'Datope'.
         IF sy-subrc = 0.
           rt_datope_filter = ls_datope_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_usuapp_filter WITH KEY property = 'Usuapp'.
         IF sy-subrc = 0.
           rt_usuapp_filter = ls_usuapp_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_ftree_filter WITH KEY property = 'FTree'.
         IF sy-subrc = 0.
           rt_ftree_filter = ls_ftree_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_matat_filter WITH KEY property = 'MatAt'.
         IF sy-subrc = 0.
           rt_matat_filter = ls_matat_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_oper_filter WITH KEY property = 'Oper'.
         IF sy-subrc = 0.
           rt_oper_filter = ls_oper_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_ordens_filter WITH KEY property = 'Ordens'.
         IF sy-subrc = 0.
           rt_ordens_filter = ls_ordens_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_gstrp_ini_filter WITH KEY property = 'GstrpIni'.
         IF sy-subrc = 0.
           rt_gstrp_ini_filter = ls_gstrp_ini_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_datope_ini_filter WITH KEY property = 'DatopeIni'.
         IF sy-subrc = 0.
           rt_datope_ini_filter = ls_datope_ini_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_gstrp_fim_filter WITH KEY property = 'GstrpFim'.
         IF sy-subrc = 0.
           rt_gstrp_fim_filter = ls_gstrp_fim_filter-select_options.
         ENDIF.

         READ TABLE it_filter_select_options INTO ls_datope_fim_filter WITH KEY property = 'DatopeFim'.
         IF sy-subrc = 0.
           rt_datope_fim_filter = ls_datope_fim_filter-select_options.
         ENDIF.

       ENDIF.

       CLEAR lv_quantidade_registros.
       CALL FUNCTION '/PTLOMS/MF062'
         DESTINATION lv_rfcdest
         EXPORTING
           rt_werks         = rt_werks_filter
           rt_aufnr         = rt_aufnr_filter
           rt_auart         = rt_auart_filter
           rt_qmnum         = rt_qmnum_filter
           rt_priok         = rt_priok_filter
           rt_tplnr         = rt_tplnr_filter
           rt_equnr         = rt_equnr_filter
           rt_iwerk         = rt_iwerk_filter
           rt_ingpr         = rt_ingpr_filter
           rt_ilart         = rt_ilart_filter
           rt_gewrk         = rt_gewrk_filter
           rt_gstrp         = rt_gstrp_filter
           rt_datope        = rt_datope_filter
           rt_usuapp        = rt_usuapp_filter
           rt_f_tree        = rt_ftree_filter
           rt_mat_at        = rt_matat_filter
           rt_oper          = rt_oper_filter
           rt_ordens        = rt_ordens_filter
           rt_gstrp_ini     = rt_gstrp_ini_filter
           rt_datope_ini    = rt_datope_ini_filter
           rt_gstrp_fim     = rt_gstrp_fim_filter
           rt_datope_fim    = rt_datope_fim_filter
         IMPORTING
           it_despacho_tree = lt_despacho_tree.

       DESCRIBE TABLE lt_despacho_tree LINES lv_quantidade_registros.
       ls_programaca_usuarios-out_programacao_usuariosset = lt_despacho_tree.
       ls_programaca_usuarios-quantidade_registros        = lv_quantidade_registros.

       APPEND ls_programaca_usuarios TO lt_programacao_usuarios.

       APPEND 'root_out_programacao_usuariosSet/out_programacao_usuariosSet'   TO et_expanded_tech_clauses.

       copy_data_to_ref( EXPORTING is_data = lt_programacao_usuarios CHANGING cr_data = er_entityset ).

     WHEN OTHERS.

   ENDCASE.

   " Controle de acessos
   ls_controle-entity_name     = iv_entity_name.
   ls_controle-metodo          = 'GET_EXPANDED_ENTITYSET'.
   ls_controle-usuario_sistema = sy-uname.
   ls_controle-aplicacao       = 'OMS'.
   ls_controle-usuario_app     = gv_usuario_app.

   " Controle de acessos
   /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

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


  METHOD out_associacoess_get_entityset.
    DATA: lv_rfcdest     TYPE bdbapidst,
          t_associacoes  TYPE /ptloms/cl_soms_mpc=>tt_out_associacoes,
          lt_associacoes TYPE /ptloms/ct118,
          ls_associacao  LIKE LINE OF t_associacoes,
          lv_usuario     TYPE xubname,
          lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    CASE iv_entity_set_name.

      WHEN 'out_associacoesSet'.


        DATA rt_aufnr TYPE /iwbep/t_cod_select_options.

        READ TABLE it_filter_select_options INTO DATA(ls_aufnr) WITH KEY property = 'Aufnr'.
        IF sy-subrc = 0.
          LOOP AT ls_aufnr-select_options INTO DATA(ls_aufnr2).
            APPEND ls_aufnr2 TO rt_aufnr.
          ENDLOOP.
        ENDIF.

        DATA rt_vornr TYPE /iwbep/t_cod_select_options.

        READ TABLE it_filter_select_options INTO DATA(ls_vornr) WITH KEY property = 'Vornr'.
        IF sy-subrc = 0.
          LOOP AT ls_vornr-select_options INTO DATA(ls_vornr2).
            APPEND ls_vornr2 TO rt_vornr.
          ENDLOOP.
        ENDIF.

        DATA rt_usuario TYPE /iwbep/t_cod_select_options.

        READ TABLE it_filter_select_options INTO DATA(ls_usuario) WITH KEY property = 'Usuario'.
        IF sy-subrc = 0.
          LOOP AT ls_usuario-select_options INTO DATA(ls_usuario2).
            APPEND ls_usuario2 TO rt_usuario.
          ENDLOOP.
        ENDIF.

        CALL FUNCTION '/PTLOMS/MF102'
          DESTINATION lv_rfcdest
          EXPORTING
            rt_aufnr       = rt_aufnr
            rt_vornr       = rt_vornr
            rt_usuario     = rt_usuario
          IMPORTING
            et_associacoes = lt_associacoes.

      WHEN OTHERS.

    ENDCASE.

    et_entityset = CORRESPONDING #( lt_associacoes ).

*    DATA: ls_controle TYPE /ptloms/tb048.
*
*    " Controle de acessos
*    ls_controle-entity_name     = iv_entity_name.
*    ls_controle-metodo          = 'OUT_ASSOCIACOES_GET_ENTITYSET'.
*    ls_controle-usuario_sistema = sy-uname.
*    ls_controle-aplicacao       = 'OMS'.
*    ls_controle-usuario_app     = gv_usuario_app.
*
*    " Controle de acessos
*    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).
  ENDMETHOD.


  METHOD out_autorizacaos_get_entityset.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_autorizacao TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_autorizacao.

    DATA: lt_autorizacao TYPE /ptloms/ct076.

    DATA: ls_autorizacao LIKE LINE OF t_autorizacao.

    DATA: lv_usuario     TYPE xubname,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    CASE iv_entity_set_name.

      WHEN 'out_autorizacaoSet'.

* Cria Sessão para usuário
        READ TABLE it_filter_select_options INTO DATA(ls_usuario) WITH KEY property = 'Usuario'.
        IF sy-subrc = 0.
          DATA(rt_usuario) = ls_usuario-select_options.
        ENDIF.
        READ TABLE rt_usuario INTO DATA(ls_usuario_aux) INDEX 1.

        lv_usuario = ls_usuario_aux-low.

        CALL FUNCTION '/PTLOMS/MF058'
          DESTINATION lv_rfcdest
          EXPORTING
            im_usuario     = lv_usuario
          IMPORTING
            it_autorizacao = lt_autorizacao.

        LOOP AT lt_autorizacao INTO DATA(ls_autorizacao_aux).
          CLEAR ls_autorizacao.
          MOVE-CORRESPONDING ls_autorizacao_aux TO ls_autorizacao.
          APPEND ls_autorizacao TO t_autorizacao.
        ENDLOOP.

      WHEN OTHERS.
    ENDCASE.

    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_autorizacao( t_autorizacao ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_AUTORIZACAOS_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).
  ENDMETHOD.


  METHOD out_catalogoset_get_entityset.

*    DATA: lv_rfcdest     TYPE bdbapidst,
*          lv_msgv1(50)   TYPE c,
*          lv_msgv2(50)   TYPE c,
*          lv_subrc       TYPE sy-subrc,
*          lv_same_user   TYPE rfcdisplay-rfcsameusr,
*          lv_usuario_sap TYPE flag,
*          ls_usuario     TYPE /iwbep/s_cod_select_option,
*          lv_guid        TYPE char32,
*          lv_usuario     TYPE xubname,
*          lt_catalogos   TYPE /ptloms/ct002.
*
*    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
*
*    IF sy-subrc EQ 0.
*
**Verifica se conexão está ativa
*      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
*        EXPORTING
*          rfcdestination = lv_rfcdest
*        IMPORTING
*          msgv1          = lv_msgv1
*          msgv2          = lv_msgv2
*          rfc_subrc      = lv_subrc.
*
*      IF lv_subrc NE 0.
*
*        IF lv_subrc = 3.
*
*          CONCATENATE 'Usuário Sem Autorização para RFC'(001) lv_rfcdest INTO DATA(lv_mensagem) SEPARATED BY space.
*
*        ELSE.
*
*          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
*
*        ENDIF.
*
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*            message = CONV bapi_msg( lv_mensagem ).
*
*      ENDIF.
*
*    ELSE.
*
*      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
** Valida Configuração RFC (Verifica se possui usuário fixo)
*    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
*      EXPORTING
*        destination             = lv_rfcdest
*      IMPORTING
*        same_user               = lv_same_user
*      EXCEPTIONS
*        authority_not_available = 1
*        destination_not_exist   = 2
*        information_failure     = 3
*        internal_failure        = 4
*        OTHERS                  = 5.
*
** Verifica se é Usuário SAP
*    CALL FUNCTION '/PTLOMS/MF049'
*      DESTINATION lv_rfcdest
*      IMPORTING
*        ex_usuario_sap = lv_usuario_sap.
*
*    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR "Se usuário SAP, então SAME_USER deve estar marcado
*       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio
*
*      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
** Autenticação
*    READ TABLE it_filter_select_options INTO DATA(ls_usuarioapp) WITH KEY property = 'UsuarioApp'.
*
*    IF sy-subrc = 0.
*
*      DATA(rt_usuario_app) = ls_usuarioapp-select_options.
*
*    ENDIF.
*
*    IF rt_usuario_app[] IS INITIAL.
*
*      ls_usuario-sign   = 'I'.
*      ls_usuario-option = 'EQ'.
*      ls_usuario-low = sy-uname.
*      APPEND ls_usuario TO rt_usuario_app.
*
*    ENDIF.
*
*    READ TABLE it_filter_select_options INTO DATA(ls_rbrn) WITH KEY property = 'Rbnr'.
*
*    IF sy-subrc = 0.
*
*      DATA(rt_rbnr) = ls_rbrn-select_options.
*
*    ENDIF.
*
*    CALL FUNCTION '/PTLOMS/MF019' DESTINATION lv_rfcdest
*      EXPORTING
*        rt_rbnr      = rt_rbnr
*      IMPORTING
*        it_catalogos = lt_catalogos.
*
*    et_entityset = CORRESPONDING #( lt_catalogos ).

  ENDMETHOD.


  METHOD out_configuracao_get_entityset.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_configuracao_sistema TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_configuracao_sistema.

    DATA: lt_configuracao_sistema TYPE /ptloms/ct074.

    DATA: ls_configuracao_sistema LIKE LINE OF t_configuracao_sistema.

*    DATA: o_oms TYPE REF TO /ptloms/cl001.
*
*    CREATE OBJECT o_oms.

    DATA: lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr..

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    CASE iv_entity_set_name.

      WHEN 'out_configuracao_sistemaSet'.

        CALL FUNCTION '/PTLOMS/MF038'
          DESTINATION lv_rfcdest
          IMPORTING
            it_configuracao_sistema = lt_configuracao_sistema.
*        o_oms->out_configuracao_sistema(
*          IMPORTING
*            et_configuracao_sistema = lt_configuracao_sistema ).

        LOOP AT lt_configuracao_sistema INTO DATA(ls_configuracao_sistema_aux).
          CLEAR ls_configuracao_sistema.
          MOVE-CORRESPONDING ls_configuracao_sistema_aux TO ls_configuracao_sistema.
          APPEND ls_configuracao_sistema TO t_configuracao_sistema.
        ENDLOOP.

      WHEN OTHERS.
    ENDCASE.

    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_configuracao_sistema( t_configuracao_sistema ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_CONFIGURACAO_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_config_perfi_get_entityset.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_configuracao TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_config_perfil.

    DATA: lt_configuracao TYPE /ptloms/ct078.

    DATA: ls_configuracao LIKE LINE OF t_configuracao.

    DATA: lv_perfil TYPE c LENGTH 10.

    DATA: lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr..

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    CASE iv_entity_set_name.

      WHEN 'out_config_perfilSet'.

* Cria Sessão para usuário
        READ TABLE it_filter_select_options INTO DATA(ls_perfil) WITH KEY property = 'Perfil'.
        IF sy-subrc = 0.
          DATA(rt_perfil) = ls_perfil-select_options.
        ENDIF.
        READ TABLE rt_perfil INTO DATA(ls_perfil_aux) INDEX 1.

        lv_perfil = ls_perfil_aux-low.

        CALL FUNCTION '/PTLOMS/MF060'
          DESTINATION lv_rfcdest
          EXPORTING
            im_perfil       = lv_perfil
          IMPORTING
            it_configuracao = lt_configuracao.

        LOOP AT lt_configuracao INTO DATA(ls_configuracao_aux).
          CLEAR ls_configuracao.
          MOVE-CORRESPONDING ls_configuracao_aux TO ls_configuracao.
          APPEND ls_configuracao TO t_configuracao.
        ENDLOOP.

      WHEN OTHERS.
    ENDCASE.

    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_config_perfil( t_configuracao ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_CONFIG_PERFI_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_documento_me_get_entityset.


*    DATA: lt_equipamento         TYPE /ptloms/ct019,
*          lt_filtro_equnr        TYPE /ptloms/ct056,
*          lt_filtro_eqktx        TYPE /ptloms/ct056,
*          lt_filtro_invnr        TYPE /ptloms/ct056,
*          lt_filtro_tidnr        TYPE /ptloms/ct056,
*          lv_rfcdest             TYPE bdbapidst,
*          lv_msgv1(50)           TYPE c,
*          lv_msgv2(50)           TYPE c,
*          lv_subrc               TYPE sy-subrc,
*          lv_same_user           TYPE rfcdisplay-rfcsameusr,
*          lv_usuario_sap         TYPE flag,
*          ls_usuario             TYPE /iwbep/s_cod_select_option,
*          lv_guid                TYPE char32,
*          out_equipamentoset     TYPE /ptloms/cl_soms_mpc=>tt_out_equipamento,
*          lv_usuario             TYPE xubname,
*          lt_documento_medicao   TYPE /ptloms/ct004,
*          r_point                TYPE /iwbep/t_cod_select_options.
*
*    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
*
*    IF sy-subrc EQ 0.
*
**Verifica se conexão está ativa
*      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
*        EXPORTING
*          rfcdestination = lv_rfcdest
*        IMPORTING
*          msgv1          = lv_msgv1
*          msgv2          = lv_msgv2
*          rfc_subrc      = lv_subrc.
*
*      IF lv_subrc NE 0.
*
*        IF lv_subrc = 3.
*
*          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO DATA(lv_mensagem) SEPARATED BY space.
*
*        ELSE.
*
*          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
*
*        ENDIF.
*
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*            message = CONV bapi_msg( lv_mensagem ).
*
*      ENDIF.
*
*    ELSE.
*
*      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
** Valida Configuração RFC (Verifica se possui usuário fixo)
*    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
*      EXPORTING
*        destination             = lv_rfcdest
*      IMPORTING
*        same_user               = lv_same_user
*      EXCEPTIONS
*        authority_not_available = 1
*        destination_not_exist   = 2
*        information_failure     = 3
*        internal_failure        = 4
*        OTHERS                  = 5.
*
** Verifica se é Usuário SAP
*    CALL FUNCTION '/PTLOMS/MF049'
*      DESTINATION lv_rfcdest
*      IMPORTING
*        ex_usuario_sap = lv_usuario_sap.
*
*    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR "Se usuário SAP, então SAME_USER deve estar marcado
*       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio
*
*      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
** Autenticação
*    READ TABLE it_filter_select_options INTO DATA(ls_usuarioapp) WITH KEY property = 'UsuarioApp'.
*
*    IF sy-subrc = 0.
*
*      DATA(rt_usuario_app) = ls_usuarioapp-select_options.
*
*    ENDIF.
*
*    IF rt_usuario_app[] IS INITIAL.
*
*      ls_usuario-sign   = 'I'.
*      ls_usuario-option = 'EQ'.
*      ls_usuario-low = sy-uname.
*      APPEND ls_usuario TO rt_usuario_app.
*
*    ENDIF.
*
*    READ TABLE rt_usuario_app INTO DATA(ls_usuario_app_aux) INDEX 1.
*
*    READ TABLE it_filter_select_options INTO DATA(ls_guid) WITH KEY property = 'Guid'.
*
*    IF sy-subrc = 0.
*
*      DATA(rt_guid) = ls_guid-select_options.
*
*    ENDIF.
*
*    READ TABLE rt_guid INTO DATA(ls_guid_aux) INDEX 1.
*
*    IF ls_usuario_app_aux-low IS NOT INITIAL.
*
*      lv_usuario = ls_usuario_app_aux-low.
*      TRANSLATE lv_usuario TO UPPER CASE.
*
*    ELSE.
*
*      lv_usuario = sy-uname.
*
*    ENDIF.
*
*    CALL FUNCTION '/PTLOMS/MF044'
*      DESTINATION lv_rfcdest
*      EXPORTING
*        im_usuario = CONV char12( lv_usuario )
*      IMPORTING
*        ex_usuario = lv_usuario.
*
*    CALL FUNCTION '/PTLOMS/MF042'
*      DESTINATION lv_rfcdest
*      EXPORTING
*        im_usuario = lv_usuario
*      IMPORTING
*        ex_guid    = lv_guid.
*
*    IF it_filter_select_options[] IS NOT INITIAL.
*
*      READ TABLE it_filter_select_options INTO DATA(ls_point) WITH KEY property = 'Point'.
*
*      IF sy-subrc = 0.
*
*        DATA(rt_point) = ls_point-select_options.
*
*      ENDIF.
*
*    ENDIF.
*
*    LOOP AT rt_point INTO DATA(lw_point).
*
*      lw_point-sign   = 'I'.
*      lw_point-option = 'EQ'.
*      lw_point-low    = lw_point-low.
*
*      APPEND lw_point TO r_point.
*
*    ENDLOOP.
*
*    DATA(lv_quantidade_equipamento) = 0.
*    DATA(lv_top)  = is_paging-top.
*    DATA(lv_skip) = is_paging-skip.
*
*    CALL FUNCTION '/PTLOMS/MF021'
*      DESTINATION lv_rfcdest
*      EXPORTING
*        rt_point             = r_point
*        rt_usuario_app       = rt_usuario_app
*      IMPORTING
*        it_documento_medicao = lt_documento_medicao.
*
*    LOOP AT lt_documento_medicao ASSIGNING FIELD-SYMBOL(<fs_documento_medicao>).
*      <fs_documento_medicao>-point = |{ <fs_documento_medicao>-point ALPHA = OUT }|.
*    ENDLOOP.
*
*    et_entityset = CORRESPONDING #( lt_documento_medicao ).

  ENDMETHOD.


  METHOD out_equipamentos_get_entityset.

    DATA: lt_imagens_equipamento TYPE /ptloms/ct072,
          lt_equipamento         TYPE /ptloms/ct019,
          lt_filtro_equnr        TYPE /ptloms/ct056,
          lt_filtro_eqktx        TYPE /ptloms/ct056,
          lt_filtro_invnr        TYPE /ptloms/ct056,
          lt_filtro_tidnr        TYPE /ptloms/ct056,
          lv_rfcdest             TYPE bdbapidst,
          lv_msgv1(50)           TYPE c,
          lv_msgv2(50)           TYPE c,
          lv_subrc               TYPE sy-subrc,
          lv_same_user           TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap         TYPE flag,
          ls_usuario             TYPE /iwbep/s_cod_select_option,
          out_equipamentoset     TYPE /ptloms/cl_soms_mpc=>tt_out_equipamento,
          lv_usuario             TYPE xubname.

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

          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO DATA(lv_mensagem) SEPARATED BY space.

        ELSE.

          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.

        ENDIF.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = CONV bapi_msg( lv_mensagem ).

      ENDIF.

    ELSE.

      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = CONV bapi_msg( lv_mensagem ).

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
          message = CONV bapi_msg( lv_mensagem ).

    ENDIF.

* Autenticação
    READ TABLE it_filter_select_options INTO DATA(ls_usuarioapp) WITH KEY property = 'UsuarioApp'.

    IF sy-subrc = 0.

      DATA(rt_usuario_app) = ls_usuarioapp-select_options.

    ENDIF.

    IF rt_usuario_app[] IS INITIAL.

      ls_usuario-sign   = 'I'.
      ls_usuario-option = 'EQ'.
      ls_usuario-low = sy-uname.
      APPEND ls_usuario TO rt_usuario_app.

    ENDIF.

    IF it_filter_select_options[] IS NOT INITIAL.

      READ TABLE it_filter_select_options INTO DATA(ls_bukrs) WITH KEY property = 'Bukrs'.

      IF sy-subrc = 0.

        DATA(rt_bukrs) = ls_bukrs-select_options.

      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_iwerk) WITH KEY property = 'Iwerk'.

      IF sy-subrc = 0.

        DATA(rt_iwerk) = ls_iwerk-select_options.

      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_ingrp) WITH KEY property = 'Ingrp'.

      IF sy-subrc = 0.

        DATA(rt_ingrp) = ls_ingrp-select_options.

      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_beber) WITH KEY property = 'Beber'.

      IF sy-subrc = 0.

        DATA(rt_beber) = ls_beber-select_options.

      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_gewrk) WITH KEY property = 'Gewrk'.

      IF sy-subrc = 0.

        DATA(rt_gewrk) = ls_gewrk-select_options.

      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_eqart) WITH KEY property = 'Eqart'.

      IF sy-subrc = 0.

        DATA(rt_eqart) = ls_eqart-select_options.

      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_eqtyp) WITH KEY property = 'Eqtyp'.

      IF sy-subrc = 0.

        DATA(rt_eqtyp) = ls_eqtyp-select_options.

      ENDIF.

    ENDIF.

    DATA(lv_quantidade_equipamento) = 0.
    DATA(lv_top)  = is_paging-top.
    DATA(lv_skip) = is_paging-skip.

    CALL FUNCTION '/PTLOMS/MF090' DESTINATION lv_rfcdest
      EXPORTING
        rt_bukrs                  = rt_bukrs
        rt_iwerk                  = rt_iwerk
        rt_ingrp                  = rt_ingrp
        rt_beber                  = rt_beber
        rt_gewrk                  = rt_gewrk
        rt_eqart                  = rt_eqart
        rt_eqtyp                  = rt_eqtyp
        rt_usuario_app            = rt_usuario_app
        im_top                    = lv_top
        im_skip                   = lv_skip
      IMPORTING
        it_imagems_equipamento    = lt_imagens_equipamento
        it_equipamento            = lt_equipamento
        it_filtro_equnr           = lt_filtro_equnr
        it_filtro_eqktx           = lt_filtro_eqktx
        it_filtro_invnr           = lt_filtro_invnr
        it_filtro_tidnr           = lt_filtro_tidnr
        ex_quantidade_equipamento = lv_quantidade_equipamento.

    LOOP AT lt_equipamento ASSIGNING FIELD-SYMBOL(<fs_equi>).
      <fs_equi>-quantidade_equipamento = lv_quantidade_equipamento.
      <fs_equi>-equnr = |{ <fs_equi>-equnr ALPHA = OUT }|.
      CALL FUNCTION 'CONVERSION_EXIT_TPLNR_OUTPUT'
        EXPORTING
          input  = <fs_equi>-tplnr
        IMPORTING
          output = <fs_equi>-tplnr.

    ENDLOOP.

    et_entityset = CORRESPONDING #( lt_equipamento ).

  ENDMETHOD.


  METHOD out_layout_cabse_get_entityset.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_layout TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_layout_cab.

    DATA: lt_layout TYPE /ptloms/ct083.

    DATA: ls_layout LIKE LINE OF t_layout.

    DATA: lv_usuario     TYPE xubname,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    CASE iv_entity_set_name.

      WHEN 'out_layout_cabSet'.

        READ TABLE it_filter_select_options INTO DATA(ls_tabela) WITH KEY property = 'Tabela'.
        IF sy-subrc = 0.
          DATA(rt_tabela) = ls_tabela-select_options.
        ENDIF.
        READ TABLE it_filter_select_options INTO DATA(ls_usuario) WITH KEY property = 'Usuario'.
        IF sy-subrc = 0.
          DATA(rt_usuario) = ls_usuario-select_options.
        ENDIF.
        READ TABLE it_filter_select_options INTO DATA(ls_padrao) WITH KEY property = 'Padrao'.
        IF sy-subrc = 0.
          DATA(rt_padrao) = ls_padrao-select_options.
        ENDIF.

        CALL FUNCTION '/PTLOMS/MF065'
          DESTINATION lv_rfcdest
          EXPORTING
            rt_tabela  = rt_tabela
            rt_usuario = rt_usuario
            rt_padrao  = rt_padrao
          IMPORTING
            it_layout  = lt_layout.

        LOOP AT lt_layout INTO DATA(ls_layout_aux).
          CLEAR ls_layout.
          MOVE-CORRESPONDING ls_layout_aux TO ls_layout.
          APPEND ls_layout TO t_layout.
        ENDLOOP.

      WHEN OTHERS.
    ENDCASE.

    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_layout_cab( t_layout ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_LAYOUT_CABSE_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_layout_items_get_entityset.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_layout_values TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_layout_item.

    DATA: lt_layout_values TYPE /ptloms/ct084.

    DATA: ls_layout_values LIKE LINE OF t_layout_values.

    DATA: lv_usuario     TYPE xubname,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    CASE iv_entity_set_name.

      WHEN 'out_layout_itemSet'.

        READ TABLE it_filter_select_options INTO DATA(ls_id_layout) WITH KEY property = 'IdLayout'.
        IF sy-subrc = 0.
          DATA(rt_id_layout) = ls_id_layout-select_options.
        ENDIF.

        CALL FUNCTION '/PTLOMS/MF066'
          DESTINATION lv_rfcdest
          EXPORTING
            rt_id_layout     = rt_id_layout
          IMPORTING
            it_layout_values = lt_layout_values.

        LOOP AT lt_layout_values INTO DATA(ls_layout_values_aux).
          CLEAR ls_layout_values.
          MOVE-CORRESPONDING ls_layout_values_aux TO ls_layout_values.
          APPEND ls_layout_values TO t_layout_values.
        ENDLOOP.

      WHEN OTHERS.
    ENDCASE.

    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_layout_item( t_layout_values ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_LAYOUT_ITEMS_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_lista_tarefa_get_entityset.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_lista_tarefa TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_lista_tarefa.

    DATA: lt_lista_tarefa TYPE /ptloms/ct121.

    DATA: ls_lista_tarefa LIKE LINE OF t_lista_tarefa.

    DATA: lv_usuario     TYPE xubname,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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
    READ TABLE it_filter_select_options INTO DATA(ls_filter) WITH KEY property = 'Usuario'.

    IF sy-subrc = 0.

      DATA(rt_usuario) = ls_filter-select_options.

    ENDIF.

    CALL FUNCTION '/PTLOMS/MF110'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_usuario = rt_usuario
      IMPORTING
        it_lista   = lt_lista_tarefa.

    LOOP AT lt_lista_tarefa ASSIGNING FIELD-SYMBOL(<fs_lista_tarefa>).

      CLEAR ls_lista_tarefa.
      MOVE-CORRESPONDING <fs_lista_tarefa> TO ls_lista_tarefa.

      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
        EXPORTING
          input  = <fs_lista_tarefa>-plnnr
        IMPORTING
          output = ls_lista_tarefa-plnnr.

      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
        EXPORTING
          input  = <fs_lista_tarefa>-plnal
        IMPORTING
          output = ls_lista_tarefa-plnal.

      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
        EXPORTING
          input  = <fs_lista_tarefa>-zaehl
        IMPORTING
          output = ls_lista_tarefa-zaehl.

      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
        EXPORTING
          input  = <fs_lista_tarefa>-equnr
        IMPORTING
          output = ls_lista_tarefa-equnr.

      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
        EXPORTING
          input  = <fs_lista_tarefa>-tplnr
        IMPORTING
          output = ls_lista_tarefa-tplnr.

      APPEND ls_lista_tarefa TO t_lista_tarefa.

    ENDLOOP.

    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_lista_tarefa( t_lista_tarefa ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_lista_tarefaSET_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_lista_tecn03_get_entityset. "out_lista_tecnica

*    DATA: lt_filtro_equnr       TYPE /ptloms/ct056,
*          lt_filtro_eqktx       TYPE /ptloms/ct056,
*          lt_filtro_invnr       TYPE /ptloms/ct056,
*          lt_filtro_tidnr       TYPE /ptloms/ct056,
*          lv_rfcdest            TYPE bdbapidst,
*          lv_msgv1(50)          TYPE c,
*          lv_msgv2(50)          TYPE c,
*          lv_subrc              TYPE sy-subrc,
*          lv_same_user          TYPE rfcdisplay-rfcsameusr,
*          lv_usuario_sap        TYPE flag,
*          ls_usuario            TYPE /iwbep/s_cod_select_option,
*          lv_guid               TYPE char32,
*          lv_usuario            TYPE xubname,
*          lt_lista_tecnica_equi TYPE /ptloms/ct031.
*
*    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
*
*    IF sy-subrc EQ 0.
*
**Verifica se conexão está ativa
*      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
*        EXPORTING
*          rfcdestination = lv_rfcdest
*        IMPORTING
*          msgv1          = lv_msgv1
*          msgv2          = lv_msgv2
*          rfc_subrc      = lv_subrc.
*
*      IF lv_subrc NE 0.
*
*        IF lv_subrc = 3.
*
*          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO DATA(lv_mensagem) SEPARATED BY space.
*
*        ELSE.
*
*          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
*
*        ENDIF.
*
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*            message = CONV bapi_msg( lv_mensagem ).
*
*      ENDIF.
*
*    ELSE.
*
*      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
** Valida Configuração RFC (Verifica se possui usuário fixo)
*    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
*      EXPORTING
*        destination             = lv_rfcdest
*      IMPORTING
*        same_user               = lv_same_user
*      EXCEPTIONS
*        authority_not_available = 1
*        destination_not_exist   = 2
*        information_failure     = 3
*        internal_failure        = 4
*        OTHERS                  = 5.
*
** Verifica se é Usuário SAP
*    CALL FUNCTION '/PTLOMS/MF049'
*      DESTINATION lv_rfcdest
*      IMPORTING
*        ex_usuario_sap = lv_usuario_sap.
*
*    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR "Se usuário SAP, então SAME_USER deve estar marcado
*       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio
*
*      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
*    READ TABLE it_filter_select_options INTO DATA(ls_equnr) WITH KEY property = 'Equnr'.
*
*    IF sy-subrc = 0.
*
*      DATA(rt_equnr) = ls_equnr-select_options.
*
*    ENDIF.
*
*    CALL FUNCTION '/PTLOMS/MF091' DESTINATION lv_rfcdest
*      EXPORTING
*        rt_equnr              = rt_equnr
*      IMPORTING
*        it_lista_tecnica_equi = lt_lista_tecnica_equi.
*
*    et_entityset = CORRESPONDING #( lt_lista_tecnica_equi ).

  ENDMETHOD.


  METHOD out_lista_tecnic_get_entityset.
*
*    DATA: ls_usuario                TYPE LINE OF /iwbep/t_mgw_name_value_pair,
*          it_local_instal           TYPE /iwbep/t_cod_select_options,
*          ls_local_instal           TYPE /iwbep/s_cod_select_option,
*          lv_rfcdest                TYPE bdbapidst,
*          t_local_instal            TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_local_instalacao,
*          lt_local_instal           TYPE /ptloms/ct081,
*          lv_usuario                TYPE xubname,
*          lv_usuario_sap            TYPE flag,
*          lv_same_user              TYPE rfcdisplay-rfcsameusr,
*          lv_msgv1(50)              TYPE c,
*          lv_msgv2(50)              TYPE c,
*          lv_subrc                  TYPE sy-subrc,
*          lv_mensagem               TYPE bapi_msg,
*          lv_usuario_app            TYPE char12,
*          it_ordem_catalogo         TYPE TABLE OF /ptloms/et128,
*          it_retorno_catalogo       TYPE TABLE OF /ptloms/et063,
*          lv_quantidade_local_inst  TYPE int4,
*          lt_lista_tecnica_loc_inst TYPE /ptloms/ct032.
*
** Busca Conexão
*    SELECT SINGLE rfcdest
*      FROM /ptloms/tb036 INTO lv_rfcdest.
*
*    IF sy-subrc EQ 0.
**Verifica se conexão está ativa
*      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
*        EXPORTING
*          rfcdestination = lv_rfcdest
*        IMPORTING
*          msgv1          = lv_msgv1
*          msgv2          = lv_msgv2
*          rfc_subrc      = lv_subrc.
*
*      IF lv_subrc NE 0.
*
*        IF lv_subrc = 3.
*
*          CONCATENATE 'Usuário Sem Autorização para RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
*
*        ELSE.
*
*          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
*
*        ENDIF.
*
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*            message = lv_mensagem.
*
*      ENDIF.
*
*    ELSE.
*
*      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = lv_mensagem.
*
*    ENDIF.
*
** Valida Configuração RFC (Verifica se possui usuário fixo)
*    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
*      EXPORTING
*        destination             = lv_rfcdest
*      IMPORTING
*        same_user               = lv_same_user
*      EXCEPTIONS
*        authority_not_available = 1
*        destination_not_exist   = 2
*        information_failure     = 3
*        internal_failure        = 4
*        OTHERS                  = 5.
*
** Verifica se é Usuário SAP
*    CALL FUNCTION '/PTLOMS/MF049'
*      DESTINATION lv_rfcdest
*      IMPORTING
*        ex_usuario_sap = lv_usuario_sap.
*
*    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR   "Se usuário SAP, então SAME_USER deve estar marcado
*       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio
*
*      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = lv_mensagem.
*
*    ENDIF.
*
*    IF it_filter_select_options[] IS NOT INITIAL.
*
*      READ TABLE it_filter_select_options INTO DATA(ls_filter) WITH KEY property = 'Tplnr'.
*
*      IF sy-subrc = 0.
*
*        DATA(rt_tplnr) = ls_filter-select_options.
*        DATA(lv_top)  = is_paging-top.
*        DATA(lv_skip) = is_paging-skip.
*
*        CLEAR lv_quantidade_local_inst.
*
*        CALL FUNCTION '/PTLOMS/MF092'
*          DESTINATION lv_rfcdest
*          EXPORTING
*            rt_tplnr                  = rt_tplnr
*          IMPORTING
*            it_lista_tecnica_loc_inst = lt_lista_tecnica_loc_inst.
*
*        et_entityset = CORRESPONDING #( lt_lista_tecnica_loc_inst ).
*
*      ENDIF.
*
*    ENDIF.

  ENDMETHOD.


  METHOD out_local_instal_get_entityset.

    DATA: ls_usuario               TYPE LINE OF /iwbep/t_mgw_name_value_pair,
          it_local_instal          TYPE /iwbep/t_cod_select_options,
          ls_local_instal          TYPE /iwbep/s_cod_select_option,
          lv_rfcdest               TYPE bdbapidst,
          t_local_instal           TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_local_instalacao,
          lt_local_instal          TYPE /ptloms/ct081,
          lv_usuario               TYPE xubname,
          lv_usuario_sap           TYPE flag,
          lv_same_user             TYPE rfcdisplay-rfcsameusr,
          lv_msgv1(50)             TYPE c,
          lv_msgv2(50)             TYPE c,
          lv_subrc                 TYPE sy-subrc,
          lv_mensagem              TYPE bapi_msg,
          lv_usuario_app           TYPE char12,
          it_ordem_catalogo        TYPE TABLE OF /ptloms/et128,
          it_retorno_catalogo      TYPE TABLE OF /ptloms/et063,
          lv_quantidade_local_inst TYPE int4,
          lt_local_inst            TYPE /ptloms/ct018.

* Busca Conexão
    SELECT SINGLE rfcdest
      FROM /ptloms/tb036 INTO lv_rfcdest.

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

    IF it_filter_select_options[] IS NOT INITIAL.

      READ TABLE it_filter_select_options INTO DATA(ls_filter) WITH KEY property = 'Usuarioapp'.

      IF sy-subrc = 0.

        DATA(rt_usuario_app) = ls_filter-select_options.
        DATA(lv_top)  = is_paging-top.
        DATA(lv_skip) = is_paging-skip.

        CLEAR lv_quantidade_local_inst.

        CALL FUNCTION '/PTLOMS/MF095'
          DESTINATION lv_rfcdest
          EXPORTING
            rt_usuario_app           = rt_usuario_app
            im_top                   = lv_top
            im_skip                  = lv_skip
          IMPORTING
            it_local_inst            = lt_local_inst
            ex_quantidade_local_inst = lv_quantidade_local_inst.

        et_entityset = CORRESPONDING #( lt_local_inst ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD out_logset_get_entityset.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_log TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_log.

    DATA: lt_log TYPE /ptloms/ct077.

    DATA: ls_log LIKE LINE OF t_log.

    DATA: lv_usuario TYPE xubname.

    DATA: lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    CASE iv_entity_set_name.

      WHEN 'out_logSet'.

* Cria Sessão para usuário
*        READ TABLE it_filter_select_options INTO DATA(ls_datefrom) WITH KEY property = 'DateFrom'.
        DATA ls_datefrom  LIKE LINE OF it_filter_select_options.
        READ TABLE it_filter_select_options INTO ls_datefrom WITH KEY property = 'DateFrom'.
        IF sy-subrc = 0.
*          DATA(rt_datefrom) = ls_datefrom-select_options.
          DATA rt_datefrom TYPE TABLE OF /iwbep/s_cod_select_option.
          rt_datefrom = ls_datefrom-select_options.
*          READ TABLE rt_datefrom INTO DATA(ls_datefrom_aux) INDEX 1.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_dateto) WITH KEY property = 'DateTo'.
        IF sy-subrc = 0.
          DATA(rt_dateto) = ls_dateto-select_options.
*          READ TABLE rt_dateto INTO DATA(ls_dateto_aux) INDEX 1.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_timefrom) WITH KEY property = 'TimeFrom'.
        IF sy-subrc = 0.
          DATA(rt_timefrom) = ls_timefrom-select_options.
*          READ TABLE rt_timefrom INTO DATA(ls_timefrom_aux) INDEX 1.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_timeto) WITH KEY property = 'TimeTo'.
        IF sy-subrc = 0.
          DATA(rt_timeto) = ls_timeto-select_options.
*          READ TABLE rt_timeto INTO DATA(ls_timeto_aux) INDEX 1.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_datetimefrom) WITH KEY property = 'DateTimeFrom'.
        IF sy-subrc = 0.
          DATA(rt_datetimefrom) = ls_datetimefrom-select_options.
          READ TABLE rt_datetimefrom INTO DATA(ls_datetimefrom_aux) INDEX 1.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_datetimeto) WITH KEY property = 'DateTimeTo'.
        IF sy-subrc = 0.
          DATA(rt_datetimeto) = ls_datetimeto-select_options.
          READ TABLE rt_datetimeto INTO DATA(ls_datetimeto_aux) INDEX 1.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_userid) WITH KEY property = 'UserId'.
        IF sy-subrc = 0.
          DATA(rt_userid) = ls_userid-select_options.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_bukrs) WITH KEY property = 'Bukrs'.
        IF sy-subrc = 0.
          DATA(rt_bukrs) = ls_bukrs-select_options.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_werks) WITH KEY property = 'Werks'.
        IF sy-subrc = 0.
          DATA(rt_werks) = ls_werks-select_options.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_ingrp) WITH KEY property = 'Ingrp'.
        IF sy-subrc = 0.
          DATA(rt_ingrp) = ls_ingrp-select_options.
        ENDIF.

*        READ TABLE it_filter_select_options INTO DATA(ls_auart) WITH KEY property = 'Auart'.
*        IF sy-subrc = 0.
*          DATA(rt_auart) = ls_auart-select_options.
*        ENDIF.

        DATA: ls_datefrom_aux LIKE LINE OF rt_datefrom,
              ls_dateto_aux   LIKE LINE OF rt_dateto,
              ls_timefrom_aux LIKE LINE OF rt_datefrom,
              ls_timeto_aux   LIKE LINE OF rt_dateto.

* DateFrom
        IF ls_datetimefrom_aux-low IS NOT INITIAL.
          ls_datefrom_aux-low = ls_datetimefrom_aux-low+6(4) &&
                                ls_datetimefrom_aux-low+3(2) &&
                                ls_datetimefrom_aux-low(2).
          ls_datefrom_aux-sign   = 'I'.
          ls_datefrom_aux-option = 'EQ'.

* TimeFrom
          ls_timefrom_aux-low = ls_datetimefrom_aux-low+11(2) &&
                                ls_datetimefrom_aux-low+14(2) &&
                                ls_datetimefrom_aux-low+17(2).
          ls_timefrom_aux-sign   = 'I'.
          ls_timefrom_aux-option = 'EQ'.

          APPEND: ls_datefrom_aux TO rt_datefrom,
                  ls_timefrom_aux TO rt_timefrom.
        ENDIF.

* DateTo
        IF ls_datetimeto_aux-low IS NOT INITIAL.
          ls_dateto_aux-low = ls_datetimeto_aux-low+6(4) &&
                              ls_datetimeto_aux-low+3(2) &&
                              ls_datetimeto_aux-low(2).
          ls_dateto_aux-sign   = 'I'.
          ls_dateto_aux-option = 'EQ'.

* TimeTo
          ls_timeto_aux-low = ls_datetimeto_aux-low+11(2) &&
                              ls_datetimeto_aux-low+14(2) &&
                              ls_datetimeto_aux-low+17(2).
          ls_timeto_aux-sign   = 'I'.
          ls_timeto_aux-option = 'EQ'.

          APPEND: ls_dateto_aux TO rt_dateto,
                  ls_timeto_aux TO rt_timeto.
        ENDIF.

        CALL FUNCTION '/PTLOMS/MF059'
          DESTINATION lv_rfcdest
          EXPORTING
            rt_date_from = rt_datefrom
            rt_date_to   = rt_dateto
            rt_time_from = rt_timefrom
            rt_time_to   = rt_timeto
            rt_user_id   = rt_userid
            rt_bukrs     = rt_bukrs
            rt_werks     = rt_werks
            rt_ingrp     = rt_ingrp
          IMPORTING
            et_log       = t_log.

      WHEN OTHERS.
    ENDCASE.

    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_log( t_log ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_LOGSET_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_log_reservas_get_entityset.

    DATA: lv_rfcdest     TYPE bdbapidst,
          t_log_reserva  TYPE /ptloms/cl_soms_mpc=>tt_out_log_reserva,
          lt_log_reserva TYPE /ptloms/ct117,
          ls_log_reserva LIKE LINE OF t_log_reserva,
          lv_usuario     TYPE xubname,
          lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    CASE iv_entity_set_name.

      WHEN 'out_log_reservaSet'.

* Cria Sessão para usuário
        READ TABLE it_filter_select_options INTO DATA(ls_datum) WITH KEY property = 'Datum'.
        IF sy-subrc = 0.
          DATA(rt_datum) = ls_datum-select_options.
        ENDIF.

        READ TABLE it_filter_select_options INTO DATA(ls_usuario_app) WITH KEY property = 'UsuarioApp'.
        IF sy-subrc = 0.
          DATA(rt_usuario_app) = ls_usuario_app-select_options.
        ENDIF.

        DATA: so_datum     TYPE /iwbep/t_cod_select_options,
              s_datum      TYPE /iwbep/s_cod_select_option,
              ls_datum_aux TYPE /iwbep/s_cod_select_option,
              s_datum_aux  TYPE /iwbep/s_mgw_select_option.

        LOOP AT rt_datum INTO DATA(wl_datum).

          IF sy-tabix = 1.

            s_datum-low = wl_datum-low+6(4) &&
                          wl_datum-low+3(2) &&
                          wl_datum-low(2).
          ELSE.

            s_datum-high = wl_datum-low+6(4) &&
                           wl_datum-low+3(2) &&
                           wl_datum-low(2).

          ENDIF.

        ENDLOOP.

        s_datum-sign   = 'I'.
        s_datum-option = 'BT'.

        APPEND: s_datum TO so_datum.

        CALL FUNCTION '/PTLOMS/MF100'
          DESTINATION lv_rfcdest
          EXPORTING
            rt_datum       = so_datum
            rt_usuario_app = rt_usuario_app
          IMPORTING
            et_log_reserva = Lt_log_reserva.

      WHEN OTHERS.

    ENDCASE.

    et_entityset = CORRESPONDING #( Lt_log_reserva ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_LOG_RESERVAS_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_materialset_get_entityset.

    DATA: BEGIN OF t_out_material.
    DATA: out_materialset TYPE /ptloms/cl_soms_mpc=>ts_out_material,
          END OF t_out_material.

    DATA: lv_rfcdest      TYPE bdbapidst,
          lv_msgv1(50)    TYPE c,
          lv_msgv2(50)    TYPE c,
          lv_subrc        TYPE sy-subrc,
          lv_same_user    TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap  TYPE flag,
          ls_usuario      TYPE /iwbep/s_cod_select_option,
          ls_out_material LIKE t_out_material,
          lt_material     TYPE /ptloms/ct030.

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

          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO DATA(lv_mensagem) SEPARATED BY space.

        ELSE.

          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.

        ENDIF.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = CONV bapi_msg( lv_mensagem ).

      ENDIF.

    ELSE.

      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = CONV bapi_msg( lv_mensagem ).

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
          message = CONV bapi_msg( lv_mensagem ).

    ENDIF.

* Autenticação
    READ TABLE it_filter_select_options INTO DATA(ls_usuarioapp) WITH KEY property = 'Usuarioapp'.

    IF sy-subrc = 0.

      DATA(rt_usuario_app) = ls_usuarioapp-select_options.

    ENDIF.

    IF rt_usuario_app[] IS INITIAL.

      ls_usuario-sign   = 'I'.
      ls_usuario-option = 'EQ'.
      ls_usuario-low = sy-uname.
      APPEND ls_usuario TO rt_usuario_app.

    ENDIF.

    READ TABLE rt_usuario_app INTO DATA(ls_usuario_app_aux) INDEX 1.

    " Carrega filtros
    IF it_filter_select_options[] IS NOT INITIAL.

      READ TABLE it_filter_select_options INTO DATA(ls_mtart) WITH KEY property = 'Mtart'.

      IF sy-subrc = 0.

        DATA(rt_mtart) = ls_mtart-select_options.

      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_werks_aux) WITH KEY property = 'Werks'.

      IF sy-subrc = 0.

        DATA(rt_werks) = ls_werks_aux-select_options.

      ENDIF.

      READ TABLE it_filter_select_options INTO DATA(ls_lgort) WITH KEY property = 'Lgort'.

      IF sy-subrc = 0.

        DATA(rt_lgort) = ls_lgort-select_options.

      ENDIF.

    ENDIF.

    DATA(lv_quantidade_material) = 0.
    DATA(lv_top)  = is_paging-top.
    DATA(lv_skip) = is_paging-skip.

    CALL FUNCTION '/PTLOMS/MF028'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_mtart               = rt_mtart
        rt_werks               = rt_werks
        rt_lgort               = rt_lgort
        rt_usuario_app         = rt_usuario_app
        im_top                 = lv_top
        im_skip                = lv_skip
      IMPORTING
        rt_materiais           = lt_material
        ex_quantidade_material = lv_quantidade_material.

    LOOP AT lt_material ASSIGNING FIELD-SYMBOL(<fs_material>).

      SHIFT <fs_material>-matnr LEFT DELETING LEADING '0'.
      <fs_material>-quantidade_material = lv_quantidade_material.

    ENDLOOP.

    et_entityset = CORRESPONDING #( lt_material ).

  ENDMETHOD.


  METHOD out_nota_perfil__get_entityset.

    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap TYPE flag,
          lt_notas       TYPE /ptloms/ct110.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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
    " Carrega filtros
    IF it_filter_select_options[] IS NOT INITIAL.

      READ TABLE it_filter_select_options INTO DATA(ls_usuapp_filter) WITH KEY property = 'UsuarioApp'.

      IF sy-subrc = 0.

        DATA(rt_usuapp_filter) = ls_usuapp_filter-select_options.

      ENDIF.

    ENDIF.

    CALL FUNCTION '/PTLOMS/MF081'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_usuario_app = rt_usuapp_filter
      IMPORTING
        it_notas       = lt_notas.

    et_entityset = CORRESPONDING #( lt_notas ).

  ENDMETHOD.


  METHOD out_ordemset_get_entityset.

*    DATA: lv_rfcdest                     TYPE bdbapidst,
*          lv_msgv1(50)                   TYPE c,
*          lv_msgv2(50)                   TYPE c,
*          lv_subrc                       TYPE sy-subrc,
*          lv_mensagem                    TYPE bapi_msg,
*          lv_same_user                   TYPE rfcdisplay-rfcsameusr,
*          lv_usuario_sap                 TYPE flag,
*          lv_senha                       TYPE char32,
*          lv_confsenha                   TYPE char32,
*          lv_autenticado                 TYPE char1,
*          lv_senha_alterada              TYPE char1,
*          lv_perfil                      TYPE c LENGTH 10,
*          ls_usuario                     TYPE /iwbep/s_cod_select_option,
*          lv_guid                        TYPE char32,
*          lv_usuario                     TYPE xubname,
*          lt_despacho                    TYPE /ptloms/ct079,
*          lt_ordens                      TYPE /ptloms/ct036,
*          lt_textos_ordem                TYPE /ptloms/ct037,
*          lt_operacoes_ordem             TYPE /ptloms/ct038,
*          lt_componentes_ordem           TYPE /ptloms/ct039,
*          lt_confirmacao                 TYPE /ptloms/ct075,
*          lt_empresa_centro              TYPE /ptloms/ct006,
*          lt_grupo_planejamento          TYPE /ptloms/ct007,
*          lt_area_operacional            TYPE /ptloms/ct008,
*          lt_centro_trabalho             TYPE /ptloms/ct009,
*          lt_tipo_nota                   TYPE /ptloms/ct010,
*          lt_tipo_ordem                  TYPE /ptloms/ct011,
*          lt_tipo_prioridade_ordem       TYPE /ptloms/ct012,
*          lt_tipo_prioridade_nota        TYPE /ptloms/ct013,
*          lt_tipo_atv_manutencao         TYPE /ptloms/ct014,
*          lt_centro_custo                TYPE /ptloms/ct015,
*          lt_condicao_inst_ordem         TYPE /ptloms/ct016,
*          lt_tipo_atv_operacao           TYPE /ptloms/ct017,
*          lt_tipo_material               TYPE /ptloms/ct027,
*          lt_categoria_item_material     TYPE /ptloms/ct028,
*          lt_deposito                    TYPE /ptloms/ct029,
*          lt_categoria_equipamento       TYPE /ptloms/ct034,
*          lt_tipo_objeto                 TYPE /ptloms/ct035,
*          lt_categoria_loc_inst          TYPE /ptloms/ct040,
*          lt_equipamento                 TYPE /ptloms/ct019,
*          lt_imagens_equipamento         TYPE /ptloms/ct072,
*          lt_local_inst                  TYPE /ptloms/ct018,
*          lt_tipo_atv_ordem              TYPE /ptloms/ct049,
*          lt_lista_tecnica               TYPE /ptloms/ct054,
*          lt_imagens_local_inst          TYPE /ptloms/ct072,
*          lt_imagens_nota                TYPE /ptloms/ct072,
*          lt_imagens_ordem               TYPE /ptloms/ct072,
*          lt_filtro_ordem                TYPE /ptloms/ct056,
*          lt_filtro_nota                 TYPE /ptloms/ct056,
*          lt_filtro_tipo_ordem           TYPE /ptloms/ct056,
*          lt_filtro_inicio_base          TYPE /ptloms/ct056,
*          lt_filtro_fim_base             TYPE /ptloms/ct056,
*          lt_filtro_local_instalacao     TYPE /ptloms/ct056,
*          lt_filtro_equipamento          TYPE /ptloms/ct056,
*          lt_filtro_grupo_planejamento   TYPE /ptloms/ct056,
*          lt_filtro_centro_trabalho      TYPE /ptloms/ct056,
*          lt_filtro_codigo_abc           TYPE /ptloms/ct056,
*          lt_filtro_plano_manutencao     TYPE /ptloms/ct056,
*          lt_filtro_ciclo                TYPE /ptloms/ct056,
*          lt_filtro_tipo_atvd_manutencao TYPE /ptloms/ct056,
*          lv_quantidade_ordem            TYPE int4,
*          lt_filtro                      TYPE /ptloms/ct103,
*          lv_data                        TYPE sy-datum,
*          lv_hora                        TYPE sy-uzeit.
*
** Busca Conexão
*    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
*    IF sy-subrc EQ 0.
**Verifica se conexão está ativa
*      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
*        EXPORTING
*          rfcdestination = lv_rfcdest
*        IMPORTING
*          msgv1          = lv_msgv1
*          msgv2          = lv_msgv2
*          rfc_subrc      = lv_subrc.
*      IF lv_subrc NE 0.
*        IF lv_subrc = 3.
**          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
*          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
*        ELSE.
**          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
*          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
*        ENDIF.
*
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*            message = lv_mensagem.
*      ENDIF.
*    ELSE.
*      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = lv_mensagem.
*    ENDIF.
*
** Valida Configuração RFC (Verifica se possui usuário fixo)
*    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
*      EXPORTING
*        destination             = lv_rfcdest
*      IMPORTING
*        same_user               = lv_same_user
*      EXCEPTIONS
*        authority_not_available = 1
*        destination_not_exist   = 2
*        information_failure     = 3
*        internal_failure        = 4
*        OTHERS                  = 5.
*
** Verifica se é Usuário SAP
*    CALL FUNCTION '/PTLOMS/MF049'
*      DESTINATION lv_rfcdest
*      IMPORTING
*        ex_usuario_sap = lv_usuario_sap.
*
*    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR "Se usuário SAP, então SAME_USER deve estar marcado
*       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio
*
*      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = lv_mensagem.
*    ENDIF.
*    " Carrega filtros
*    IF it_filter_select_options[] IS NOT INITIAL.
*
*      READ TABLE it_filter_select_options INTO DATA(ls_usuapp_filter) WITH KEY property = 'UsuarioApp'.
*
*      IF sy-subrc = 0.
*
*        DATA(rt_usuapp_filter) = ls_usuapp_filter-select_options.
*
*      ENDIF.
*
*    ENDIF.
*
*    CALL FUNCTION '/PTLOMS/MF080'
*      DESTINATION lv_rfcdest
*      EXPORTING
*        rt_usuario_app                 = rt_usuapp_filter
*      IMPORTING
*        it_ordens                      = lt_ordens
*        it_textos_ordem                = lt_textos_ordem
*        it_operacoes_ordem             = lt_operacoes_ordem
*        it_componentes_ordem           = lt_componentes_ordem
*        it_confirmacoes                = lt_confirmacao
*        it_imagens_ordem               = lt_imagens_ordem
*        it_filtro_ordem                = lt_filtro_ordem
*        it_filtro_nota                 = lt_filtro_nota
*        it_filtro_tipo_ordem           = lt_filtro_tipo_ordem
*        it_filtro_inicio_base          = lt_filtro_inicio_base
*        it_filtro_fim_base             = lt_filtro_fim_base
*        it_filtro_local_instalacao     = lt_filtro_local_instalacao
*        it_filtro_equipamento          = lt_filtro_equipamento
*        it_filtro_grupo_planejamento   = lt_filtro_grupo_planejamento
*        it_filtro_centro_trabalho      = lt_filtro_centro_trabalho
*        it_filtro_codigo_abc           = lt_filtro_codigo_abc
*        it_filtro_plano_manutencao     = lt_filtro_plano_manutencao
*        it_filtro_ciclo                = lt_filtro_ciclo
*        it_filtro_tipo_atvd_manutencao = lt_filtro_tipo_atvd_manutencao
*        ex_quantidade_ordem            = lv_quantidade_ordem.
*
** Converte Data
*    LOOP AT lt_ordens ASSIGNING FIELD-SYMBOL(<fs_ordens>).
*
*      lv_data = <fs_ordens>-start_date.
*
*      <fs_ordens>-start_date = lv_data+6(2) && |/| &&
*                               lv_data+4(2) && |/| &&
*                               lv_data(4).
*
*      lv_data = <fs_ordens>-finish_date.
*
*      <fs_ordens>-finish_date = lv_data+6(2) && |/| &&
*                                lv_data+4(2) && |/| &&
*                                lv_data(4).
*
*      <fs_ordens>-notif_no = |{ <fs_ordens>-notif_no ALPHA = OUT }|.
*      <fs_ordens>-orderid  = |{ <fs_ordens>-orderid ALPHA = OUT }|.
*
*    ENDLOOP.
*
*    et_entityset = CORRESPONDING #( lt_ordens ).

  ENDMETHOD.


  METHOD out_ordem_catalo_get_entityset.

    DATA: ls_usuario TYPE LINE OF /iwbep/t_mgw_name_value_pair,
          it_variant TYPE /iwbep/t_cod_select_options,
          ls_variant TYPE /iwbep/s_cod_select_option.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_variant TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_variant.

    DATA: lt_variant TYPE /ptloms/ct081.

    DATA: lv_usuario     TYPE xubname,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50)        TYPE c,
          lv_msgv2(50)        TYPE c,
          lv_subrc            TYPE sy-subrc,
          lv_mensagem         TYPE bapi_msg,
          lv_usuario_app      TYPE char12,
          it_ordem_catalogo   TYPE TABLE OF /ptloms/et128,
          ls_ordem_catalogo   TYPE /ptloms/et128,
          it_retorno_catalogo TYPE TABLE OF /ptloms/et063.

* Busca Conexão
    SELECT SINGLE rfcdest
      FROM /ptloms/tb036 INTO lv_rfcdest.
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

    IF it_filter_select_options[] IS NOT INITIAL.

      READ TABLE it_filter_select_options INTO DATA(ls_filter) WITH KEY property = 'UsuarioApp'.

      IF sy-subrc = 0.

        DATA(rt_qmnum) = ls_filter-select_options.
        lv_usuario_app =  VALUE #( rt_qmnum[ 1 ]-low OPTIONAL ).

        IF lv_usuario_app IS NOT INITIAL.

          CALL FUNCTION '/PTLOMS/MF085'
            DESTINATION lv_rfcdest
            EXPORTING
              im_usuario_app      = lv_usuario_app
            CHANGING
              it_retorno_catalogo = it_retorno_catalogo
              it_ordem_catalogo   = it_ordem_catalogo.

*          DELETE ADJACENT DUPLICATES FROM it_ordem_catalogo COMPARING notifno parteobjetocode sintomadanocode causacode.

          et_entityset = CORRESPONDING #( it_ordem_catalogo ).

        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD out_ordem_perfil_get_entityset.


    DATA: lv_rfcdest     TYPE bdbapidst,
          lv_msgv1(50)   TYPE c,
          lv_msgv2(50)   TYPE c,
          lv_subrc       TYPE sy-subrc,
          lv_mensagem    TYPE bapi_msg,
          lv_same_user   TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap TYPE flag,
          lt_ordens      TYPE /ptloms/ct109.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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
    " Carrega filtros
    IF it_filter_select_options[] IS NOT INITIAL.

      READ TABLE it_filter_select_options INTO DATA(ls_usuapp_filter) WITH KEY property = 'UsuarioApp'.

      IF sy-subrc = 0.

        DATA(rt_usuapp_filter) = ls_usuapp_filter-select_options.

      ENDIF.

    ENDIF.

    CALL FUNCTION '/PTLOMS/MF080'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_usuario_app = rt_usuapp_filter
      IMPORTING
        it_ordens      = lt_ordens.

    et_entityset = CORRESPONDING #( lt_ordens ).

  ENDMETHOD.


  METHOD out_parceiro_neg_get_entityset.

    DATA: rt_objnr            TYPE /iwbep/t_cod_select_options,
          lt_parceiro_negocio TYPE /ptloms/ct005,
          lv_rfcdest          TYPE bdbapidst,
          lv_msgv1(50)        TYPE c,
          lv_msgv2(50)        TYPE c,
          lv_subrc            TYPE sy-subrc,
          lv_same_user        TYPE rfcdisplay-rfcsameusr,
          lv_usuario_sap      TYPE flag,
          ls_usuario          TYPE /iwbep/s_cod_select_option,
          lv_guid             TYPE char32,
          lv_usuario          TYPE xubname,
          lt_objnr            TYPE /iwbep/t_cod_select_options,
          ls_objnr            LIKE LINE OF rt_objnr.

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

          CONCATENATE 'Usuário Sem Autorização para RFC'(001) lv_rfcdest INTO DATA(lv_mensagem) SEPARATED BY space.

        ELSE.

          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.

        ENDIF.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = CONV bapi_msg( lv_mensagem ).

      ENDIF.

    ELSE.

      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = CONV bapi_msg( lv_mensagem ).

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
          message = CONV bapi_msg( lv_mensagem ).

    ENDIF.

* Autenticação
    READ TABLE it_filter_select_options INTO DATA(ls_usuarioapp) WITH KEY property = 'UsuarioApp'.

    IF sy-subrc = 0.

      DATA(rt_usuario_app) = ls_usuarioapp-select_options.

    ENDIF.

    IF rt_usuario_app[] IS INITIAL.

      ls_usuario-sign   = 'I'.
      ls_usuario-option = 'EQ'.
      ls_usuario-low = sy-uname.
      APPEND ls_usuario TO rt_usuario_app.

    ENDIF.

    READ TABLE rt_usuario_app INTO DATA(ls_usuario_app_aux) INDEX 1.

    IF ls_usuario_app_aux-low IS NOT INITIAL.

      lv_usuario = ls_usuario_app_aux-low.
      TRANSLATE lv_usuario TO UPPER CASE.

    ELSE.

      lv_usuario = sy-uname.

    ENDIF.

    CALL FUNCTION '/PTLOMS/MF044'
      DESTINATION lv_rfcdest
      EXPORTING
        im_usuario = CONV char12( lv_usuario )
      IMPORTING
        ex_usuario = lv_usuario.

    READ TABLE it_filter_select_options INTO DATA(objnr) WITH KEY property = 'Objnr'.

    IF sy-subrc = 0.

      rt_objnr = objnr-select_options.

      LOOP AT rt_objnr INTO ls_objnr.

        " Filtro para método out_classe_característica
        ls_objnr-sign = 'I'.
        ls_objnr-option = 'EQ'.
        ls_objnr-low = ls_objnr-low.

        APPEND ls_objnr TO lt_objnr.

      ENDLOOP.

      CALL FUNCTION '/PTLOMS/MF022'
        DESTINATION lv_rfcdest
        EXPORTING
          rt_objnr            = lt_objnr
        IMPORTING
          it_parceiro_negocio = lt_parceiro_negocio.

      et_entityset = CORRESPONDING #( lt_parceiro_negocio ).

    ENDIF.

  ENDMETHOD.


  METHOD out_ponto_medica_get_entityset.

" O serviço do ponto de medição foi alterado para o CREAD DEEP ENTITY
*    DATA: lt_imagens_equipamento TYPE /ptloms/ct072,
*          lt_equipamento         TYPE /ptloms/ct019,
*          lt_filtro_equnr        TYPE /ptloms/ct056,
*          lt_filtro_eqktx        TYPE /ptloms/ct056,
*          lt_filtro_invnr        TYPE /ptloms/ct056,
*          lt_filtro_tidnr        TYPE /ptloms/ct056,
*          lv_rfcdest             TYPE bdbapidst,
*          lv_msgv1(50)           TYPE c,
*          lv_msgv2(50)           TYPE c,
*          lv_subrc               TYPE sy-subrc,
*          lv_same_user           TYPE rfcdisplay-rfcsameusr,
*          lv_usuario_sap         TYPE flag,
*          ls_usuario             TYPE /iwbep/s_cod_select_option,
*          lv_guid                TYPE char32,
*          out_equipamentoset     TYPE /ptloms/cl_soms_mpc=>tt_out_equipamento,
*          lv_usuario             TYPE xubname,
*          rt_objnr               TYPE /iwbep/t_cod_select_options,
*          lt_objnr               TYPE /iwbep/t_cod_select_options,
*          ls_objnr               LIKE LINE OF rt_objnr,
*          lt_ponto_medicao       TYPE /ptloms/ct003.
*
*    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
*
*    IF sy-subrc EQ 0.
*
**Verifica se conexão está ativa
*      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
*        EXPORTING
*          rfcdestination = lv_rfcdest
*        IMPORTING
*          msgv1          = lv_msgv1
*          msgv2          = lv_msgv2
*          rfc_subrc      = lv_subrc.
*
*      IF lv_subrc NE 0.
*
*        IF lv_subrc = 3.
*
*          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO DATA(lv_mensagem) SEPARATED BY space.
*
*        ELSE.
*
*          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
*
*        ENDIF.
*
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*            message = CONV bapi_msg( lv_mensagem ).
*
*      ENDIF.
*
*    ELSE.
*
*      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
** Valida Configuração RFC (Verifica se possui usuário fixo)
*    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
*      EXPORTING
*        destination             = lv_rfcdest
*      IMPORTING
*        same_user               = lv_same_user
*      EXCEPTIONS
*        authority_not_available = 1
*        destination_not_exist   = 2
*        information_failure     = 3
*        internal_failure        = 4
*        OTHERS                  = 5.
*
** Verifica se é Usuário SAP
*    CALL FUNCTION '/PTLOMS/MF049'
*      DESTINATION lv_rfcdest
*      IMPORTING
*        ex_usuario_sap = lv_usuario_sap.
*
*    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR "Se usuário SAP, então SAME_USER deve estar marcado
*       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio
*
*      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
** Autenticação
*    READ TABLE it_filter_select_options INTO DATA(ls_usuarioapp) WITH KEY property = 'UsuarioApp'.
*    IF sy-subrc = 0.
*      DATA(rt_usuario_app) = ls_usuarioapp-select_options.
*    ENDIF.
*    IF rt_usuario_app[] IS INITIAL.
*      ls_usuario-sign   = 'I'.
*      ls_usuario-option = 'EQ'.
*      ls_usuario-low = sy-uname.
*      APPEND ls_usuario TO rt_usuario_app.
*    ENDIF.
*    READ TABLE rt_usuario_app INTO DATA(ls_usuario_app_aux) INDEX 1.
*
*    READ TABLE it_filter_select_options INTO DATA(ls_guid) WITH KEY property = 'Guid'.
*    IF sy-subrc = 0.
*      DATA(rt_guid) = ls_guid-select_options.
*    ENDIF.
*    READ TABLE rt_guid INTO DATA(ls_guid_aux) INDEX 1.
*
*    IF ls_usuario_app_aux-low IS NOT INITIAL.
*      lv_usuario = ls_usuario_app_aux-low.
*      TRANSLATE lv_usuario TO UPPER CASE.
*    ELSE.
*      lv_usuario = sy-uname.
*    ENDIF.
*
*    CALL FUNCTION '/PTLOMS/MF044'
*      DESTINATION lv_rfcdest
*      EXPORTING
*        im_usuario = CONV char12( lv_usuario )
*      IMPORTING
*        ex_usuario = lv_usuario.
*
*    CALL FUNCTION '/PTLOMS/MF042'
*      DESTINATION lv_rfcdest
*      EXPORTING
*        im_usuario = lv_usuario
*      IMPORTING
*        ex_guid    = lv_guid.
*
*    READ TABLE it_filter_select_options INTO DATA(objnr) WITH KEY property = 'Objnr'.
*
*    IF sy-subrc = 0.
*
*      rt_objnr = objnr-select_options.
*
*      LOOP AT rt_objnr INTO ls_objnr.
*
*        " Filtro para método out_classe_característica
*        ls_objnr-sign = 'I'.
*        ls_objnr-option = 'EQ'.
*        ls_objnr-low = ls_objnr-low.
*
*        APPEND ls_objnr TO lt_objnr.
*
*      ENDLOOP.
*
**      CALL FUNCTION '/PTLOMS/MF020'
**        DESTINATION lv_rfcdest
**        EXPORTING
**          rt_objnr                  = lt_objnr
**          rt_usuario_app            = rt_usuario_app
**        IMPORTING
**          it_ponto_medicao          = lt_ponto_medicao
**        EXCEPTIONS
**          environment_not_available = 1.
*
*      et_entityset = CORRESPONDING #( lt_ponto_medicao ).
*
*    ENDIF.

  ENDMETHOD.


  METHOD out_saldo_materi_get_entityset.

" O serviço de saldo de material foi alterado para o CREAD DEEP ENTITY

*    DATA: lv_rfcdest        TYPE bdbapidst,
*          lv_msgv1(50)      TYPE c,
*          lv_msgv2(50)      TYPE c,
*          lv_subrc          TYPE sy-subrc,
*          lv_same_user      TYPE rfcdisplay-rfcsameusr,
*          lv_usuario_sap    TYPE flag,
*          ls_usuario        TYPE /iwbep/s_cod_select_option,
*          lv_guid           TYPE char32,
*          lv_usuario        TYPE xubname,
*          lt_saldo_material TYPE /ptloms/ct064,
*          lv_submt          TYPE /ptloms/ed100,
*          lv_iwerk          TYPE /ptloms/ed101,
*          rt_equnr_aux      TYPE /iwbep/t_cod_select_options,
*          rt_lgort_aux      TYPE /iwbep/t_cod_select_options,
*          rt_werks_aux      TYPE /iwbep/t_cod_select_options,
*          rt_matnr_aux      TYPE /iwbep/t_cod_select_options,
*          ls_equnr_aux      LIKE LINE OF rt_equnr_aux,
*          ls_matnr_aux      LIKE LINE OF rt_matnr_aux,
*          ls_werks_aux      LIKE LINE OF rt_werks_aux.
*
*    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
*
*    IF sy-subrc EQ 0.
*
**Verifica se conexão está ativa
*      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
*        EXPORTING
*          rfcdestination = lv_rfcdest
*        IMPORTING
*          msgv1          = lv_msgv1
*          msgv2          = lv_msgv2
*          rfc_subrc      = lv_subrc.
*
*      IF lv_subrc NE 0.
*
*        IF lv_subrc = 3.
*
*          CONCATENATE 'Usuário Sem Autorização para RFC'(001) lv_rfcdest INTO DATA(lv_mensagem) SEPARATED BY space.
*
*        ELSE.
*
*          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
*
*        ENDIF.
*
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*            message = CONV bapi_msg( lv_mensagem ).
*
*      ENDIF.
*
*    ELSE.
*
*      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
** Valida Configuração RFC (Verifica se possui usuário fixo)
*    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
*      EXPORTING
*        destination             = lv_rfcdest
*      IMPORTING
*        same_user               = lv_same_user
*      EXCEPTIONS
*        authority_not_available = 1
*        destination_not_exist   = 2
*        information_failure     = 3
*        internal_failure        = 4
*        OTHERS                  = 5.
*
** Verifica se é Usuário SAP
*    CALL FUNCTION '/PTLOMS/MF049'
*      DESTINATION lv_rfcdest
*      IMPORTING
*        ex_usuario_sap = lv_usuario_sap.
*
*    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR "Se usuário SAP, então SAME_USER deve estar marcado
*       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio
*
*      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = CONV bapi_msg( lv_mensagem ).
*
*    ENDIF.
*
** Autenticação
*    READ TABLE it_filter_select_options INTO DATA(ls_usuarioapp) WITH KEY property = 'UsuarioApp'.
*
*    IF sy-subrc = 0.
*
*      DATA(rt_usuario_app) = ls_usuarioapp-select_options.
*
*    ENDIF.
*
*    IF rt_usuario_app[] IS INITIAL.
*
*      ls_usuario-sign   = 'I'.
*      ls_usuario-option = 'EQ'.
*      ls_usuario-low = sy-uname.
*      APPEND ls_usuario TO rt_usuario_app.
*
*    ENDIF.
*
*    READ TABLE it_filter_select_options INTO DATA(ls_matnr) WITH KEY property = 'Matnr'.
*
*    IF sy-subrc = 0.
*
*      DATA(rt_matnr) = ls_matnr-select_options.
*
*    ENDIF.
*
*    READ TABLE it_filter_select_options INTO DATA(ls_werks) WITH KEY property = 'Werks'.
*
*    IF sy-subrc = 0.
*
*      DATA(rt_werks) = ls_werks-select_options.
*
*    ENDIF.
*
*    READ TABLE it_filter_select_options INTO DATA(ls_equnr) WITH KEY property = 'Equnr'.
*
*    IF sy-subrc = 0.
*
*      DATA(rt_equnr) = ls_equnr-select_options.
*
*    ENDIF.
*
*    LOOP AT rt_matnr INTO DATA(wl_matnr).
*
*      READ TABLE rt_werks INTO DATA(wl_werks) INDEX sy-tabix.
*
*      READ TABLE rt_equnr INTO DATA(wl_equnr) INDEX sy-tabix.
*
*      CLEAR ls_matnr_aux.
*
*      ls_matnr_aux-sign   = 'I'.
*      ls_matnr_aux-option = 'EQ'.
*      ls_matnr_aux-low    = wl_matnr-low.
*
*      APPEND ls_matnr_aux TO rt_matnr_aux.
*
*      IF wl_equnr-low IS NOT INITIAL.
*
*        CLEAR: lv_submt, lv_iwerk.
*
*        CALL FUNCTION '/PTLOMS/MF045'
*          DESTINATION lv_rfcdest
*          EXPORTING
*            im_equnr = wl_matnr-low
*          IMPORTING
*            ex_submt = lv_submt
*            ex_iwerk = lv_iwerk.
*
*      ELSE.
*
*        lv_iwerk = wl_werks-high.
*
*      ENDIF.
*
*      CLEAR ls_werks_aux.
*
*      ls_werks_aux-sign   = 'I'.
*      ls_werks_aux-option = 'EQ'.
*      ls_werks_aux-low    = lv_iwerk.
*
*      APPEND ls_werks_aux TO rt_werks_aux.
*
*      CLEAR: lt_saldo_material.
*
*      CALL FUNCTION '/PTLOMS/MF032'
*        DESTINATION lv_rfcdest
*        EXPORTING
*          rt_matnr       = rt_matnr_aux
*          rt_werks       = rt_werks_aux
*          rt_lgort       = rt_lgort_aux
*          rt_usuario_app = rt_usuario_app
*        IMPORTING
*          it_saldo       = lt_saldo_material.
*
*      APPEND LINES OF lt_saldo_material TO et_entityset.
*
*    ENDLOOP.

  ENDMETHOD.


  METHOD out_usuarioset_get_entityset.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_dados_usuario TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_usuario.

    DATA: lt_dados_usuario_app TYPE /ptloms/ct101.

    DATA: ls_usuario_app   TYPE /iwbep/s_cod_select_option,
          ls_dados_usuario LIKE LINE OF t_dados_usuario.

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

*    DATA: o_oms    TYPE REF TO /ptloms/cl001,
*          o_sessao TYPE REF TO /ptloms/cl005.
*
*    CREATE OBJECT: o_oms,
*                   o_sessao.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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
*    lv_usuario = /ptloms/cl006=>busca_usuario( lv_usuario ).

    CALL FUNCTION '/PTLOMS/MF049'
      DESTINATION lv_rfcdest
      IMPORTING
        ex_usuario_sap = lv_usuario_sap.
*    SELECT SINGLE usuario_sap FROM /ptloms/tb033 INTO @DATA(lv_usuario_sap).

* Cria sessão para usuário Mobile (Ainda não foi autenticado)
*    IF ls_usuarioapp_aux-low IS NOT INITIAL.
    IF lv_usuario_sap IS INITIAL.

*      lv_usuario = ls_usuarioapp_aux-low.
*      TRANSLATE lv_usuario TO UPPER CASE.
      lv_senha     = ls_senha_aux-low.
      lv_confsenha = ls_confsenha_aux-low.

* Verifica se há necessidade de alterar a senha
      IF ls_senha_aux-low IS NOT INITIAL AND ls_confsenha_aux-low IS NOT INITIAL.

        CALL FUNCTION '/PTLOMS/MF043'
          DESTINATION lv_rfcdest
          EXPORTING
            im_usuario        = lv_usuario
            im_senha          = lv_senha
            im_confsenha      = lv_confsenha
          IMPORTING
            ex_senha_alterada = lv_senha_alterada.
*        o_sessao->atualiza_senha( EXPORTING im_usuario        = lv_usuario
*                                            im_senha          = lv_senha
*                                            im_confsenha      = lv_confsenha
*                                  IMPORTING ex_senha_alterada = lv_senha_alterada ).

        IF lv_senha_alterada IS INITIAL.
          RETURN.
        ENDIF.

      ENDIF.

      CALL FUNCTION '/PTLOMS/MF039'
        DESTINATION lv_rfcdest
        EXPORTING
          im_usuario     = lv_usuario
          im_senha       = lv_senha
        IMPORTING
          ex_autenticado = lv_autenticado.
*      o_sessao->autentica( EXPORTING im_usuario     = lv_usuario
*                                     im_senha       = lv_senha
*                           IMPORTING ex_autenticado = lv_autenticado ).

      IF lv_autenticado IS INITIAL.
        lv_mensagem = 'Senha/Usuário inválido'.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid  = /iwbep/cx_mgw_busi_exception=>business_error
            message = lv_mensagem.
      ENDIF.

*******      IF lv_autenticado = 'X'.
*******
*******        CALL FUNCTION '/PTLOMS/MF040'
*******          DESTINATION lv_rfcdest
*******          EXPORTING
*******            im_usuario       = lv_usuario
*******          IMPORTING
*******            ex_sessao_criada = lv_sessao_criada.
********        o_sessao->cria_sessao( EXPORTING im_usuario       = lv_usuario
********                               IMPORTING ex_sessao_criada = lv_sessao_criada ).
*******
*******      ELSE.
*******
*******        lv_mensagem = 'Favor iniciar uma nova sessão'.
*******
*******        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*******          EXPORTING
*******            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*******            message = lv_mensagem.
*******
*******      ENDIF.

* Cria sessão para usuário SAP (Já foi autenticado)
    ELSE.

*********      lv_usuario = sy-uname.
********
********      CALL FUNCTION '/PTLOMS/MF040'
********        DESTINATION lv_rfcdest
********        EXPORTING
********          im_usuario       = lv_usuario
********        IMPORTING
********          ex_sessao_criada = lv_sessao_criada.
*********      o_sessao->cria_sessao( EXPORTING im_usuario       = lv_usuario
*********                             IMPORTING ex_sessao_criada = lv_sessao_criada ).
    ENDIF.

*********    IF lv_sessao_criada = 'X'.
*********
*********      CALL FUNCTION '/PTLOMS/MF042'
*********        DESTINATION lv_rfcdest
*********        EXPORTING
*********          im_usuario = lv_usuario
*********        IMPORTING
*********          ex_guid    = lv_guid.
**********      o_sessao->busca_sessao( EXPORTING im_usuario = lv_usuario
**********                              IMPORTING ex_guid    = lv_guid ).
*********
*********    ENDIF.
*********
*********    IF lv_guid IS INITIAL.
*********      RETURN.
*********    ENDIF.

    CASE iv_entity_set_name.

      WHEN 'out_usuarioSet'.

        CLEAR ls_usuario_app.
        ls_usuario_app-sign = 'I'.
        ls_usuario_app-option = 'EQ'.
        ls_usuario_app-low = lv_usuario.
        APPEND ls_usuario_app TO rt_usuarioapp.

        CALL FUNCTION '/PTLOMS/MF034'
          DESTINATION lv_rfcdest
          EXPORTING
            rt_usuario_app       = rt_usuarioapp
          IMPORTING
            it_dados_usuario_app = lt_dados_usuario_app.
*        o_oms->out_usuario(
*          EXPORTING
*            rt_usuario_app       = rt_usuarioapp
*          IMPORTING
*            et_dados_usuario_app = lt_dados_usuario_app ).

        READ TABLE lt_dados_usuario_app INTO DATA(ls_dados_usuario_app) INDEX 1.
        IF sy-subrc EQ 0.

          IF ls_dados_usuario_app-bloqueado = 'X'.
            lv_mensagem = 'Usuário bloqueado'.

            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                textid  = /iwbep/cx_mgw_busi_exception=>business_error
                message = lv_mensagem.
          ENDIF.

          MOVE-CORRESPONDING ls_dados_usuario_app TO ls_dados_usuario.
          ls_dados_usuario-guid = lv_guid.
          CLEAR: ls_dados_usuario-senha, ls_dados_usuario-conf_senha.
        ENDIF.

        APPEND ls_dados_usuario TO t_dados_usuario.

      WHEN OTHERS.
    ENDCASE.

    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_usuario( t_dados_usuario ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_USUARIOSET_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_variantset_create_entity.

    DATA: lv_rfcdest TYPE bdbapidst,
          ls_variant TYPE /ptloms/cl_soms_mpc=>ts_out_variant.

    DATA: lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    io_data_provider->read_entry_data( IMPORTING es_data = ls_variant ).

    CALL FUNCTION '/PTLOMS/MF078'
      DESTINATION lv_rfcdest
      EXPORTING
        iv_variant = ls_variant.

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_VARIANTSET_CREATE_ENTITY'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_variantset_delete_entity.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    FIELD-SYMBOLS : <fs_keytab> TYPE /iwbep/s_mgw_name_value_pair.

    UNASSIGN <fs_keytab>.

    READ TABLE it_key_tab ASSIGNING <fs_keytab> INDEX 1.

    IF sy-subrc IS INITIAL.

      CALL FUNCTION '/PTLOMS/MF076'
        DESTINATION lv_rfcdest
        EXPORTING
          iv_var_key = <fs_keytab>-value.

    ENDIF.

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_VARIANTSET_DELETE_ENTITY'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_variantset_get_entity.

    DATA: ls_usuario TYPE LINE OF /iwbep/t_mgw_name_value_pair,
          it_variant TYPE /iwbep/t_cod_select_options,
          ls_variant TYPE /iwbep/s_cod_select_option.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_variant TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_variant.

    DATA: lt_variant TYPE /ptloms/ct081.

    DATA: lv_usuario     TYPE xubname,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    LOOP AT it_key_tab ASSIGNING FIELD-SYMBOL(<fs_key_tab>).

      IF <fs_key_tab>-name = 'VarUsuario'.

        ls_variant-sign   = 'I'.
        ls_variant-option = 'EQ'.
        ls_variant-low    = <fs_key_tab>-value.

        MOVE-CORRESPONDING <fs_key_tab> TO ls_variant.
        APPEND ls_variant TO it_variant.

      ENDIF.

    ENDLOOP.

    CALL FUNCTION '/PTLOMS/MF077'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_variant  = it_variant
      IMPORTING
        it_variants = lt_variant.

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_VARIANTSET_GET_ENTITY'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_variantset_get_entityset.

    DATA: lv_rfcdest TYPE bdbapidst.

    DATA: t_variant TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_variant.

    DATA: lt_variant TYPE /ptloms/ct081.

    DATA: ls_variant LIKE LINE OF t_variant.

    DATA: lv_usuario     TYPE xubname,
          lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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
    READ TABLE it_filter_select_options INTO DATA(ls_filter) WITH KEY property = 'VarUsuario'.

    IF sy-subrc = 0.

      DATA(rt_variant) = ls_filter-select_options.

    ENDIF.

    CALL FUNCTION '/PTLOMS/MF063'
      DESTINATION lv_rfcdest
      EXPORTING
        rt_variant = rt_variant
      IMPORTING
        it_variant = lt_variant.

    LOOP AT lt_variant ASSIGNING FIELD-SYMBOL(<fs_variant>).
      CLEAR ls_variant.
      MOVE-CORRESPONDING <fs_variant> TO ls_variant.
      APPEND ls_variant TO t_variant.
    ENDLOOP.

    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_variant( t_variant ).

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_VARIANTSET_GET_ENTITYSET'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_variantset_update_entity.

    DATA: lv_rfcdest TYPE bdbapidst,
          ls_variant TYPE /ptloms/cl_soms_mpc=>ts_out_variant.

    DATA: lv_usuario_sap TYPE flag,
          lv_same_user   TYPE rfcdisplay-rfcsameusr.

    DATA: lv_msgv1(50) TYPE c,
          lv_msgv2(50) TYPE c,
          lv_subrc     TYPE sy-subrc,
          lv_mensagem  TYPE bapi_msg.

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
*          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
        ELSE.
*          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
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

    io_data_provider->read_entry_data( IMPORTING es_data = ls_variant ).

    CALL FUNCTION '/PTLOMS/MF075'
      DESTINATION lv_rfcdest
      EXPORTING
        iv_variant = ls_variant.

    DATA: ls_controle TYPE /ptloms/tb048.

    " Controle de acessos
    ls_controle-entity_name     = iv_entity_name.
    ls_controle-metodo          = 'OUT_VARIANTSET_UPDATE_ENTITY'.
    ls_controle-usuario_sistema = sy-uname.
    ls_controle-aplicacao       = 'OMS'.
    ls_controle-usuario_app     = gv_usuario_app.

    " Controle de acessos
    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  METHOD out_variant_valu_delete_entity.

*    FIELD-SYMBOLS : <fs_keytab> TYPE /iwbep/s_mgw_name_value_pair.
*
*    UNASSIGN <fs_keytab>.
*
*    READ TABLE it_key_tab ASSIGNING <fs_keytab> INDEX 1.
*
*    IF sy-subrc IS INITIAL.
*
*      DELETE FROM /ptloms/tb049 WHERE var_key EQ <fs_keytab>-value.
*
*      IF sy-subrc IS INITIAL.
*
*        COMMIT WORK.
*
*      ENDIF.
*
*      UNASSIGN <fs_keytab>.
*
*    ENDIF.

  ENDMETHOD.


  METHOD out_variant_valu_get_entityset.

*    DATA: lv_rfcdest TYPE bdbapidst.
*
*    DATA: t_variant_values TYPE STANDARD TABLE OF /ptloms/cl_soms_mpc=>ts_out_variant_values.
*
*    DATA: lt_variant_values TYPE /ptloms/ct082.
*
*    DATA: ls_variant_values LIKE LINE OF t_variant_values.
*
*    DATA: lv_perfil TYPE c LENGTH 10.
*
*    DATA: lv_msgv1(50)   TYPE c,
*          lv_msgv2(50)   TYPE c,
*          lv_subrc       TYPE sy-subrc,
*          lv_mensagem    TYPE bapi_msg,
*          lv_usuario_sap TYPE flag,
*          lv_same_user   TYPE rfcdisplay-rfcsameusr.
*
** Busca Conexão
*    SELECT SINGLE rfcdest FROM /ptloms/tb036 INTO lv_rfcdest.
*    IF sy-subrc EQ 0.
**Verifica se conexão está ativa
*      CALL FUNCTION 'CAT_CHECK_RFC_DESTINATION'
*        EXPORTING
*          rfcdestination = lv_rfcdest
*        IMPORTING
*          msgv1          = lv_msgv1
*          msgv2          = lv_msgv2
*          rfc_subrc      = lv_subrc.
*      IF lv_subrc NE 0.
*        IF lv_subrc = 3.
**          lv_mensagem = 'Usuário Sem Autorização par RFC'(001) && lv_rfcdest.
*          CONCATENATE 'Usuário Sem Autorização par RFC'(001) lv_rfcdest INTO lv_mensagem SEPARATED BY space.
*        ELSE.
**          lv_mensagem = 'RFC' && lv_rfcdest && 'não existe ou indisponível'(002).
*          CONCATENATE 'RFC' lv_rfcdest 'não existe ou indisponível'(002) INTO lv_mensagem SEPARATED BY space.
*        ENDIF.
*
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            textid  = /iwbep/cx_mgw_busi_exception=>business_error
*            message = lv_mensagem.
*      ENDIF.
*    ELSE.
*      lv_mensagem = 'Não foi cadastrada RFC para acesso ao ECC'(003).
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = lv_mensagem.
*    ENDIF.
*
** Valida Configuração RFC (Verifica se possui usuário fixo)
*    CALL FUNCTION 'RFC_READ_R3_DESTINATION'
*      EXPORTING
*        destination             = lv_rfcdest
*      IMPORTING
*        same_user               = lv_same_user
*      EXCEPTIONS
*        authority_not_available = 1
*        destination_not_exist   = 2
*        information_failure     = 3
*        internal_failure        = 4
*        OTHERS                  = 5.
*
** Verifica se é Usuário SAP
*    CALL FUNCTION '/PTLOMS/MF049'
*      DESTINATION lv_rfcdest
*      IMPORTING
*        ex_usuario_sap = lv_usuario_sap.
*
*    IF ( lv_usuario_sap IS NOT INITIAL AND lv_same_user IS INITIAL ) OR "Se usuário SAP, então SAME_USER deve estar marcado
*       ( lv_usuario_sap IS INITIAL     AND lv_same_user IS NOT INITIAL ). "Se usuário não SAP, então SAME_USER deve estar vazio
*
*      lv_mensagem = 'RFC incompatível com modo de usuário selecionado. Rever configuração SM59'(004).
*      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*        EXPORTING
*          textid  = /iwbep/cx_mgw_busi_exception=>business_error
*          message = lv_mensagem.
*    ENDIF.
*
*    CASE iv_entity_set_name.
*
*      WHEN 'out_variant_valuesSet'.
*
*        READ TABLE it_filter_select_options INTO DATA(ls_variant) WITH KEY property = 'Variant'.
*        IF sy-subrc = 0.
*          DATA(rt_variant) = ls_variant-select_options.
*        ENDIF.
*
*        CALL FUNCTION '/PTLOMS/MF064'
*          DESTINATION lv_rfcdest
*          EXPORTING
*            rt_variant        = rt_variant
*          IMPORTING
*            it_variant_values = lt_variant_values.
*
*        LOOP AT lt_variant_values INTO DATA(ls_variant_values_aux).
*          CLEAR ls_variant_values.
*          MOVE-CORRESPONDING ls_variant_values_aux TO ls_variant_values.
*          APPEND ls_variant_values TO t_variant_values.
*        ENDLOOP.
*
*      WHEN OTHERS.
*    ENDCASE.
*
*    et_entityset = CORRESPONDING /ptloms/cl_soms_mpc=>tt_out_variant_values( t_variant_values ).
*
*    DATA: ls_controle TYPE /ptloms/tb048.
*
*    " Controle de acessos
*    ls_controle-entity_name     = iv_entity_name.
*    ls_controle-metodo          = 'OUT_VARIANT_VALU_GET_ENTITYSET'.
*    ls_controle-usuario_sistema = sy-uname.
*    ls_controle-aplicacao       = 'OMS'.
*    ls_controle-usuario_app     = gv_usuario_app.
*
*    " Controle de acessos
*    /ptloms/cl010=>inserir( CHANGING ch_controle = ls_controle ).

  ENDMETHOD.


  method ROOT_OUT_VARIANT_GET_ENTITY.



  endmethod.
ENDCLASS.
