create table objeto(
    cod_objeto number,
    peso number,
    dimensao number,
    constraint objeto_pk primary key(cod_objeto)
);

create table bonificacao(
    cod_bonificacao number,
    valor number,
    data_bonificacao date,
    constraint bonificacao_pk primary key(cod_bonificacao)
);

create table cliente(
    cod_cliente number,
    nome varchar2(100),
    CEP  number,
    descricao varchar2(50),
    constraint cliente_pk primary key(cod_cliente)
);

create table funcionario(
    CPF number,
    CPF_chefe number not null,
    nome varchar2(100),
    idade number,
    sexo varchar2(1),
    constraint funcionario_pk primary key (CPF),
    constraint funcionario_fk foreign key (CPF_chefe)references funcionario(CPF)
);

create table cliente_telefone(
    cod_cliente number,
    telefone number,
    constraint cliente_telefone_pk primary key (cod_cliente, telefone),
    constraint cliente_telefone_fk foreign key(cod_cliente) references cliente(cod_cliente)
);

create table dependente(
    CPF number,
    nome varchar2(100),
    idade number,
    parentesco varchar2(50),
    constraint dependente_pk primary key (CPF, nome),
    constraint dependente_fk foreign key (CPF) references funcionario(CPF)
);

create table departamento(
    cod_dpto number,
    descricao varchar2(100),
    n_de_func number,
    constraint departamento_pk primary key(cod_dpto)
);

create table PF(
    cod_cliente number,
    CPF number,
    constraint PF_pk primary key(cod_cliente),
    constraint PF_fk foreign key(cod_cliente) references cliente(cod_cliente)
);

create table PJ(
    cod_cliente number,
    CNPJ number,
    constraint PJ_pk primary key(cod_cliente),
    constraint PJ_fk foreign key(cod_cliente) references cliente(cod_cliente)
);

create table trabalha(
    CPF number,
    codigo number,
    cod_bonificacao number unique,
    constraint trabalha_pk primary key(CPF,codigo),
    constraint trabalha_fk1 foreign key(CPF) references funcionario(CPF),
    constraint trabalha_fk2 foreign key(codigo) references departamento(cod_dpto),
    constraint trabalha_fk3 foreign key(cod_bonificacao) references bonificacao(cod_bonificacao)
);

create table entrega(
    cod_objeto number,
    dt_entrega date,
    cod_cliente number not null unique,
    CPF number not null,
    destinatário varchar2(50),
    constraint entrega_pk primary key(cod_objeto,dt_entrega),
    constraint entrega_fk1 foreign key(CPF) references funcionario(CPF),
    constraint entrega_fk2 foreign key(cod_objeto) references objeto(cod_objeto),
    constraint entrega_fk3 foreign key(cod_cliente) references cliente(cod_cliente)
);