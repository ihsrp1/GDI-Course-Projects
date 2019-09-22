-----------------------------------------------------------------------------------------------------------------------------------------------
--1
SELECT idade
FROM funcionario
WHERE idade BETWEEN 18 AND 30
-----------------------------------------------------------------------------------------------------------------------------------------------
--2
SELECT dt_entrega
FROM entrega
WHERE dt_entrega BETWEEN '12-FEB-80' AND '12-MAR-80'
-----------------------------------------------------------------------------------------------------------------------------------------------
--3
SELECT nome
FROM cliente
WHERE nome LIKE 'F%'
-----------------------------------------------------------------------------------------------------------------------------------------------
--4
SELECT *
FROM PF
WHERE cod_cliente IN (SELECT cod_cliente FROM cliente WHERE cod_cliente = 1)
-----------------------------------------------------------------------------------------------------------------------------------------------
--5
SELECT *
FROM departamento
WHERE n_de_func IS NOT NULL
-----------------------------------------------------------------------------------------------------------------------------------------------
--6
SELECT idade
FROM funcionario
ORDER BY idade
-----------------------------------------------------------------------------------------------------------------------------------------------
--7
CREATe VIEW teste 
AS 
SELECT idade, nome
FROM dependente
-----------------------------------------------------------------------------------------------------------------------------------------------
--8
SELECT *
FROM teste
WHERE idade <= 18
-----------------------------------------------------------------------------------------------------------------------------------------------
--9
DROP VIEW teste
-----------------------------------------------------------------------------------------------------------------------------------------------
--10
ALTER TABLE dependente
ADD CONSTRAINT rest_idade
CHECK (idade <= 18)
-----------------------------------------------------------------------------------------------------------------------------------------------
--11
ALTER TABLE dependente
DROP CONSTRAINT dependente_pk

ALTER TABLE dependente
ADD CONSTRAINT newDependente_pk
PRIMARY KEY(CPF, nome)
-----------------------------------------------------------------------------------------------------------------------------------------------
--12
CREATE TABLE x(CPF number, nome varchar2(100));

ALTER TABLE x
ADD CONSTRAINT fk_x FOREIGN KEY (CPF, nome) REFERENCES dependente; 

