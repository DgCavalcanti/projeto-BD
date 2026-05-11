-- PL 4. CREATE PROCEDURE
-- PL 6. %TYPE
-- PL 16. USO DE PARÂMETROS (IN e OUT)
CREATE OR REPLACE PROCEDURE pr_reajustar_salario_cargo (
    p_cargo            IN  CARGO.nome_cargo%TYPE,
    p_percentual       IN  NUMBER,
    p_linhas_alteradas OUT NUMBER
) AS
BEGIN
    UPDATE CARGO
    SET salario = salario + (salario * p_percentual / 100)
    WHERE nome_cargo = p_cargo;

    p_linhas_alteradas := SQL%ROWCOUNT;
END;
/

-- PL 5. CREATE FUNCTION
-- PL 6. %TYPE
-- PL 13. SELECT ... INTO
-- PL 15. EXCEPTION WHEN
CREATE OR REPLACE FUNCTION fn_qtd_processos_prisioneiro (
    p_cpf IN PRISIONEIRO.cpf_prisioneiro%TYPE
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM PROCESSO_PENAL
    WHERE cpf_prisioneiro = p_cpf;

    RETURN v_total;
EXCEPTION
    WHEN OTHERS THEN
        RETURN -1;
END;
/

-- PL 17. CREATE OR REPLACE PACKAGE
-- PL 1. USO DE RECORD
-- PL 2. USO DE ESTRUTURA DE DADOS DO TIPO TABLE
-- PL 6. %TYPE
CREATE OR REPLACE PACKAGE pkg_relatorio_prisional_av4 AS
    TYPE t_resumo_pavilhao IS RECORD (
        letra              PAVILHAO.letra_pavilhao%TYPE,
        total_prisioneiros NUMBER,
        capacidade_total   NUMBER,
        classificacao      VARCHAR2(30)
    );

    TYPE t_tabela_resumo IS TABLE OF t_resumo_pavilhao INDEX BY PLS_INTEGER;

    PROCEDURE resumo_pavilhao (
        p_letra              IN  PAVILHAO.letra_pavilhao%TYPE,
        p_total_prisioneiros OUT NUMBER,
        p_capacidade_total   OUT NUMBER
    );

    FUNCTION classificacao_lotacao (
        p_letra IN PAVILHAO.letra_pavilhao%TYPE
    ) RETURN VARCHAR2;
END pkg_relatorio_prisional_av4;
/

-- PL 18. CREATE OR REPLACE PACKAGE BODY
-- PL 8. IF ELSIF
-- PL 9. CASE WHEN
-- PL 13. SELECT ... INTO
CREATE OR REPLACE PACKAGE BODY pkg_relatorio_prisional_av4 AS
    PROCEDURE resumo_pavilhao (
        p_letra              IN  PAVILHAO.letra_pavilhao%TYPE,
        p_total_prisioneiros OUT NUMBER,
        p_capacidade_total   OUT NUMBER
    ) AS
    BEGIN
        SELECT
            (SELECT COUNT(*)
             FROM PRISIONEIRO
             WHERE letra_pavilhao = p_letra),
            (SELECT NVL(SUM(capacidade), 0)
             FROM CELA
             WHERE letra_pavilhao = p_letra)
        INTO p_total_prisioneiros, p_capacidade_total
        FROM DUAL;
    END resumo_pavilhao;

    FUNCTION classificacao_lotacao (
        p_letra IN PAVILHAO.letra_pavilhao%TYPE
    ) RETURN VARCHAR2 AS
        v_total      NUMBER;
        v_capacidade NUMBER;
        v_percentual NUMBER;
    BEGIN
        resumo_pavilhao(p_letra, v_total, v_capacidade);

        IF v_capacidade = 0 THEN
            RETURN 'SEM CELAS';
        ELSIF v_total = 0 THEN
            RETURN 'SEM PRISIONEIROS';
        ELSE
            v_percentual := v_total / v_capacidade;
        END IF;

        CASE
            WHEN v_percentual < 0.50 THEN
                RETURN 'BAIXA LOTACAO';
            WHEN v_percentual < 0.90 THEN
                RETURN 'LOTACAO MODERADA';
            ELSE
                RETURN 'LOTACAO ALTA';
        END CASE;
    END classificacao_lotacao;
END pkg_relatorio_prisional_av4;
/

-- PL 19. CREATE OR REPLACE TRIGGER (COMANDO)
CREATE OR REPLACE TRIGGER trg_visita_comando_av4
AFTER INSERT OR UPDATE OR DELETE ON VISITA
BEGIN
    DBMS_OUTPUT.PUT_LINE('Operacao de comando executada na tabela VISITA.');
END;
/

-- PL 20. CREATE OR REPLACE TRIGGER (LINHA)
CREATE OR REPLACE TRIGGER trg_prisioneiro_linha_av4
BEFORE INSERT OR UPDATE OF periculosidade ON PRISIONEIRO
FOR EACH ROW
BEGIN
    IF :NEW.periculosidade IS NOT NULL
       AND :NEW.periculosidade NOT IN ('BAIXA', 'MEDIA', 'ALTA') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Periculosidade invalida para PRISIONEIRO.');
    END IF;
END;
/

-- PL 3. BLOCO ANÔNIMO
-- PL 1. USO DE RECORD
-- PL 2. USO DE ESTRUTURA DE DADOS DO TIPO TABLE
-- PL 6. %TYPE
-- PL 7. %ROWTYPE
-- PL 8. IF ELSIF
-- PL 9. CASE WHEN
-- PL 10. LOOP EXIT WHEN
-- PL 11. WHILE LOOP
-- PL 12. FOR IN LOOP
-- PL 13. SELECT ... INTO
-- PL 14. CURSOR (OPEN, FETCH e CLOSE)
-- PL 15. EXCEPTION WHEN
-- PL 16. USO DE PARÂMETROS (IN e OUT)
DECLARE
    TYPE t_prisioneiro_record IS RECORD (
        cpf            PRISIONEIRO.cpf_prisioneiro%TYPE,
        nome           PRISIONEIRO.nome%TYPE,
        periculosidade PRISIONEIRO.periculosidade%TYPE
    );

    TYPE t_prisioneiro_table IS TABLE OF t_prisioneiro_record INDEX BY PLS_INTEGER;

    v_lista             t_prisioneiro_table;
    v_prisioneiro       PRISIONEIRO%ROWTYPE;
    v_nome              PRISIONEIRO.nome%TYPE;
    v_total_processos   NUMBER;
    v_linhas            NUMBER;
    v_indice            PLS_INTEGER := 1;
    v_contador          PLS_INTEGER := 1;
    v_status            VARCHAR2(30);
    v_total_pav         NUMBER;
    v_capacidade_pav    NUMBER;

    CURSOR c_prisioneiros IS
        SELECT cpf_prisioneiro, nome, periculosidade
        FROM PRISIONEIRO
        ORDER BY nome;

    v_cursor c_prisioneiros%ROWTYPE;
BEGIN
    SELECT *
    INTO v_prisioneiro
    FROM PRISIONEIRO
    WHERE cpf_prisioneiro = 23232323232;

    v_nome := v_prisioneiro.nome;
    v_total_processos := fn_qtd_processos_prisioneiro(v_prisioneiro.cpf_prisioneiro);

    IF v_total_processos = 0 THEN
        v_status := 'SEM PROCESSO';
    ELSIF v_total_processos = 1 THEN
        v_status := 'UM PROCESSO';
    ELSE
        v_status := 'MAIS DE UM PROCESSO';
    END IF;

    CASE
        WHEN v_prisioneiro.periculosidade = 'ALTA' THEN
            DBMS_OUTPUT.PUT_LINE(v_nome || ' possui periculosidade alta.');
        WHEN v_prisioneiro.periculosidade = 'MEDIA' THEN
            DBMS_OUTPUT.PUT_LINE(v_nome || ' possui periculosidade media.');
        WHEN v_prisioneiro.periculosidade = 'BAIXA' THEN
            DBMS_OUTPUT.PUT_LINE(v_nome || ' possui periculosidade baixa.');
        ELSE
            DBMS_OUTPUT.PUT_LINE(v_nome || ' possui periculosidade nao informada.');
    END CASE;

    DBMS_OUTPUT.PUT_LINE('Status processual: ' || v_status);

    OPEN c_prisioneiros;
    LOOP
        FETCH c_prisioneiros INTO v_cursor;
        EXIT WHEN c_prisioneiros%NOTFOUND OR v_indice > 5;

        v_lista(v_indice).cpf := v_cursor.cpf_prisioneiro;
        v_lista(v_indice).nome := v_cursor.nome;
        v_lista(v_indice).periculosidade := v_cursor.periculosidade;
        v_indice := v_indice + 1;
    END LOOP;
    CLOSE c_prisioneiros;

    v_indice := v_lista.FIRST;
    LOOP
        EXIT WHEN v_indice IS NULL;
        DBMS_OUTPUT.PUT_LINE('LOOP: ' || v_lista(v_indice).nome);
        v_indice := v_lista.NEXT(v_indice);
    END LOOP;

    WHILE v_contador <= v_lista.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('WHILE: posicao ' || v_contador);
        v_contador := v_contador + 1;
    END LOOP;

    FOR r IN (
        SELECT letra_pavilhao, COUNT(*) AS total
        FROM PRISIONEIRO
        GROUP BY letra_pavilhao
        ORDER BY letra_pavilhao
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('FOR: pavilhao ' || r.letra_pavilhao || ' tem ' || r.total || ' prisioneiro(s).');
    END LOOP;

    pkg_relatorio_prisional_av4.resumo_pavilhao('A', v_total_pav, v_capacidade_pav);
    DBMS_OUTPUT.PUT_LINE('Package OUT: pavilhao A total=' || v_total_pav || ', capacidade=' || v_capacidade_pav);
    DBMS_OUTPUT.PUT_LINE('Package FUNCTION: ' || pkg_relatorio_prisional_av4.classificacao_lotacao('A'));

    pr_reajustar_salario_cargo('ZELADOR', 0, v_linhas);
    DBMS_OUTPUT.PUT_LINE('Procedure OUT: linhas afetadas=' || v_linhas);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum prisioneiro encontrado para o CPF informado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro no bloco anonimo: ' || SQLERRM);
END;
/
