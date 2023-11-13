--Caio Ribeiro -- RM99759 -- 1TDSPY
--Eduardo Jablinski -- RM550975 -- 1TDSPY
--Gabriel Cunha -- RM98074 -- 1TDSPX
--Guilherme Riofrio -- RM550137 -- 1TDSPY
--Natalia Scigliano -- RM98430 -- 1TDSPX

--Aqui todas as tabelas estão sendo deletadas para não dar conflito com outros trabalhos;
--Todas as tabelas e tudo relacionado à elas estão sendo deletados primeiramente.
DROP TABLE tb_acs_apolice CASCADE CONSTRAINTS;

DROP TABLE tb_acs_modal CASCADE CONSTRAINTS;

DROP TABLE tb_acs_modelo CASCADE CONSTRAINTS;

DROP TABLE tb_acs_modeloap CASCADE CONSTRAINTS;

DROP TABLE tb_acs_modprestador CASCADE CONSTRAINTS;

DROP TABLE tb_acs_ordemservico CASCADE CONSTRAINTS;

DROP TABLE tb_acs_prestador CASCADE CONSTRAINTS;

DROP TABLE tb_acs_user CASCADE CONSTRAINTS;

DROP TABLE tb_acs_veiculo CASCADE CONSTRAINTS;

DROP TABLE tb_acs_veiculo_apolice CASCADE CONSTRAINTS;


CREATE TABLE tb_acs_apolice (
    id_apolice                  INTEGER NOT NULL,
    numero_apolice              VARCHAR2(40),
    tb_acs_user_id_user         INTEGER NOT NULL,
    tb_acs_modeloap_id_modeloap INTEGER NOT NULL
);

ALTER TABLE tb_acs_apolice ADD CONSTRAINT tb_acs_apolice_pk PRIMARY KEY ( id_apolice );

CREATE TABLE tb_acs_modal (
    id_modal                   INTEGER NOT NULL,
    tipo_modal                 VARCHAR2(80),
    capacidade_modal           VARCHAR2(30),
    capacidade_intermodalidade VARCHAR2(80)
);

ALTER TABLE tb_acs_modal ADD CONSTRAINT tb_acs_modal_pk PRIMARY KEY ( id_modal );

CREATE TABLE tb_acs_modelo (
    id_modelo                 INTEGER NOT NULL,
    altura_modelo             FLOAT,
    largura_modelo            FLOAT,
    comprimento_modelo        FLOAT,
    categoria_modelo          VARCHAR2(50),
    montadora_modelo          VARCHAR2(30),
    tb_acs_veiculo_id_veiculo INTEGER NOT NULL
);

ALTER TABLE tb_acs_modelo ADD CONSTRAINT tb_acs_veiculo_pkv2 PRIMARY KEY ( id_modelo );

CREATE TABLE tb_acs_modeloap (
    id_modeloap       INTEGER NOT NULL,
    tipo_cobertura    VARCHAR2(80),
    periodo_vigencia  DATE,
    exclusoes_apolice VARCHAR2(100)
);

ALTER TABLE tb_acs_modeloap ADD CONSTRAINT tb_acs_modeloapolice_pk PRIMARY KEY ( id_modeloap );

CREATE TABLE tb_acs_modprestador (
    id_modprestador               INTEGER NOT NULL,
    placa_modalprestador          VARCHAR2(7),
    tb_acs_prestador_id_prestador INTEGER NOT NULL,
    tb_acs_modal_id_modal         INTEGER NOT NULL
);

ALTER TABLE tb_acs_modprestador ADD CONSTRAINT tb_acs_modalprestador_pk PRIMARY KEY ( id_modprestador );

CREATE TABLE tb_acs_ordemservico (
    id_ordemservico                     INTEGER NOT NULL,
    descricao_ordemservico              VARCHAR2(200),
    dataabertura_ordemservico           TIMESTAMP,
    datafechamendo_ordemservico         TIMESTAMP,
    status_ordemservico                 VARCHAR2(50),
    localizacao_ordemservico            VARCHAR2(100),
    tb_acs_user_id_user                 INTEGER NOT NULL, 
    tb_acs_veiculo_apolice_id_veiculoap INTEGER NOT NULL,  
    tb_acs_modprestador_id_modprestador INTEGER NOT NULL
);

ALTER TABLE tb_acs_ordemservico ADD CONSTRAINT tb_acs_ordemservico_pk PRIMARY KEY ( id_ordemservico );

