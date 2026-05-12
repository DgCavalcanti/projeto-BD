--ALTER TABLE

-- Ajustando tamanho das variáveis VARCHAR2 para melhor se adequar 
ALTER TABLE CRIME MODIFY artigo_lei VARCHAR2(10);
ALTER TABLE PROCESSO_PENAL MODIFY sentenca VARCHAR2(100);
ALTER TABLE VISITANTE MODIFY rua VARCHAR2(100);

-- Ajustando o nome de uma coluna para tirar redundancia 
ALTER TABLE REGIME_SEMIABERTO RENAME COLUMN data_inicio_aberto TO data_inicio;

-- CREATE INDEX
-- Criando indice para ser ultilizado futuralmente 
CREATE INDEX idx_salario_cargo ON CARGO(salario);
CREATE INDEX idx_prisioneiro_peric ON PRISIONEIRO(periculosidade);
CREATE INDEX idx_visita_dia ON VISITA(dia_visita);

-- INSERT INTO
-- Adcicionando Visita de uma familia de novos visitantes e seus telefones 
-- Pai de Luciana Mendes
INSERT INTO VISITANTE (cpf_visitante, nome, rua, cidade, estado, numero)
VALUES (90909090909, 'Jeremias Mendes', 'Rua 1', 'Recife', 'PE', 10);
INSERT INTO TELEFONE_VISITANTE (cpf_visitante, telefone) 
VALUES (90909090909, '81999999999');   
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (90909090909, 22232425262, 99999999999, DATE '2024-07-27', '07:00', '08:00');

--Mae de Luciana Mendes
INSERT INTO VISITANTE (cpf_visitante, nome, rua, cidade, estado, numero)
VALUES (99999900000, 'Joana Mendes', 'Rua 1', 'Recife', 'PE', 10);
INSERT INTO TELEFONE_VISITANTE (cpf_visitante, telefone) 
VALUES (99999900000, '81888888888');   
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (99999900000, 22232425262, 99999999999, DATE '2024-07-27', '08:00', '09:00');

-- UPDATE 
-- Atualizando o nivel de pecularidade dos prisioneiros conforme comportamento 
-- Alta para Media
UPDATE PRISIONEIRO
SET periculosidade = 'MEDIA'
WHERE cpf_prisioneiro = 17181920212;

--Media para Baixa
UPDATE PRISIONEIRO
SET periculosidade = 'BAIXA'
WHERE cpf_prisioneiro = 24242424242;

--Baixa para Alta
UPDATE PRISIONEIRO
SET periculosidade = 'ALTA'
WHERE cpf_prisioneiro = 22232425262;

-- DELETE
-- Removendo Funcionarios antigos e seu cargo
-- Enfermeira Mariana Costa
DELETE FROM FUNCIONARIO_CARGO
WHERE cpf_funcionario = '30303030303';
DELETE FROM FUNCIONARIO
WHERE cpf_funcionario = '30303030303';

-- Zelador Jose Inácio
DELETE FROM FUNCIONARIO_CARGO
WHERE cpf_funcionario = '16161616161';
DELETE FROM FUNCIONARIO
WHERE cpf_funcionario = '16161616161';

-- SELECT-FROM-WHERE
-- Prisioneiros com periculosidade alta
SELECT cpf_prisioneiro, nome, periculosidade, letra_pavilhao, numero_cela
FROM PRISIONEIRO
WHERE periculosidade = 'ALTA';

-- Crimes com pena minima maior que 5 anos
SELECT artigo_lei, descricao_crime, pena_minima
FROM CRIME
WHERE pena_minima > 5;

-- Visitas realizadas no dia 2024-07-27
SELECT cpf_visitante, cpf_prisioneiro, dia_visita, hora_visita
FROM VISITA
WHERE dia_visita = DATE '2024-07-27';

-- BETWEEN
-- Processos penais registrados entre 2021 e 2024
SELECT numero_processo, cpf_prisioneiro, artigo_lei, data_registro, tempo_sentenciado
FROM PROCESSO_PENAL
WHERE data_registro BETWEEN DATE '2021-01-01' AND DATE '2024-12-31';

-- Cargos com salario entre 5000 e 10000
SELECT salario 
FROM CARGO
WHERE salario BETWEEN 5000 AND 10000;

-- IN
-- Pavilhoes com nivel de seguranca alto ou medio
SELECT letra_pavilhao, nivel_seguranca
FROM PAVILHAO
WHERE nivel_seguranca IN ('ALTO', 'MEDIO');

