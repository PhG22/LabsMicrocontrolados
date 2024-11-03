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
offset    SPACE 0x400
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
;Função que cria um atraso de 0,5s entre o aperto do pushButton e seu tratamento
; ****************************************
	MOV R0, #200
	PUSH {LR}
	BL SysTick_Wait1ms
    POP {LR}
	
	BX LR
	
; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo
