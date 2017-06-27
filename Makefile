########################################
###Script by PerguGames
###GitHub:https://github.com/PerduGames
########################################
#Arquivo Makefile 
#Arquivo para compilar executavel em c++, 
#buscando as dependencias em suas respectivas pastas
#O que acontece quando digito "make"?
#Busca dentro do diretorio atribuido na variavel "SRC" todos os arquivos .cpp
#Muda o sufixo e prefixo de todos os arquivos: "src/*.cpp" para "obj/*.o"
#Compila os arquivos .cpp e cria os arquivos .o no diretorio atribuido na variavel "OBJ"
#Linka e cria o executavel com o nome que você colocou na variavel "NOME_EXECUTAVEL",
#buscando as bibliotecas e os arquivos-objetos que foram criados
#O que acontece quando digito "make run"?
#Executa o programa "NOME_EXECUTAVEL",
#O que acontece quando digito "make cleanObjetos"?
#Exclui todos os arquivos .o no diretorio atribuido na variavel "OBJ"
#O que acontece quando digito "make clean"?
#Exclui todos os arquivos no diretorio atribuido na variavel "BIN" que seria seu
#executavel que deu o nome em "NOME_EXECUTAVEL"
#O que acontece quando digito "make tar"?
#Empacota todo o diretorio atual onde esta o arquivo makefile com o
#nome que você colocou na variavel "NOME_EXECUTAVEL"

#Compilador
COMPILADOR=g++
#Nome do seu executavel
NOME_EXECUTAVEL=nomeDoSeuExecutavel
#Diretorio dos arquivos binarios
BIN=./bin
#Diretorio dos arquivos .h e .hpp
INCLUDE=./include
#Diretorio dos arquivos-objetos
OBJ=./obj
#Diretorio dos arquivos .c e .cpp
SRC=./src
#Diretorio dos arquivos de bibliotecas
LIB=./lib

#Para otimizar e mostrar mais avisos
FLAGS= -O3 -Wall
#Para encontrar as bibliotecas utilizadas(em "-lm", apenas um exemplo, caso seu compilador nao faca isso por voce)
LIBS= -lm -L $(LIB)

#Pega todos arquivos .cpp e muda os nomes para .o
#Fontes .cpp
FONTES=$(wildcard $(SRC)/*.cpp)
#Retirar prefixo e sufixo
OBJLIMPAR=$(notdir $(basename $(FONTES)))
#Adicionar novo prefixo e sufixo
OBJETOS=$(addprefix $(OBJ)/, $(addsuffix .o, $(OBJLIMPAR)))

.PHONY: all cleanObjetos clean tar

all: compilar $(NOME_EXECUTAVEL)

#Arquivos .o do projeto
compilar: $(OBJETOS)

#Compilar e criar os arquivos-objetos
$(OBJ)/%.o: $(SRC)/%.cpp $(INCLUDE)/%.hpp
	$(COMPILADOR) $(FLAGS) -c $< -I $(INCLUDE) -o $@

#Linkar e criar o executavel
$(NOME_EXECUTAVEL): $(OBJETOS)
	$(COMPILADOR) $(FLAGS) $(OBJETOS) $(LIBS) -o $(BIN)/$@

#Executar programa
run:
	$(BIN)/$(NOME_EXECUTAVEL)

#Limpar arquivos .o
cleanObjetos:
	rm -f $(OBJ)/*.o

#Limpar executavel
clean:
	rm -f $(BIN)/$(NOME_EXECUTAVEL)

#Empacotar projeto
tar:
	tar cvjf $(NOME_EXECUTAVEL).tar.bz2 pwd

