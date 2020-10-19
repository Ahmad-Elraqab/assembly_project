TITLE Calculate Elapsed Time          (TimingLoop.asm)


INCLUDE Irvine32.inc
INCLUDE Macros.inc

;// used to display the player turn after an error occurs. 
playerInfo macro
	
	SetColor 11
	cmp playerTurn, 1
	jne nextPlayer
	
	setXY 0, 1
	mWrite "                                                       ",0
	setXY 0, 1
	println turn
	print p1_name
	jmp outfun

nextPlayer:

	setXY 0, 1
	
	mWrite "                                                      ",0
	setXY 0, 1
	println turn
	print p2_name

outfun:


endm

;// set the player turn with dispalying their names 
setPlayers macro              
	mov AL, 1
	AND AL, num
	JZ p2
	
	setXY 0, 1
	mWrite "                                                    ",0
	setXY 0, 1
	println turn
	print p1_name
	mov playerTurn, 1
	jmp endPlayer
p2:
	setXY 0, 1
	mWrite "                                                     ",0
	setXY 0, 1
	println turn
	print p2_name
	mov playerTurn, 0
	


endPlayer:
	inc num


endm

;// check draw for the game
checkEndGame macro

	mov edi, OFFSET index
	mov ecx, lengthof index
	
L2loop:

	mov eax, "X"
	cmp [edi], eax
	JE inv4

	mov eax, "O"
	cmp [edi], eax
	JE inv4
	JNE nextStep


inv4:
	inc nums
	add edi, 4

	cmp nums, 9
	JE inv3
	

LOOP L2loop

inv3:

	SetColor 14
	setXY 10,28
	print line

	setXY 10,30
	print height
     
	setXY 70,30
	print height

	setXY 10,32
	print line

	setXY 25,30
	print str6
	jmp endGame

nextStep: 
	mov nums, 0
	jmp next

endm

;// set color for the text 
SetColor macro color

	mov eax, color
	call SetTextColor
	mov eax, 0

endm 


printGame macro

	mov ecx, 16
	mov yIndex, 3
	mov xIndex, 25
draw:
	setXY 32, yIndex
	print yAxis
	

	setXY 42, yIndex
	print yAxis

	inc yIndex
loop draw

	mov ecx, 16

draw1:

	setXY xIndex, 7
	print xAxis

	setXY xIndex, 14
	print xAxis

	inc xIndex

loop draw1

	mov yIndex, 8
	mov xIndex, 0
	mov ecx, 0
	
	SetColor 14
	setXY 28, 5
	println index+8
	setXY 37, 5
	println index+4
	setXY 46, 5
	println index
;//--------------------------------
	setXY 28, 11
	println index+20
	setXY 37, 11
	println index+16
	setXY 46, 11
	println index+12
;//--------------------------------
	setXY 28, 17
	println index+32
	setXY 37, 17
	println index+28
	setXY 46, 17
	println index+24
	

endm

;// check if the player win the game
playerWin macro         

	cmp playerTurn, 1
	jne checkPlayer2
	mov eax, "X"
	jmp checking
	checkPlayer2:
	mov eax, "O"


checking:

	cmp eax, index+8          ;//check row 1
	JNE row2
	cmp eax, index+4
	JNE row2
	cmp eax, index
	JNE row2
	jmp endCheck

row2:
	cmp eax, index+20         ;//check row 2
	JNE row3
	cmp eax, index+16
	JNE row3
	cmp eax, index+12
	JNE row3
	jmp endCheck

row3:
	cmp eax, index+32		 ;//check row 3
	JNE column1
	cmp eax, index+28
	JNE column1
	cmp eax, index+24
	JNE column1
	jmp endCheck


column1:
	cmp eax, index+8		 ;//check column 1
	JNE column2
	cmp eax, index+20
	JNE column2
	cmp eax, index+32
	JNE column2
	jmp endCheck

column2:
	cmp eax, index+4		 ;//check column 2
	JNE column3
	cmp eax, index+16
	JNE column3
	cmp eax, index+28
	JNE column3
	jmp endCheck

column3:
	cmp eax, index		      ;//check column 3
	JNE diagonal1
	cmp eax, index+12
	JNE diagonal1
	cmp eax, index+24
	JNE diagonal1
	jmp endCheck

