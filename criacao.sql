-- 1. PAVILHAO
CREATE TABLE PAVILHAO (
    letra_pavilhao VARCHAR2(2) NOT NULL,
    nivel_seguranca VARCHAR2(5),

    CONSTRAINT pk_pavilhao PRIMARY KEY (letra_pavilhao),
    CONSTRAINT chk_nivel_seguranca
        CHECK (nivel_seguranca IN ('BAIXO', 'MEDIO', 'ALTO'))
);

-- 2. CELA
CREATE TABLE CELA (
    numero_cela NUMBER NOT NULL,
    letra_pavilhao VARCHAR2(2) NOT NULL,
    tipo VARCHAR2(20),
    capacidade NUMBER,

    CONSTRAINT pk_cela PRIMARY KEY (numero_cela, letra_pavilhao),
    CONSTRAINT fk_cela_pavilhao FOREIGN KEY (letra_pavilhao)
        REFERENCES PAVILHAO(letra_pavilhao),

    CONSTRAINT chk_tipo_cela
        CHECK (tipo IN ('COMUM', 'ISOLAMENTO', 'SEGURANCA_MAXIMA')),
    CONSTRAINT chk_capacidade_cela
        CHECK (capacidade > 0)
);

-- 3. PRISIONEIRO
CREATE TABLE PRISIONEIRO (
    cpf_prisioneiro NUMBER(11) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    data_nascimento DATE,
    sexo CHAR(1),
    inicio_prisao DATE,
    periculosidade VARCHAR2(5),
    numero_cela NUMBER,
    letra_pavilhao VARCHAR2(2),

    CONSTRAINT pk_prisioneiro PRIMARY KEY (cpf_prisioneiro),
    CONSTRAINT fk_prisioneiro_cela FOREIGN KEY (numero_cela, letra_pavilhao)
        REFERENCES CELA(numero_cela, letra_pavilhao),

    CONSTRAINT chk_sexo_prisioneiro
        CHECK (sexo IN ('M', 'F')),
    CONSTRAINT chk_periculosidade
        CHECK (periculosidade IN ('BAIXA', 'MEDIA', 'ALTA'))
);

-- 4. REGIME_SEMIABERTO
CREATE TABLE REGIME_SEMIABERTO (
    cpf_prisioneiro NUMBER(11) NOT NULL,
    data_inicio_aberto DATE,
    data_saida DATE,
    horario_retorno VARCHAR2(5),

    CONSTRAINT pk_reg_semiaberto PRIMARY KEY (cpf_prisioneiro),
    CONSTRAINT fk_reg_semiab_pris FOREIGN KEY (cpf_prisioneiro)
        REFERENCES PRISIONEIRO(cpf_prisioneiro),

    CONSTRAINT chk_datas_semiaberto
        CHECK (data_saida IS NULL OR data_inicio_aberto <= data_saida)
);

-- 5. REGIME_FECHADO
CREATE TABLE REGIME_FECHADO (   
    cpf_prisioneiro NUMBER(11) NOT NULL,
    data_progressao DATE,

    CONSTRAINT pk_reg_fechado PRIMARY KEY (cpf_prisioneiro),
    CONSTRAINT fk_reg_fechado_pris FOREIGN KEY (cpf_prisioneiro)
        REFERENCES PRISIONEIRO(cpf_prisioneiro)
);

-- 6. CRIME
CREATE TABLE CRIME (
    artigo_lei VARCHAR2(20) NOT NULL,
    descricao_crime VARCHAR2(255),
    pena_minima NUMBER,
    pena_maxima NUMBER,

    CONSTRAINT pk_crime PRIMARY KEY (artigo_lei),
    CONSTRAINT chk_penas_crime
        CHECK (pena_minima >= 0 AND pena_maxima >= pena_minima)
);

-- 7. PROCESSO_PENAL
CREATE TABLE PROCESSO_PENAL (
    numero_processo NUMBER NOT NULL,
    cpf_prisioneiro NUMBER(11) NOT NULL,
    artigo_lei VARCHAR2(20) NOT NULL,
    data_registro DATE,
    sentenca VARCHAR2(255),
    tempo_sentenciado NUMBER,

    CONSTRAINT pk_processo_penal PRIMARY KEY 
        (numero_processo, cpf_prisioneiro, artigo_lei),

    CONSTRAINT fk_proc_prisioneiro FOREIGN KEY (cpf_prisioneiro)
        REFERENCES PRISIONEIRO(cpf_prisioneiro),

    CONSTRAINT fk_proc_crime FOREIGN KEY (artigo_lei)
        REFERENCES CRIME(artigo_lei),

    CONSTRAINT chk_tempo_sentenciado
        CHECK (tempo_sentenciado >= 0)
);

