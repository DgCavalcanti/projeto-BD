------------------------------------------------------------
-- 1. PAVILHAO
------------------------------------------------------------
INSERT INTO PAVILHAO (letra_pavilhao, nivel_seguranca) VALUES ('A', 'ALTO');
INSERT INTO PAVILHAO (letra_pavilhao, nivel_seguranca) VALUES ('B', 'MEDIO');
INSERT INTO PAVILHAO (letra_pavilhao, nivel_seguranca) VALUES ('C', 'BAIXO');
INSERT INTO PAVILHAO (letra_pavilhao, nivel_seguranca) VALUES ('F', 'ALTO'); -- Pavilhão Feminino
INSERT INTO PAVILHAO (letra_pavilhao, nivel_seguranca) VALUES ('D', 'MEDIO');
INSERT INTO PAVILHAO (letra_pavilhao, nivel_seguranca) VALUES ('E', 'BAIXO');
------------------------------------------------------------
-- 2. CELA
------------------------------------------------------------
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (101, 'A', 'SEGURANCA_MAXIMA', 1);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (102, 'A', 'ISOLAMENTO', 1);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (103, 'A', 'COMUM', 6);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (104, 'A', 'COMUM', 10);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (105, 'A', 'COMUM', 8);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (201, 'B', 'COMUM', 4);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (202, 'B', 'COMUM', 4);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (203, 'B', 'COMUM', 6);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (204, 'B', 'COMUM', 8); 
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (205, 'B', 'COMUM', 10);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (301, 'C', 'COMUM', 10);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (302, 'C', 'COMUM', 10);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (303, 'C', 'COMUM', 8);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (304, 'C', 'COMUM', 6);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (305, 'C', 'COMUM', 4);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (401, 'F', 'COMUM', 6);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (402, 'F', 'COMUM', 6);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (403, 'F', 'COMUM', 4);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (404, 'F', 'COMUM', 8);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (405, 'F', 'COMUM', 10);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (501, 'D', 'COMUM', 6);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (502, 'D', 'COMUM', 6);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (601, 'E', 'COMUM', 6);
------------------------------------------------------------
-- 3. CARGO
------------------------------------------------------------
INSERT INTO CARGO (nome_cargo, salario) VALUES ('DIRETOR_GERAL', 12000.00);
INSERT INTO CARGO (nome_cargo, salario) VALUES ('SUPERVISOR_PLATA', 6500.00);
INSERT INTO CARGO (nome_cargo, salario) VALUES ('AGENTE_PENITENCIARIO', 4200.00);
INSERT INTO CARGO (nome_cargo, salario) VALUES ('MEDICO_CLINICO', 8500.00);
INSERT INTO CARGO (nome_cargo, salario) VALUES ('PSICOLOGO', 5500.00);
INSERT INTO CARGO (nome_cargo, salario) VALUES ('ASSISTENTE_SOCIAL', 4800.00);
INSERT INTO CARGO (nome_cargo, salario) VALUES ('ENFERMEIRO', 3500.00);
INSERT INTO CARGO (nome_cargo, salario) VALUES ('COZINHEIRO', 3000.00);
INSERT INTO CARGO (nome_cargo, salario) VALUES ('ZELADOR', 1700.00);
INSERT INTO CARGO (nome_cargo, salario) VALUES ('VIGIA', 3000.00);
------------------------------------------------------------
-- 4. FUNCIONARIO
-- Nota: Inserir chefe (sem supervisor) antes dos subordinados
------------------------------------------------------------
-- Diretor
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (11111111111, 'Carlos Eduardo Gomes', DATE '1970-05-15', 'MANHA', NULL);

-- Supervisores (Subordinados ao Diretor)
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (22222222222, 'Renata Vasconcelos', DATE '1982-10-20', 'TARDE', 11111111111);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (88888888888, 'Luciana Mendes', DATE '1985-11-08', 'MANHA', 11111111111);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (99999999999, 'Fernando Souza', DATE '1990-09-25', 'NOITE', 11111111111);

