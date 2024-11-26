; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 24/08/2020

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================

; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi��o da RAM		
count	  SPACE 0x8
step	  SPACE 0x4
count_dir SPACE 0x1	
	
; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun��o Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma fun��o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; fun��o <func>
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
; Fun��o main()
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
;Fun��o que cria um atraso de 0,5s entre o aperto do pushButton e seu tratamento
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
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
