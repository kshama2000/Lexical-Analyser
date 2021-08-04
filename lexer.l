%{
#include<stdio.h>
extern int yyval;
%}
%option noyywrap
%%
"#include<stdio.h>" {fprintf(yyout,"%s \tPRE-PROCESSOR DIRECTIVE\n",yytext);}
"/*"[a-zA-a0-9' '\t\n]+"*/" {fprintf(yyout,"%s \t\tMULTI-LINE COMMENT\n",yytext);}
"//"[a-zA-Z0-9].* {fprintf(yyout,"%s \tSINGLE-LINE COMMENT\n",yytext);}
[0-9]+ {fprintf(yyout,"%s \t\t\tNUMERIC CONSTANT\n",yytext);}
int|float|char|double|void|return|signed|unsigned|main {fprintf(yyout,"%s \t\t\tKEYWORD\n",yytext);}
"if"|"else"|"else if" {fprintf(yyout,"%s \t\t\tCONDITIONAL STATEMENT\n",yytext);}
"while"|"for"|"do" {fprintf(yyout,"%s \t\t\tLOOPING STATEMENT\n",yytext);}
"printf(".*";" {fprintf(yyout,"%s\t\tOUTPUT FUNCTION\n",yytext);}
"scanf" {fprintf(yyout,"%s \t\t\tINPUT FUNCTION\n",yytext);}
"(" {fprintf(yyout,"%c \t\t\tOPENING BRACKET\n",yytext[0]);}
")" {fprintf(yyout,"%c \t\t\tCLOSING BRACKET\n",yytext[0]);}
"{" {fprintf(yyout,"%c \t\t\tOPENING BRACES\n",yytext[0]);}
"}" {fprintf(yyout,"%c \t\t\tCLOSING BRACES\n",yytext[0]);}
";" {fprintf(yyout,"%c \t\t\tSEMICOLON DELIMITER\n",yytext[0]);}
"," {fprintf(yyout,"%c \t\t\tCOMMA DELIMITER\n",yytext[0]);}
"+"|"-"|"*"|"/"|"++"|"--"|"&"|"=="|"="|"<"|">" {fprintf(yyout,"%s \t\t\tOPERATOR\n",yytext);}
"\"%"[a-zA-Z]"\"" {fprintf(yyout,"%s \t\t\tSTRING CONSTANT\n",yytext);}
"\\t" {fprintf(yyout,"%s \t\t\tTAB HORIZONTAL SPACE\n",yytext);}
"\\n" {fprintf(yyout,"%s \t\t\tNEW LINE CHARACTER\n",yytext);}
"\"" {fprintf(yyout,"%s \t\t\tDOUBLE QUOTES\n",yytext);}
[a-zA-Z]+ {fprintf(yyout,"%s \t\t\tIDENTIFIER\n",yytext);}
%%
void main()
{
yyin=fopen("program.txt","r");
yyout=fopen("Op.txt","w");
yylex();
fclose(yyin);
fclose(yyout);
}