-- Agentes e médicos(Subordinados aos Supervisores)
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (33333333333, 'Felipe Andrade', DATE '1990-02-10', 'NOITE', 99999999999);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (44444444444, 'Juliana Paes', DATE '1988-11-25', 'MANHA', 88888888888);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (11023444591, 'Roberto Mendes', DATE '1975-08-30', 'TARDE', 22222222222);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (55555555555, 'Dr. Roberto Almeida', DATE '1975-08-30', 'TARDE', 22222222222);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (66666666666, 'Dra. Ana Paula Silva', DATE '1992-04-18', 'NOITE', 99999999999);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (77777777777, 'Dr. Marcos Vinicius', DATE '1985-09-05', 'MANHA', 88888888888);

-- Psicólogas (Responde ao Diretor Geral) 
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (10101010101, 'Dra. Camila Rocha', DATE '1985-03-22', 'MANHA', 88888888888);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (12121212121, 'Dra. Juliana Lima', DATE '1987-07-10', 'TARDE', 22222222222);

-- Assistente_Social (Responde ao Supervisor Plata)
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (20202020202, 'Thiago Moura', DATE '1993-08-14', 'TARDE', 22222222222);

-- Enfermeiros (Respondem ao Medico Clinico)
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (30303030303, 'Mariana Costa', DATE '1989-12-01', 'MANHA', 55555555555);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (13131313131, 'Juliana Maria', DATE '1987-07-10', 'TARDE', 12121212121);

-- Cozinheiro (Responde ao Supervisor Plata)
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (14141414141, 'Carlos Alberto', DATE '1980-11-20', 'MANHA', 88888888888);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (15151515151, 'Maria Fernanda', DATE '1982-04-15', 'TARDE', 22222222222);

--Zelador (Responde ao Supervisor Plata)
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (16161616161, 'Jose Inácio', DATE '1970-01-10', 'MANHA', 88888888888);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (17171717171, 'Maria do Carmo', DATE '1975-05-20', 'TARDE', 22222222222);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (18181818181, 'Antonio Carlos', DATE '1980-09-30', 'NOITE', 99999999999);

