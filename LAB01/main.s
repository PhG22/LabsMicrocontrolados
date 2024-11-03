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
offset    SPACE 0x400
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
	
MainLoop
	
;	BL GetPushBtnsState
;	MOV R1, R0
;	CMP R0, #2_01
;	IT 
;		
;	CMP R1, #2_10
;	IT 
;	
	
	MOV R0,#0
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#0
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#0
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#1
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#1
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#1
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#2
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#2
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#2
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#3
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#3
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#3
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#4
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#4
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#4
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#5
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#5
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#5
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#6
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#6
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#6
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#7
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#7
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#7
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#8
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#8
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#8
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#9
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#9
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#0
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	BL wait_200ms
	
	MOV R0,#0
	BL Enable7SegLeft
	BL SysTick_Wait1ms
	MOV R0,#0
	BL Enable7SegRight
	BL SysTick_Wait1ms
	MOV R0,#1
	BL EnableLEDs
	BL SysTick_Wait1ms
	BL DisableAllLEDs
	
	B MainLoop
	
;--------------------------------------------------------------------------------
wait_200ms
; ****************************************
;Fun��o que cria um atraso de 0,5s entre o aperto do pushButton e seu tratamento
; ****************************************
	MOV R0, #200
	PUSH {LR}
	BL SysTick_Wait1ms
    POP {LR}
	
	BX LR
	
; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
