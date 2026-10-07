FUNCTION /ptloms/mf165.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  EXPORTING
*"     VALUE(ET_PERGUNTAS) TYPE /PTLOMS/CT155
*"----------------------------------------------------------------------

  DATA: lo_checklist TYPE REF TO /ptloms/cl017,
        lt_perguntas TYPE /ptloms/cl017=>tt_checklist_perguntas,
        ls_pergunta  TYPE /ptloms/tb075,
        lt_grupos    TYPE TABLE OF /ptloms/tb073,
        ls_grupo     TYPE /ptloms/tb073,
        ls_saida     TYPE /ptloms/et088.

  CLEAR et_perguntas[].

*---------------------------------------------------------------------*
* 1. Instancia classe de checklist
*---------------------------------------------------------------------*
  CREATE OBJECT lo_checklist.

*---------------------------------------------------------------------*
* 2. Recupera todas as perguntas cadastradas para o OMS
*---------------------------------------------------------------------*
  CALL METHOD lo_checklist->busca_checklist_perguntas
    IMPORTING
      e_perguntas = lt_perguntas.

*---------------------------------------------------------------------*
* 3. Recupera descrições dos grupos utilizados pelas perguntas
*---------------------------------------------------------------------*
  IF lt_perguntas[] IS NOT INITIAL.

    SELECT *
      INTO TABLE lt_grupos
      FROM /ptloms/tb073
      FOR ALL ENTRIES IN lt_perguntas
      WHERE aplicacao = lt_perguntas-aplicacao
        AND grupo     = lt_perguntas-grupo.

    SORT lt_grupos BY aplicacao grupo.

  ENDIF.

*---------------------------------------------------------------------*
* 4. Monta estrutura de saída
*---------------------------------------------------------------------*
  LOOP AT lt_perguntas INTO ls_pergunta.

    CLEAR: ls_saida,
           ls_grupo.

    ls_saida-chave            = 'X'.
    ls_saida-aplicacao        = ls_pergunta-aplicacao.
    ls_saida-formulario       = ls_pergunta-formulario.
    ls_saida-sequencial       = ls_pergunta-sequencial.
    ls_saida-ordenacao1       = ls_pergunta-ordenacao1.
    ls_saida-ordenacao2       = ls_pergunta-ordenacao2.
    ls_saida-descricao        = ls_pergunta-descricao.
    ls_saida-resposta         = ls_pergunta-resposta.
    ls_saida-opcao            = ls_pergunta-opcao.
    ls_saida-grupo            = ls_pergunta-grupo.
    ls_saida-obrigatorio      = ls_pergunta-obrigatorio.
    ls_saida-inf_complementar = ls_pergunta-inf_complementar.

*---------------------------------------------------------------------*
* 5. Recupera descrição do grupo
*---------------------------------------------------------------------*
    IF ls_pergunta-grupo IS NOT INITIAL.

      READ TABLE lt_grupos
        INTO ls_grupo
        WITH KEY aplicacao = ls_pergunta-aplicacao
                 grupo     = ls_pergunta-grupo
        BINARY SEARCH.

      IF sy-subrc = 0.
        ls_saida-descr_grupo = ls_grupo-descricao.
      ENDIF.

    ENDIF.

    APPEND ls_saida TO et_perguntas.

  ENDLOOP.

ENDFUNCTION.