diagonal1:
	cmp eax, index+8		 ;//check diagonal1
	JNE diagonal2
	cmp eax, index+16
	JNE diagonal2
	cmp eax, index+24
	JNE diagonal2
	jmp endCheck

diagonal2:
	cmp eax, index			 ;//check diagonal2
	JNE next5
	cmp eax, index+16
	JNE next5
	cmp eax, index+32
	JNE next5
	jmp endCheck
	

endm


;// print the game board for the game guide
gameBoard macro 

setXY 7,1
println role3

	mov ecx, 16
	mov yIndex, 3
	mov xIndex, 25
draw:
	setXY 32, yIndex
	print yAxis
	

	setXY 42, yIndex
	print yAxis

	inc yIndex
loop draw

	mov ecx, 16

draw1:

	setXY xIndex, 7
	print xAxis

	setXY xIndex, 14
	print xAxis

	inc xIndex

loop draw1

	mov yIndex, 8
	mov xIndex, 0
	mov ecx, 0
	
	SetColor 14
	setXY 28, 5
	mWrite "7"
	setXY 37, 5
	mWrite "8"
	setXY 46, 5
	mWrite "9"
;//--------------------------------
	setXY 28, 11
	mWrite "4"
	setXY 37, 11
	mWrite "5"
	setXY 46, 11
	mWrite "6"
;//--------------------------------
	setXY 28, 17
	mWrite "1"
	setXY 37, 17
	mWrite "2"
	setXY 46, 17
	mWrite "3"
	

endm

BoardGuide macro



	mov ecx, 11
	mov yIndex, 0
	mov xIndex, 60
drawing:
	setXY 65, yIndex
	print yAxis
	

	setXY 73, yIndex
	print yAxis

	inc yIndex
loop drawing

	mov ecx, 11

drawing1:

	setXY xIndex, 3
	print xAxis

	setXY xIndex, 7
	print xAxis

	inc xIndex

loop drawing1

	mov yIndex, 8
	mov xIndex, 0
	mov ecx, 0
	
	SetColor 14
	setXY 61, 1
	mWrite "7"
	setXY 69, 1
	mWrite "8"
	setXY 76, 1
	mWrite "9"
;//--------------------------------
	setXY 61, 5
	mWrite "4"
	setXY 69, 5
	mWrite "5"
	setXY 76, 5
	mWrite "6"
;//--------------------------------
	setXY 61, 9
	mWrite "1"
	setXY 69, 9
	mWrite "2"
	setXY 76, 9
	mWrite "3"

endm 

;// set the cordinates for the output for X & Y 
setXY macro xAixs, yAixs    
	mov  dl, xAixs		
     mov  dh, yAixs		
     call Gotoxy
endm

; // reqest to enter the players names 
setPlayer macro string       

	mov edx, offset buffer2
	mov ecx, SIZEOF buffer2
	call ReadString
	mov eax, buffer2
	mov string, eax

endm

;// print the String output without new line 
println macro string          
	mov edx, offset string
	call writeString
endm


;// print the string output with new line
print macro string			 
	mov edx, offset string
	call writeString
	call crlf
endm


;// print the integer output in decimal form 
printInt macro number      
	mov eax, number
	call writeDec
endm

setDelay macro num       
	mov eax, num
	call Delay
endm

.data
line byte "===============================================================",0
height byte "||",0
invalidIndex byte "Invalid Index, Please Enter Another Number",9,0
emptyPower byte "Sorry, you don't have a superpower, choose an empty index (1-9)",0
youwin byte "Well done , you have won the game", 0    ;// Output display for the winner 

intro byte "***** GROUP GG GAME (TIC-TAC-TOE REDEMPTION) *****", 0		 ;// used for the intro 	

str1 byte "1- AHMAD MOUSA JABER ELRAQAB",0		
str2 byte "2- MARWAN MOSTAFA...........",0	
str3 byte "3- ALI HAMED ...............",0
str4 byte "4- KHALED AHMED.............",0
str5 byte "Press Any Key to Continue...",0
str6 byte "There is no winner for this Game", 0

