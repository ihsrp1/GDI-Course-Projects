
-- objeto
-- bonificacao
-- cliente
-- funcionario
-- cliente_telefone
-- dependente
-- departamento
-- PF
-- PJ
-- trabalha
-- entrega

-- Inserindo objetos (5 no total)
INSERT INTO objeto (cod_objeto, peso, dimensao) VALUES (1, 5, 10);
INSERT INTO objeto (cod_objeto, peso, dimensao) VALUES (2, 7.5, 15);
INSERT INTO objeto (cod_objeto, peso, dimensao) VALUES (3, 11, 12);
INSERT INTO objeto (cod_objeto, peso, dimensao) VALUES (4, 5.75, 10.5);
INSERT INTO objeto (cod_objeto, peso, dimensao) VALUES (5, 20, 20);

-- Inserindo bonificações (5 no total)
INSERT INTO bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (1, 2000, to_date ('21/02/1980', 'dd/mm/yyyy'));
INSERT INTO bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (2, 2500, to_date ('12/04/1982', 'dd/mm/yyyy'));
INSERT INTO bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (3, 2750, to_date ('10/11/1995', 'dd/mm/yyyy'));
INSERT INTO bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (4, 1000, to_date ('05/07/2019', 'dd/mm/yyyy'));
INSERT INTO bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (5, 500, to_date ('27/10/1987', 'dd/mm/yyyy'));

-- Inserindo cliente (5 no total)
INSERT INTO cliente (cod_cliente, nome, CEP, descricao) VALUES (1, 'Fulano da Silva', 11111111, 'Lorem ipsum dolor sit amet, consectetur');
INSERT INTO cliente (cod_cliente, nome, CEP, descricao) VALUES (2, 'Fulano Cicrano', 22222222, 'Sed do eiusmod tempor incididunt ut');
INSERT INTO cliente (cod_cliente, nome, CEP, descricao) VALUES (3, 'Maria de Tal', 33333333, 'Ut enim ad minim veniam');
INSERT INTO cliente (cod_cliente, nome, CEP, descricao) VALUES (4, 'José Henrique', 44444444, 'Quis nostrud exercitation ullamco');
INSERT INTO cliente (cod_cliente, nome, CEP, descricao) VALUES (5, 'Cláudio Fernandes', 55555555, 'Duis aute irure dolor in reprehenderit');

-- Inserindo funcionarios (5 no total)
INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (11111, 11111, 'Silva de Fulano', 25, 'M');
INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (22222, 22222, 'Cicrana Fulano', 20, 'F');
INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (33333, 33333, 'Tal de Maria', 32, 'F');
INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (44444, 11111, 'Henrique José', 67, 'M');
INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (55555, 22222, 'Fernandes Cláudio', 40, 'M');

-- Inserindo telefones (8 no total)
INSERT INTO cliente_telefone (cod_cliente, telefone) VALUES (1, 22222222);
INSERT INTO cliente_telefone (cod_cliente, telefone) VALUES (1, 33333333);
INSERT INTO cliente_telefone (cod_cliente, telefone) VALUES (2, 44444444);
INSERT INTO cliente_telefone (cod_cliente, telefone) VALUES (3, 55555555);
INSERT INTO cliente_telefone (cod_cliente, telefone) VALUES (3, 66666666);
INSERT INTO cliente_telefone (cod_cliente, telefone) VALUES (4, 77777777);
INSERT INTO cliente_telefone (cod_cliente, telefone) VALUES (4, 88888888);
INSERT INTO cliente_telefone (cod_cliente, telefone) VALUES (5, 99999999);

-- Inserindo dependentes (5 no total)
INSERT INTO dependente (CPF, nome, idade, parentesco) VALUES (11111, 'Fulano de tal', 15, 'Filho');
INSERT INTO dependente (CPF, nome, idade, parentesco) VALUES (22222, 'Cicrana de Fulano', 12, 'Sobrinha');
INSERT INTO dependente (CPF, nome, idade, parentesco) VALUES (11111, 'Maria tereza', 13, 'Irma');
INSERT INTO dependente (CPF, nome, idade, parentesco) VALUES (44444, 'Henrique Maia', 10, 'Neto');
INSERT INTO dependente (CPF, nome, idade, parentesco) VALUES (55555, 'Fernandes Ferreira', 11, 'Irmão');

-- Inserindo departamentos (3 no total)
INSERT INTO departamento (cod_dpto, descricao, n_de_func) VALUES (1, 'Velit esse cillum dolore eu fugiat nulla pariatur', 1);
INSERT INTO departamento (cod_dpto, descricao, n_de_func) VALUES (2, 'Excepteur sint occaecat cupidatat non proident', 1);
INSERT INTO departamento (cod_dpto, descricao, n_de_func) VALUES (3, 'Sunt in culpa qui officia deserunt mollit', 3);

-- Inserindo PF (2 no total)
INSERT INTO PF (cod_cliente, CPF) VALUES (1, 11111111);
INSERT INTO PF (cod_cliente, CPF) VALUES (3, 33333333);

-- Inserindo PJ (3 no total)
INSERT INTO PJ (cod_cliente, CNPJ) VALUES (2, 22222222);
INSERT INTO PJ (cod_cliente, CNPJ) VALUES (4, 44444444);
INSERT INTO PJ (cod_cliente, CNPJ) VALUES (5, 55555555);

-- Inserindo trabalha (5 no total)
INSERT INTO trabalha (CPF, codigo, cod_bonificacao) VALUES (11111, 1, 1);
INSERT INTO trabalha (CPF, codigo, cod_bonificacao) VALUES (22222, 2, 4);
INSERT INTO trabalha (CPF, codigo, cod_bonificacao) VALUES (33333, 3, 3);
INSERT INTO trabalha (CPF, codigo, cod_bonificacao) VALUES (44444, 3, 2);
INSERT INTO trabalha (CPF, codigo, cod_bonificacao) VALUES (55555, 3, 5);

-- Inserindo entrega (5 no total)
INSERT INTO entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatário) VALUES (1, to_date ('12/02/1980', 'dd/mm/yyyy'), 1, 11111, 'Fulano da Silva');
INSERT INTO entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatário) VALUES (2, to_date ('12/02/1980', 'dd/mm/yyyy'), 2, 22222, 'Fulano Cicrano');
INSERT INTO entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatário) VALUES (3, to_date ('12/02/1980', 'dd/mm/yyyy'), 3, 33333, 'Fulano da Silva');
INSERT INTO entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatário) VALUES (4, to_date ('12/02/1980', 'dd/mm/yyyy'), 4, 44444, 'Fulano da Silva');
INSERT INTO entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatário) VALUES (5, to_date ('12/02/1980', 'dd/mm/yyyy'), 5, 55555, 'Fulano da Silva');