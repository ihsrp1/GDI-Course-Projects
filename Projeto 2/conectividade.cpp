#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <sql.h>
#include <sqlext.h>
#include <sqltypes.h>
#include <iostream>
#include <string>
#include <string.h>

using namespace std;

void sqlIUD(SQLHDBC *dbc, char *command)
{
    SQLHSTMT stmt;
    SQLRETURN ret;
    SQLAllocHandle(SQL_HANDLE_STMT, (*dbc), &stmt);
    ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);
}

void recoverPrint(SQLHDBC *dbc, char *command, string tabela)
{
    SQLHSTMT stmt;
    SQLRETURN ret;
    SQLLEN indicator[5];

    SQLLEN cod_objeto;
    SQLLEN peso;
    SQLLEN dimensao;

    SQLLEN cod_boni;
    SQLLEN valor;
    SQLCHAR data [20] = "";

    SQLLEN cod_cliente;
    SQLCHAR nome [100] = "";
    SQLLEN CEP;

    SQLLEN CPF;
    SQLLEN CPF_chefe;
    SQLLEN idade;
    SQLCHAR sexo [1] =  "";

    SQLLEN telefone;

    SQLCHAR parentesco [50] = "";

    SQLLEN cod_dpto;
    SQLCHAR desc [100] = "";
    SQLLEN num_func;

    SQLLEN CNPJ;

    SQLCHAR dest [50] = "";

    int i = 0;

    stmt = NULL;

    SQLAllocHandle(SQL_HANDLE_STMT, (*dbc), &stmt);

    if(tabela == "objeto")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &cod_objeto,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_LONG, &peso, 0, &indicator[1]);
        ret = SQLBindCol(stmt, 3, SQL_C_LONG, &dimensao, 0, &indicator[2]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("COD_OBJETO: %d \t PESO: %d \t DIMENSAO: %d \n", cod_objeto, peso, dimensao);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }

    if(tabela == "bonificacao")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &cod_boni,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_LONG, &valor, 0, &indicator[1]);
        ret = SQLBindCol(stmt, 3, SQL_C_CHAR, data, sizeof(data), &indicator[2]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("COD_BONIFICACAO: %d \t VALOR: %d \t DATA: %s \n", cod_boni, valor, data);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }


    if(tabela == "cliente")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &cod_cliente,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_CHAR, nome, sizeof(nome), &indicator[1]);
        ret = SQLBindCol(stmt, 3, SQL_C_LONG, &CEP, 0, &indicator[2]);
        ret = SQLBindCol(stmt, 4, SQL_C_CHAR, desc, sizeof(desc), &indicator[3]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("COD_CLIENTE: %d \t NOME: %s \t CEP: %d \t DESCRICAO: %s \n", cod_cliente, nome, CEP, desc);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }

    if(tabela == "funcionario")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &CPF,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_LONG, &CPF_chefe, 0, &indicator[1]);
        ret = SQLBindCol(stmt, 3, SQL_C_CHAR, nome, sizeof(nome), &indicator[2]);
        ret = SQLBindCol(stmt, 4, SQL_C_LONG, &idade, 0, &indicator[3]);
        ret = SQLBindCol(stmt, 5, SQL_C_CHAR, sexo, sizeof(sexo), &indicator[4]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("CPF: %d \t CPF_chefe: %d \t  NOME: %s \t IDADE: %d \t SEXO: %s\n", CPF, CPF_chefe, nome, idade, sexo);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }

    if(tabela == "cliente_telefone")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &cod_cliente,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_LONG, &telefone, 0, &indicator[1]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("COD_CLIENTE: %d \t TELEFONE: %d \n", cod_cliente, telefone);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }

    if(tabela == "dependente")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &CPF,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_CHAR, nome, sizeof(nome), &indicator[1]);
        ret = SQLBindCol(stmt, 3, SQL_C_LONG, &idade, 0, &indicator[2]);
        ret = SQLBindCol(stmt, 4, SQL_C_CHAR, parentesco, sizeof(parentesco), &indicator[3]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("CPF: %d \t NOME:%s \t IDADE: %d \t PARENTESCO: %s \n", CPF, nome, idade, parentesco);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }

    if(tabela == "departamento")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &cod_dpto,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_CHAR, desc, sizeof(desc), &indicator[1]);
        ret = SQLBindCol(stmt, 3, SQL_C_LONG, &num_func, 0, &indicator[2]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("COD_DPTO: %d \t DESCRICAO: %s \t N_DE_FUNC: %d \n", cod_dpto, desc, num_func);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }

    if(tabela == "PF")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &cod_cliente,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_LONG, &CPF, 0, &indicator[1]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("COD_CLIENTE: %d \t CPF: %d \n", cod_cliente, CPF);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }

    if(tabela == "PJ")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &cod_cliente,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_LONG, &CNPJ, 0, &indicator[1]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("COD_CLIENTE: %d \t CNPJ: %d \n", cod_cliente, CNPJ);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }

    if(tabela == "trabalha")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &CPF,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_LONG, &cod_dpto, 0, &indicator[1]);
        ret = SQLBindCol(stmt, 3, SQL_C_LONG, &cod_boni, 0, &indicator[2]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("CPF: %d \t CODIGO: %d \t COD_BONIFICACAO:%d \n", CPF, cod_dpto, cod_boni);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }

    if(tabela == "entrega")
    {
        ret = SQLBindCol(stmt, 1, SQL_C_LONG, &cod_objeto,0, &indicator[0]);
        ret = SQLBindCol(stmt, 2, SQL_C_CHAR, data, sizeof(data), &indicator[1]);
        ret = SQLBindCol(stmt, 3, SQL_C_LONG, &cod_cliente, 0, &indicator[2]);
        ret = SQLBindCol(stmt, 4, SQL_C_LONG, &CPF, 0, &indicator[3]);
        ret = SQLBindCol(stmt, 5, SQL_C_CHAR, dest, sizeof(dest), &indicator[4]);
        ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);

        while((ret=SQLFetch(stmt)) != SQL_NO_DATA)
        {
            i++;
            printf("COD_OBJETO: %d \t DT_ENTREGA:%s \t COD_CLIENTE:%d \t CPF:%d \t DESTINATARIO:%s \n", cod_objeto, data, cod_cliente, CPF, dest);
        }

        cout << "Numero de linhas retornadas = " << i << endl;
    }
}