role  byte "1- This game is called 'tic tac toe' where the players need to draw sequence of ",10,"   three from the same Shape (X or O)",0
role1 byte "2- Our enhancment on this game is that the player will have a superpower to ",10,"   overwrite the opponent chosen index",0
role2 byte "3- The player will get the superpower by answering question at ",10,"   the begining of the game",0
role3 byte  "************************** Game Board ***************************",0
role11 byte "************************** Game Rules ***************************",0

wrong db "Wrong answer, you didn't earn a superpower",0
correct db "Correct Answer, you earned a superpower",0
ques db " ,Answer the following question to earn the superpower => ", 0
supchrg1 db "Player 1 Superpower charge : ",0
supchrg2 db "Player 2 Superpower charge : ",0
rand dd ?

questions db "(2^3 * 5) / (5 * 8)",0,"(3^2 * 4) /(2^3 /2)",0,"(3 * 4) / (2^3 + 4)",0,"(3^2 /9) / (2^3 /8)",0,"(81 / 9) * (18 / 6)",0,"(5^2 - 5) / 4 )    ",0,"(100 / 5) * (10 /2)",0,"(30 / 2) / 5)      ",0,"(5 * 20) / 2)      ",0,"(500 * 2)/ 100 + 1)",0
answers db 1,9,1,1,18,5,100,3,50,11
playerAnswer db ?
total db ?

player1SP dword 0
player2SP dword 0

player1 byte "Enter Player 1 Name => ",0
player2 byte "Enter Player 2 Name => ",0
MAX = 4
turn byte "Enter Number (1-9) / Turn For: ",0
xWord dd 1
yWord dd 0
nums dd 0
playerTurn dword ?

p1_name BYTE 31 DUP(?)				          ;// hold the user string input for first player name 
p2_name BYTE 31 DUP(?)					     ;// hold the user string input for second player name 

player1_name BYTE ?					          ;// store the player 1 name in it 
player2_name BYTE ?						     ;// store the player 1 name in it 
	
num BYTE 1							     ;// to set the players turns 
index dword " "," "," "," "," "," "," "," "," "   ;// array to store the input from the user in the game 
userInput dword ?						     ;// read the user input using it 

MAXLEN dd 20
COUNT dd 10

xAxis byte "..........",0
yAxis byte ".",0
yIndex db ?
xIndex db ?

.code
main PROC

	SetColor 10
	call groupDesc
	setXY 20, 18
	call waitmsg
	call Clrscr
	
	call gameGuide

	setXY 0, 0
	SetColor 14
	println player1
	mReadString p1_name	
	call crlf
	

	println player2
	mReadString p2_name
	call crlf
	
	call set1Questions
	call set2Questions


	boardGuide

	next: 
	call gameStart
		


;//-------------------------**********check winner**********--------------------------	
	playerWin

;//-------------------------**********check draw************--------------------------
next5:

	checkEndGame


endCheck:

	
	SetColor 14
	setXY 10,28
	print line

	setXY 10,30
	print height
     
	setXY 70,30
	print height

	setXY 10,32
	print line

	setXY 25,30
	print youwin
	


endGame:
	call crlf
	call crlf
	call crlf

	setXY 0, 35
	call waitmsg
	exit
main ENDP

;// set the cordinates for the intro output and print it 
groupDesc PROC        

	setXY 12, 9
	print intro
	setXY 20, 11
	print str1
	setXY 20, 12
	print str2
	setXY 20, 13
	print str3
	setXY 20, 14
	print str4

	ret

groupDesc ENDP

;// set the cordinates for the roles output and print it 
gameGuide PROC       

	setXY 8, 3
	print role11
	setXY 0, 8
	print role
	setXY 0, 13
	print role1
	setXY 0, 18
	print role2

	setXY 0, 22
	call waitmsg
	call Clrscr

	gameBoard

	setXY 0, 22
	call waitmsg
	call Clrscr

	ret

gameGuide ENDP


;// the game generator 
gameStart PROC

	
	SetColor 11
	setPlayers
next2::
	setXY 0, 6
	call readDec
	setXY 0, 6
	mWrite "     ",0
	mov userInput, eax
	mov edi, OFFSET index
	mov ecx, lengthof index
	mov eax, 0