--Vigia (Responde ao Supervisor Plata)
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (19191919191, 'Vigilio Silva', DATE '1985-02-28', 'NOITE', 99999999999);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (20202020203, 'Maria Antônia', DATE '1987-06-15', 'MANHA', 88888888888);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor)
VALUES (21212121212, 'Joao da Silva', DATE '1990-10-05', 'TARDE', 22222222222);
------------------------------------------------------------
-- 5. FUNCIONARIO_CARGO
------------------------------------------------------------
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (11111111111, 'DIRETOR_GERAL');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (22222222222, 'SUPERVISOR_PLATA');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (33333333333, 'AGENTE_PENITENCIARIO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (44444444444, 'AGENTE_PENITENCIARIO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (55555555555, 'MEDICO_CLINICO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (10101010101, 'PSICOLOGO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (20202020203, 'ASSISTENTE_SOCIAL');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (30303030303, 'ENFERMEIRO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (66666666666, 'MEDICO_CLINICO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (77777777777, 'MEDICO_CLINICO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (88888888888, 'SUPERVISOR_PLATA');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (99999999999, 'SUPERVISOR_PLATA');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (11023444591, 'AGENTE_PENITENCIARIO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (12121212121, 'MEDICO_CLINICO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (13131313131, 'ENFERMEIRO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (14141414141, 'COZINHEIRO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (15151515151, 'COZINHEIRO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (16161616161, 'ZELADOR');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (17171717171, 'ZELADOR');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (18181818181, 'ZELADOR');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (19191919191, 'VIGIA');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (20202020202, 'VIGIA');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (21212121212, 'VIGIA');

------------------------------------------------------------
-- 6. CRIME
------------------------------------------------------------
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART121-1', 'Homicidio Simples', 6, 20);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART155-1', 'Furto', 1, 4);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART157-1', 'Roubo Subtração com Ameaça', 4, 10);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART33-1', 'Trafico de Drogas', 5, 15);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART171-1', 'Estelionato', 1, 5);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART288-1', 'Associacao Criminosa', 1, 3);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART213-1', 'Estupro', 6, 10);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART33-2', 'Associacao ao Trafico de Drogas', 3, 8);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART121-2', 'Homicidio Qualificado', 12, 30);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART155-2', 'Abandono de Incapazes', 3, 6);
------------------------------------------------------------
-- 7. PRISIONEIRO
------------------------------------------------------------
INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (23232323232, 'Marcos da Silva', DATE '1995-04-12', 'M', DATE '2023-01-15', 'ALTA', 101, 'A');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (24242424242, 'Joao Batista', DATE '1980-12-05', 'M', DATE '2019-06-20', 'MEDIA', 201, 'B');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (25252525252, 'Pedro Alcantara', DATE '2000-01-22', 'M', DATE '2024-03-10', 'BAIXA', 301, 'C');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (26262626262, 'Maria das Dores', DATE '1992-07-18', 'F', DATE '2021-09-05', 'MEDIA', 401, 'F');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (12131415161, 'Roberto Carlos Alves', DATE '1978-02-11', 'M', DATE '2022-03-15', 'MEDIA', 501, 'D');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (17181920212, 'Fernando Souza', DATE '1990-09-25', 'M', DATE '2024-01-10', 'ALTA', 502, 'D');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (22232425262, 'Luciana Mendes', DATE '1985-11-08', 'F', DATE '2020-05-20', 'BAIXA', 601, 'E');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao)
VALUES (27272727272, 'Marcos Vinicius', DATE '1985-09-05', 'M', DATE '2022-11-10', 'ALTA', 101, 'A');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao)
VALUES (28282828282, 'Joao da Silva', DATE '1990-10-05', 'M', DATE '2019-05-15', 'MEDIA', 201, 'B');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao)
VALUES (29292929292, 'Maria Antônia', DATE '1987-06-15', 'F', DATE '2024-02-01', 'BAIXA', 301, 'C');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao)
VALUES (31313131313, 'Fernando Souza', DATE '1990-09-25', 'M', DATE '2021-08-20', 'ALTA', 101, 'A');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao)
VALUES (12345678910, 'Roberto Carlos Alves', DATE '1986-02-11', 'M', DATE '2021-04-17', 'MEDIA', 501, 'D');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao)
VALUES (12345678911, 'Fernando Souza', DATE '1990-09-25', 'M', DATE '2024-01-10', 'ALTA', 502, 'D');
------------------------------------------------------------
-- 8. REGIMES (SEMIABERTO E FECHADO)
------------------------------------------------------------
-- Fechado
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (23232323232, DATE '2030-01-15');
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (24242424242, DATE '2027-09-05');
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (17181920212, DATE '2032-01-10');
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (27272727272, DATE '2030-11-10');
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (31313131313, DATE '2028-08-20');
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (12345678911, DATE '2032-01-10');
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (12345678910, DATE '2029-03-15');
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (28282828282, DATE '2026-02-01');

-- Semiaberto
INSERT INTO REGIME_SEMIABERTO (cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno) 
VALUES (25252525252, DATE '2024-03-10', DATE '2025-03-10', '20:00');

INSERT INTO REGIME_SEMIABERTO (cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno) 
VALUES (12131415161, DATE '2025-03-15', NULL, '19:00');

INSERT INTO REGIME_SEMIABERTO (cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno) 
VALUES (22232425262, DATE '2023-05-20', DATE '2026-05-20', '18:30');

INSERT INTO REGIME_SEMIABERTO (cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno) 
VALUES (26262626262, DATE '2021-09-05', DATE '2024-09-05', '17:00');

INSERT INTO REGIME_SEMIABERTO (cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno) 
VALUES (29292929292, DATE '2024-11-10', NULL, '18:00');
------------------------------------------------------------
-- 9. PROCESSO_PENAL
------------------------------------------------------------
INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10001, 23232323232, 'ART121-1', DATE '2022-11-10', 'Culpado em tribunal do juri', 18);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10002, 24242424242, 'ART157-1', DATE '2019-05-15', 'Condenado por roubo a mao armada', 8);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10003, 25252525252, 'ART155-1', DATE '2024-02-01', 'Furto qualificado, reu primario', 2);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10004, 26262626262, 'ART33-2', DATE '2021-08-20', 'Condenada por associacao ao trafico', 10);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10005, 12131415161, 'ART171-1', DATE '2021-12-01', 'Condenado por fraudes bancarias', 4);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10006, 17181920212, 'ART213-1', DATE '2023-11-15', 'Condenacao em regime fechado', 9);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10006, 17181920212, 'ART288-1', DATE '2023-11-15', 'Agravante por associacao criminosa', 2);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10007, 22232425262, 'ART288-1', DATE '2019-10-10', 'Participacao em quadrilha', 3);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado)
VALUES (10008, 27272727272, 'ART121-2', DATE '2024-11-10', 'Homicidio qualificado, reu primario', 12);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado)
VALUES (10009, 28282828282, 'ART33-1', DATE '2019-05-15', 'Condenacao por trafico de drogas', 8);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado)
VALUES (10010, 29292929292, 'ART171-1', DATE '2024-11-10', 'Condenacao por estelionato', 3);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado)
VALUES (10011, 31313131313, 'ART121-1', DATE '2021-08-20', 'Homicidio simples, reu primario', 6);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado)
VALUES (10012, 12345678910, 'ART171-1', DATE '2022-03-15', 'Condenacao por estelionato', 4);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado)
VALUES (10013, 12345678911, 'ART213-1', DATE '2024-01-10', 'Condenacao por estupro', 10);