CREATE TABLE tb_acs_prestador (
    id_prestador                 INTEGER NOT NULL,
    nome_prestador               VARCHAR2(50),
    telefone_prestador           VARCHAR2(15),
    ultima_localizacao_prestador VARCHAR2(30)
);

ALTER TABLE tb_acs_prestador ADD CONSTRAINT tb_acs_prestador_pk PRIMARY KEY ( id_prestador );

CREATE TABLE tb_acs_user (
    id_user       INTEGER NOT NULL,
    nome_user     VARCHAR2(80),
    cpf_user      VARCHAR2(11),
    endereco_user VARCHAR2(80),
    email_user    VARCHAR2(50),
    telefone_user VARCHAR2(15)
);

ALTER TABLE tb_acs_user ADD CONSTRAINT tb_acs_user_pk PRIMARY KEY ( id_user );

CREATE TABLE tb_acs_veiculo (
    id_veiculo       INTEGER NOT NULL,
    ano_veiculo      INTEGER,
    peso_veiculo     FLOAT,
    tipo_combustivel VARCHAR2(40),
    cor_veiculo      VARCHAR2(30)
);

ALTER TABLE tb_acs_veiculo ADD CONSTRAINT tb_acs_veiculo_pk PRIMARY KEY ( id_veiculo );

CREATE TABLE tb_acs_veiculo_apolice (
    id_veiculoap              INTEGER NOT NULL,
    placa_veiculo             VARCHAR2(7),
    condicao_veiculo          VARCHAR2(100),
    tb_acs_veiculo_id_veiculo INTEGER NOT NULL,
    tb_acs_apolice_id_apolice INTEGER NOT NULL
);

ALTER TABLE tb_acs_veiculo_apolice ADD CONSTRAINT tb_acs_veiculo_apolice_pk PRIMARY KEY ( id_veiculoap );

ALTER TABLE tb_acs_apolice
    ADD CONSTRAINT tb_acs_apolice_tb_acs_modeloap_fk FOREIGN KEY ( tb_acs_modeloap_id_modeloap )
        REFERENCES tb_acs_modeloap ( id_modeloap );

ALTER TABLE tb_acs_apolice
    ADD CONSTRAINT tb_acs_apolice_tb_acs_user_fk FOREIGN KEY ( tb_acs_user_id_user )
        REFERENCES tb_acs_user ( id_user );

ALTER TABLE tb_acs_modprestador
    ADD CONSTRAINT tb_acs_modalprestador_tb_acs_modal_fk FOREIGN KEY ( tb_acs_modal_id_modal )
        REFERENCES tb_acs_modal ( id_modal );

ALTER TABLE tb_acs_modprestador
    ADD CONSTRAINT tb_acs_modalprestador_tb_acs_prestador_fk FOREIGN KEY ( tb_acs_prestador_id_prestador )
        REFERENCES tb_acs_prestador ( id_prestador );
 
ALTER TABLE tb_acs_modelo
    ADD CONSTRAINT tb_acs_modelo_tb_acs_veiculo_fk FOREIGN KEY ( tb_acs_veiculo_id_veiculo )
        REFERENCES tb_acs_veiculo ( id_veiculo );

ALTER TABLE tb_acs_ordemservico
    ADD CONSTRAINT tb_acs_ordemservico_tb_acs_modprestador_fk FOREIGN KEY ( tb_acs_modprestador_id_modprestador )
        REFERENCES tb_acs_modprestador ( id_modprestador );

ALTER TABLE tb_acs_ordemservico
    ADD CONSTRAINT tb_acs_ordemservico_tb_acs_user_fk FOREIGN KEY ( tb_acs_user_id_user )
        REFERENCES tb_acs_user ( id_user );

ALTER TABLE tb_acs_ordemservico
    ADD CONSTRAINT tb_acs_ordemservico_tb_acs_veiculo_apolice_fk FOREIGN KEY ( tb_acs_veiculo_apolice_id_veiculoap )
        REFERENCES tb_acs_veiculo_apolice ( id_veiculoap );

ALTER TABLE tb_acs_veiculo_apolice
    ADD CONSTRAINT tb_acs_veiculo_apolice_tb_acs_apolice_fk FOREIGN KEY ( tb_acs_apolice_id_apolice )
        REFERENCES tb_acs_apolice ( id_apolice );
 
