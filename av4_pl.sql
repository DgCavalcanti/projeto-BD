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
DECLARE
    v_total_visitas     NUMBER;
    v_operacao          VARCHAR2(10);
BEGIN
    -- Identifica qual operação foi executada
    IF INSERTING THEN
        v_operacao := 'INSERT';
    ELSIF UPDATING THEN
        v_operacao := 'UPDATE';
    ELSIF DELETING THEN
        v_operacao := 'DELETE';
    END IF;

    -- Consulta o total atual de visitas na tabela
    SELECT COUNT(*)
    INTO v_total_visitas
    FROM VISITA;

    DBMS_OUTPUT.PUT_LINE('=========================================');
    DBMS_OUTPUT.PUT_LINE('OPERACAO  : ' || v_operacao);
    DBMS_OUTPUT.PUT_LINE('TABELA    : VISITA');
    DBMS_OUTPUT.PUT_LINE('DATA/HORA : ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('TOTAL DE VISITAS REGISTRADAS: ' || v_total_visitas);
    DBMS_OUTPUT.PUT_LINE('=========================================');
END;
/

-- PL 20. CREATE OR REPLACE TRIGGER (LINHA)
CREATE OR REPLACE TRIGGER trg_prisioneiro_linha_av4
BEFORE UPDATE OF periculosidade ON PRISIONEIRO
FOR EACH ROW
BEGIN
    -- Impede rebaixamento direto de ALTA para BAIXA
    IF :OLD.periculosidade = 'ALTA' AND :NEW.periculosidade = 'BAIXA' THEN
        RAISE_APPLICATION_ERROR(-20002,
            'Rebaixamento invalido: periculosidade ALTA nao pode ir direto para BAIXA. Passe por MEDIA primeiro.');
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
    -- Define um RECORD para armazenar dados resumidos de um prisioneiro
    TYPE t_prisioneiro_record IS RECORD (
        cpf            PRISIONEIRO.cpf_prisioneiro%TYPE,
        nome           PRISIONEIRO.nome%TYPE,
        periculosidade PRISIONEIRO.periculosidade%TYPE
    );

    -- Define uma TABLE (coleção) de records de prisioneiros
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

    -- Cursor que busca todos os prisioneiros ordenados por nome
    CURSOR c_prisioneiros IS
        SELECT cpf_prisioneiro, nome, periculosidade
        FROM PRISIONEIRO
        ORDER BY nome;

    v_cursor c_prisioneiros%ROWTYPE; -- Variável para receber cada linha do cursor
BEGIN
    -- SELECT INTO: busca todos os dados do prisioneiro de CPF fixo
    SELECT *
    INTO v_prisioneiro
    FROM PRISIONEIRO
    WHERE cpf_prisioneiro = 23232323232;

    v_nome := v_prisioneiro.nome;

    -- Chama a function para contar quantos processos esse prisioneiro tem
    v_total_processos := fn_qtd_processos_prisioneiro(v_prisioneiro.cpf_prisioneiro);

    -- IF/ELSIF: classifica o status processual com base na quantidade de processos
    IF v_total_processos = 0 THEN
        v_status := 'SEM PROCESSO';
    ELSIF v_total_processos = 1 THEN
        v_status := 'UM PROCESSO';
    ELSE
        v_status := 'MAIS DE UM PROCESSO';
    END IF;

    -- CASE WHEN: exibe a periculosidade do prisioneiro em formato legível
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

    -- CURSOR: abre, busca e fecha manualmente os primeiros 5 prisioneiros
    OPEN c_prisioneiros;
    LOOP
        FETCH c_prisioneiros INTO v_cursor;
        EXIT WHEN c_prisioneiros%NOTFOUND OR v_indice > 5; -- Para ao achar 5 ou acabar os dados

        -- Preenche a coleção com os dados de cada prisioneiro
        v_lista(v_indice).cpf            := v_cursor.cpf_prisioneiro;
        v_lista(v_indice).nome           := v_cursor.nome;
        v_lista(v_indice).periculosidade := v_cursor.periculosidade;
        v_indice := v_indice + 1;
    END LOOP;
    CLOSE c_prisioneiros;

    -- LOOP simples: percorre a coleção e exibe o nome de cada prisioneiro
    v_indice := v_lista.FIRST;
    LOOP
        EXIT WHEN v_indice IS NULL;
        DBMS_OUTPUT.PUT_LINE('LOOP: ' || v_lista(v_indice).nome);
        v_indice := v_lista.NEXT(v_indice);
    END LOOP;

    -- WHILE LOOP: percorre a coleção pelo contador e exibe a posição de cada elemento
    WHILE v_contador <= v_lista.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('WHILE: posicao ' || v_contador);
        v_contador := v_contador + 1;
    END LOOP;

    -- FOR IN LOOP: agrupa prisioneiros por pavilhão e exibe o total de cada um
    FOR r IN (
        SELECT letra_pavilhao, COUNT(*) AS total
        FROM PRISIONEIRO
        GROUP BY letra_pavilhao
        ORDER BY letra_pavilhao
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('FOR: pavilhao ' || r.letra_pavilhao || ' tem ' || r.total || ' prisioneiro(s).');
    END LOOP;

    -- Chama a procedure do package para obter total e capacidade do pavilhão A (parâmetros OUT)
    pkg_relatorio_prisional_av4.resumo_pavilhao('A', v_total_pav, v_capacidade_pav);
    DBMS_OUTPUT.PUT_LINE('Package OUT: pavilhao A total=' || v_total_pav || ', capacidade=' || v_capacidade_pav);

    -- Chama a function do package para classificar a lotação do pavilhão A
    DBMS_OUTPUT.PUT_LINE('Package FUNCTION: ' || pkg_relatorio_prisional_av4.classificacao_lotacao('A'));

    -- Chama a procedure de reajuste com percentual 0 apenas para testar o parâmetro OUT de linhas afetadas
    pr_reajustar_salario_cargo('ZELADOR', 0, v_linhas);
    DBMS_OUTPUT.PUT_LINE('Procedure OUT: linhas afetadas=' || v_linhas);

EXCEPTION
    -- Captura caso o CPF do prisioneiro não exista na tabela
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum prisioneiro encontrado para o CPF informado.');
    -- Captura qualquer outro erro inesperado
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro no bloco anonimo: ' || SQLERRM);
END;
/