DROP TABLE x
-----------------------------------------------------------------------------------------------------------------------------------------------
--13
ALTER TABLE bonificacao
MODIFY valor DEFAULT 100
-----------------------------------------------------------------------------------------------------------------------------------------------
--14
ALTER TABLE funcionario
MODIFY nome nchar(100)
-----------------------------------------------------------------------------------------------------------------------------------------------
--15
ALTER TABLE objeto
ADD descricao varchar(100)
-----------------------------------------------------------------------------------------------------------------------------------------------
--16
ALTER TABLE objeto
DROP COLUMN descricao
-----------------------------------------------------------------------------------------------------------------------------------------------
--17
SELECT *
FROM bonificacao
WHERE valor + 100 >= 2800
-----------------------------------------------------------------------------------------------------------------------------------------------
--18
SELECT max(valor)
FROM bonificacao
-----------------------------------------------------------------------------------------------------------------------------------------------
--19
SELECT max(valor), data_bonificacao
FROM bonificacao
GROUP BY data_bonificacao
-----------------------------------------------------------------------------------------------------------------------------------------------
--20
SELECT DISTINCT valor
FROM bonificacao
-----------------------------------------------------------------------------------------------------------------------------------------------
--21
SELECT max(valor), data_bonificacao
FROM bonificacao
GROUP BY data_bonificacao
HAVING max(valor) > 2000
-----------------------------------------------------------------------------------------------------------------------------------------------
--22
SELECT max(valor), data_bonificacao
FROM bonificacao
GROUP BY data_bonificacao
HAVING max(valor) > (SELECT avg(valor) FROM bonificacao)
-----------------------------------------------------------------------------------------------------------------------------------------------
--23
SELECT avg(n_de_func), descricao
FROM departamento
WHERE cod_dpto > 0
GROUP BY descricao
HAVING avg(n_de_func) < (SELECT count(cod_cliente) FROM cliente)
-----------------------------------------------------------------------------------------------------------------------------------------------
--24
SELECT *
FROM cliente CROSS JOIN funcionario
-----------------------------------------------------------------------------------------------------------------------------------------------
--25
SELECT *
FROM cliente CROSS JOIN funcionario CROSS JOIN objeto
ON cliente.cod_cliente = 1
-----------------------------------------------------------------------------------------------------------------------------------------------
-- 26
SELECT *
FROM cliente INNER JOIN entrega
ON cliente.cod_cliente = entrega.cod_cliente
-----------------------------------------------------------------------------------------------------------------------------------------------
--27
SELECT *
FROM cliente LEFT JOIN cliente_telefone
ON cliente.cod_cliente = cliente_telefone.cod_cliente
-----------------------------------------------------------------------------------------------------------------------------------------------
-- 28
SELECT *
FROM cliente RIGHT JOIN cliente_telefone
ON cliente.cod_cliente = cliente_telefone.cod_cliente
-----------------------------------------------------------------------------------------------------------------------------------------------
-- 29
SELECT *
FROM cliente FULL OUTER JOIN entrega
ON cliente.cod_cliente = entrega.cod_cliente
-----------------------------------------------------------------------------------------------------------------------------------------------
--30
SELECT *
FROM bonificacao
WHERE cod_bonificacao = ANY (SELECT cod_bonificacao FROM trabalha WHERE valor > 1000)
-----------------------------------------------------------------------------------------------------------------------------------------------
--31
SELECT *
FROM bonificacao
WHERE cod_bonificacao = ALL (SELECT cod_bonificacao FROM trabalha WHERE valor = 2000)
-----------------------------------------------------------------------------------------------------------------------------------------------
--32
SELECT cod_dpto, n_de_func
FROM departamento
WHERE EXISTS (SELECT CPF FROM funcionario WHERE CPF IS NOT NULL)
-----------------------------------------------------------------------------------------------------------------------------------------------
--33
SELECT idade
FROM dependente
WHERE idade <= (SELECT idade AS menor FROM funcionario WHERE nome LIKE 'F%')
-----------------------------------------------------------------------------------------------------------------------------------------------
--34
SELECT CPF
FROM PF
WHERE EXISTS(SELECT CEP FROM cliente WHERE CEP IS NOT NULL)
UNION
SELECT CPF
FROM funcionario
WHERE CPF_Chefe IS NOT NULL
-----------------------------------------------------------------------------------------------------------------------------------------------
--35
SELECT cod_cliente
FROM cliente
INTERSECT
SELECT cod_cliente
FROM entrega
WHERE cod_objeto = 1
-----------------------------------------------------------------------------------------------------------------------------------------------
--36
SELECT *
FROM cliente
MINUS
SELECT *
FROM cliente
WHERE nome LIKE 'F%'
-----------------------------------------------------------------------------------------------------------------------------------------------
--37
INSERT INTO cliente (cod_cliente, nome, CEP, descricao)
SELECT 6, nome, 66666666, 'FON'
FROM funcionario 
WHERE CPF = 11111
-----------------------------------------------------------------------------------------------------------------------------------------------
--38
UPDATE cliente
SET nome = (SELECT nome FROM funcionario WHERE CPF = 22222)
WHERE cod_cliente = 6
-----------------------------------------------------------------------------------------------------------------------------------------------
--39
DELETE FROM PJ
WHERE cod_cliente = (SELECT cod_cliente FROM cliente WHERE cod_cliente = 5)
-----------------------------------------------------------------------------------------------------------------------------------------------
--40
CREATE USER chaublinha123 IDENTIFIED BY 123
GRANT INSERT, DELETE ON objeto TO chaublinha123
-----------------------------------------------------------------------------------------------------------------------------------------------
--41
CREATE USER chaublinha123 IDENTIFIED BY 123
REVOKE INSERT,DELETE ON objeto TO chaublinha123
-----------------------------------------------------------------------------------------------------------------------------------------------
--42
SELECT CEP 
FROM (SELECT CEP, nome, cod_cliente FROM cliente) 
WHERE (cod_cliente = 5);
-----------------------------------------------------------------------------------------------------------------------------------------------
--43
SELECT sum(idade) - avg(idade)
FROM funcionario
-----------------------------------------------------------------------------------------------------------------------------------------------
--44
SELECT nome, idade 
FROM funcionario 
WHERE idade BETWEEN (SELECT min(idade) FROM funcionario) AND (SELECT avg(idade) FROM funcionario)
-----------------------------------------------------------------------------------------------------------------------------------------------
--45
SELECT *
FROM funcionario 
INNER JOIN entrega ON funcionario.CPF = entrega.CPF
INNER JOIN cliente ON cliente.cod_cliente = entrega.cod_cliente
-----------------------------------------------------------------------------------------------------------------------------------------------
--47
SELECT peso 
FROM objeto 
WHERE EXISTS (SELECT cod_objeto FROM entrega WHERE cod_objeto = 5);
-----------------------------------------------------------------------------------------------------------------------------------------------
--46
SELECT * 
FROM funcionario
ORDER BY cpf_chefe, cpf, idade
-----------------------------------------------------------------------------------------------------------------------------------------------
--48 e 49
DECLARE
    novo_valor bonificacao.valor%TYPE;