ALTER TABLE tb_acs_veiculo_apolice
    ADD CONSTRAINT tb_acs_veiculo_apolice_tb_acs_veiculo_fk FOREIGN KEY ( tb_acs_veiculo_id_veiculo )
        REFERENCES tb_acs_veiculo ( id_veiculo );


INSERT INTO TB_ACS_MODAL (ID_MODAL, TIPO_MODAL, CAPACIDADE_MODAL, CAPACIDADE_INTERMODALIDADE)
    VALUES(1, 'Guincho Plataforma', '+ 20 toneladas', 'V');
INSERT INTO TB_ACS_MODAL (ID_MODAL, TIPO_MODAL, CAPACIDADE_MODAL, CAPACIDADE_INTERMODALIDADE)
    VALUES(2, 'Guincho Munck', '10 toneladas', 'F');
INSERT INTO TB_ACS_MODAL (ID_MODAL, TIPO_MODAL, CAPACIDADE_MODAL, CAPACIDADE_INTERMODALIDADE)
    VALUES(3, 'Guincho Rotador', '+ 10 toneladas', 'F');
INSERT INTO TB_ACS_MODAL (ID_MODAL, TIPO_MODAL, CAPACIDADE_MODAL, CAPACIDADE_INTERMODALIDADE)
    VALUES(4, 'Guincho Reboque Caminhões Pesados', '+ 10 toneladas', 'V');
INSERT INTO TB_ACS_MODAL (ID_MODAL, TIPO_MODAL, CAPACIDADE_MODAL, CAPACIDADE_INTERMODALIDADE)
    VALUES(5, 'Guincho de Cabo', '+ 10 toneladas', 'V');

INSERT INTO TB_ACS_PRESTADOR (ID_PRESTADOR, NOME_PRESTADOR, TELEFONE_PRESTADOR, ULTIMA_LOCALIZACAO_PRESTADOR) 
    VALUES (1, 'João da Silva', '(12)985852211', 'Rodovia Imigrantes, KM25');
INSERT INTO TB_ACS_PRESTADOR (ID_PRESTADOR, NOME_PRESTADOR, TELEFONE_PRESTADOR, ULTIMA_LOCALIZACAO_PRESTADOR) 
    VALUES (2, 'Renata Pires', '(11)977441133', 'Rodovia Presidente Dutra');
INSERT INTO TB_ACS_PRESTADOR (ID_PRESTADOR, NOME_PRESTADOR, TELEFONE_PRESTADOR, ULTIMA_LOCALIZACAO_PRESTADOR) 
    VALUES (3, 'Lucas Oliveira', '(31)985852211', 'Rodovia Fernão Dias');
INSERT INTO TB_ACS_PRESTADOR (ID_PRESTADOR, NOME_PRESTADOR, TELEFONE_PRESTADOR, ULTIMA_LOCALIZACAO_PRESTADOR) 
    VALUES (4, 'Pedro Santos', '(21)985852211', 'Rodovia Rio-Santos');
INSERT INTO TB_ACS_PRESTADOR (ID_PRESTADOR, NOME_PRESTADOR, TELEFONE_PRESTADOR, ULTIMA_LOCALIZACAO_PRESTADOR) 
    VALUES (5, 'Matheus Pereira', '(11)985852211', 'Rodovia Castelo Branco');
INSERT INTO TB_ACS_PRESTADOR (ID_PRESTADOR, NOME_PRESTADOR, TELEFONE_PRESTADOR, ULTIMA_LOCALIZACAO_PRESTADOR) 
    VALUES (6, 'André Souza', '(31)985852211', 'Rodovia BR-040');
INSERT INTO TB_ACS_PRESTADOR (ID_PRESTADOR, NOME_PRESTADOR, TELEFONE_PRESTADOR, ULTIMA_LOCALIZACAO_PRESTADOR) 
    VALUES (7, 'Rafael Costa', '(91)985852211', 'Rodovia Transamazônica');
    
