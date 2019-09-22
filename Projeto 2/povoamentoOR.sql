-- tb_objeto
-- tb_bonificacao
-- tb_cliente
-- tb_funcionario
-- tb_cliente_telefone
-- tb_dependente
-- tb_departamento
-- tb_PF
-- tb_PJ
-- tb_trabalha
-- tb_entrega

-- Inserindo tb_objetos (5 no total)
INSERT INTO tb_objeto (cod_objeto, peso, dimensao) VALUES (1, 5, 10);
INSERT INTO tb_objeto (cod_objeto, peso, dimensao) VALUES (2, 7.5, 15);
INSERT INTO tb_objeto (cod_objeto, peso, dimensao) VALUES (3, 11, 12);
INSERT INTO tb_objeto (cod_objeto, peso, dimensao) VALUES (4, 5.75, 10.5);
INSERT INTO tb_objeto (cod_objeto, peso, dimensao) VALUES (5, 20, 20);

-- Inserindo tb_bonificações (5 no total)
INSERT INTO tb_bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (1, 2000, to_date ('21/02/1980', 'dd/mm/yyyy'));
INSERT INTO tb_bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (2, 2500, to_date ('12/04/1982', 'dd/mm/yyyy'));
INSERT INTO tb_bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (3, 2750, to_date ('10/11/1995', 'dd/mm/yyyy'));
INSERT INTO tb_bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (4, 1000, to_date ('05/07/2019', 'dd/mm/yyyy'));
INSERT INTO tb_bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (5, 500, to_date ('27/10/1987', 'dd/mm/yyyy'));

-- Inserindo tb_cliente (5 no total)
INSERT INTO tb_cliente (cod_cliente, nome, CEP, descricao, telefone) VALUES (1, 'Fulano da Silva', 11111111, 'Lorem ipsum dolor sit amet, consectetur', tp_telefone ('11111'));
INSERT INTO tb_cliente (cod_cliente, nome, CEP, descricao, telefone) VALUES (2, 'Fulano Cicrano', 22222222, 'Sed do eiusmod tempor incididunt ut', tp_telefone ('22222'));
INSERT INTO tb_cliente (cod_cliente, nome, CEP, descricao, telefone) VALUES (3, 'Maria de Tal', 33333333, 'Ut enim ad minim veniam', tp_telefone ('33333'));
INSERT INTO tb_cliente (cod_cliente, nome, CEP, descricao, telefone) VALUES (4, 'José Henrique', 44444444, 'Quis nostrud exercitation ullamco', tp_telefone ('44444'));
INSERT INTO tb_cliente (cod_cliente, nome, CEP, descricao, telefone) VALUES (5, 'Cláudio Fernandes', 55555555, 'Duis aute irure dolor in reprehenderit', tp_telefone ('55555','66666'));

-- Inserindo tb_funcionarios (5 no total)
INSERT INTO tb_funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (11111, (SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 11111), 'Silva de Fulano', 25, 'M');
INSERT INTO tb_funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (22222, (SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 22222), 'Cicrana Fulano', 20, 'F');
INSERT INTO tb_funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (33333, (SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 33333), 'Tal de Maria', 32, 'F');
INSERT INTO tb_funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (44444, (SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 11111), 'Henrique José', 67, 'M');
INSERT INTO tb_funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (55555, (SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 22222), 'Fernandes Cláudio', 40, 'M');

-- Inserindo tb_dependentes (5 no total)
INSERT INTO tb_dependente (CPF, nome, idade, parentesco) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.cpf = 11111), 'Fulano de tal', 15, 'Filho');
INSERT INTO tb_dependente (CPF, nome, idade, parentesco) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.cpf = 22222), 'Cicrana de Fulano', 12, 'Sobrinha');
INSERT INTO tb_dependente (CPF, nome, idade, parentesco) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.cpf = 11111), 'Maria tereza', 13, 'Irma');
INSERT INTO tb_dependente (CPF, nome, idade, parentesco) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.cpf = 44444), 'Henrique Maia', 10, 'Neto');
INSERT INTO tb_dependente (CPF, nome, idade, parentesco) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.cpf = 55555), 'Fernandes Ferreira', 11, 'Irmão');

-- Inserindo tb_departamentos (3 no total)
INSERT INTO tb_departamento (cod_dpto, descricao, n_de_func) VALUES (1, 'Velit esse cillum dolore eu fugiat nulla pariatur', 1);
INSERT INTO tb_departamento (cod_dpto, descricao, n_de_func) VALUES (2, 'Excepteur sint occaecat cupidatat non proident', 1);
INSERT INTO tb_departamento (cod_dpto, descricao, n_de_func) VALUES (3, 'Sunt in culpa qui officia deserunt mollit', 3);