------------------------------------------------------------
-- 10. VISITANTE
------------------------------------------------------------

INSERT INTO VISITANTE (cpf_visitante, nome, rua, cidade, estado, numero) 
VALUES (12121212121, 'Ana Clara da Silva', 'Rua das Flores', 'Recife', 'PE', 123);

INSERT INTO VISITANTE (cpf_visitante, nome, rua, cidade, estado, numero) 
VALUES (34343434343, 'Jose Batista', 'Av. Boa Viagem', 'Recife', 'PE', 4500);

INSERT INTO VISITANTE (cpf_visitante, nome, rua, cidade, estado, numero) 
VALUES (56565656565, 'Marta Alcantara', 'Rua do Sol', 'Joao Pessoa', 'PB', 89);

INSERT INTO VISITANTE (cpf_visitante, nome, rua, cidade, estado, numero) 
VALUES (98765432111, 'Carla Alves', 'Rua das Nuvens', 'Fortaleza', 'CE', 45);

INSERT INTO VISITANTE (cpf_visitante, nome, rua, cidade, estado, numero) 
VALUES (87654321022, 'Raimundo Nonato', 'Av. Oceano', 'Natal', 'RN', 1020);

INSERT INTO VISITANTE (cpf_visitante, nome, rua, cidade, estado, numero) 
VALUES (76543210933, 'Patricia Mendes', 'Tv. das Gracas', 'Salvador', 'BA', 77);

------------------------------------------------------------
-- 11. TELEFONE_VISITANTE
------------------------------------------------------------

INSERT INTO TELEFONE_VISITANTE (cpf_visitante, telefone) VALUES (12121212121, '81999991111');
INSERT INTO TELEFONE_VISITANTE (cpf_visitante, telefone) VALUES (12121212121, '81988882222'); -- 2º telefone da Ana
INSERT INTO TELEFONE_VISITANTE (cpf_visitante, telefone) VALUES (34343434343, '81977773333');
INSERT INTO TELEFONE_VISITANTE (cpf_visitante, telefone) VALUES (56565656565, '83966664444');
INSERT INTO TELEFONE_VISITANTE (cpf_visitante, telefone) VALUES (98765432111, '85999998888');
INSERT INTO TELEFONE_VISITANTE (cpf_visitante, telefone) VALUES (87654321022, '84988887777');
INSERT INTO TELEFONE_VISITANTE (cpf_visitante, telefone) VALUES (76543210933, '71977776666');
------------------------------------------------------------
-- 12. VISITA
------------------------------------------------------------
-- Ana visitando Marcos, acompanhada pelo agente Felipe
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (12121212121, 23232323232, 33333333333, DATE '2024-05-12', '14:00', '16:00');

-- Jose visitando João, acompanhada pela agente Juliana
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (34343434343, 24242424242, 44444444444, DATE '2024-05-15', '09:00', '11:30');

-- Marta visitando Pedro, acompanhada pela agente Juliana
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (56565656565, 25252525252, 44444444444, DATE '2024-05-20', '10:00', '12:00');

-- Visita em cela acompanhada pelo agente Felipe 
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (87654321022, 17181920212, 33333333333, DATE '2024-06-05', '09:00', '10:00');

-- Visita ao pavilhão E acompanhada pela psicóloga
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (76543210933, 22232425262, 10101010101, DATE '2024-06-10', '14:30', '16:30');
COMMIT;