--  Funcionarios que trabalham no turno da manha ou tarde
SELECT * 
FROM FUNCIONARIO
WHERE turno IN ('MANHA', 'TARDE');

-- LIKE
-- Prisioneiros cujo nome começa com 'Marcos'
SELECT cpf_prisioneiro, nome, periculosidade
FROM PRISIONEIRO
WHERE nome LIKE 'Marcos%';

-- Visitantes que tem sobrenome 'Mendes'
SELECT cpf_visitante, nome 
FROM VISITANTE
WHERE nome LIKE '%Mendes%';

-- IS NULL e IS NOT NULL
-- Prisioneiros que estão no regime semiaberto e não tem data de saída registrada
SELECT cpf_prisioneiro, data_inicio, data_saida, horario_retorno
FROM REGIME_SEMIABERTO
WHERE data_saida IS NULL;

-- Funcionarios que ja tem supervisor
SELECT *
FROM FUNCIONARIO
WHERE cpf_supervisor IS NOT NULL;

--  INNER JOIN
-- Correlacionar prisioneiros com suas celas e o nivel de seguranca do pavilhao onde estão
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
        
-- MAX
-- Maior tempo sentenciado entre os processos penais
SELECT MAX(tempo_sentenciado) AS maior_tempo_sentenciado
FROM PROCESSO_PENAL;

-- Maior salario entre os cargos
SELECT MAX(salario) AS maior_salario
FROM CARGO;

-- MIN
-- Menor pena minima entre os crimes
SELECT MIN(pena_minima) AS menor_pena_minima
FROM CRIME;

-- Menor salario entre os cargos
SELECT MIN(salario) AS menor_salario
FROM CARGO;

-- AVG
-- Média de tempo sentenciado entre os processos penais
SELECT AVG(tempo_sentenciado) AS media_tempo_sentenciado
FROM PROCESSO_PENAL;

-- Média salarial entre os cargos
SELECT AVG(salario) AS media_salario
FROM CARGO;

-- COUNT
-- Total de visitas
SELECT COUNT(*) AS total_visitas
FROM VISITA;

-- Total de prisioneiros
SELECT COUNT(*) AS total_prisioneiros
FROM PRISIONEIRO;

-- LEFT OUTER JOIN
SELECT p.cpf_prisioneiro,
       p.nome,
       rs.data_inicio,
       rs.data_saida,
       rs.horario_retorno
FROM PRISIONEIRO p
LEFT OUTER JOIN REGIME_SEMIABERTO rs
             ON p.cpf_prisioneiro = rs.cpf_prisioneiro;

-- SUBCONSULTA COM OPERADOR RELACIONAL
-- Prisioneiros que tem tempo sentenciado maior que a média
SELECT numero_processo, cpf_prisioneiro, artigo_lei, tempo_sentenciado
FROM PROCESSO_PENAL
WHERE tempo_sentenciado > (
    SELECT AVG(tempo_sentenciado)
    FROM PROCESSO_PENAL
);

-- Prisioneiros que estão na mesma cela que 'Marcos da Silva'
SELECT cpf_prisioneiro, nome, numero_cela
FROM PRISIONEIRO
WHERE numero_cela = (
    SELECT numero_cela 
    FROM PRISIONEIRO 
    WHERE NOME = 'Marcos da Silva'
);

-- SUBCONSULTA COM IN
-- Prisioneiros que receberam visitas
SELECT cpf_prisioneiro, nome
FROM PRISIONEIRO
WHERE cpf_prisioneiro IN (
    SELECT cpf_prisioneiro
    FROM VISITA
);

-- Visitantes que nunca visitaram um prisioneiro de alta periculosidade
SELECT nome
FROM VISITANTE
WHERE cpf_visitante NOT IN (
    SELECT v.cpf_visitante
    FROM VISITA v
    JOIN PRISIONEIRO p ON v.cpf_prisioneiro = p.cpf_prisioneiro
    WHERE p.periculosidade = 'ALTA'
);

-- SUBCONSULTA COM ANY
-- Cargos com salario maior que o salario de qualquer cargo médico da penitenciária, checagem de valorização dessa área
SELECT nome_cargo, salario
FROM CARGO
WHERE salario > ANY (
    SELECT salario
    FROM CARGO
    WHERE nome_cargo IN ('ENFERMEIRO', 'MÉDICO')
);

--Mudança do cargo de ENFERMEIRO, buscando uma valorização maior dele
UPDATE CARGO
SET salario = 5000.00
WHERE nome_cargo = "ENFERMEIRO";

