-----------------------------------------------------------------------------------------------------------------------------------------------
--1,6 e 10
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
	id NUMBER,
	idade NUMBER,
	nome varchar(50),
	sexo char,
	MEMBER FUNCTION attIdade (x INTEGER) RETURN INTEGER
)NOT FINAL;

CREATE OR REPLACE TYPE tp_estudante UNDER tp_pessoa(
	faculdade varchar2(30)
)FINAL;

CREATE OR REPLACE TYPE BODY tp_pessoa IS
	MEMBER FUNCTION attIdade(x INTEGER) RETURN INTEGER IS
	BEGIN
		RETURN SELF.idade + x;
	END;
END;

CREATE TABLE tb_pessoa of tp_pessoa (
	PRIMARY KEY (id)	
);

INSERT INTO tb_pessoa (id, idade, nome, sexo) VALUES (1, 17, 'Qualquer','F');

DECLARE
	x number;
BEGIN
	SELECT y.idade INTO x FROM tb_pessoa y WHERE y.attIdade(1) = 18;
	DBMS_OUTPUT.PUT_LINE(x);
END;

ALTER TYPE tp_pessoa
DROP MEMBER FUNCTION attIDADE(x INTEGER) RETURN INTEGER CASCADE;

DROP TABLE tb_pessoa;
DROP TYPE tp_estudante;
DROP TYPE tp_pessoa;
-----------------------------------------------------------------------------------------------------------------------------------------------
--2 e 4 
CREATE OR REPLACE TYPE tp_telefone_teste AS TABLE OF NUMBER;

CREATE OR REPLACE TYPE tp_teste AS OBJECT(
	idade NUMBER,
	telefone tp_telefone_teste
)FINAL;

DROP TYPE tp_teste;
DROP TYPE tp_telefone_teste;
-----------------------------------------------------------------------------------------------------------------------------------------------
--3
CREATE OR REPLACE TYPE tp_telefone_teste As varray(2) of varchar2(30);

CREATE OR REPLACE TYPE tp_teste AS OBJECT(
	idade NUMBER,
	telefone tp_telefone_teste
)FINAL;

DROP TYPE tp_teste;
DROP TYPE tp_telefone_teste;
-----------------------------------------------------------------------------------------------------------------------------------------------
--5
CREATE OR REPLACE TYPE tp_vendedor AS OBJECT(
cpf number,
nome char,
qtd_vendas number,
nivel number,
CONSTRUCTOR FUNCTION tp_vendedor(cpf number, nome char, qtd_vendas number, nivel number)
	RETURN SELF AS RESULT
)NOT FINAL;

CREATE OR REPLACE TYPE BODY tp_vendedor AS
	CONSTRUCTOR FUNCTION tp_vendedor(cpf number, nome char, qtd_vendas number, nivel number)
	RETURN SELF AS RESULT
	AS
	BEGIN
		SELF.cpf := cpf;
		SELF.nome := nome;
		SELF.qtd_vendas := qtd_vendas;
		SELF.nivel := qtd_vendas*10;
		RETURN;
	END;
END;

DECLARE
z tp_vendedor;
BEGIN
z := NEW tp_vendedor(1,'x',777,'');

DBMS_OUTPUT.PUT_LINE(z.nivel);
END;

DROP TYPE tp_vendedor;
-----------------------------------------------------------------------------------------------------------------------------------------------
--7
CREATE OR REPLACE TYPE tp_arvore AS OBJECT(
	id NUMBER,
	idade NUMBER,
	especie varchar(50),
	altura NUMBER,
	latitude NUMBER,
	longitude NUMBER,
	MAP MEMBER FUNCTION treeId RETURN NUMBER
)NOT FINAL;

CREATE OR REPLACE TYPE BODY tp_arvore IS
	MAP MEMBER FUNCTION treeId RETURN NUMBER IS
	BEGIN
		RETURN latitude*10 + longitude;
	END;
END;

CREATE TABLE tb_arvore OF tp_arvore(
	PRIMARY KEY(id)
);

DECLARE
    c tp_arvore;
    d tp_arvore;
	aux number;
       
BEGIN
c := NEW tp_arvore('', 75, 'x', 15, 10, 5);
d := NEW tp_arvore('', 102, 'x', 25, 12, 6);


c.id := c.treeId();
d.id := d.treeId();

DBMS_OUTPUT.PUT_LINE(c.id);
DBMS_OUTPUT.PUT_LINE(d.id);

INSERT INTO tb_arvore(id, idade, especie, altura, latitude, longitude) VALUES (c.id, c.idade, c.especie, c.altura, c.latitude, c.longitude);

