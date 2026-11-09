.data
mensagem: .asciiz "Digite o numero maximo (1 < numero < 10000): "
erro: .asciiz "Numero invalido! Tente novamente.\n"
titulo: .asciiz "Numeros primos: \n"
espaco: .asciiz " "

.text

#Leitura da entrada
inicio:
li $v0, 4
la $a0, mensagem
syscall

li $v0, 5
syscall

move $t0, $v0

#Intervalo permitido
li $t6, 1
ble $t0, $t6, invalido

li $t6, 10000
bge $t0, $t6, invalido

#Titulo da lista
li $v0, 4
la $a0, titulo
syscall

#Inicializacao do candidato
li $t1, 2

#Percorre os numeros ate o maximo
volta:
bgt $t1, $t0, sair

li $t2, 2

#Testa os divisores
divisor:
mul $t3, $t2, $t2
bgt $t3, $t1, eh_primo

rem $t4, $t1, $t2
beq $t4, $zero, proximo

addi $t2, $t2, 1
j divisor

#Escreve o primo
eh_primo:
li $v0, 1
move $a0, $t1
syscall

li $v0, 4
la $a0, espaco
syscall

#Proximo numero
proximo:
addi $t1, $t1, 1
j volta

#mensagem de erro
invalido:
li $v0, 4
la $a0, erro
syscall

j inicio

#Encerramento do programa
sair:
li $v0, 10
syscall
