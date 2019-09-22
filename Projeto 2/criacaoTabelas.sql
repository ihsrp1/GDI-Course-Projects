CREATE TABLE tb_objeto of tp_objeto (
	PRIMARY KEY (cod_objeto)	
);

CREATE TABLE tb_bonificacao of tp_bonificacao(
	PRIMARY KEY (cod_bonificacao)
);

CREATE TABLE tb_cliente of tp_cliente(
	PRIMARY KEY (cod_cliente)
)NESTED TABLE telefone STORE AS tb_telefone_cli;

CREATE TABLE tb_funcionario of tp_funcionario(
	PRIMARY KEY (CPF),
	FOREIGN KEY (CPF_chefe) references tb_funcionario
);

CREATE TABLE tb_dependente of tp_dependente(
	FOREIGN KEY (CPF) references tb_funcionario
);

CREATE TABLE tb_departamento of tp_departamento(
	PRIMARY KEY (cod_dpto)
);

CREATE TABLE tb_PF of tp_PF(
	PRIMARY KEY (cod_cliente)
)NESTED TABLE telefone STORE AS tb_telefone_cli_PF;

CREATE TABLE tb_PJ of tp_PJ(	
	PRIMARY KEY (cod_cliente)
)NESTED TABLE telefone STORE AS tb_telefone_cli_PJ;

CREATE TABLE tb_trabalha of tp_trabalha(
	FOREIGN KEY (CPF) references tb_funcionario,
	FOREIGN KEY (codigo) references tb_departamento,
	FOREIGN KEY (cod_bonificacao) references tb_bonificacao
);

CREATE TABLE tb_entrega of tp_entrega(
	FOREIGN KEY (CPF) references tb_funcionario,
	FOREIGN KEY (cod_objeto) references tb_objeto,
	FOREIGN KEY (cod_cliente) references tb_cliente
);