INSERT INTO tb_arvore(id, idade, especie, altura, latitude, longitude) VALUES (d.id, d.idade, d.especie, d.altura, d.latitude, d.longitude);

SELECT x.altura INTO aux FROM tb_arvore x WHERE x.treeId() = 105;

DBMS_OUTPUT.PUT_LINE(aux);
END;

DROP TABLE tb_arvore;
DROP TYPE tp_arvore;
-----------------------------------------------------------------------------------------------------------------------------------------------
--8
CREATE OR REPLACE TYPE tp_animal AS OBJECT(
	id NUMBER,
	idade NUMBER,
	especie varchar(50),
	sexo char,
	ORDER MEMBER FUNCTION compIdade (x tp_animal) RETURN INTEGER
)NOT FINAL;

CREATE OR REPLACE TYPE BODY tp_animal IS
	ORDER MEMBER FUNCTION compIdade(x tp_animal) RETURN INTEGER IS
	BEGIN
		IF x.idade > SELF.idade THEN
			RETURN 1;
			ELSE
				RETURN 0;
		END IF;
	END;
END;

DECLARE
    c tp_animal;
    d tp_animal;
    teste integer;
       
BEGIN
c := NEW tp_animal(1, 2, 'x', 'f');
d := NEW tp_animal(2, 3, 'y', 'f');


teste := c.compIdade(d);

DBMS_OUTPUT.PUT_LINE(teste);
END;

DROP TYPE tp_animal;
-----------------------------------------------------------------------------------------------------------------------------------------------
--9 ERRADO
CREATE OR REPLACE TYPE tp_ponto AS OBJECT(
	x number,
	y number,
	MEMBER FUNCTION valx RETURN NUMBER,
	MEMBER FUNCTION valy RETURN NUMBER,
	NOT INSTANTIABLE MEMBER PROCEDURE desenhar
)NOT FINAL NOT INSTANTIABLE;

CREATE OR REPLACE TYPE BODY tp_ponto IS
	MEMBER FUNTION valx RETURN NUMBER IS
	BEGIN RETURN x; END;

	MEMBER FUNTION valy RETURN NUMBER IS
	BEGIN RETURN y; END;
END;

DECLARE 
kapa tp_ponto; 
BEGIN
	kapa := NEW tp_ponto(3,4);
END;

DROP TYPE tp_ponto;
-----------------------------------------------------------------------------------------------------------------------------------------------
--11 e 14
ALTER TYPE tp_cliente
ADD ATTRIBUTE (apelido varchar2(30)) CASCADE;
-----------------------------------------------------------------------------------------------------------------------------------------------
--12 e 15
ALTER TYPE tp_cliente
MODIFY ATTRIBUTE apelido varchar2(100) INVALIDATE;
-----------------------------------------------------------------------------------------------------------------------------------------------
--13
ALTER TYPE tp_cliente
DROP ATTRIBUTE apelido CASCADE;
-----------------------------------------------------------------------------------------------------------------------------------------------
--16
SELECT x.CPF.nome FROM tb_entrega x WHERE x.CPF.CPF = 11111;
-----------------------------------------------------------------------------------------------------------------------------------------------
--17
CREATE OR REPLACE TYPE tp_vendedor AS OBJECT(
CPF number,
nome varchar2(50),
telefone number,
sexo char
)NOT FINAL;

CREATE OR REPLACE TYPE tp_dependente2 AS OBJECT(
cod number,
nome varchar2(50),
sexo char,
cod_titular REF tp_vendedor
)NOT FINAL;

CREATE TABLE tb_vendedor OF tp_vendedor(
	PRIMARY KEY(CPF)
);

CREATE TABLE tb_dependente2 OF tp_dependente2(
	PRIMARY KEY(cod),
	cod_titular SCOPE IS tb_vendedor
);

DROP TABLE tb_dependente2;
DROP TYPE tp_dependente2;
DROP TABLE tb_vendedor;
DROP TYPE tp_vendedor;
-----------------------------------------------------------------------------------------------------------------------------------------------
--18
CREATE OR REPLACE TYPE tp_teste AS OBJECT(
	att1 NUMBER,
	att2 char,
	att3 DATE
)NOT FINAL;

CREATE TABLE tb_teste OF tp_teste(
	PRIMARY KEY(att1)
);