-- 8. VISITANTE
CREATE TABLE VISITANTE (
    cpf_visitante NUMBER(11) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    rua VARCHAR2(150),
    cidade VARCHAR2(100),
    estado VARCHAR2(2),
    numero NUMBER,

    CONSTRAINT pk_visitante PRIMARY KEY (cpf_visitante),
    CONSTRAINT chk_estado_visitante
        CHECK (estado IN ('PE', 'PB', 'CE', 'RN', 'AL', 'BA', 'SE'))
);

-- 9. TELEFONE_VISITANTE
CREATE TABLE TELEFONE_VISITANTE (
    cpf_visitante NUMBER(11) NOT NULL,
    telefone VARCHAR2(15) NOT NULL,

    CONSTRAINT pk_telefone_visitante PRIMARY KEY (cpf_visitante, telefone),
    CONSTRAINT fk_tel_visitante FOREIGN KEY (cpf_visitante)
        REFERENCES VISITANTE(cpf_visitante)
);

-- 10. CARGO
CREATE TABLE CARGO (
    nome_cargo VARCHAR2(50) NOT NULL,
    salario NUMBER(10, 2),

    CONSTRAINT pk_cargo PRIMARY KEY (nome_cargo),
    CONSTRAINT chk_salario_cargo
        CHECK (salario > 1621)
);

-- 11. FUNCIONARIO
CREATE TABLE FUNCIONARIO (
    cpf_funcionario NUMBER(11) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    data_nascimento DATE,
    turno VARCHAR2(5),
    cpf_supervisor NUMBER(11),

    CONSTRAINT pk_funcionario PRIMARY KEY (cpf_funcionario),
    CONSTRAINT fk_func_supervisor FOREIGN KEY (cpf_supervisor)
        REFERENCES FUNCIONARIO(cpf_funcionario),

    CONSTRAINT chk_turno_funcionario
        CHECK (turno IN ('MANHA', 'TARDE', 'NOITE'))
);

-- 12. FUNCIONARIO_CARGO
CREATE TABLE FUNCIONARIO_CARGO (
    cpf_funcionario NUMBER(11) NOT NULL,
    cargo VARCHAR2(50) NOT NULL,

    CONSTRAINT pk_funcionario_cargo PRIMARY KEY (cpf_funcionario, cargo),

    CONSTRAINT fk_fc_funcionario FOREIGN KEY (cpf_funcionario)
        REFERENCES FUNCIONARIO(cpf_funcionario),

    CONSTRAINT fk_fc_cargo FOREIGN KEY (cargo)
        REFERENCES CARGO(nome_cargo)
);

CREATE SEQUENCE sequencia_idvisita
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- 13. VISITA
CREATE TABLE VISITA (
    cpf_visitante NUMBER(11) NOT NULL,
    cpf_prisioneiro NUMBER(11) NOT NULL,
    cpf_funcionario NUMBER(11) NOT NULL,
    dia_visita DATE NOT NULL,
    hora_visita VARCHAR2(5) NOT NULL,
    horario_retorno VARCHAR2(5),
    idvisita NUMBER DEFAULT sequencia_idvisita.NEXTVAL NOT NULL,

    CONSTRAINT pk_visita PRIMARY KEY 
        (cpf_visitante, cpf_prisioneiro, cpf_funcionario, idvisita),

    CONSTRAINT fk_visita_visitante FOREIGN KEY (cpf_visitante)
        REFERENCES VISITANTE(cpf_visitante),

    CONSTRAINT fk_visita_prisioneiro FOREIGN KEY (cpf_prisioneiro)
        REFERENCES PRISIONEIRO(cpf_prisioneiro),

    CONSTRAINT fk_visita_funcionario FOREIGN KEY (cpf_funcionario)
        REFERENCES FUNCIONARIO(cpf_funcionario)
);