INSERT INTO TB_ACS_USER (ID_USER, NOME_USER, TELEFONE_USER, CPF_USER, EMAIL_USER, ENDERECO_USER) VALUES (1, 'Ana Júlia', '(11)987452222', '11122233366', 'anajulia@gmail.com',
'Avenida Paulista, Bela Vista, São Paulo - SP');
INSERT INTO TB_ACS_USER (ID_USER, NOME_USER, TELEFONE_USER, CPF_USER, EMAIL_USER, ENDERECO_USER) VALUES (2, 'Antônio Ricardo Lopes', '(12)985441133', '99988877741', 'toninho@gmail.com',
'Rua XV de Novembro, Centro, Taubaté - SP');
INSERT INTO TB_ACS_USER (ID_USER, NOME_USER, TELEFONE_USER, CPF_USER, EMAIL_USER, ENDERECO_USER) VALUES (3, 'Cleiton Jesus Silva', '(82)999998787', '3322255599', 'cleitin@gmail.com',
'Rua Sá e Albuquerque, Farol, Maceió - AL');
INSERT INTO TB_ACS_USER (ID_USER, NOME_USER, TELEFONE_USER, CPF_USER, EMAIL_USER, ENDERECO_USER) VALUES (4, 'Ronaldo Peres Ferreira', '(27)988556622', '77744411122', 'dinhoperes@gmail.com',
'Rua João da Cruz, Praia do Canto, Vitória - ES');
INSERT INTO TB_ACS_USER (ID_USER, NOME_USER, TELEFONE_USER, CPF_USER, EMAIL_USER, ENDERECO_USER) VALUES (5, 'Roberta Souza Silva', '(31)966554411', '44400077755', 'roberta@gmail.com',
'Rua da Bahia, Centro, Belo Horizonte - MG');
INSERT INTO TB_ACS_USER (ID_USER, NOME_USER, TELEFONE_USER, CPF_USER, EMAIL_USER, ENDERECO_USER) VALUES (6, 'Eduardo Pinto Costa', '(41)921447788', '66633300099', 'educosta@gmail.com',
'Rua XV de Novembro, Centro, Curitiba - PR');
INSERT INTO TB_ACS_USER (ID_USER, NOME_USER, TELEFONE_USER, CPF_USER, EMAIL_USER, ENDERECO_USER) VALUES (7, 'Aparecido Gonçalves', '(11)969998974', '44455588899', 'cido@gmail.com',
'Rua Augusta, Consolação, São Paulo - SP');

INSERT INTO TB_ACS_VEICULO (ID_VEICULO, ANO_VEICULO, PESO_VEICULO, TIPO_COMBUSTIVEL, COR_VEICULO) VALUES (20, 2009, 29021.31, 'Diesel-S10', 'Amarelo');
INSERT INTO TB_ACS_VEICULO (ID_VEICULO, ANO_VEICULO, PESO_VEICULO, TIPO_COMBUSTIVEL, COR_VEICULO) VALUES (21, 2000, 40020.05, 'Diesel Comum', 'Branco');
INSERT INTO TB_ACS_VEICULO (ID_VEICULO, ANO_VEICULO, PESO_VEICULO, TIPO_COMBUSTIVEL, COR_VEICULO) VALUES (22, 2023, 54010.50, 'Diesel Comum', 'Vermelho');
INSERT INTO TB_ACS_VEICULO (ID_VEICULO, ANO_VEICULO, PESO_VEICULO, TIPO_COMBUSTIVEL, COR_VEICULO) VALUES (23, 2021, 10089.98, 'Etanol', 'Azul');
INSERT INTO TB_ACS_VEICULO (ID_VEICULO, ANO_VEICULO, PESO_VEICULO, TIPO_COMBUSTIVEL, COR_VEICULO) VALUES (24, 2010, 30012.20, 'Biodiesel', 'Branco');
INSERT INTO TB_ACS_VEICULO (ID_VEICULO, ANO_VEICULO, PESO_VEICULO, TIPO_COMBUSTIVEL, COR_VEICULO) VALUES (25, 2008, 58200.06, 'Etanol', 'Preto');
INSERT INTO TB_ACS_VEICULO (ID_VEICULO, ANO_VEICULO, PESO_VEICULO, TIPO_COMBUSTIVEL, COR_VEICULO) VALUES (26, 2009, 25300.30, 'Diesel-S10', 'Azul');

INSERT INTO TB_ACS_MODELOAP (ID_MODELOAP, TIPO_COBERTURA, PERIODO_VIGENCIA, EXCLUSOES_APOLICE) 
    VALUES(1, 'Cobertura de danos', '25-10-2020', 'Exclusão de atos criminosos');
INSERT INTO TB_ACS_MODELOAP (ID_MODELOAP, TIPO_COBERTURA, PERIODO_VIGENCIA, EXCLUSOES_APOLICE) 
    VALUES(2, 'Cobertura de responsabilidade civil', '08-01-2007', 'Exclusão de desgaste e deterioração normal');