-- SUBCONSULTA COM ALL
-- Prisioneiros que têm o maior tempo sentenciado
SELECT numero_processo, cpf_prisioneiro, artigo_lei, tempo_sentenciado
FROM PROCESSO_PENAL
WHERE tempo_sentenciado >= ALL (
    SELECT tempo_sentenciado
    FROM PROCESSO_PENAL
);

-- Prisioneiros que tem a maior data de progressao do pavilhao A
SELECT p.nome, p.letra_pavilhao, r.data_progressao
FROM PRISIONEIRO p
JOIN REGIME_FECHADO r ON p.cpf_prisioneiro = r.cpf_prisioneiro
WHERE p.letra_pavilhao = 'A'
AND r.data_progressao >= ALL (
    SELECT r2.data_progressao 
    FROM REGIME_FECHADO r2
    JOIN PRISIONEIRO p2 ON r2.cpf_prisioneiro = p2.cpf_prisioneiro
    WHERE p2.letra_pavilhao = 'A'
);

-- ORDER BY
--Prisioneiros ordenados pelo tempo de início da prisão (mais recente primeiro)
SELECT cpf_prisioneiro, nome, inicio_prisao, periculosidade
FROM PRISIONEIRO
ORDER BY inicio_prisao DESC;

-- Prisioneiros do sexo masculino ordenados pelo tempo sentenciado (do menor para o maior), junto com o artigo da lei e a descrição do crime
SELECT p.nome, pp.tempo_sentenciado, c.artigo_lei, c.descricao_crime
FROM PRISIONEIRO p
JOIN PROCESSO_PENAL pp ON p.cpf_prisioneiro = pp.cpf_prisioneiro
JOIN CRIME c ON pp.artigo_lei = c.artigo_lei
WHERE p.sexo = 'M'
ORDER BY pp.tempo_sentenciado ASC;

-- GROUP BY
-- Total de prisioneiros por periculosidade
SELECT periculosidade, COUNT(*) AS total_prisioneiros
FROM PRISIONEIRO
GROUP BY periculosidade;

-- Total de funcionários por turno
SELECT turno, COUNT(*) AS total_funcionarios
FROM FUNCIONARIO 
GROUP BY turno;

-- Consultas HAVING
-- Pavilhoes que tem mais de 1 prisioneiro
SELECT letra_pavilhao, COUNT(*) AS total_prisioneiros
FROM PRISIONEIRO
GROUP BY letra_pavilhao
HAVING COUNT(*) > 1;

-- Pavilhoes que tem o maior número de celas
SELECT letra_pavilhao, COUNT(*) AS quantidade_celas
FROM CELA
GROUP BY letra_pavilhao
HAVING COUNT(*) = (
    SELECT MAX(qtd)
    FROM (
        SELECT COUNT(*) AS qtd
        FROM CELA
        GROUP BY letra_pavilhao
    )
);

-- UNION
-- Prisioneiros que estão no regime fechado ou semiaberto
SELECT cpf_prisioneiro,'REGIME_FECHADO' AS tipo
FROM REGIME_FECHADO
UNION
SELECT cpf_prisioneiro, 'REGIME_SEMIABERTO' AS tipo
FROM REGIME_SEMIABERTO;

-- Nomes de todos os prisioneiros e visitantes
SELECT nome, 'PRISIONEIRO' AS tipo
FROM PRISIONEIRO
UNION
SELECT nome, 'VISITANTE' AS tipo
FROM VISITANTE;

-- CREATE VIEW
-- View para correlacionar prisioneiros com suas celas e o nivel de seguranca do pavilhao
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


--GRANT e REVOKE
CREATE USER auditor_externo IDENTIFIED BY senha123;
GRANT CREATE SESSION TO auditor_externo; 

-- GRANT 
--Concede permissão de leitura (SELECT) nas tabelas relevantes para o auditor
GRANT SELECT ON PRISIONEIRO         TO auditor_externo;
GRANT SELECT ON PROCESSO_PENAL      TO auditor_externo;
GRANT SELECT ON CRIME               TO auditor_externo;
GRANT SELECT ON VISITA              TO auditor_externo;
GRANT SELECT ON LOG_ALTERACAO_PRISIONEIRO TO auditor_externo;
GRANT SELECT ON vw_prisioneiro_cela TO auditor_externo;
-- REVOKE
--Remove a permissão de leitura (SELECT) da tabela VISITA para o auditor
REVOKE SELECT ON VISITA FROM auditor_externo;