void menu()
{
    cout << "Escolha uma das opcoes : " << endl;

    cout << "1 - Inserir no BD" << endl << "2 - Atualizar o BD" << endl << "3 - Remocao no BD" << endl << "4 - Fazer consulta no BD" << endl << "5 - Encerrar" << endl;
}

main()
{
    SQLHENV env;
    SQLHDBC dbc;
    SQLHSTMT stmt;
    SQLRETURN ret;
    char *qrc; // string para receber os comandos
    string aux;
    int aux2;
    string cmd;

    qrc = (char *) malloc (200 * sizeof(char));
    //variaveis iniciais
    int op = 0;
    string tabela;

    //atributos das tabelas
    string peso;
    string dimensao;
    string cod_cliente;
    string cod_objeto;
    string cod_boni;
    string cod_dpto;
    string valor;
    string data;
    string nome;
    string CEP;
    string desc;
    string cpf;
    string cnpj;
    string cpf_chefe;
    string idade;
    string sexo;
    string telefone;
    string parentesco;
    string num_func;
    string dest;

    //variaveis para a atualização
    string old;
    string newbie;
    string cond;
    string campos;

    /* Aloca um handle do tipo environment */
    SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);

    /* Seta o ambiente para oferecer suporte a ODBC 3 */
    SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *) SQL_OV_ODBC3, 0);

    /* Aloca um handle do tipo connection */
    SQLAllocHandle(SQL_HANDLE_DBC, env, &dbc);

    /* Conecta ao DSN chamado "GDI"*/
    /* Mude "Teste" para o nome do DNS que você já criou*/
    SQLDriverConnect(dbc, NULL, (SQLCHAR*)"DSN=GDI;", SQL_NTS,
                     NULL, 0, NULL, SQL_DRIVER_COMPLETE);

    while(1)
    {
        menu();
        cin >> op;

        if(op == 5)
            exit(1);

        system("cls");

        cout << "Digite o nome da tabela que deseja alterar: " << endl;
        cin >> tabela;

        switch(op)
        {
        case 1:
            fflush(stdin);
            cout << "Informe os dados a serem adicionados: (separe-os por virgula) " << endl;
            getline(cin,cmd);

            if(tabela == "funcionario")
            {
                aux2 = cmd.find(",");
                cpf = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2 + 1, cmd.size() - 1);

                aux2 = cmd.find(",");
                cpf_chefe = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                nome = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                idade = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                sexo = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (CPF, CPF_chefe, nome, idade, sexo)" + " VALUES (" + cpf + "," + cpf_chefe + "," + "'" + nome + "'" + "," + idade + "," + "'" + sexo +  "'" + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "objeto")
            {
                aux2 = cmd.find(",");
                cod_objeto = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2 + 1, cmd.size() - 1);

                aux2 = cmd.find(",");
                peso = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                dimensao = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (cod_objeto, peso, dimensao)" + " VALUES (" + cod_objeto + "," + peso + "," + dimensao + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "bonificacao")
            {
                aux2 = cmd.find(",");
                cod_boni = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2 + 1, cmd.size() - 1);

                aux2 = cmd.find(",");
                valor = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                data = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (cod_bonificacao, valor, data_bonificacao)" + " VALUES (" + cod_boni + "," + valor + "," + "'" + data + "'" + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "cliente")
            {
                aux2 = cmd.find(",");
                cod_cliente = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2 + 1, cmd.size() - 1);

                aux2 = cmd.find(",");
                nome = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                CEP = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                desc = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (cod_cliente, nome, CEP, descricao)" + " VALUES (" + cod_cliente + "," + "'" + nome + "'" + "," + CEP + "," + "'" + desc + "'" + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "cliente_telefone")
            {
                aux2 = cmd.find(",");
                cod_cliente = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                telefone = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (cod_cliente, telefone)" + " VALUES (" + cod_cliente + "," + telefone + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "dependente")
            {
                aux2 = cmd.find(",");
                cpf = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                nome = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                idade = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                parentesco = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (CPF, nome, idade, parentesco)" + " VALUES (" + cpf + "," + "'" + nome + "'" + "," + idade + "," + "'" + parentesco + "'" + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "departamento")
            {
                aux2 = cmd.find(",");
                cod_dpto = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                desc = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                num_func = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (cod_dpto, desc, num_func)" + " VALUES (" + cod_dpto + "," + "'" + desc + "'" + "," + num_func + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "PF")
            {
                aux2 = cmd.find(",");
                cod_cliente = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                cpf = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (cod_cliente, CPF)" + " VALUES (" + cod_cliente + "," + cpf + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "PJ")
            {
                aux2 = cmd.find(",");
                cod_cliente = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                cnpj = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (cod_cliente, CNPJ)" + " VALUES (" + cod_cliente + "," + cnpj + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "trabalha")
            {
                aux2 = cmd.find(",");
                cpf = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                cod_dpto = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                cod_boni = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (CPF, codigo, cod_bonificacao)" + " VALUES (" + cpf + "," + cod_dpto + "," + cod_boni + ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            if(tabela == "entrega")
            {
                aux2 = cmd.find(",");
                cod_objeto = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                data = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                cod_cliente = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                cpf = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux2 = cmd.find(",");
                dest = cmd.substr(0, aux2);
                cmd = cmd.substr(aux2+1, cmd.size() - 1);

                aux = "INSERT INTO " + tabela + " (cod_objeto, dt_entrega, cod_cliente, CPF, destinatario)" + " VALUES (" + cod_objeto + "," + "'" + data + "'" + "," + cod_cliente + "," + cpf + "," + "'" + dest + "'" +  ")";
                strcpy(qrc, aux.c_str());
                sqlIUD(&dbc, qrc);
            }

            break;

        case 2:
            fflush(stdin);
            cout << "Insira o nome da coluna a ser alterada, seu novo valor e sua condicao de atualizacao: (separe-os por virgula e use aspas o valor seja uma string) " << endl;

            getline(cin,cmd);

            aux2 = cmd.find(",");
            old = cmd.substr(0, aux2);
            cmd = cmd.substr(aux2+1, cmd.size() - 1);

            aux2 = cmd.find(",");
            newbie = cmd.substr(0, aux2);
            cmd = cmd.substr(aux2+1, cmd.size() - 1);

            aux2 = cmd.find(",");
            cond = cmd.substr(0, aux2);
            cmd = cmd.substr(aux2+1, cmd.size() - 1);

            aux = "UPDATE " + tabela + " SET " + old + " = " + newbie + " WHERE " + cond;
            strcpy(qrc, aux.c_str());
            sqlIUD(&dbc, qrc);

            break;

        case 3:
            fflush(stdin);
            cout << "Insira a condicao para delecao da linha: " << endl;
            getline(cin,cond);

            aux = "DELETE FROM " + tabela + " WHERE " + cond;
            strcpy(qrc, aux.c_str());
            sqlIUD(&dbc, qrc);

            break;

        case 4:
            fflush(stdin);
            cout << "Insira a condicao de selecao da consulta SQL: " << endl;
            getline(cin,cond);

            aux = "SELECT * FROM " + tabela + " WHERE " + cond;
            strcpy(qrc, aux.c_str());
            recoverPrint(&dbc, qrc, tabela);

            break;

        default:
            break;
        }
    }
}