INSERT INTO TB_ACS_MODELOAP (ID_MODELOAP, TIPO_COBERTURA, PERIODO_VIGENCIA, EXCLUSOES_APOLICE) 
    VALUES(3, 'Cobertura de vida', '15-05-2021', 'Exclusão de condições preexistentes');
INSERT INTO TB_ACS_MODELOAP (ID_MODELOAP, TIPO_COBERTURA, PERIODO_VIGENCIA, EXCLUSOES_APOLICE) 
    VALUES(4, 'Cobertura de saúde', '21-06-1995', 'Exclusão de atividades de alto risco');
INSERT INTO TB_ACS_MODELOAP (ID_MODELOAP, TIPO_COBERTURA, PERIODO_VIGENCIA, EXCLUSOES_APOLICE) 
    VALUES(5, 'Cobertura de propriedade ', '05-11-2006', 'Exclusão de inundação');
INSERT INTO TB_ACS_MODELOAP (ID_MODELOAP, TIPO_COBERTURA, PERIODO_VIGENCIA, EXCLUSOES_APOLICE) 
    VALUES(6, 'Cobertura de responsabilidade profissional', '22-03-2001', 'Exclusão de uso comercial');
INSERT INTO TB_ACS_MODELOAP (ID_MODELOAP, TIPO_COBERTURA, PERIODO_VIGENCIA, EXCLUSOES_APOLICE) 
    VALUES(7, 'Cobertura de invalidez', '06-11-2015', 'Exclusão de atos de guerra');
    
INSERT INTO TB_ACS_MODPRESTADOR (ID_MODPRESTADOR, tb_acs_prestador_id_prestador, tb_acs_modal_id_modal, PLACA_MODALPRESTADOR) VALUES (2, 7, 1, 'RST456');
INSERT INTO TB_ACS_MODPRESTADOR (ID_MODPRESTADOR, tb_acs_prestador_id_prestador, tb_acs_modal_id_modal, PLACA_MODALPRESTADOR) VALUES (1, 6, 2, 'MNO789');
INSERT INTO TB_ACS_MODPRESTADOR (ID_MODPRESTADOR, tb_acs_prestador_id_prestador, tb_acs_modal_id_modal, PLACA_MODALPRESTADOR) VALUES (4, 5, 3, 'GHI123');
INSERT INTO TB_ACS_MODPRESTADOR (ID_MODPRESTADOR, tb_acs_prestador_id_prestador, tb_acs_modal_id_modal, PLACA_MODALPRESTADOR) VALUES (7, 4, 4, 'UVX555');
INSERT INTO TB_ACS_MODPRESTADOR (ID_MODPRESTADOR, tb_acs_prestador_id_prestador, tb_acs_modal_id_modal, PLACA_MODALPRESTADOR) VALUES (6, 3, 5, 'YZA987');
INSERT INTO TB_ACS_MODPRESTADOR (ID_MODPRESTADOR, tb_acs_prestador_id_prestador, tb_acs_modal_id_modal, PLACA_MODALPRESTADOR) VALUES (5, 2, 1, 'QWE321');
INSERT INTO TB_ACS_MODPRESTADOR (ID_MODPRESTADOR, tb_acs_prestador_id_prestador, tb_acs_modal_id_modal, PLACA_MODALPRESTADOR) VALUES (3, 1, 2, 'JKL654');

INSERT INTO TB_ACS_MODELO (ID_MODELO, tb_acs_veiculo_id_veiculo, ALTURA_MODELO, LARGURA_MODELO, COMPRIMENTO_MODELO, CATEGORIA_MODELO, MONTADORA_MODELO) 
    VALUES (10, 22, 3545.59, 2600.00, 5780.00, 'Caminhão Scania R400', 'Scania AB');
INSERT INTO TB_ACS_MODELO (ID_MODELO, tb_acs_veiculo_id_veiculo, ALTURA_MODELO, LARGURA_MODELO, COMPRIMENTO_MODELO, CATEGORIA_MODELO, MONTADORA_MODELO) 
    VALUES (16, 24, 2774.00, 2486.00, 8793.00, 'Atego 3026 8x2 Plataforma', 'Mercedes Benz');