BEGIN
    SELECT bonificacao.valor INTO novo_valor FROM bonificacao WHERE bonificacao.valor BETWEEN 1000 AND 2000;
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(novo_valor));
    
    
    EXCEPTION 
    WHEN TOO_MANY_ROWS THEN
    SELECT bonificacao.valor INTO novo_valor FROM bonificacao WHERE bonificacao.valor BETWEEN 1751 AND 2001;
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(novo_valor));
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--50/51
DECLARE
    variavel NUMBER;
BEGIN
    SELECT avg(idade) into variavel from funcionario;
    IF variavel > 10 then
        dbms_output.put_line('Idade média maior do que 10');
        ELSIF variavel  = 10 then
            dbms_output.put_line('Idade média igual a 10');
        ELSE
             dbms_output.put_line('Idade média menor do que 10');
    END IF;
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--52/56
DECLARE
    variavel NUMBER;
    resposta VARCHAR2(50);
BEGIN
    SELECT avg(idade) into variavel from funcionario;
    resposta :=
    case
        when variavel > 10 then 'Idade média maior do que 10'
        when variavel = 10 then 'Idade média igual a 10'
        when variavel < 10 then 'Idade média menor do que 10'
    end;
    dbms_output.put_line(resposta);
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--53
DECLARE
    variavel NUMBER;
BEGIN
    variavel := 0;
    dbms_output.put_line(variavel);
    LOOP
        variavel := variavel + 1;
        dbms_output.put_line(variavel);
    EXIT when variavel = 2;
    END LOOP;
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--54
DECLARE
    variavel NUMBER;
BEGIN
    variavel := 0;
    dbms_output.put_line(variavel);
    while variavel <> 2 loop
        variavel := variavel + 1;
        dbms_output.put_line(variavel);
    END LOOP;
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--55
DECLARE
    variavel NUMBER;
BEGIN
    variavel := 0;
    dbms_output.put_line(variavel);
    FOR numero in 0..2 LOOP
        variavel := variavel + 1;
        dbms_output.put_line(variavel);
    END LOOP;
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--57/58/59/60/61
DECLARE
    CURSOR cur(cod NUMBER) IS
        SELECT * 
        FROM cliente 
        where cod_cliente = cod;
    reg_cur cur%ROWTYPE;
    variavel number;
BEGIN
    open cur(1);
    fetch cur into reg_cur;
    variavel := reg_cur.CEP;
    dbms_output.put_line(variavel);
    close cur;
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--62
DECLARE
    variavel number;
BEGIN
    FOR reg_cur IN (SELECT * 
                    FROM cliente 
                    where cod_cliente <6)
    LOOP
        dbms_output.put_line(reg_cur.CEP);
    END LOOP;
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--63
CREATE OR REPLACE PROCEDURE sem_param IS
    CURSOR cur IS
        SELECT * 
        FROM cliente
        WHERE cod_cliente = 1;
    variavel cur%ROWTYPE;
BEGIN
    OPEN cur;
    FETCH cur into variavel;
    dbms_output.put_line(variavel.nome || ' ' || variavel.CEP);
    close cur;
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--64/65/66/67
CREATE OR REPLACE PROCEDURE all_in(a in number, b in out number, c out number) IS
BEGIN
    b := (a + b);
    c := b/2;
    dbms_output.put_line(a || ' ' || b || ' ' || c);
END;

DECLARE
    r number;
    t number;
BEGIN
    r := 4;
    all_in(2,r,t);
    dbms_output.put_line(r || ' ' || t);
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
-- 68
CREATE OR REPLACE FUNCTION fsem_param RETURN NUMBER IS
    variavel number;
BEGIN
    SELECT avg(idade) INTO variavel FROM dependente;
    return variavel;
END;

BEGIN
    dbms_output.put_line(fsem_param);
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--69/70/71
CREATE OR REPLACE FUNCTION fall_in (a in number, b in out number, c out number) RETURN NUMBER IS
    variavel number;
BEGIN
    SELECT idade INTO variavel FROM funcionario WHERE CPF = a;
    SELECT valor INTO b FROM bonificacao WHERE cod_bonificacao = b;
    c := variavel;
    return c;