-- Inserindo tb_PF (2 no total)
INSERT INTO tb_PF (cod_cliente, CPF) VALUES (1, 11111111);
INSERT INTO tb_PF (cod_cliente, CPF) VALUES (3, 33333333);

-- Inserindo tb_PJ (3 no total)
INSERT INTO tb_PJ (cod_cliente, CNPJ) VALUES (2, 22222222);
INSERT INTO tb_PJ (cod_cliente, CNPJ) VALUES (4, 44444444);
INSERT INTO tb_PJ (cod_cliente, CNPJ) VALUES (5, 55555555);

-- Inserindo tb_trabalha (5 no total)
INSERT INTO tb_trabalha (CPF, codigo, cod_bonificacao) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 11111), (SELECT REF(y) FROM tb_departamento y WHERE y.cod_dpto = 1), (SELECT REF(z) FROM tb_bonificacao z WHERE z.cod_bonificacao = 1));
INSERT INTO tb_trabalha (CPF, codigo, cod_bonificacao) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 22222), (SELECT REF(y) FROM tb_departamento y WHERE y.cod_dpto = 2), (SELECT REF(z) FROM tb_bonificacao z WHERE z.cod_bonificacao = 4));
INSERT INTO tb_trabalha (CPF, codigo, cod_bonificacao) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 33333), (SELECT REF(y) FROM tb_departamento y WHERE y.cod_dpto = 3), (SELECT REF(z) FROM tb_bonificacao z WHERE z.cod_bonificacao = 3));
INSERT INTO tb_trabalha (CPF, codigo, cod_bonificacao) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 44444), (SELECT REF(y) FROM tb_departamento y WHERE y.cod_dpto = 3), (SELECT REF(z) FROM tb_bonificacao z WHERE z.cod_bonificacao = 2));
INSERT INTO tb_trabalha (CPF, codigo, cod_bonificacao) VALUES ((SELECT REF(x) FROM tb_funcionario x WHERE x.CPF = 55555), (SELECT REF(y) FROM tb_departamento y WHERE y.cod_dpto = 3), (SELECT REF(z) FROM tb_bonificacao z WHERE z.cod_bonificacao = 5));


-- Inserindo tb_entrega (5 no total)
INSERT INTO tb_entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatario) VALUES ((SELECT REF(x) FROM tb_objeto x WHERE x.cod_objeto = 1), to_date ('12/02/1980', 'dd/mm/yyyy'), (SELECT REF(y) FROM tb_cliente y WHERE y.cod_cliente = 1), (SELECT REF(z) FROM tb_funcionario z WHERE z.CPF = 11111), 'Fulano da Silva');
INSERT INTO tb_entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatario) VALUES ((SELECT REF(x) FROM tb_objeto x WHERE x.cod_objeto = 2), to_date ('12/02/1980', 'dd/mm/yyyy'), (SELECT REF(y) FROM tb_cliente y WHERE y.cod_cliente = 2), (SELECT REF(z) FROM tb_funcionario z WHERE z.CPF = 22222), 'Fulano Cicrano');
INSERT INTO tb_entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatario) VALUES ((SELECT REF(x) FROM tb_objeto x WHERE x.cod_objeto = 3), to_date ('12/02/1980', 'dd/mm/yyyy'), (SELECT REF(y) FROM tb_cliente y WHERE y.cod_cliente = 3), (SELECT REF(z) FROM tb_funcionario z WHERE z.CPF = 33333), 'Fulano da Silva');
INSERT INTO tb_entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatario) VALUES ((SELECT REF(x) FROM tb_objeto x WHERE x.cod_objeto = 4), to_date ('12/02/1980', 'dd/mm/yyyy'), (SELECT REF(y) FROM tb_cliente y WHERE y.cod_cliente = 4), (SELECT REF(z) FROM tb_funcionario z WHERE z.CPF = 44444), 'Fulano da Silva');
INSERT INTO tb_entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatario) VALUES ((SELECT REF(x) FROM tb_objeto x WHERE x.cod_objeto = 5), to_date ('12/02/1980', 'dd/mm/yyyy'), (SELECT REF(y) FROM tb_cliente y WHERE y.cod_cliente = 5), (SELECT REF(z) FROM tb_funcionario z WHERE z.CPF = 55555), 'Fulano da Silva');