INSERT INTO TB_ACS_MODELO (ID_MODELO, tb_acs_veiculo_id_veiculo, ALTURA_MODELO, LARGURA_MODELO, COMPRIMENTO_MODELO, CATEGORIA_MODELO, MONTADORA_MODELO) 
    VALUES (11, 20, 3710.00, 2520.00, 7200.00, 'Novo Actros 2651 6x4 LS Pneumática', 'Mercedes Benz');
INSERT INTO TB_ACS_MODELO (ID_MODELO, tb_acs_veiculo_id_veiculo, ALTURA_MODELO, LARGURA_MODELO, COMPRIMENTO_MODELO, CATEGORIA_MODELO, MONTADORA_MODELO) 
    VALUES (15, 25, 3699.00, 2505.00, 8200.00, 'Caminhão Arocs 58 Ton 8x4 K', 'Mercedes Benz');
INSERT INTO TB_ACS_MODELO (ID_MODELO, tb_acs_veiculo_id_veiculo, ALTURA_MODELO, LARGURA_MODELO, COMPRIMENTO_MODELO, CATEGORIA_MODELO, MONTADORA_MODELO) 
    VALUES (12, 26, 3900.00, 2500.00, 6880.00, 'Scania R 500', 'Scania');
INSERT INTO TB_ACS_MODELO (ID_MODELO, tb_acs_veiculo_id_veiculo, ALTURA_MODELO, LARGURA_MODELO, COMPRIMENTO_MODELO, CATEGORIA_MODELO, MONTADORA_MODELO) 
    VALUES (14, 21, 3800.00, 2600.00, 5780.00, 'Caminhão Volvo FH16', 'Volvo');
INSERT INTO TB_ACS_MODELO (ID_MODELO, tb_acs_veiculo_id_veiculo, ALTURA_MODELO, LARGURA_MODELO, COMPRIMENTO_MODELO, CATEGORIA_MODELO, MONTADORA_MODELO) 
    VALUES (13, 23, 3500.00, 2500.00, 8000.00, 'Mercedes-Benz Arocs 3345K', 'Mercedes Benz');
    
INSERT INTO TB_ACS_APOLICE (ID_APOLICE, tb_acs_modeloap_id_modeloap, tb_acs_user_id_user, NUMERO_APOLICE) VALUES (1, 5, 3, 'SSSSSAAAAFFFFRRRRNNNNNNNEEEEEE');
INSERT INTO TB_ACS_APOLICE (ID_APOLICE, tb_acs_modeloap_id_modeloap, tb_acs_user_id_user, NUMERO_APOLICE) VALUES (2, 4, 1, 'AASAAANFNSFFRNFENRRNNSSEENAAAA');
INSERT INTO TB_ACS_APOLICE (ID_APOLICE, tb_acs_modeloap_id_modeloap, tb_acs_user_id_user, NUMERO_APOLICE) VALUES (3, 3, 5, 'FFNEEERSRANNSNNNAAAAFRFSAFFSSS');
INSERT INTO TB_ACS_APOLICE (ID_APOLICE, tb_acs_modeloap_id_modeloap, tb_acs_user_id_user, NUMERO_APOLICE) VALUES (4, 2, 6, 'NNNNNEEEERFAASASRRRSFSSFAAANF');
INSERT INTO TB_ACS_APOLICE (ID_APOLICE, tb_acs_modeloap_id_modeloap, tb_acs_user_id_user, NUMERO_APOLICE) VALUES (5, 1, 7, 'SSSFFNAAERNENNNRRRFEESAAASNFFF');
INSERT INTO TB_ACS_APOLICE (ID_APOLICE, tb_acs_modeloap_id_modeloap, tb_acs_user_id_user, NUMERO_APOLICE) VALUES (6, 6, 4, 'AARRSFFNNEEEENNNASAAASRRFSFFFF');
INSERT INTO TB_ACS_APOLICE (ID_APOLICE, tb_acs_modeloap_id_modeloap, tb_acs_user_id_user, NUMERO_APOLICE) VALUES (7, 7, 2, 'FRAAAAAFSSSSNERNNRFFNAENEEFFS');

