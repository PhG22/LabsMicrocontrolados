; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 24/08/2020

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; ========================

; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		
count	  SPACE 0x8
step	  SPACE 0x4
count_dir SPACE 0x1	
	
; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT  GPIO_Init
        IMPORT 	Enable7SegLeft
		IMPORT 	Enable7SegRight
		IMPORT 	EnableLEDs	
		IMPORT 	GetPushBtnsState
		IMPORT 	DisableAllLEDs


; -------------------------------------------------------------------------------
; Função main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	BL InitializeVars 
	
MainLoop
	
	BL GetPushBtnsState
	CMP R12,R0
	IT EQ
		BEQ Branch
	MOV R12, R0
	LDR R1, =step 
	LDR R2,[R1]
	CMP R0, #2_01
	IT EQ
		ADDEQ R2, R2, #1
	CMP R2, #9
	IT EQ
		MOVEQ R2,#1
	STRB R2,[R1]	
		  
	LDR R1, =count_dir 
	LDR R2,[R1]	
	CMP R0, #2_10
	IT EQ
		EOREQ R2,R2,#1
	STRB R2,[R1]	
	
Branch

	LDR R1, =count
	LDR R4, [R1]
	LDR R2, =step
	LDR R5, [R2]
	LDR R3, =count_dir
	LDR R6, [R3]
	
	CMP R6,#1
	ITE EQ
		ADDEQ R4,R4,R5
		SUBNE R4,R4,R5
	
	MOV R0, #99
	CMP R4, R0
	IT GE
		SUBGE R4, R4,R0
		
	
	MOV R0, #0
	CMP R4, R0
	MOV R0, #99
	IT LT
		ADDLT R4, R4, R0	
		
	STRB R4,[R1]
				
	
	MOV R5,#10
	UDIV R3, R4, R5
	
		
	MOV R0,R3
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	BL wait_200ms
	
	
	MLS R0, R3, R5, R4
	
	BL Enable7SegRight
	BL SysTick_Wait1ms
	BL wait_200ms
	
	
	MOV R0,R4
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL wait_200ms
	BL DisableAllLEDs
	

	
		
	B MainLoop
	
;--------------------------------------------------------------------------------
wait_200ms
; ****************************************
;Função que cria um atraso de 0,5s entre o aperto do pushButton e seu tratamento
; ****************************************
	MOV R0, #100
	PUSH {LR}
	BL SysTick_Wait1ms
    POP {LR}
	
	BX LR

;--------------------------------------------------------------------------------
InitializeVars
; ****************************************
	
	LDR R1, =count
	MOV R2, #0
	STRB R2,[R1]
	
	LDR R1, =step
	MOV R2, #1
	STRB R2,[R1]
	
	LDR R1, =count_dir
	MOV R2, #1
	STRB R2,[R1]
	
	BX LR


; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo
