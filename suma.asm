title "Tarea 4"
	.model small
	.386
	.stack 64
	.data
x dw 6h	; se inicializa la variable x = 6 
y dw 0	; se inicializa la variable y = 0
valMul dw 2h
valDiv dw 2h 
exCode db 0 ;variable exCode de tipo byte
	.code
inicio:
	mov ax, @data	; es considerado como el numero de segmento que sera utilizado en los datos 
	mov dx, ax 	; aqui solo le esta pasando la seccion de "ax" osea "ax = bx"
; Limpiamos el registro ax y bx 
	mov ax, 0	; decimos que es ax = 0 para que no aya confucion 
	mov dx, 0	; igualmente hacemos lo mismo y decimos que bx = 0
; Lo que quemos llegara es a esto y(x) = x^3 - 2x^2 + 3/2x + 5 asi que aplicamos el jonh de raper vamos por parte
; Vamos primero por lo que es x^3 osea cmaos a estar haciendo x*x*x
	mov ax, [x] ; Aqui le decimos que "ax" esta siendo igualado al valor x asi que podemos intepretarlo como "ax = x" o tambien "ax = 6h"
	mul [x]	; Lo que hacemos es multiplicar ax * x o x*x
	mul [x] ; Aqui se vuelve a multiplicar otra vez lo que es x por tercera vez
; Sabemos que hasta esta linea sabemos que ax = x = D8h
; Ahora que ya sabemos que cuanot vale x^3 vamos con la siguiente parte 2x^2
	mov dx, [x] ;Aqui hacemos que dx tenga en valor de lo que es x "dx = x"
	mul [x]	;Aqui vamos a volver a multiplicar por si mismo para que se cumpla x^2
	mul [valMul]	; se multiplica un valor contante lo que dx

; Aqui nos tiene que decir que dx = 48h

	mov cx, 3	; Le pasamos el valor 3 a "cx" 
	div [valDiv] ; Esto se valor nos sirve para poder dividir con el valor de arriba 
	mul [x] ; y esto para multiplicar por el valor de x

	add [y], ax ;}
	add [y], dx ;}
	add [y], cx ;} Literalmete toda esta seccion para hacer la suma de todos los valores anteriores 
	add [y], 5	;}
salir:				;inicia etiqueta Salir
	mov ah,4Ch		;AH = 4Ch, opcion para terminar programa
	mov al,[exCode]	;AL = 0 exit Code, codigo devuelto al finalizar el programa
	int 21h			;senal 21h de interrupcion, pasa el control al sistema operativo
	end inicio		;fin de etiqueta inicio, fin de programa





