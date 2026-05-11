-- SQL 1. ALTER TABLE
ALTER TABLE VISITA ADD observacao VARCHAR2(100);

-- SQL 2. CREATE INDEX
CREATE INDEX idx_prisioneiro_peric ON PRISIONEIRO(periculosidade);

-- SQL 3. INSERT INTO
INSERT INTO VISITANTE (cpf_visitante, nome, rua, cidade, estado, numero)
VALUES (90909090909, 'Visitante Temporario', 'Rua Teste', 'Recife', 'PE', 10);

-- SQL 4. UPDATE
UPDATE VISITANTE
SET cidade = 'Olinda'
WHERE cpf_visitante = 90909090909;

-- SQL 5. DELETE
DELETE FROM VISITANTE
WHERE cpf_visitante = 90909090909;

-- SQL 6. SELECT-FROM-WHERE
SELECT cpf_prisioneiro, nome, periculosidade, letra_pavilhao, numero_cela
FROM PRISIONEIRO
WHERE periculosidade = 'ALTA';

-- SQL 7. BETWEEN
SELECT numero_processo, cpf_prisioneiro, artigo_lei, data_registro, tempo_sentenciado
FROM PROCESSO_PENAL
WHERE data_registro BETWEEN DATE '2021-01-01' AND DATE '2024-12-31';

-- SQL 8. IN
SELECT letra_pavilhao, nivel_seguranca
FROM PAVILHAO
WHERE nivel_seguranca IN ('ALTO', 'MEDIO');

-- SQL 9. LIKE
SELECT cpf_prisioneiro, nome, periculosidade
FROM PRISIONEIRO
WHERE nome LIKE 'Marcos%';

-- SQL 10. IS NULL ou IS NOT NULL
SELECT cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno
FROM REGIME_SEMIABERTO
WHERE data_saida IS NULL;

-- SQL 11. INNER JOIN
SELECT p.nome AS prisioneiro,
       p.periculosidade,
       c.numero_cela,
       c.tipo AS tipo_cela,
       pav.nivel_seguranca
FROM PRISIONEIRO p
INNER JOIN CELA c
        ON p.numero_cela = c.numero_cela
       AND p.letra_pavilhao = c.letra_pavilhao
INNER JOIN PAVILHAO pav
        ON c.letra_pavilhao = pav.letra_pavilhao;

-- SQL 12. MAX
SELECT MAX(tempo_sentenciado) AS maior_tempo_sentenciado
FROM PROCESSO_PENAL;

-- SQL 13. MIN
SELECT MIN(pena_minima) AS menor_pena_minima
FROM CRIME;

-- SQL 14. AVG
SELECT AVG(tempo_sentenciado) AS media_tempo_sentenciado
FROM PROCESSO_PENAL;

-- SQL 15. COUNT
SELECT COUNT(*) AS total_visitas
FROM VISITA;

-- SQL 16. LEFT OUTER JOIN
SELECT p.cpf_prisioneiro,
       p.nome,
       rs.data_inicio_aberto,
       rs.data_saida,
       rs.horario_retorno
FROM PRISIONEIRO p
LEFT OUTER JOIN REGIME_SEMIABERTO rs
             ON p.cpf_prisioneiro = rs.cpf_prisioneiro;

-- SQL 17. SUBCONSULTA COM OPERADOR RELACIONAL
SELECT numero_processo, cpf_prisioneiro, artigo_lei, tempo_sentenciado
FROM PROCESSO_PENAL
WHERE tempo_sentenciado > (
    SELECT AVG(tempo_sentenciado)
    FROM PROCESSO_PENAL
);

-- SQL 18. SUBCONSULTA COM IN
SELECT cpf_prisioneiro, nome
FROM PRISIONEIRO
WHERE cpf_prisioneiro IN (
    SELECT cpf_prisioneiro
    FROM VISITA
);

-- SQL 19. SUBCONSULTA COM ANY
SELECT nome_cargo, salario
FROM CARGO
WHERE salario > ANY (
    SELECT salario
    FROM CARGO
    WHERE nome_cargo IN ('ZELADOR', 'VIGIA', 'COZINHEIRO')
);

-- SQL 20. SUBCONSULTA COM ALL
SELECT numero_processo, cpf_prisioneiro, artigo_lei, tempo_sentenciado
FROM PROCESSO_PENAL
WHERE tempo_sentenciado >= ALL (
    SELECT tempo_sentenciado
    FROM PROCESSO_PENAL
);

-- SQL 21. ORDER BY
SELECT cpf_prisioneiro, nome, inicio_prisao, periculosidade
FROM PRISIONEIRO
ORDER BY inicio_prisao DESC;

-- SQL 22. GROUP BY
SELECT periculosidade, COUNT(*) AS total_prisioneiros
FROM PRISIONEIRO
GROUP BY periculosidade;

-- SQL 23. HAVING
SELECT letra_pavilhao, COUNT(*) AS total_prisioneiros
FROM PRISIONEIRO
GROUP BY letra_pavilhao
HAVING COUNT(*) > 1;

-- SQL 24. UNION
SELECT cpf_prisioneiro
FROM REGIME_FECHADO
UNION
SELECT cpf_prisioneiro
FROM REGIME_SEMIABERTO;

-- SQL 25. CREATE VIEW
CREATE OR REPLACE VIEW vw_prisioneiro_cela AS
SELECT p.cpf_prisioneiro,
       p.nome,
       p.periculosidade,
       p.numero_cela,
       p.letra_pavilhao,
       c.tipo AS tipo_cela,
       c.capacidade,
       pav.nivel_seguranca
FROM PRISIONEIRO p
JOIN CELA c
  ON p.numero_cela = c.numero_cela
 AND p.letra_pavilhao = c.letra_pavilhao
JOIN PAVILHAO pav
  ON pav.letra_pavilhao = c.letra_pavilhao;

SELECT *
FROM vw_prisioneiro_cela
ORDER BY letra_pavilhao, numero_cela, nome;

-- SQL 26. GRANT / REVOKE (não executar no Oracle Live SQL)
-- GRANT SELECT ON PRISIONEIRO TO outro_usuario;
-- REVOKE SELECT ON PRISIONEIRO FROM outro_usuario;
