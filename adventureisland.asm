;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Hudson's Adventure Island (U) Disassembly;
;                                         ;
;            By Yoshimaster96             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.include	"regs.asm"
.include	"vars.asm"

;;;;;;;;;;;;;
;INES HEADER;
;;;;;;;;;;;;;
.incbin		"header.bin"

;;;;;;;;;
;PRG ROM;
;;;;;;;;;
.include	"prg0.asm"

;;;;;;;;;
;CHR ROM;
;;;;;;;;;
.incbin		"chr0.bin"
.incbin		"chr1.bin"
.incbin		"chr2.bin"
.incbin		"chr3.bin"