INSERT INTO TB_ACS_VEICULO_APOLICE (id_veiculoap, tb_acs_veiculo_id_veiculo, tb_acs_apolice_id_apolice, PLACA_VEICULO, CONDICAO_VEICULO) VALUES (7, 26, 1, 'ABC123', 'Manutenção regular');
INSERT INTO TB_ACS_VEICULO_APOLICE (id_veiculoap, tb_acs_veiculo_id_veiculo, tb_acs_apolice_id_apolice, PLACA_VEICULO, CONDICAO_VEICULO) VALUES (6, 25, 2, 'XYZ789', 'Limites de cobertura');
INSERT INTO TB_ACS_VEICULO_APOLICE (id_veiculoap, tb_acs_veiculo_id_veiculo, tb_acs_apolice_id_apolice, PLACA_VEICULO, CONDICAO_VEICULO) VALUES (5, 24, 3, 'FGH456', 'Prevenção de roubo');
INSERT INTO TB_ACS_VEICULO_APOLICE (id_veiculoap, tb_acs_veiculo_id_veiculo, tb_acs_apolice_id_apolice, PLACA_VEICULO, CONDICAO_VEICULO) VALUES (4, 23, 4, 'LMN001', 'Manutenção regular');
INSERT INTO TB_ACS_VEICULO_APOLICE (id_veiculoap, tb_acs_veiculo_id_veiculo, tb_acs_apolice_id_apolice, PLACA_VEICULO, CONDICAO_VEICULO) VALUES (3, 22, 5, 'QRS987', 'Exclusões específicas');
INSERT INTO TB_ACS_VEICULO_APOLICE (id_veiculoap, tb_acs_veiculo_id_veiculo, tb_acs_apolice_id_apolice, PLACA_VEICULO, CONDICAO_VEICULO) VALUES (2, 21, 6, 'PQR555', 'Limites de cobertura');
INSERT INTO TB_ACS_VEICULO_APOLICE (id_veiculoap, tb_acs_veiculo_id_veiculo, tb_acs_apolice_id_apolice, PLACA_VEICULO, CONDICAO_VEICULO) VALUES (1, 20, 7, 'UVW333', 'Manutenção regular');

INSERT INTO TB_ACS_ORDEMSERVICO (ID_ORDEMSERVICO, tb_acs_veiculo_apolice_id_veiculoap, tb_acs_modprestador_id_modprestador, tb_acs_user_id_user, DESCRICAO_ORDEMSERVICO, 
    DATAABERTURA_ORDEMSERVICO, DATAFECHAMENTO_ORDEMSERVICO, STATUS_ORDEMSERVICO, LOCALIZACAO_ORDEMSERVICO) 
        VALUES (1, 7, 1, 7, 'Reparo de colisão frontal e Serviço de manutenção preventiva', '20-03-2022', '20-04-2022', 
            'Concluída', 'Anápolis - GO');
INSERT INTO TB_ACS_ORDEMSERVICO (ID_ORDEMSERVICO, tb_acs_veiculo_apolice_id_veiculoap, tb_acs_modprestador_id_modprestador, tb_acs_user_id_user, DESCRICAO_ORDEMSERVICO, 
    DATAABERTURA_ORDEMSERVICO, DATAFECHAMENTO_ORDEMSERVICO, STATUS_ORDEMSERVICO, LOCALIZACAO_ORDEMSERVICO) 
        VALUES (2, 6, 5, 6, 'Reparo de danos causados por granizo e Serviço de manutenção preventiva', '15-05-2023', '30-10-2023', 
            'Concluída', 'São Paulo - SP');
INSERT INTO TB_ACS_ORDEMSERVICO (ID_ORDEMSERVICO, tb_acs_veiculo_apolice_id_veiculoap, tb_acs_modprestador_id_modprestador, tb_acs_user_id_user, DESCRICAO_ORDEMSERVICO, 
    DATAABERTURA_ORDEMSERVICO, DATAFECHAMENTO_ORDEMSERVICO, STATUS_ORDEMSERVICO, LOCALIZACAO_ORDEMSERVICO) 
        VALUES (3, 5, 7, 5, 'Reparo de colisão frontal e Reparo de pneu furado', '20-12-2022', '20-03-2023', 
            'Concluída', 'Rio de Janeiro - RJ');
INSERT INTO TB_ACS_ORDEMSERVICO (ID_ORDEMSERVICO, tb_acs_veiculo_apolice_id_veiculoap, tb_acs_modprestador_id_modprestador, tb_acs_user_id_user, DESCRICAO_ORDEMSERVICO, 
    DATAABERTURA_ORDEMSERVICO, DATAFECHAMENTO_ORDEMSERVICO, STATUS_ORDEMSERVICO, LOCALIZACAO_ORDEMSERVICO) 
        VALUES (4, 3, 6, 4, 'Reparo de sistemas de transmissão, Reparo de pneu furado e Reparo de colisão frontal', '05-02-2023', '12-07-2023', 
            'Concluída', 'Curitiba - PR');