top:
	cmp ecx, 0
	jle outLoop

	cmp playerTurn, 1
	JNE pl2

	cmp ecx, userInput
	JNE L1Loop
	mov eax, "X"


	call checkEmpty

next3::
	
	mov [edi], eax 
	add edi, 4
	jmp L1loop
pl2:
	cmp ecx, userInput
	JNE L1Loop
	mov eax, "O"


	call checkEmpty

next4::
	
	mov [edi], eax 
	add edi, 4

L1Loop:
	add edi, 4
	
	dec ecx	
	jmp top
outLoop:

;//------------------------********print program********-------------------
	printGame

		setXY 5,20
		print supchrg1
		setXY 35,20
		printInt player1SP

		setXY 40,20
		print supchrg2
		setXY 70,20
		printInt player2SP

		boardGuide

	ret

gameStart ENDP


checkEmpty proc


	cmp playerTurn, 1
	jne secondPlayer

	cmp [edi], eax
	JE inv1
	mov eax, "O"
	cmp [edi], eax
	je nextcheck
	mov eax, "X"
	jmp next3

secondPlayer:

	cmp [edi], eax
	JE inv1
	mov eax, "X"
	cmp [edi], eax
	je nextcheck
	mov eax, "O"
	jmp next4


inv1::
	SetColor 12
	setXY 0, 33
	print invalidIndex
	setDelay 1000
	setXY 0, 33
	mWrite "                                                       ",0
	playerInfo
	
	jmp next2


nextcheck:
	call superPower

		
	ret
checkEmpty endp

superPower proc

	cmp playerTurn, 1
	jne nextchecking1

nextchecking::

	cmp player1SP, 1
	jne inv1

	dec player1SP
	mov eax, "X"
	jmp next3

nextchecking1::
	cmp player2SP, 1
	jne inv1
		
	dec player2SP
	mov eax, "O"
	jmp next4

superPower endp


;// generate the question for the first player.
set1Questions proc

		
	mov eax, 10
	call Randomize
	call RandomRange
	mov rand, eax

	mov ebx, 0
OutputLoop:
	
	cmp ebx, rand
	jne nextString

     SetColor 14
	setXY 0, 5
	println p1_name
	print ques
	setXY 0, 8

	mov ecx, MAXLEN
	mov eax, ebx
     mul ecx 
	lea edx, questions[eax]
	call WriteString
	setXY 0, 9

	call readDec
	mov playerAnswer, al
	mov ecx, 0
	mov edi, offset answers
l1:
	cmp ecx, rand
	jne nextAnswer
	mov al, [edi]
	mov total, al

	mov al, playerAnswer
	cmp total, al      
	jne wrongAnswer

	inc player1SP
	print correct
	jmp endSuperpower
nextAnswer:
	add edi, 1
	inc ecx
	cmp ecx, 10
	jbe l1

nextString:
	inc ebx
	cmp ebx,COUNT
	jl OutputLoop


wrongAnswer:
	setXY 0, 11
	print wrong


endSuperpower:	
	
	setDelay 2000
	call Clrscr

    ret
set1Questions endp


;// generate the question for the second player.
set2Questions proc

		
	mov eax, 10
	call Randomize
	call RandomRange
	mov rand, eax

	mov ebx, 0
OutputLoop1:
	
	cmp ebx, rand
	jne nextString1

     SetColor 14
	setXY 0, 5
	println p2_name
	print ques
	setXY 0, 8

	mov ecx, MAXLEN
	mov eax, ebx
     mul ecx 
	lea edx, questions[eax]
	call WriteString
	setXY 0, 9

	call readDec
	mov playerAnswer, al
	mov ecx, 0
	mov edi, offset answers
l11:
	cmp ecx, rand
	jne nextAnswer1
	mov al, [edi]
	mov total, al

	mov al, playerAnswer
	cmp total, al      
	jne wrongAnswer1

	inc player2SP
	print correct
	jmp endSuperpower1
nextAnswer1:
	add edi, 1
	inc ecx
	cmp ecx, 10
	jbe l11

nextString1:
	inc ebx
	cmp ebx,COUNT
	jl OutputLoop1


wrongAnswer1:
	setXY 0, 11
	print wrong


endSuperpower1:	
	
	setDelay 2000
	call Clrscr

    ret
set2Questions endp

END main