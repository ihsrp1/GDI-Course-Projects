CREATE OR REPLACE TYPE tp_telefone as TABLE OF NUMBER;

CREATE OR REPLACE TYPE tp_objeto as OBJECT(
	cod_objeto NUMBER,
	peso NUMBER,
	dimensao NUMBER
)NOT FINAL;

CREATE OR REPLACE TYPE tp_bonificacao as OBJECT(
	cod_bonificacao NUMBER,
	valor NUMBER,
	data_bonificacao DATE
)NOT FINAL;

CREATE OR REPLACE TYPE tp_cliente as OBJECT(
	cod_cliente NUMBER,
	nome varchar2(100),
	CEP NUMBER,
	descricao varchar2(50),
	telefone tp_telefone
)NOT FINAL;

CREATE OR REPLACE TYPE tp_funcionario as OBJECT(
	CPF NUMBER,
	CPF_chefe REF tp_funcionario,
	nome varchar2(100),
	idade NUMBER,
	sexo char
)NOT FINAL;

CREATE OR REPLACE TYPE tp_dependente as OBJECT(
	CPF REF tp_funcionario,
	nome varchar2(100),
	idade NUMBER,
	parentesco varchar2(50)
)NOT FINAL;

CREATE OR REPLACE TYPE tp_departamento as OBJECT(
	cod_dpto NUMBER,
	descricao varchar2(100),
	n_de_func NUMBER
)NOT FINAL;

CREATE OR REPLACE TYPE tp_PF under tp_cliente(
	CPF NUMBER
)NOT FINAL;

CREATE OR REPLACE TYPE tp_PJ under tp_cliente(
	CNPJ NUMBER
)NOT FINAL;

CREATE OR REPLACE TYPE tp_trabalha as OBJECT(
	CPF REF tp_funcionario,
	codigo REF tp_departamento,
	cod_bonificacao REF tp_bonificacao
)FINAL;

CREATE OR REPLACE TYPE tp_entrega as OBJECT(
	cod_objeto REF tp_objeto,
	dt_entrega DATE,
	cod_cliente REF tp_cliente,
	CPF REF tp_funcionario,
	destinatario varchar2(50)
)FINAL;