INSERT INTO TB_ACS_ORDEMSERVICO (ID_ORDEMSERVICO, tb_acs_veiculo_apolice_id_veiculoap, tb_acs_modprestador_id_modprestador, tb_acs_user_id_user, DESCRICAO_ORDEMSERVICO, 
    DATAABERTURA_ORDEMSERVICO, DATAFECHAMENTO_ORDEMSERVICO, STATUS_ORDEMSERVICO, LOCALIZACAO_ORDEMSERVICO) 
        VALUES (5, 4, 2, 3, 'Reparo de colisão frontal, Reparo de pneu furado e Serviço de manutenção preventiva', '20-06-2023', '28-09-2023', 
            'Concluída', 'Recife - PE');
INSERT INTO TB_ACS_ORDEMSERVICO (ID_ORDEMSERVICO, tb_acs_veiculo_apolice_id_veiculoap, tb_acs_modprestador_id_modprestador, tb_acs_user_id_user, DESCRICAO_ORDEMSERVICO, 
    DATAABERTURA_ORDEMSERVICO, DATAFECHAMENTO_ORDEMSERVICO, STATUS_ORDEMSERVICO, LOCALIZACAO_ORDEMSERVICO) 
        VALUES (6, 2, 3, 2, 'Reparo de colisão frontal e Reparo de painel lateral amassado', '08-07-2022', '10-09-2022', 
            'Concluída', 'Salvador - BA');
INSERT INTO TB_ACS_ORDEMSERVICO (ID_ORDEMSERVICO, tb_acs_veiculo_apolice_id_veiculoap, tb_acs_modprestador_id_modprestador, tb_acs_user_id_user, DESCRICAO_ORDEMSERVICO, 
    DATAABERTURA_ORDEMSERVICO, DATAFECHAMENTO_ORDEMSERVICO, STATUS_ORDEMSERVICO, LOCALIZACAO_ORDEMSERVICO) 
        VALUES (7, 1, 4, 1, 'Reparo de colisão frontal', '20-03-2023', '20-04-2023', 
            'Concluída', 'Porto Alegre - RS');

--Deletando a primeira fk:
DELETE FROM TB_ACS_VEICULO_APOLICE
WHERE id_veiculoap = 1;

--Deletando depois outra FK:
DELETE FROM TB_ACS_ORDEMSERVICO
WHERE ID_APOLICE = 1;

--Deletando outra FK:
DELETE FROM TB_ACS_APOLICE
WHERE ID_APOLICE = 1;

--Finalmente deletando o objetivo principal: um tipo de apolice que não está mais incluída na Porto:
DELETE FROM TB_ACS_MODELOAP
WHERE ID_ID_MODELOAP = 5;

--Update para atualizar dados da tabela;
UPDATE TB_ACS_USER
SET TELEFONE_USER = '(41)996225500'
WHERE ID_USER = 6;

--Update para atualizar dados da tabela;
UPDATE TB_ACS_MODPRESTADOR
SET PLACA_MODALPRESTADOR = 'NOO521'
WHERE tb_acs_modal_id_modal = 2;

--Update para atualizar dados da tabela;
UPDATE TB_ACS_ORDEMSERVICO
SET STATUS_ORDEMSERVICO = 'Em Análise'
WHERE ID_ORDEMSERVICO = 1;

--Função de ordenação em ordem crescente, baseada no ID dos usuários da tabela de ORDEMSERVICO;
SELECT *
FROM TB_ACS_VEICULO_APOLICE
ORDER BY tb_acs_apolice_id_apolice ASC;

--Função para calcular a média de comprimento dos veículos cadastrados no sistema;
SELECT ROUND(AVG(COMPRIMENTO_MODELO), 3) AS MEDIA_COMPRIMENTO_VEICULOS
FROM TB_ACS_MODELO;

--Função para agrupar todos os prestadores que possuem uma ordem de serviço concluída (no caso, todos os cadastrados a possuem);
SELECT tb_acs_modprestador_id_modprestador, COUNT(CASE WHEN STATUS_ORDEMSERVICO = 'Concluída' THEN 1 ELSE NULL END) AS SERVICO_CONCLUIDO
FROM TB_ACS_ORDEMSERVICO
GROUP BY tb_acs_modprestador_id_modprestador;