END;

DECLARE
    t1 number;
    t2 number;
    t3 number;
BEGIN
    t1 := 3;
    t3 := fall_in(11111, t1, t2);
    dbms_output.put_line(t1 || ' ' || t2);
    dbms_output.put_line(t3);
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--72/90
create or replace package pacote IS

    variavel number;

    procedure all_in(a in number, b in out number, c out number);
    function fall_in(x in number, y in out number, z out number) return number;
    function aumento(f in number, g in out number, h out number) return number;

end pacote;

create or replace package body pacote IS

    procedure all_in(a in number, b in out number, c out number) IS
    BEGIN
        b := (a + b);
        c := b/2;
        dbms_output.put_line(a || ' ' || b || ' ' || c);
    END;    

    function fall_in(x in number, y in out number, z out number)return number IS
    BEGIN
        SELECT idade INTO variavel FROM funcionario WHERE CPF = x;
        SELECT valor INTO y FROM bonificacao WHERE cod_bonificacao = y;
        z := variavel;
        return z;
    END;

    function aumento(f in number, g in out number, h out number) return number IS
    BEGIN
        h := fall_in(11111, g, h);

        variavel := f * g;

        RETURN variavel;

    END;

end pacote;

DECLARE
    r number;
    t number;
BEGIN
    r := 4;
    pacote.all_in(2,r,t);
    dbms_output.put_line(r || ' ' || t);
END;

DECLARE
    t1 number;
    t2 number;
    t3 number;
BEGIN
    t1 := 3;
    t3 := pacote.fall_in(11111, t1, t2);
    dbms_output.put_line(t1 || ' ' || t2);
    dbms_output.put_line(t3);
END;

DECLARE
    result number;
    t1 number;
    t2 number;
BEGIN
    t1 := 1;
    result := pacote.aumento(1.5, t1, t2);
    dbms_output.put_line(result);
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--73/75/78/81
CREATE OR REPLACE TRIGGER gatilho
BEFORE INSERT ON funcionario
FOR EACH ROW
BEGIN
    IF (:NEW.idade < 18) THEN
        RAISE_APPLICATION_ERROR(-20002, 'VALOR INVÁLIDO');
    END IF;
END;

INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (66666, 11111, 'De Fulana Silva', 15, 'F');
-----------------------------------------------------------------------------------------------------------------------------------------------
--74/76/79
CREATE OR REPLACE TRIGGER gatilho
AFTER DELETE ON funcionario
FOR EACH ROW
WHEN (OLD.sexo = 'M')
BEGIN
    IF (:NEW.idade IS NULL) THEN
        DBMS_OUTPUT.PUT_LINE('DEVIDAMENTE DELETADO');
    END IF;
END;


DELETE FROM funcionario
WHERE CPF = 66666;
-----------------------------------------------------------------------------------------------------------------------------------------------
--77
CREATE OR REPLACE TRIGGER gatilho
AFTER DELETE ON funcionario
BEGIN
    DBMS_OUTPUT.PUT_LINE('DEVIDAMENTE DELETADO');
END;

INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (66666, 11111, 'De Fulana Silva', 15, 'F');


DELETE FROM funcionario
WHERE CPF = 66666;
-----------------------------------------------------------------------------------------------------------------------------------------------
--80/82
CREATE OR REPLACE TRIGGER gatilho
BEFORE UPDATE OF idade ON funcionario
FOR EACH ROW
BEGIN
    IF(:NEW.idade < 18 AND :OLD.idade > 18) THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Deu ruim');
        
    END IF;
END;

UPDATE funcionario
SET idade = 17
WHERE CPF = 22222
-----------------------------------------------------------------------------------------------------------------------------------------------
--83
CREATE OR REPLACE TRIGGER gatilho
BEFORE DELETE ON funcionario
FOR EACH ROW
BEGIN
    IF (:OLD.idade IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20003, 'NÃO DELETADO POIS A IDADE É NULA');
    END IF;
END;

INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (12345, 11111, 'De Fulana Silva', NULL, 'F');

DELETE FROM funcionario
WHERE CPF = 12345
-----------------------------------------------------------------------------------------------------------------------------------------------
--84
CREATE OR REPLACE TRIGGER gatilho
AFTER INSERT ON funcionario
FOR EACH ROW
BEGIN
    INSERT INTO dependente (CPF, nome, idade, parentesco) VALUES (:NEW.CPF, 'NEW DEPENDENTE', 30, 'IRMÃO');
    DBMS_OUTPUT.PUT_LINE('INSERIDO COM SUCESSO');
