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
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (201, 'B', 'COMUM', 4);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (202, 'B', 'COMUM', 4);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (301, 'C', 'COMUM', 10);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (401, 'F', 'COMUM', 6);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (501, 'D', 'COMUM', 5);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (502, 'D', 'ISOLAMENTO', 1);
INSERT INTO CELA (numero_cela, letra_pavilhao, tipo, capacidade) VALUES (601, 'E', 'COMUM', 8);
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
------------------------------------------------------------
-- 4. FUNCIONARIO
-- Nota: Inserir chefe (sem supervisor) antes dos subordinados
------------------------------------------------------------
-- Diretor
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (11111111111, 'Carlos Eduardo Gomes', DATE '1970-05-15', 'MANHA', NULL);

-- Supervisor (Subordinado ao Diretor)
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (22222222222, 'Renata Vasconcelos', DATE '1982-10-20', 'TARDE', 11111111111);

-- Agentes e Médico (Subordinados ao Supervisor)
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (33333333333, 'Felipe Andrade', DATE '1990-02-10', 'NOITE', 22222222222);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (44444444444, 'Juliana Paes', DATE '1988-11-25', 'MANHA', 22222222222);

INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (55555555555, 'Dr. Roberto Almeida', DATE '1975-08-30', 'TARDE', 11111111111);

-- Responde ao Diretor Geral 
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (10101010101, 'Dra. Camila Rocha', DATE '1985-03-22', 'MANHA', 11111111111);

-- Responde ao Supervisor Plata 
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (20202020202, 'Thiago Moura', DATE '1993-08-14', 'TARDE', 22222222222);

-- Responde ao Medico Clinico 
INSERT INTO FUNCIONARIO (cpf_funcionario, nome, data_nascimento, turno, cpf_supervisor) 
VALUES (30303030303, 'Mariana Costa', DATE '1989-12-01', 'NOITE', 55555555555);
------------------------------------------------------------
-- 5. FUNCIONARIO_CARGO
------------------------------------------------------------
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (11111111111, 'DIRETOR_GERAL');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (22222222222, 'SUPERVISOR_PLATA');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (33333333333, 'AGENTE_PENITENCIARIO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (44444444444, 'AGENTE_PENITENCIARIO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (55555555555, 'MEDICO_CLINICO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (10101010101, 'PSICOLOGO');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (20202020202, 'ASSISTENTE_SOCIAL');
INSERT INTO FUNCIONARIO_CARGO (cpf_funcionario, cargo) VALUES (30303030303, 'ENFERMEIRO');
------------------------------------------------------------
-- 6. CRIME
------------------------------------------------------------
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART121', 'Homicidio Simples', 6, 20);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART155', 'Furto', 1, 4);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART157', 'Roubo Subtração com Ameaça', 4, 10);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART33', 'Trafico de Drogas', 5, 15);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART171', 'Estelionato', 1, 5);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART288', 'Associacao Criminosa', 1, 3);
INSERT INTO CRIME (artigo_lei, descricao_crime, pena_minima, pena_maxima) VALUES ('ART213', 'Estupro', 6, 10);
------------------------------------------------------------
-- 7. PRISIONEIRO
------------------------------------------------------------
INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (66666666666, 'Marcos da Silva', DATE '1995-04-12', 'M', DATE '2023-01-15', 'ALTA', 101, 'A');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (77777777777, 'Joao Batista', DATE '1980-12-05', 'M', DATE '2019-06-20', 'MEDIA', 201, 'B');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (88888888888, 'Pedro Alcantara', DATE '2000-01-22', 'M', DATE '2024-03-10', 'BAIXA', 301, 'C');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (99999999999, 'Maria das Dores', DATE '1992-07-18', 'F', DATE '2021-09-05', 'MEDIA', 401, 'F');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (12131415161, 'Roberto Carlos Alves', DATE '1978-02-11', 'M', DATE '2022-03-15', 'MEDIA', 501, 'D');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (17181920212, 'Fernando Souza', DATE '1990-09-25', 'M', DATE '2024-01-10', 'ALTA', 502, 'D');

INSERT INTO PRISIONEIRO (cpf_prisioneiro, nome, data_nascimento, sexo, inicio_prisao, periculosidade, numero_cela, letra_pavilhao) 
VALUES (22232425262, 'Luciana Mendes', DATE '1985-11-08', 'F', DATE '2020-05-20', 'BAIXA', 601, 'E');
------------------------------------------------------------
-- 8. REGIMES (SEMIABERTO E FECHADO)
------------------------------------------------------------
-- Fechado
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (66666666666, DATE '2030-01-15');
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (99999999999, DATE '2027-09-05');
INSERT INTO REGIME_FECHADO (cpf_prisioneiro, data_progressao) VALUES (17181920212, DATE '2032-01-10');

-- Semiaberto
INSERT INTO REGIME_SEMIABERTO (cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno) 
VALUES (77777777777, DATE '2024-06-20', NULL, '18:00');

INSERT INTO REGIME_SEMIABERTO (cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno) 
VALUES (88888888888, DATE '2024-03-10', DATE '2025-03-10', '20:00');

INSERT INTO REGIME_SEMIABERTO (cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno) 
VALUES (12131415161, DATE '2025-03-15', NULL, '19:00');

INSERT INTO REGIME_SEMIABERTO (cpf_prisioneiro, data_inicio_aberto, data_saida, horario_retorno) 
VALUES (22232425262, DATE '2023-05-20', DATE '2026-05-20', '18:30');

------------------------------------------------------------
-- 9. PROCESSO_PENAL
------------------------------------------------------------
INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10001, 66666666666, 'ART121', DATE '2022-11-10', 'Culpado em tribunal do juri', 18);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10002, 77777777777, 'ART157', DATE '2019-05-15', 'Condenado por roubo a mao armada', 8);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10003, 88888888888, 'ART155', DATE '2024-02-01', 'Furto qualificado, reu primario', 2);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10004, 99999999999, 'ART33', DATE '2021-08-20', 'Condenada por associacao ao trafico', 10);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10005, 12131415161, 'ART171', DATE '2021-12-01', 'Condenado por fraudes bancarias', 4);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10006, 17181920212, 'ART213', DATE '2023-11-15', 'Condenacao em regime fechado', 9);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10006, 17181920212, 'ART288', DATE '2023-11-15', 'Agravante por associacao criminosa', 2);

INSERT INTO PROCESSO_PENAL (numero_processo, cpf_prisioneiro, artigo_lei, data_registro, sentenca, tempo_sentenciado) 
VALUES (10007, 22232425262, 'ART288', DATE '2019-10-10', 'Participacao em quadrilha', 3);
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
VALUES (12121212121, 66666666666, 33333333333, DATE '2024-05-12', '14:00', '16:00');

-- Jose visitando João, acompanhada pela agente Juliana
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (34343434343, 77777777777, 44444444444, DATE '2024-05-15', '09:00', '11:30');

-- Marta visitando Pedro, acompanhada pela agente Juliana
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (56565656565, 88888888888, 44444444444, DATE '2024-05-20', '10:00', '12:00');

-- Visita em cela acompanhada pelo agente Felipe 
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (87654321022, 17181920212, 33333333333, DATE '2024-06-05', '09:00', '10:00');

-- Visita ao pavilhão E acompanhada pela psicóloga
INSERT INTO VISITA (cpf_visitante, cpf_prisioneiro, cpf_funcionario, dia_visita, hora_visita, horario_retorno) 
VALUES (76543210933, 22232425262, 10101010101, DATE '2024-06-10', '14:30', '16:30');
COMMIT;