DROP TABLE tb_teste;
DROP TYPE tp_teste;
-----------------------------------------------------------------------------------------------------------------------------------------------
--19 e 21
SELECT VALUE(x).CPF.CPF_chefe.CPF FROM tb_entrega x;
-----------------------------------------------------------------------------------------------------------------------------------------------
--20
SELECT DEREF(x.CPF).CPF from tb_trabalha x;
-----------------------------------------------------------------------------------------------------------------------------------------------
--22 e 26
SELECT x1.* FROM tb_cliente x, table(x.telefone) x1;
-----------------------------------------------------------------------------------------------------------------------------------------------
--23
SELECT COUNT(*) 
FROM tb_dependente x
WHERE (x.idade BETWEEN 1 AND 18) AND (x.nome LIKE '%a%')
GROUP BY x.CPF.CPF
HAVING x.CPF.CPF = 11111

SELECT y.idade
FROM tb_funcionario y
ORDER BY y.idade
-----------------------------------------------------------------------------------------------------------------------------------------------
--24
SELECT x.*
FROM tb_objeto x
WHERE x.dimensao > ANY(SELECT x.cod_objeto.dimensao FROM tb_entrega x WHERE x.cod_objeto.dimensao = 10)

SELECT x.*
FROM tb_objeto x
WHERE x.dimensao > ALL(SELECT x.cod_objeto.dimensao FROM tb_entrega x WHERE x.cod_objeto.dimensao < 13)

SELECT x.*
FROM tb_objeto x
WHERE x.dimensao IN (SELECT MIN(x.cod_objeto.dimensao) FROM tb_entrega x)
-----------------------------------------------------------------------------------------------------------------------------------------------
--25
CREATE OR REPLACE TYPE tp_telefone_teste AS varray (5) OF NUMBER;

CREATE OR REPLACE TYPE tp_teste AS OBJECT(
	cod NUMBER,
	telefone_teste tp_telefone_teste
)FINAL;

CREATE TABLE tb_telefone_teste OF tp_teste(
	PRIMARY KEY(cod)
);

INSERT INTO tb_telefone_teste(cod, telefone_teste) VALUES (1, tp_telefone_teste(1111,2222,3333,4444,5555));

SELECT x1.* FROM tb_telefone_teste x, table(x.telefone_teste) x1;

DROP TABLE tb_telefone_teste;
DROP TYPE tp_teste;
DROP TYPE tp_telefone_teste;
-----------------------------------------------------------------------------------------------------------------------------------------------
--27
SELECT x.CPF.CPF AS CPF_Funcionario FROM tb_entrega x 
WHERE EXISTS(SELECT y.*
			FROM tb_objeto y
			WHERE y.dimensao > 0);
-----------------------------------------------------------------------------------------------------------------------------------------------
--28
CREATE OR REPLACE TRIGGER gatilho
BEFORE INSERT OR DELETE OR UPDATE OF cod_objeto ON tb_objeto
FOR EACH ROW
BEGIN
	DBMS_OUTPUT.PUT_LINE('Antigo codigo : ' || :OLD.cod_objeto);
	DBMS_OUTPUT.PUT_LINE('Novo codigo : ' || :NEW.cod_objeto);
END;

UPDATE tb_objeto
SET cod_objeto = 6
WHERE cod_objeto = 5

DROP TRIGGER gatilho
-----------------------------------------------------------------------------------------------------------------------------------------------
--29
CREATE OR REPLACE TRIGGER gatilho
BEFORE INSERT OR DELETE OR UPDATE OF dimensao ON tb_objeto
FOR EACH ROW
BEGIN
	IF :NEW.dimensao = 0 THEN
		RAISE_APPLICATION_ERROR(-20001, 'Dimensao invalida para um objeto');
	END IF;
END;

UPDATE tb_objeto
SET dimensao = 0
WHERE peso = 5

DROP TRIGGER gatilho
-----------------------------------------------------------------------------------------------------------------------------------------------
--30
CREATE OR REPLACE TRIGGER gatilho
AFTER INSERT OR DELETE OR UPDATE OF CPF ON tb_entrega
BEGIN
	DBMS_OUTPUT.PUT_LINE('Entrega agendada com sucesso');
END;

INSERT INTO tb_entrega (cod_objeto, dt_entrega, cod_cliente, CPF, destinatario) VALUES ((SELECT REF(x) FROM tb_objeto x WHERE x.cod_objeto = 6), to_date ('12/02/1988', 'dd/mm/yyyy'), (SELECT REF(y) FROM tb_cliente y WHERE y.cod_cliente = 6), (SELECT REF(z) FROM tb_funcionario z WHERE z.CPF = 66666), 'Fulano da Silva');

DROP TRIGGER gatilho;
-----------------------------------------------------------------------------------------------------------------------------------------------