END;

INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (54321, 22222, 'Cicrana Fulano', 20, 'F');

SELECT * FROM dependente
-----------------------------------------------------------------------------------------------------------------------------------------------
--85
CREATE OR REPLACE TRIGGER reajuste
AFTER INSERT ON trabalha
FOR EACH ROW
BEGIN
    UPDATE departamento
    SET n_de_func = (n_de_func + 1)
    WHERE cod_dpto = :NEW.codigo;
    DBMS_OUTPUT.PUT_LINE('NOVO FUNCIONARIO NO DEPARTAMENTO');
END;

INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (66666, 11111, 'teste', 10, 'M');
INSERT INTO bonificacao (cod_bonificacao, valor, data_bonificacao) VALUES (6, 112000, to_date ('21/03/1980', 'dd/mm/yyyy'));
INSERT INTO trabalha (CPF, codigo, cod_bonificacao) VALUES (66666, 1, 6);
-----------------------------------------------------------------------------------------------------------------------------------------------
--86
CREATE OR REPLACE TRIGGER regra
AFTER UPDATE OF CEP ON cliente
FOR EACH ROW
BEGIN
    DELETE FROM entrega
    WHERE cod_cliente = :OLD.cod_cliente;
    DBMS_OUTPUT.PUT_LINE('ENTREGA CANCELADA');
END;

UPDATE cliente
SET CEP = 66666666
WHERE cod_cliente = 1
-----------------------------------------------------------------------------------------------------------------------------------------------
--87
CREATE OR REPLACE FUNCTION fsem_param RETURN NUMBER IS
    variavel number;
BEGIN
    SELECT avg(idade) INTO variavel FROM dependente;
    return variavel;
END;

SELECT nome FROM funcionario WHERE idade >= fsem_param();
-----------------------------------------------------------------------------------------------------------------------------------------------
--88/89
CREATE OR REPLACE FUNCTION fRETreg (a IN trabalha%ROWTYPE) RETURN funcionario%ROWTYPE IS
    variavel number;
    variavel2 number;
    resposta funcionario%ROWTYPE;
BEGIN 
    SELECT max(valor) INTO variavel FROM bonificacao;

    SELECT valor INTO variavel2 FROM bonificacao WHERE cod_bonificacao = a.cod_bonificacao;

    if(variavel2 * 1.2 > variavel) then
        DBMS_OUTPUT.PUT_LINE('Aumento nao autorizado');
        SELECT * INTO resposta FROM funcionario WHERE CPF = (SELECT CPF FROM trabalha WHERE cod_bonificacao = a. cod_bonificacao);
        RETURN resposta;
    else
        DBMS_OUTPUT.PUT_LINE('Aumento autorizado');
        SELECT * INTO resposta FROM funcionario WHERE CPF = (SELECT CPF FROM trabalha WHERE cod_bonificacao = a. cod_bonificacao);
        RETURN resposta;
    end if; 
END;

DECLARE
    CURSOR cur(cod NUMBER) IS
        SELECT * 
        FROM trabalha 
        where CPF = cod;
    reg_cur cur%ROWTYPE;
    resposta funcionario%ROWTYPE;
BEGIN
    open cur(44444);
    fetch cur into reg_cur;
    resposta := fRETreg(reg_cur);
    DBMS_OUTPUT.PUT_LINE(resposta.nome || ' ' || resposta.idade || ' ' || resposta.sexo);
    close cur;
END;
-----------------------------------------------------------------------------------------------------------------------------------------------
--91
CREATE VIEW idades
AS
SELECT nome, idade, CPF FROM funcionario 
UNION 
SELECT nome, idade, CPF FROM dependente 

CREATE OR REPLACE TRIGGER gatilho
INSTEAD OF INSERT ON idades
FOR EACH ROW
BEGIN
    INSERT INTO funcionario (CPF, CPF_chefe, nome, idade, sexo) VALUES (66666, 11111, :NEW.nome, :NEW.idade, 'M');
    INSERT INTO dependente (CPF, nome, idade, parentesco) VALUES (66666, 'Fulano de ' || :NEW.nome , :NEW.idade, 'Filho');
    DBMS_OUTPUT.PUT_LINE('É isto');
END;

INSERT INTO idades (nome, idade) VALUES ('FON', 9999);
-----------------------------------------------------------------------------------------------------------------------------------------------