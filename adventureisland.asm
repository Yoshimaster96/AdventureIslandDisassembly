;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Hudson's Adventure Island (U) Disassembly;
;                                         ;
;            By Yoshimaster96             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;NES CPU Registers
SQ1_VOL		.equ $4000
SQ1_SWEEP	.equ $4001
SQ1_LO		.equ $4002
SQ1_HI		.equ $4003
SQ2_VOL		.equ $4004
SQ2_SWEEP	.equ $4005
SQ2_LO		.equ $4006
SQ2_HI		.equ $4007
TRI_LINEAR	.equ $4008
;Unused
TRI_LO		.equ $400A
TRI_HI		.equ $400B
NOISE_VOL	.equ $400C
;Unused
NOISE_LO	.equ $400E
NOISE_HI	.equ $400F
DMC_FREQ	.equ $4010
DMC_RAW		.equ $4011
DMC_START	.equ $4012
DMC_LEN		.equ $4013
OAM_DMA		.equ $4014
SND_CHN		.equ $4015
JOY1		.equ $4016
JOY2		.equ $4017
;NES PPU Registers
PPU_CTRL	.equ $2000
PPU_MASK	.equ $2001
PPU_STATUS	.equ $2002
OAM_ADDR	.equ $2003
OAM_DATA	.equ $2004
PPU_SCROLL	.equ $2005
PPU_ADDR	.equ $2006
PPU_DATA	.equ $2007
;NES Joypad Defines
BUTTON_A	.equ $80
BUTTON_B	.equ $40
BUTTON_SELECT	.equ $20
BUTTON_START	.equ $10
BUTTON_UP	.equ $08
BUTTON_DOWN	.equ $04
BUTTON_LEFT	.equ $02
BUTTON_RIGHT	.equ $01
;Game Variables
Mirror_PPUCtrl		.equ $04
Mirror_PPUMask		.equ $05
Mirror_PPUScrollX	.equ $06
Mirror_PPUScrollY	.equ $07
PadCur			.equ $08
SetCHRBankFlag		.equ $0A
GraphicsNMITaskFlag	.equ $0B
GlobalNMITaskFlag	.equ $0C
;UnkB_0D
;UnkB_0E
;UnkB_0F
;UnkB_10
;UnkB_11
ClearBridgeFlag		.equ $12
WritePaletteFlag	.equ $13
WriteNormScrollFlag	.equ $14
WriteSlopeScrollFlag	.equ $15
WriteNormAttrFlag	.equ $16
WriteSlopeAttrFlag	.equ $17
;UnkW_18
LevelDataPointer	.equ $1A
;UnkW_1C


AreaNum			.equ $37
RoundNum		.equ $38

DemoFlag		.equ $40
;UnkB_41
DemoCounter		.equ $42
DemoInput		.equ $43

LevelNum		.equ $51
LevelSet		.equ $52

TimerHi			.equ $76
TimerLo			.equ $77

SpriteDataPointer	.equ $82

DemoDataPointer		.equ $9C

MusicID			.equ $AB
SilenceAudioFlag	.equ $AC

PaletteVRAMBuffer	.equ $0140
SlopeScrollAttrBuffer	.equ $0160
SlopeScrollTileBuffer	.equ $01E0
;UnkBuf_03E0
;UnkBuf_0420

SlopeScrollVRAMBuffer	.equ $04B4
NormScrollVRAMBuffer	.equ $04D4
SlopeAttrVRAMBuffer	.equ $04F2
NormAttrVRAMBuffer	.equ $04FA

NormScrollVRAMDest	.equ $051A
SlopeScrollVRAMDestA	.equ $051C
SlopeScrollVRAMDestB	.equ $051E
SlopeScrollDir		.equ $0520
NormAttrVRAMDest	.equ $0521
SlopeAttrVRAMDestA	.equ $0523
SlopeAttrVRAMDestB	.equ $0525
SlopeAttrDir		.equ $0527

CurRoom			.equ $054C
CurScrollSlope		.equ $054D
CurBGSlope		.equ $054E
CurFloorOffs		.equ $054F
CurColiGeo		.equ $0550
CurFruitHeight		.equ $0551
CurSlipperyType		.equ $0552
Enemy_Status		.equ $0554
Enemy_ID		.equ $0564
Enemy_SubXPos		.equ $0574
Enemy_ScreenXPos	.equ $0584
Enemy_XVel		.equ $0594
;Enemy_Unk05A4
Enemy_SubYPos		.equ $05B4
Enemy_ScreenYPos	.equ $05C4
Enemy_YVel		.equ $05D4
Enemy_WorldXPos		.equ $05E4
Enemy_WorldYPos		.equ $05F4
Enemy_ColiWidth		.equ $0604
Enemy_ColiHeight	.equ $0614
;Enemy_Unk0624
;Enemy_Unk0634
Enemy_Sprite		.equ $0644
;Enemy_Unk0654
;Enemy_Unk0664
;Enemy_Unk0674


ColdBootStringRAM	.equ $0694
ScoreCurrent		.equ $069A
ScoreTop		.equ $06A3
ScoreRoundBonus		.equ $06AC
ScorePotBonus		.equ $06B5
OAMBuffer		.equ $0700
;Game Defines
ENEMY_FIRE		.equ $01
ENEMY_ROCK		.equ $02
ENEMY_SNAKE		.equ $03
ENEMY_STONE1		.equ $04
ENEMY_STONE2		.equ $05
ENEMY_PIG1		.equ $06
ENEMY_FROGL		.equ $07
ENEMY_FROGR		.equ $08
ENEMY_BIRD1		.equ $09
ENEMY_BIRD2		.equ $0A
ENEMY_BAT		.equ $0B
ENEMY_PIG2		.equ $0C
ENEMY_FROG2		.equ $0D
ENEMY_SNAIL		.equ $0E
ENEMY_SKULL		.equ $0F
ENEMY_BANANA		.equ $10
ENEMY_APPLE		.equ $11
ENEMY_PEACH		.equ $12
ENEMY_CARROT		.equ $13
ENEMY_PINEAPPLE		.equ $14
ENEMY_EGG1		.equ $17
ENEMY_ITEMHAMMER	.equ $18
ENEMY_EGG		.equ $19
ENEMY_EGGBEE		.equ $1A
ENEMY_EGGKEY		.equ $1B
ENEMY_EGG2		.equ $1C
ENEMY_EGGEGGPLANT	.equ $1D
ENEMY_FLOWER1		.equ $20
ENEMY_FLOWER2		.equ $22
ENEMY_FROGR_POT		.equ $22
ENEMY_SQUIDR1		.equ $23
ENEMY_LONGFISH		.equ $24
ENEMY_SQUIDR2		.equ $25
ENEMY_ICICLE1		.equ $26
ENEMY_ICICLE2		.equ $27
ENEMY_SQUIDB1		.equ $28
ENEMY_SQUIDB2		.equ $29
ENEMY_ITEMFIRE		.equ $2A
ENEMY_PLATBONUS		.equ $30
ENEMY_ROCK_POT		.equ $31
ENEMY_FIRE_POT		.equ $32
ENEMY_SNAIL_POT		.equ $33
ENEMY_PIG1_POT		.equ $34
ENEMY_SNAKE_POT		.equ $35
ENEMY_TRAMPOLINE1	.equ $36
ENEMY_TRAMPOLINE2	.equ $37
ENEMY_BEETLE		.equ $38
ENEMY_POT		.equ $39
ENEMY_PLAT1		.equ $3A
ENEMY_PLAT2		.equ $3B
ENEMY_PLAT3		.equ $3E
ENEMY_PLAT4		.equ $3F
ENEMY_PLAYER		.equ $40
ENEMY_SIGN		.equ $41
ENEMY_PROJHAMMER	.equ $42
ENEMY_BOSSBODY		.equ $43
ENEMY_PROJBOSSFIRE	.equ $44
;(is this used?)
ENEMY_BOSSHEAD		.equ $46
ENEMY_FAIRY		.equ $47

;;;;;;;;;
;PRG ROM;
;;;;;;;;;
Reset:
	sei					; Disable interrupts
	lda #$00				;\Clear some PPU registers
	sta PPU_MASK				;|
	sta PPU_CTRL				;/
Reset_WaitVBlank1:
	lda PPU_STATUS				;\Wait for VBlank
	bpl Reset_WaitVBlank1			;/
Reset_WaitVBlank2:
	lda PPU_STATUS				;\Wait for VBlank a second time
	bpl Reset_WaitVBlank2			;/
	cld					; Disable decimal mode
	ldx #$3F				;\Init stack pointer
	txs					;/(a bit small, but $0140-$01FF is used for variables)
	lda #$00				
	tay
Reset_ClearZP:
	sta $0000,y				;\Clear zero-page RAM
	iny					;|(why not use X register here and save a byte?)
	bne Reset_ClearZP			;/
	lda #$00				;\(this isn't necessary since A and Y are already 0 here)
	tay					;/
Reset_ClearRAM:
	sta $0200,y				;\Clear more RAM
	sta $0300,y				;|
	sta $0400,y				;|
	sta $0500,y				;|
	sta $0700,y				;|
	iny					;|
	bne Reset_ClearRAM			;/
	ldy #$40
Reset_ClearPage1:
	sta $0100,y				;\(why not include this in the loop above?)
	iny					;|(it's not like $0100-$013F can't be set to 0)
	bne Reset_ClearPage1			;/
Reset_ClearPage6:
	sta $0600,y				;\This does have a legit reason for being separate however,
	iny					;|as we don't want to overwrite the cold boot check values.
	cpy #<ColdBootCheckRAM			;|
	bne Reset_ClearPage6			;/
	ldx #$00				;\Set CHR bank to 0
	jsr SetCHRBank_Do			;/
	lda #$90
	sta Mirror_PPUCtrl
	sta PPU_CTRL
	jsr InitDemoDataPointer
	ldx #$00
	stx $053D
	stx $A0
	stx MusicID
	stx SilenceAudioFlag
	stx $41
	stx $0E
	stx $0F
	stx DemoFlag
	stx DemoInput
	inx
	stx DemoCounter
	jsr CheckColdBoot
CODE_8071:
	jsr CODE_ADD3
	lda $47
	bne CODE_807E
	lda #$00
	sta AreaNum
	sta RoundNum
CODE_807E:
	jsr CODE_8126
	lda #$00
	sta $39
	sta $3E
	lda #$03
	sta $3F
	lda DemoFlag
	bne CODE_809A
	ldy #$00
	jsr CODE_8977
	lda #$00
	sta $0529
CODE_809A:
	lda $39
	cmp #$04
	bcc CODE_80A2
	lda #$03
CODE_80A2:
	sta $39
	jsr CODE_AEB3
	lda #$00
	sta $49
	sta $4B
	sta $4C
	sta $4D
	sta $4A
	lda DemoFlag
	beq CODE_80BB
	lda #$01
	sta $6D
CODE_80BB:
	jsr CODE_C4EF
	jsr LoadLevel
	jsr CODE_8203
	lda #$00
	sta $44
	sta $45
	sta $78
	ldx #$0A
	jsr CODE_81BD
	jsr LoadLevelMusic
	jsr CODE_C4D4
CODE_80D7:
	jsr CODE_B755
	jsr CODE_8276
	jsr CODE_BCEE
	jsr CODE_8E64
	jsr CODE_C0B1
	jsr CODE_8E69
	jsr CODE_8BDD
	jsr CODE_8C45
	lda $4B
	bne CODE_810E
	lda $44
	bne CODE_8110
	lda $45
	bne CODE_8146
	lda DemoFlag
	beq CODE_8108
	lda $0F
	and #$30
	beq CODE_80D7
	jmp CODE_8071
CODE_8108:
	jsr CODE_81E3
	jmp CODE_80D7
CODE_810E:
	bne CODE_8172
CODE_8110:
	jsr CODE_81A2
	lda $49
	beq CODE_811C
	jsr CODE_AD9A
	inc $39
CODE_811C:
	dec $3F
	beq CODE_8135
	jsr CODE_8126
	jmp CODE_809A
CODE_8126:
	lda #$00
	sta $6D
	sta $6E
	sta $0534
	lda #$0C
	sta $0528
	rts
CODE_8135:
	lda DemoFlag
	bne CODE_8140
	jsr CODE_AFF2
	lda $47
	bne CODE_8143
CODE_8140:
	jmp CODE_8071
CODE_8143:
	jmp CODE_807E
CODE_8146:
	jsr CODE_81A2
	lda $49
	bne CODE_8190
	lda $46
	bne CODE_819C
	jsr CODE_AF16
	lda #$00
	sta $39
	sta $053E
	inc RoundNum
	lda RoundNum
	cmp #$04
	bcc CODE_816F
	lda #$00
	sta RoundNum
	inc AreaNum
	lda AreaNum
	and #$07
	sta AreaNum
CODE_816F:
	jmp CODE_809A
CODE_8172:
	jsr CODE_AD8D
	ldx AreaNum
	bne CODE_817D
	lda RoundNum
	beq CODE_817E
CODE_817D:
	inx
CODE_817E:
	inx
	stx $49
	lda #$02
	sta AreaNum
	lda #$00
	sta RoundNum
	lda #$02
	sta $39
	jmp CODE_80BB
CODE_8190:
	jsr CODE_AD9A
	inc $39
	lda #$00
	sta $49
	jmp CODE_80BB
CODE_819C:
	jsr CODE_B042
	jmp CODE_8071
CODE_81A2:
	ldx #$3C
	stx $10
CODE_81A6:
	jsr CODE_B755
	jsr CODE_8E64
	jsr CODE_BCEE
	jsr CODE_8EC9
	dec $10
	bne CODE_81A6
	lda #$00
	sta $A0
	jmp CODE_B755
CODE_81BD:
	stx $10
CODE_81BF:
	jsr CODE_B755
	dec $10
	bne CODE_81BF
	rts
LoadLevelMusic:
	lda $49
	beq LoadLevelMusic_SkipBonus
	lda #$07
	bne LoadLevelMusic_Bonus
LoadLevelMusic_SkipBonus:
	ldy LevelSet
	lda LevelSet_MusicIDTable,y
LoadLevelMusic_Bonus:
	sta MusicID
	rts
LevelSet_MusicIDTable:
	.db $02,$02,$03,$04,$04,$05,$05,$05,$05,$05,$06,$07
CODE_81E3:
	lda $0F
	and #$10
	beq CODE_8202
	ldx #$01
	stx SilenceAudioFlag
	stx $41
	lda #$11
	sta $A0
CODE_81F3:
	jsr CODE_B755
	lda $0F
	and #$10
	beq CODE_81F3
	lda #$00
	sta SilenceAudioFlag
CODE_8202:
	rts




































































CODE_AEF0:
	lda #$00
	sta $59
	ldx #$01
CODE_AEF6:
	jsr CODE_AEFF
CODE_AEFD:
	ldx #$02
CODE_AEFF:
	lda DATA_B1CB,x
	sta $5A
	lda DATA_B1CE,x
	sta $5D
	ldy DATA_B1D1,x
	lda $00,y
	clc
	adc DATA_B1D4,x
	jmp CODE_C301








DrawImage:
	lda DrawImageNumSections,x
	sta $00
	lda DrawImageSourceLo,x
	sta $02
	lda DrawImageSourceHi,x
	sta $03
	lda DrawImageStartSection,x
	tax
	ldy #$00
DrawImage_StartSection:
	lda DrawImageVRAMDestHi,x
	sta PPU_ADDR
	lda DrawImageVRAMDestLo,x
	sta PPU_ADDR
	lda DrawImageSectionSize,x
	sta $01
DrawImage_LoopSection:
	lda ($02),y
	sta PPU_DATA
	iny
	bne DrawImage_SkipCarry
	inc $03
DrawImage_SkipCarry:
	dec $01
	bne DrawImage_LoopSection
	inx
	dec $00
	bne DrawImage_StartSection
	rts
FillVRAM:
	sta PPU_DATA
	dex
	bne FillVRAM
	dey
	bne FillVRAM
	rts
DATA_B1CB:
	.db $90,$90,$90
DATA_B1CE:
	.db $4F,$67,$97
DATA_B1D1:
	.db $37,$38,$3F
DATA_B1D4:
	.db $0F,$0F,$0E
DrawImageSourceLo:
	.db <ImageSection00_Data
	.db <ImageSection0D_Data
	.db <ImageSection0E_Data
	.db <ImageSection11_Data
	.db <ImageSection13_Data
DrawImageSourceHi:
	.db >ImageSection00_Data
	.db >ImageSection0D_Data
	.db >ImageSection0E_Data
	.db >ImageSection11_Data
	.db >ImageSection13_Data
DrawImageStartSection:
	.db $00,$0D,$0E,$11,$13
DrawImageNumSections:
	.db $0D,$03,$03,$02,$03
DrawImageSectionSize:
	.db $16,$19,$19,$18,$16,$16,$16,$16,$03,$0A,$19,$0B,$18
	.db $09
	.db $04,$05,$01
	.db $0B,$0B
	.db $10,$0E,$11
DrawImageVRAMDestHi:
	.db $20,$20,$20,$20,$21,$21,$21,$21,$22,$22,$22,$23,$23
	.db $22
	.db $21,$21,$22
	.db $21,$22
	.db $20,$21,$21
DrawImageVRAMDestLo:
	.db $85,$A5,$C4,$E5,$07,$27,$47,$67,$0A,$6B,$E3,$2A,$64
	.db $4A
	.db $4B,$AB,$6F
	.db $4A,$2A
	.db $A8,$09,$48
ImageSection00_Data:
	.db $E8,$F5,$E4,$F3,$EF,$EE,$BF,$F3,$06,$07,$20,$21,$23,$24,$25,$26
	.db $27,$40,$41,$42,$02,$03
ImageSection01_Data:
	.db $8E,$8A,$8F,$8E,$8A,$8F,$FF,$FF,$16,$17,$30,$31,$32,$33,$34,$35
	.db $43,$44,$45,$50,$12,$13,$FF,$F4,$ED
ImageSection02_Data:
	.db $8E,$8A,$8B,$A9,$AB,$70,$60,$60,$53,$52,$53,$FF,$FF,$FF,$52,$53
	.db $FF,$52,$53,$52,$53,$52,$60,$60,$4C
ImageSection03_Data:
	.db $8E,$8A,$6A,$5F,$71,$4D,$4E,$65,$62,$63,$FF,$FF,$FF,$72,$73,$FF
	.db $62,$73,$62,$63,$62,$4D,$BE,$61
ImageSection04_Data:
	.db $72,$73,$75,$6E,$6F,$FF,$72,$73,$FF,$FF,$88,$9E,$9F,$99,$72,$BA
	.db $BB,$73,$72,$73,$CE,$61
ImageSection05_Data:
	.db $54,$55,$9B,$7E,$7F,$4C,$54,$55,$FF,$FF,$72,$AE,$AF,$73,$54,$5E
	.db $4F,$55,$54,$55,$CE,$61
ImageSection06_Data:
	.db $62,$63,$52,$AA,$5D,$61,$62,$5C,$76,$6C,$D0,$D1,$D3,$B8,$62,$63
	.db $54,$63,$62,$5C,$5D,$61
ImageSection07_Data:
	.db $64,$65,$64,$51,$51,$74,$64,$51,$51,$65,$D2,$FF,$FF,$B9,$64,$65
	.db $64,$65,$64,$51,$51,$74
ImageSection08_Data:
	.db $F4,$EF,$F0
ImageSection09_Data:
	.db $F0,$F5,$F3,$E8,$FF,$F3,$F4,$E1,$F2,$F4
ImageSection0A_Data:
	.db $F4,$ED,$FF,$E1,$EE,$E4,$FF,$CF,$FF,$DE,$DF,$FD,$FE,$FF,$E8,$F5
	.db $E4,$F3,$EF,$EE,$FF,$F3,$EF,$E6,$F4
ImageSection0B_Data:
	.db $EC,$E9,$E3,$E5,$EE,$F3,$E5,$E4,$FF,$E2,$F9
ImageSection0C_Data:
	.db $EE,$E9,$EE,$F4,$E5,$EE,$E4,$EF,$FF,$EF,$E6,$FF,$E1,$ED,$E5,$F2
	.db $E9,$E3,$E1,$FF,$E9,$EE,$E3,$69
ImageSection0D_Data:
	.db $E7,$E1,$ED,$E5,$FF,$EF,$F6,$E5,$F2
ImageSection0E_Data:
	.db $E1,$F2,$E5,$E1
ImageSection0F_Data:
	.db $F2,$EF,$F5,$EE,$E4
ImageSection10_Data:
	.db $F8
ImageSection11_Data:
	.db $F2,$EF,$F5,$EE,$E4,$FF,$E2,$EF,$EE,$F5,$F3
ImageSection12_Data:
	.db $F0,$EF,$F4,$FF,$FF,$FF,$E2,$EF,$EE,$F5,$F3
ImageSection13_Data:
	.db $E3,$EF,$EE,$E7,$F2,$E1,$F4,$F5,$EC,$E1,$F4,$E9,$EF,$EE,$F3,$C8
ImageSection14_Data:
	.db $F9,$EF,$F5,$FF,$E8,$E1,$F6,$E5,$FF,$F3,$E1,$F6,$E5,$E4
ImageSection15_Data:
	.db $F9,$EF,$F5,$F2,$FF,$EC,$EF,$F6,$E5,$EC,$F9,$FF,$F4,$E9,$EE,$E1
	.db $69









NMI:
	pha
	lda GlobalNMITaskFlag
	bne NMI_NoTasks
	lda #$01
	sta GlobalNMITaskFlag
	txa
	pha
	tya
	pha
	lda GraphicsNMITaskFlag
	beq NMI_NoGfxTasks
	lda #$00				;\DMA OAM
	sta PPU_OAM_ADDR			;|
	lda #$07				;|
	sta OAM_DMA				;/
	jsr WriteSlopeScroll			;\Do various graphics tasks
	jsr WritePalette			;/
	lda #$00				;\Reset PPU address
	sta PPU_ADDR				;|
	sta PPU_ADDR				;/
	lda Mirror_PPUCtrl			;\Write PPU registers
	sta PPU_CTRL				;|
	lda Mirror_PPUMask			;|
	sta PPU_MASK				;|
	lda Mirror_PPUScrollX			;|
	sta PPU_SCROLL				;|
	lda Mirror_PPUScrollY			;|
	sta PPU_SCROLL				;/
NMI_NoGfxTasks:
	jsr HandleSoundEffects			;\Handle audio
	jsr HandleMusic				;/
	pla
	tay
	pla
	tax
	lda #$00
	sta GraphicsNMITaskFlag
	sta GlobalNMITaskFlag
NMI_NoTasks:
	pla
IRQ:
	rti
CODE_B755:
	lda #$FF
	sta GraphicsNMITaskFlag
CODE_B759:
	lda GraphicsNMITaskFlag
	bne CODE_B759
	jsr CODE_C2C2
	jsr CODE_C506
	jsr LoadDemoInput
	jsr CODE_B782
	lda $0D
	beq CODE_B771
	lda #$10
	sta $A0
CODE_B771:
	inc $66
	lda $66
	cmp #$10
	bcc CODE_B77D
	lda #$00
	sta $66
CODE_B77D:
	lda #$00
	sta $0D
	rts
CODE_B782:
	lda #$10
	jsr CODE_B789
	lda #$20
CODE_B789:
	sta $00
	and PadCur
	beq CODE_B7A3
	lda $0E
	and $00
	beq CODE_B7A9
	lda $00
	eor #$FF
	and $0E
	sta $0E
	lda $0F
	ora $00
	bne CODE_B7AF
CODE_B7A3:
	lda $00
	ora $0E
	sta $0E
CODE_B7A9:
	lda $00
	eor #$FF
	and $0F
CODE_B7AF:
	sta $0F
	rts
LoadDemoInput:
	lda DemoFlag
	beq LoadDemoInput_Return
	lda DemoInput
	and #$3F
	sta DemoInput
	dec DemoCounter
	bne LoadDemoInput_Return
	ldy #$00
	lda (DemoDataPointer),y
	and #$C0
	ora #$01
	sta DemoInput
	lda (DemoDataPointer),y
	lsr
	lsr
	lsr
	eor (DemoDataPointer),y
	and #$07
	tax
	inx
	stx DemoCounter
	inc DemoDataPointer
	bne LoadDemoInput_Return
	inc DemoDataPointer+1
	bne LoadDemoInput_Return
InitDemoDataPointer:
	lda #$4B
	sta DemoDataPointer
	lda #$D9
	sta DemoDataPointer+1
LoadDemoInput_Return:
	rts
GetPlayerInput:
	lda DemoFlag
	beq GetPlayerInput_NotDemo
	lda DemoInput
	rts
GetPlayerInput_NotDemo:
	lda PadCur
	rts
WritePalette:
	lda WritePaletteFlag			;\Check to see if we need to write palette data
	beq WritePalette_Skip			;/If not, skip this
	lda #$3F				;\Setup PPU address for writing palette
	sta PPU_ADDR				;|
	lda #$00				;|
	sta PPU_ADDR				;/
	ldx #$00
	ldy #$00
WritePalette_Loop:
	lda PaletteVRAMBuffer,y			;\Copy palette over to PPU
	sta PPU_DATA				;|
	iny					;|
	dex					;|
	bne WritePalette_Loop			;/
	stx WritePaletteFlag			; Clear palette write flag
WritePalette_Skip:
SetCHRBank:
	lda SetCHRBankFlag			;\Check to see if we need to set the CHR bank
	bpl SetCHRBank_Skip			;/If not, skip
	and #$03
	tax
SetCHRBank_Do:
	lda BankSelectValueTable,x		;\Set CHR bank
	sta BankSelectValueTable,x		;|
	lda #$00				;|
	sta SetCHRBankFlag			;/
SetCHRBank_Skip:
ClearBridge:
	lda ClearBridgeFlag			;\Check to see if we need to clear the bridge
	beq ClearBridge_Skip			;/If not, skip
	lda #$22				;\Setup PPU address for clearing bridge
	sta PPU_ADDR				;|(first row of tiles)
	lda #$88				;|
	sta PPU_ADDR				;/
	ldx #$F8
ClearBridge_Row1Loop:
	lda (ClearBridgeTileData-$F8),x		;\Clear bridge tiles
	sta PPU_DATA				;|(first row of tiles)
	inx					;|
	bne ClearBridge_Row1Loop		;/
	lda #$22				;\Setup PPU address for clearing bridge
	sta PPU_ADDR				;|(second row of tiles)
	lda #$A8				;|
	sta PPU_ADDR				;/
	ldx #$F8
ClearBridge_Row2Loop:
	lda (ClearBridgeTileData+1-$F8),x	;\Clear bridge tiles
	sta PPU_DATA				;|(second row of tiles)
	inx					;|
	bne ClearBridge_Row2Loop		;/
	lda #$23				;\Setup PPU address for clearing bridge
	sta PPU_ADDR				;|(attributes)
	lda #$EA				;|
	sta PPU_ADDR				;/
	ldx #$FF				;\Clear bridge tiles
	stx PPU_DATA				;|(attributes)
	stx PPU_DATA				;/
	inx
	stx ClearBridgeFlag
ClearBridge_Skip:
	rts
BankSelectValueTable:
	.db $30,$31,$32,$33
ClearBridgeTileData:
	.db $04,$05,$04,$05,$04,$05,$04,$05,$04
WriteSlopeScroll:
	ldy WriteSlopeScrollFlag
	beq WriteSlopeScroll_Skip
	ldy #$E0
	ldx VRAMHorizPartialFlag
	beq WriteSlopeScroll_DestBOnly
	lda SlopeScrollVRAMDestA
	sta PPU_ADDR
	lda SlopeScrollVRAMDestA+1
	sta PPU_ADDR
WriteSlopeScroll_LoopA:
	lda (SlopeScrollVRAMBuffer-$E0),y
	sta PPU_DATA
	iny
	dex
	bne WriteSlopeScroll_LoopA
WriteSlopeScroll_DestBOnly:
	lda SlopeScrollVRAMDestB
	sta PPU_ADDR
	lda SlopeScrollVRAMDestB+1
	sta PPU_ADDR
WriteSlopeScroll_LoopB:
	lda (SlopeScrollVRAMBuffer-$E0),y
	sta PPU_DATA
	iny
	bne WriteSlopeScroll_LoopB
	sty WriteSlopeScrollFlag
WriteSlopeScroll_Skip:
WriteNormScroll:
	lda WriteNormScrollFlag
	beq WriteNormScroll_Skip
	lda Mirror_PPUCtrl
	ora #$04
	sta PPU_CTRL
	lda NormScrollVRAMDest
	sta PPU_ADDR
	lda NormScrollVRAMDest
	sta PPU_ADDR
	ldx #$E2
WriteNormScroll_Loop:
	lda (NormScrollVRAMBuffer-$E2),x
	sta PPU_DATA
	inx
	bne WriteNormScroll_Loop
	stx WriteNormScrollFlag
	lda Mirror_PPUCtrl
	sta PPU_CTRL
WriteNormScroll_Skip:
WriteSlopeAttr:
	lda SlopeAttrFlag
	beq WriteSlopeAttr_Skip
	ldy #$F8
	ldx SlopeAttrDir
	beq WriteSlopeAttr_DestBOnly
	lda SlopeAttrVRAMDestA
	sta PPU_ADDR
	lda SlopeAttrVRAMDestA+1
	sta PPU_ADDR
WriteSlopeAttr_LoopA:
	lda (SlopeAttrVRAMBuffer-$F8),y
	sta PPU_DATA
	iny
	dex
	bne WriteSlopeAttr_LoopA
WriteSlopeAttr_DestBOnly:
	lda SlopeAttrVRAMDestB
	sta PPU_ADDR
	lda SlopeAttrVRAMDestB+1
	sta PPU_ADDR
WriteSlopeAttr_LoopB:
	lda (SlopeAttrVRAMBuffer-$F8),y
	sta PPU_DATA
	iny
	bne WriteSlopeAttr_LoopB
	sty WriteSlopeAttrFlag
WriteSlopeAttr_Skip:
WriteNormAttr:
	lda WriteNormAttrFlag
	beq WriteNormAttr_Skip
	ldy #$F8
	lda NormAttrVRAMDest+1
WriteNormAttr_Loop:
	ldx NormAttrVRAMDest
	stx PPU_ADDR
	sta PPU_ADDR
	ldx (NormAttrVRAMBuffer-$F8),y
	stx PPU_DATA
	clc
	adc #$08
	iny
	bne WriteNormAttr_Loop
	sty WriteNormAttrFlag
WriteNormAttr_Skip:
	rts









LevelSetTable:
	.db $00,$03,$05,$02			;Area 1
	.db $04,$06,$07,$02			;Area 2
	.db $08,$01,$03,$02			;Area 3
	.db $00,$0A,$09,$02			;Area 4
	.db $04,$07,$08,$02			;Area 5
	.db $03,$05,$0A,$02			;Area 6
	.db $09,$04,$07,$02			;Area 7
	.db $0A,$03,$08,$02			;Area 8
	
	
GraphicsSetDataOffsetTable:
	.dw $E237,$E26A,$E2E1,$E2A0,GraphicsSet1BlockTiles,GraphicsSet1BlockPalettes
	.dw $EBFB,$ECDA,$EC2E,$EC94,GraphicsSet2BlockTiles,GraphicsSet2BlockPalettes
	.dw $E7D7,$E8FC,$E89C,$E85B,GraphicsSet3BlockTiles,GraphicsSet3BlockPalettes
LevelDataOffsetTable:
	.dw LevelSet0_Level
	.dw LevelSet1_Level
	.dw LevelSet2_Level
	.dw LevelSet3_Level
	.dw LevelSet4_Level
	.dw LevelSet5_Level
	.dw LevelSet6_Level
	.dw LevelSet7_Level
	.dw LevelSet8_Level
	.dw LevelSet9_Level
	.dw LevelSetA_Level
	.dw LevelSetB_Level
LevelSetBoundsOffsetTable:
	.dw LevelSetBoundsTable+$00
	.dw LevelSetBoundsTable+$04
	.dw LevelSetBoundsTable+$00
	.dw LevelSetBoundsTable+$08
	.dw LevelSetBoundsTable+$09
	.dw LevelSetBoundsTable+$0D
	.dw LevelSetBoundsTable+$11
	.dw LevelSetBoundsTable+$15
	.dw LevelSetBoundsTable+$19
	.dw LevelSetBoundsTable+$1D
	.dw LevelSetBoundsTable+$21
	.dw LevelSetBoundsTable+$04
LevelSetBoundsTable:
	.db $69,$69,$69,$69			;$00
	.db $5B,$77,$77,$3F			;$04
	.db $40,$48,$48,$48,$48			;$08
	.db $3E,$3E,$5A,$3E			;$0D
	.db $4C,$4C,$64,$6C			;$11
	.db $4C,$4C,$68,$A4			;$15
	.db $68,$68,$84,$64			;$19
	.db $4C,$48,$4C,$48			;$1D
	.db $68,$64,$64,$6C			;$21
;LEVEL DATA
;Each room (256px wide section of level) consists of 3 bytes,
;the format is as follows:
;rrrrrrss bbboooii ffffgggg
;r: Room ID/swatch
;s: Scroll slope
;b: BG slope
;o: Floor offset
;i: Slippery type
;f: Fruit height
;g: Collision geometry
LevelSet0_Level:
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$04,$00,$00,$08,$00,$00
	.db $08,$00,$00,$08,$00,$00,$0C,$00,$00,$10,$00,$00
	.db $0C,$00,$00,$14,$00,$00,$18,$20,$02,$19,$24,$02
	.db $19,$24,$02,$19,$24,$02,$19,$24,$02,$19,$24,$02
	.db $19,$24,$02,$09,$04,$00,$08,$00,$00,$08,$00,$00
	.db $08,$00,$00,$08,$00,$00,$1C,$00,$07,$08,$00,$00
	.db $08,$00,$00,$20,$00,$0B,$08,$00,$00,$08,$00,$00
	.db $24,$00,$09,$2C,$00,$0A,$08,$00,$00,$24,$00,$09
	.db $28,$00,$01,$28,$00,$01,$2C,$00,$0A,$08,$00,$00
LevelSet1_Level:
	.db $08,$00,$00,$08,$00,$00,$18,$20,$02,$19,$24,$02
	.db $09,$04,$00,$08,$00,$00,$18,$20,$02,$09,$04,$00
	.db $18,$20,$02,$19,$24,$02,$19,$24,$02,$09,$04,$00
	.db $30,$40,$03,$0A,$08,$00,$18,$20,$02,$19,$24,$02
	.db $19,$24,$02,$19,$24,$02,$19,$24,$02,$19,$24,$02
	.db $19,$24,$02,$19,$24,$02,$30,$44,$03,$32,$48,$03
	.db $32,$48,$03,$32,$48,$03,$18,$28,$02,$19,$24,$02
	.db $19,$24,$02,$19,$24,$02,$19,$24,$02,$09,$04,$00
	.db $08,$00,$00,$08,$00,$00,$30,$40,$03,$32,$48,$03
	.db $1A,$28,$02,$19,$24,$02,$30,$44,$03,$32,$48,$03
	.db $08,$08,$00,$08,$00,$00,$30,$40,$03,$32,$48,$03
	.db $32,$48,$03,$32,$48,$03,$32,$48,$03,$32,$48,$03
	.db $32,$48,$03,$32,$48,$03,$32,$48,$03,$32,$48,$03
	.db $1A,$28,$02,$19,$24,$02,$30,$44,$03,$32,$48,$03
	.db $32,$48,$03,$32,$48,$03,$32,$48,$03,$32,$48,$03
	.db $32,$48,$03,$32,$48,$03,$32,$48,$03,$08,$08,$00
LevelSet2_Level:
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$34,$00,$00,$34,$00,$00
	.db $34,$00,$00,$34,$00,$00,$04,$00,$00,$08,$00,$00
	.db $08,$00,$00,$08,$00,$00,$08,$00,$00,$08,$00,$00
	.db $08,$00,$00,$08,$00,$00,$18,$20,$02,$18,$24,$02
	.db $08,$04,$00,$30,$40,$03,$08,$08,$00,$08,$00,$00
	.db $18,$20,$02,$30,$44,$03,$30,$48,$03,$38,$08,$0C
	.db $28,$14,$01,$28,$00,$01
LevelSetB_Level:
	.db $3C,$00,$00,$3C,$00,$00,$40,$00,$00,$3C,$AC,$00
LevelSet3_Level:
	.db $00,$00,$00,$04,$10,$01,$08,$00,$00,$04,$00,$01
	.db $0C,$00,$01,$04,$00,$01,$0C,$00,$21,$04,$00,$11
	.db $0C,$00,$11,$10,$00,$00,$14,$00,$00,$04,$00,$01
	.db $0C,$00,$01,$04,$00,$01,$0C,$00,$21,$18,$00,$0D
	.db $14,$00,$00,$0C,$00,$11,$04,$00,$01,$0C,$00,$11
	.db $04,$00,$11,$0C,$00,$11,$04,$00,$11,$0C,$00,$11
	.db $04,$00,$41,$0C,$00,$31,$04,$00,$01,$0C,$00,$21
	.db $04,$00,$11,$18,$00,$0D,$1C,$00,$00,$20,$00,$00
	.db $1C,$00,$00,$14,$00,$00,$0C,$00,$21,$10,$00,$00
	.db $1C,$00,$00,$1C,$00,$00,$1C,$00,$00,$20,$00,$00
	.db $20,$00,$00,$14,$00,$00,$04,$00,$01,$0C,$00,$01
	.db $04,$00,$11,$40,$00,$41,$04,$00,$41,$10,$00,$00
	.db $20,$00,$00,$14,$00,$00,$04,$00,$01,$0C,$00,$21
	.db $04,$00,$21,$0C,$00,$F1,$04,$00,$F1,$0C,$00,$21
	.db $04,$00,$31,$0C,$00,$31,$04,$00,$31,$0C,$00,$01
	.db $04,$00,$21,$0C,$00,$01,$10,$00,$00,$24,$00,$00
LevelSet4_Level:
	.db $20,$00,$00,$1C,$00,$00,$1C,$00,$00,$1C,$00,$00
	.db $1C,$00,$00,$1C,$00,$00,$1C,$00,$00,$14,$00,$00
	.db $04,$00,$11,$0C,$00,$21,$04,$00,$01,$0C,$00,$01
	.db $04,$00,$01,$18,$00,$3D,$1C,$00,$00,$1C,$00,$00
	.db $1C,$00,$00,$14,$00,$00,$04,$00,$41,$0C,$00,$D1
	.db $04,$00,$01,$0C,$00,$01,$10,$00,$00,$1C,$00,$00
	.db $1C,$00,$00,$1C,$00,$00,$1C,$00,$00,$1C,$00,$00
	.db $1C,$00,$00,$1C,$00,$00,$1C,$00,$00,$1C,$00,$00
	.db $1C,$00,$00,$1C,$00,$00,$14,$00,$40,$0C,$00,$51
	.db $08,$00,$00,$0C,$00,$11,$08,$00,$C0,$0C,$00,$01
	.db $18,$00,$0D,$14,$00,$00,$04,$00,$01,$0C,$00,$01
	.db $08,$00,$10,$0C,$00,$01,$04,$00,$11,$10,$00,$00
	.db $14,$00,$00,$0C,$00,$01,$04,$00,$21,$0C,$00,$01
	.db $04,$00,$01,$0C,$00,$01,$04,$00,$31,$0C,$00,$21
	.db $04,$00,$01,$0C,$00,$01,$04,$00,$01,$0C,$00,$C1
	.db $04,$00,$01,$18,$00,$0D,$1C,$00,$00,$24,$00,$00
LevelSetA_Level:
	.db $28,$00,$00,$2C,$00,$00,$28,$64,$00,$2D,$64,$00
	.db $29,$88,$00,$2C,$00,$00,$28,$64,$00,$2D,$64,$00
	.db $29,$64,$00,$35,$A4,$04,$29,$6C,$00,$2D,$00,$00
	.db $31,$A4,$04,$2D,$04,$00,$29,$64,$00,$2D,$64,$00
	.db $28,$00,$00,$2C,$00,$00,$31,$A4,$04,$2D,$6C,$00
	.db $29,$64,$00,$2D,$00,$00,$29,$64,$00,$2C,$64,$00
	.db $38,$88,$05,$3A,$D0,$05,$2A,$88,$00,$2E,$00,$00
	.db $2A,$00,$00,$38,$88,$05,$34,$08,$04,$2D,$6C,$00
	.db $28,$00,$00,$2C,$00,$00,$28,$64,$00,$38,$88,$05
	.db $2A,$88,$00,$36,$90,$04,$32,$88,$04,$34,$00,$04
	.db $32,$88,$04,$3A,$80,$05,$38,$00,$05,$2E,$88,$00
	.db $3A,$88,$05,$36,$90,$04,$2A,$80,$00,$2E,$88,$00
	.db $28,$00,$00,$34,$08,$04,$30,$00,$04,$36,$88,$04
	.db $32,$00,$04,$34,$88,$04,$32,$88,$04,$36,$88,$04
	.db $2A,$80,$00,$2C,$88,$00,$30,$A4,$04,$3C,$80,$05
	.db $2A,$D0,$00,$2C,$64,$00,$28,$00,$00,$2C,$00,$00
LevelSet5_Level:
	.db $00,$00,$00,$00,$00,$D0,$00,$00,$00,$00,$00,$00
	.db $00,$00,$D0,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$30,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$D0,$00,$00,$00,$00,$00,$00
	.db $02,$00,$00,$00,$00,$00,$00,$00,$00,$04,$00,$00
	.db $08,$00,$21,$0C,$AC,$00,$0C,$88,$00,$0C,$88,$00
	.db $0C,$00,$00,$10,$00,$11,$14,$01,$00,$14,$01,$00
	.db $18,$01,$00,$18,$01,$00,$18,$65,$00,$18,$01,$00
	.db $18,$D1,$00,$18,$01,$00,$18,$01,$00,$18,$01,$00
	.db $1C,$01,$00,$20,$01,$00,$1C,$01,$00,$24,$01,$00
	.db $20,$01,$00,$18,$01,$00,$18,$01,$00,$1C,$01,$00
	.db $18,$01,$00,$20,$65,$00,$1D,$65,$00,$21,$65,$00
	.db $15,$65,$00,$14,$65,$E0,$10,$00,$01,$0C,$64,$00
	.db $28,$D0,$01,$6C,$00,$00,$00,$00,$00,$01,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
LevelSet6_Level:
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$D0,$00,$00,$00,$00,$00,$00,$00,$00,$D0
	.db $00,$00,$00,$00,$00,$D0,$02,$00,$D0,$02,$00,$00
	.db $00,$00,$00,$01,$00,$00,$01,$00,$D0,$00,$00,$00
	.db $00,$00,$00,$06,$00,$00,$08,$00,$01,$0C,$AC,$00
	.db $0C,$88,$00,$0C,$88,$00,$0C,$00,$00,$5C,$64,$00
	.db $60,$00,$00,$0C,$D0,$00,$40,$00,$00,$58,$AC,$00
	.db $40,$88,$00,$40,$88,$00,$58,$64,$00,$59,$64,$00
	.db $40,$00,$00,$59,$64,$00,$41,$00,$00,$58,$64,$00
	.db $59,$64,$00,$58,$64,$00,$45,$6C,$01,$49,$60,$0D
	.db $40,$00,$00,$40,$88,$00,$40,$00,$00,$45,$64,$01
	.db $40,$64,$00,$40,$00,$00,$40,$88,$00,$42,$88,$00
	.db $40,$88,$00,$42,$88,$00,$46,$88,$01,$40,$88,$00
	.db $42,$00,$00,$60,$00,$00,$0E,$D0,$00,$5E,$64,$00
	.db $0C,$00,$00,$5C,$64,$00,$0C,$00,$00,$28,$D0,$01
	.db $6C,$00,$00,$02,$00,$00,$00,$00,$00,$00,$00,$00
LevelSet7_Level:
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$64,$00,$0E
	.db $00,$00,$00,$04,$00,$00,$AC,$00,$01,$68,$00,$00
	.db $AC,$00,$01,$6C,$00,$00,$04,$00,$00,$AC,$00,$01
	.db $6C,$00,$00,$64,$00,$0E,$64,$00,$0E,$00,$00,$00
	.db $00,$00,$00,$04,$00,$00,$0A,$00,$01,$A4,$AC,$00
	.db $A8,$00,$00,$78,$00,$00,$7D,$08,$01,$80,$80,$00
	.db $84,$08,$01,$8A,$80,$00,$74,$00,$00,$74,$00,$00
	.db $8C,$00,$00,$74,$00,$00,$74,$00,$00,$8C,$00,$00
	.db $74,$00,$00,$78,$00,$00,$7E,$88,$11,$82,$00,$00
	.db $84,$88,$01,$8A,$00,$00,$90,$00,$0E,$90,$00,$1E
	.db $94,$00,$00,$84,$88,$01,$82,$88,$00,$7E,$08,$01
	.db $86,$88,$01,$86,$88,$01,$7E,$00,$01,$70,$80,$00
	.db $74,$00,$00,$98,$00,$0E,$78,$00,$00,$84,$88,$01
	.db $7E,$88,$01,$86,$88,$01,$86,$88,$01,$7E,$88,$11
	.db $72,$88,$00,$78,$00,$00,$7C,$00,$01,$86,$88,$01
	.db $84,$00,$01,$7E,$88,$01,$9C,$00,$00,$A0,$00,$00
LevelSet8_Level:
	.db $40,$00,$00,$40,$00,$00,$40,$00,$00,$40,$00,$00
	.db $40,$00,$00,$40,$00,$00,$44,$00,$01,$48,$00,$0D
	.db $40,$00,$00,$42,$88,$00,$40,$88,$00,$40,$00,$00
	.db $40,$00,$20,$4C,$B8,$00,$40,$90,$00,$41,$00,$00
	.db $40,$00,$00,$48,$00,$0D,$44,$64,$11,$48,$64,$0D
	.db $40,$00,$00,$40,$88,$00,$42,$88,$00,$42,$88,$00
	.db $42,$88,$00,$52,$00,$00,$56,$1C,$00,$58,$18,$00
	.db $44,$08,$C1,$44,$00,$E1,$48,$80,$0D,$40,$00,$00
	.db $40,$00,$00,$41,$00,$00,$44,$60,$01,$44,$04,$E1
	.db $45,$00,$11,$44,$00,$01,$44,$60,$01,$45,$64,$11
	.db $45,$64,$01,$45,$64,$01,$45,$64,$11,$45,$04,$E1
	.db $44,$00,$D1,$44,$00,$01,$41,$64,$F0,$58,$64,$F0
	.db $40,$00,$00,$41,$00,$F0,$59,$64,$F0,$59,$64,$00
	.db $58,$64,$00,$44,$00,$01,$45,$60,$01,$45,$64,$01
	.db $45,$64,$D1,$45,$64,$D1,$44,$00,$01,$44,$00,$01
	.db $45,$60,$01,$48,$84,$0D,$40,$00,$00,$40,$00,$00
LevelSet9_Level:
	.db $1C,$01,$00,$18,$01,$00,$24,$01,$00,$18,$01,$00
	.db $24,$01,$00,$18,$01,$00,$24,$01,$00,$18,$01,$00
	.db $24,$01,$00,$18,$01,$00,$18,$65,$00,$20,$01,$00
	.db $18,$89,$00,$20,$65,$00,$18,$89,$00,$20,$65,$00
	.db $18,$01,$00,$20,$01,$00,$1C,$89,$00,$1C,$01,$00
	.db $1C,$01,$00,$1C,$01,$00,$30,$01,$0D,$1C,$01,$00
	.db $30,$01,$0D,$20,$65,$00,$34,$89,$0F,$24,$01,$00
	.db $34,$01,$0F,$20,$65,$00,$30,$89,$0D,$1C,$01,$00
	.db $20,$01,$00,$20,$65,$00,$21,$65,$00,$21,$65,$00
	.db $38,$01,$01,$38,$01,$01,$39,$01,$01,$30,$01,$0D
	.db $20,$65,$00,$30,$89,$0D,$30,$01,$0D,$30,$01,$0D
	.db $30,$01,$0D,$38,$01,$01,$1C,$01,$00,$20,$65,$00
	.db $20,$01,$00,$20,$01,$00,$20,$89,$00,$22,$89,$00
	.db $22,$89,$00,$22,$89,$00,$22,$65,$00,$20,$65,$00
	.db $21,$65,$00,$3D,$89,$0D,$30,$89,$0D,$30,$89,$0D
	.db $3A,$01,$01,$38,$01,$01,$38,$01,$01,$24,$01,$00



GraphicsSet1BlockTiles:
	.db $0F,$0F,$0F,$0F,$6E,$6F,$0F,$0F,$7E,$7F,$0F,$0F,$0F,$0F,$0F,$0F
	.db $0F,$0F,$2E,$2F,$0F,$0F,$3E,$3F,$0F,$0F,$4E,$4F,$5C,$5D,$5E,$5F
	.db $0F,$07,$01,$02,$0F,$17,$18,$12,$DB,$DB,$28,$12,$DB,$DB,$38,$32
	.db $DB,$26,$48,$42,$26,$0F,$51,$52,$0F,$0F,$51,$52,$0F,$0F,$61,$62
	.db $0F,$0F,$61,$62,$0F,$0F,$61,$62,$0F,$0F,$71,$72,$0F,$0F,$0F,$0F
	.db $0F,$0F,$0F,$0F,$80,$81,$80,$81,$90,$91,$90,$91,$A0,$A1,$A0,$A1
	.db $B0,$B1,$B0,$B1,$C0,$C1,$C0,$C1,$84,$85,$86,$87,$94,$95,$96,$97
	.db $A4,$A5,$A6,$A7,$B4,$B5,$B6,$B7,$C4,$C5,$C6,$C7,$94,$95,$96,$97
	.db $03,$00,$01,$02,$13,$10,$11,$12,$23,$20,$21,$12,$33,$30,$31,$32
	.db $43,$40,$41,$42,$53,$50,$51,$52,$53,$50,$61,$52,$63,$60,$61,$52
	.db $63,$60,$61,$52,$63,$60,$71,$72,$73,$0F,$0F,$0F,$0F,$0F,$0F,$0F
	.db $0A,$0B,$0F,$07,$1A,$1B,$0F,$17,$1A,$2B,$0F,$0F,$69,$3B,$0F,$0F
	.db $53,$13,$1C,$DB,$53,$33,$0F,$0D,$63,$43,$0F,$0F,$63,$43,$0F,$0F
	.db $63,$43,$0F,$0F,$73,$73,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
	.db $01,$09,$0A,$0B,$18,$12,$1A,$1B,$28,$12,$1A,$2B,$38,$32,$DB,$3B
	.db $48,$42,$69,$13,$51,$42,$69,$33,$61,$52,$53,$43,$61,$52,$53,$43
	.db $61,$52,$53,$43,$61,$52,$53,$43,$78,$79,$73,$73,$0F,$0F,$0F,$0F
	.db $0F,$0F,$0F,$FF,$0F,$0F,$9E,$9F,$0F,$0F,$AE,$AF,$0F,$0F,$BE,$BF
	.db $0F,$0F,$0F,$CF,$0F,$0F,$DE,$DF,$0F,$ED,$EE,$DB,$5C,$FD,$FE,$DB
	.db $DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB
	.db $DB,$DB,$DB,$DB,$0D,$DB,$DB,$DB,$0F,$F8,$DB,$DB,$0F,$0F,$1C,$DB
	.db $0F,$0F,$0F,$1C,$80,$81,$80,$81,$90,$91,$90,$91,$A0,$A1,$A0,$A1
	.db $DB,$DB,$DB,$DB,$FB,$FC,$FB,$FC,$90,$91,$90,$91,$A0,$A1,$A0,$A1
	.db $73,$0F,$0F,$0F,$80,$81,$80,$81,$90,$91,$90,$91,$A0,$A1,$A0,$A1
	.db $DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$F1,$26,$27
	.db $0F,$0F,$0F,$0F,$E1,$E2,$0F,$0F,$7A,$2D,$1E,$0E,$F9,$FA,$0F,$0F
	.db $F2,$F3,$0F,$0F,$19,$2A,$0F,$0F,$74,$75,$0F,$0F,$F9,$FA,$0F,$0F
	.db $7A,$75,$0F,$0F,$19,$2A,$0F,$0F,$E3,$E4,$DB,$DB,$E1,$E2,$27,$F4
	.db $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$08,$1E,$0F,$0F,$0F,$0F
	.db $DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$27,$F4,$27,$F4
	.db $DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$F5,$F6,$F7,$DB
	.db $DB,$D0,$48,$42,$D0,$0F,$51,$52,$0F,$0F,$51,$52,$0F,$0F,$61,$62
	.db $DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$88,$89,$8A,$8B,$98,$99,$9A,$9B
	.db $A8,$A9,$AA,$AB,$B8,$B9,$BA,$BB,$C8,$C9,$CA,$CB,$F0,$F0,$F0,$8C
	.db $84,$85,$86,$9C,$94,$95,$96,$AC,$A4,$A5,$A6,$BC,$B4,$B5,$B6,$8C
	.db $C4,$C5,$C6,$9C,$94,$95,$96,$AC,$A4,$A5,$A6,$BC,$B4,$B5,$B6,$8C
	.db $DB,$DB,$DB,$DB,$88,$89,$8A,$8B,$98,$99,$9A,$9B,$A8,$A9,$AA,$AB
	.db $B8,$B9,$BA,$BB,$C8,$C9,$CA,$CB,$F0,$F0,$F0,$8C,$84,$85,$86,$9C
	.db $94,$95,$96,$AC,$A4,$A5,$A6,$BC,$B4,$B5,$B6,$8C,$C4,$C5,$C6,$9C
	.db $94,$95,$96,$AC,$A4,$A5,$A6,$BC,$B4,$B5,$B6,$8C,$C4,$C5,$C6,$9C
	.db $82,$83,$36,$37,$92,$93,$46,$47,$A2,$A3,$56,$57,$B2,$B3,$66,$67
	.db $D4,$D5,$D6,$D7,$84,$E0,$E0,$E0,$94,$85,$86,$87,$A4,$95,$96,$97
	.db $B4,$A5,$A6,$A7,$C4,$B5,$B6,$B7,$94,$C5,$C6,$C7,$A4,$95,$96,$97
	.db $DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$DB,$82,$83,$36,$37
	.db $DB,$DB,$DB,$DB,$6D,$DB,$DB,$DB,$7D,$0F,$0F,$0F,$8D,$0F,$0F,$0F
	.db $9D,$0F,$0F,$0F,$9D,$0F,$0F,$0F,$BD,$0F,$0F,$0F,$BD,$0F,$0F,$0F
	.db $DD,$0F,$0F,$0F,$9D,$0F,$0F,$0F,$BD,$0F,$0F,$0F,$BD,$0F,$0F,$0F
	.db $DB,$DB,$DB,$DB,$DB,$E5,$FB,$FC,$0F,$E6,$90,$91,$0F,$E7,$A0,$A1
	.db $0F,$E8,$B0,$B1,$0F,$E9,$C0,$C1,$0F,$EA,$86,$87,$0F,$EB,$96,$97
	.db $0F,$EC,$A6,$A7,$0F,$ED,$B6,$B7,$0F,$EA,$C6,$C7,$0F,$EB,$96,$97
	.db $0A,$0B,$04,$05,$1A,$1B,$14,$15,$1A,$2B,$24,$25,$DB,$3B,$34,$25
	.db $69,$13,$44,$45,$53,$33,$54,$55,$53,$43,$0F,$0F,$53,$43,$0F,$0F
	.db $53,$43,$0F,$0F,$72,$73,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
	.db $D1,$09,$0A,$0B,$28,$12,$1A,$1B,$28,$12,$1A,$2B,$38,$12,$1A,$3B
	.db $48,$32,$69,$13,$51,$42,$69,$33,$61,$52,$53,$43,$61,$52,$53,$43
	.db $61,$52,$53,$43,$61,$52,$53,$43,$78,$79,$73,$73,$0F,$0F,$0F,$0F
	.db $92,$93,$46,$47,$A2,$A3,$56,$57,$B2,$B3,$66,$67,$D4,$D5,$D6,$D7
	.db $84,$E0,$E0,$E0,$94,$85,$86,$87,$A4,$95,$96,$97,$B4,$A5,$A6,$A7
	.db $C4,$B5,$B6,$B7,$94,$C5,$C6,$C7,$A4,$95,$96,$97,$B4,$A5,$A6,$A7
	.db $00,$01,$00,$01,$10,$11,$10,$11,$00,$01,$00,$01,$10,$11,$10,$11
	.db $04,$05,$04,$05,$05,$04,$05,$04,$04,$05,$04,$05,$05,$04,$05,$04
	.db $08,$09,$0A,$0B,$18,$19,$1A,$1B,$28,$29,$2A,$2B,$38,$39,$3A,$3B
	.db $48,$49,$4A,$4B,$58,$59,$5A,$5B,$68,$59,$5A,$6B,$58,$59,$5A,$5B
	.db $68,$59,$5A,$6B,$58,$59,$5A,$5B,$68,$59,$5A,$6B,$58,$59,$5A,$5B
	.db $68,$59,$5A,$6B,$58,$59,$5A,$5B,$68,$59,$5A,$6B,$78,$79,$7A,$7B
	.db $0C,$0D,$0E,$98,$1C,$1D,$1E,$1F,$2C,$2D,$2E,$2F,$3C,$3D,$3E,$3F
	.db $89,$89,$89,$89,$14,$15,$14,$15,$15,$14,$15,$14,$14,$15,$14,$15
	.db $15,$14,$15,$14,$14,$15,$14,$15,$15,$14,$15,$14,$14,$15,$14,$15
GraphicsSet1BlockPalettes:
	.db $00,$00,$45,$AB,$AA,$AA,$AA,$AA,$55,$AA,$AA,$55,$AE,$AA,$55,$55
	.db $AA,$00,$00,$00,$FF,$AF,$AF,$AF,$FF,$55,$55,$D5,$55,$F0,$F0,$AB
	.db $FF,$AA,$55,$55,$AF,$AA,$55,$55,$AF,$AA,$55,$FF,$53,$55,$55,$9F
	.db $99,$55,$55,$AA,$AA,$55,$55,$AA,$AA,$AA,$55,$AA,$FF,$FF,$FF,$FF
	.db $FF,$FF,$AA,$AA

GraphicsSet3BlockTiles:
	.db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
	.db $10,$11,$12,$13,$20,$21,$22,$23,$30,$31,$00,$00,$40,$41,$00,$00
	.db $04,$05,$06,$07,$14,$15,$16,$17,$24,$25,$26,$27,$34,$35,$36,$37
	.db $08,$09,$0A,$0B,$18,$19,$1A,$1B,$28,$29,$2A,$2B,$38,$39,$3A,$3B
	.db $0C,$0D,$0E,$0F,$1C,$1D,$1E,$1F,$2C,$2D,$2E,$2F,$3C,$3D,$3E,$3F
	.db $50,$51,$52,$53,$60,$61,$62,$63,$70,$71,$72,$73,$80,$81,$82,$83
	.db $44,$45,$46,$47,$54,$55,$56,$57,$64,$65,$66,$67,$74,$75,$76,$77
	.db $84,$85,$86,$87,$54,$55,$56,$57,$64,$65,$66,$67,$74,$75,$76,$77
	.db $44,$45,$46,$49,$54,$55,$56,$59,$64,$65,$66,$69,$74,$75,$76,$79
	.db $84,$85,$86,$89,$54,$55,$56,$59,$64,$65,$66,$69,$74,$75,$76,$79
	.db $4A,$4B,$4C,$4D,$5A,$5B,$5C,$5D,$4A,$4B,$4C,$4D,$5A,$5B,$5C,$5D
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $6B,$6B,$6B,$6B,$33,$32,$33,$32,$32,$33,$32,$33,$33,$32,$33,$32
	.db $32,$33,$32,$33,$33,$32,$33,$32,$32,$33,$32,$33,$33,$32,$33,$32
	.db $4E,$4F,$4E,$4F,$5E,$5F,$5E,$5F,$4E,$4F,$4E,$4F,$5E,$5F,$5E,$5F
	.db $7F,$7E,$7F,$7E,$6E,$6F,$6E,$6F,$6F,$6E,$6F,$6E,$6E,$6F,$6E,$6F
	.db $6F,$6E,$6F,$6E,$6E,$6F,$6E,$6F,$6F,$6E,$6F,$6E,$6E,$6F,$6E,$6F
	.db $6F,$6E,$90,$91,$6E,$6F,$A0,$A1,$6F,$6E,$B0,$B1,$6E,$6F,$C0,$C1
	.db $6F,$6E,$D0,$D1,$6E,$6F,$E0,$E1,$6F,$6E,$96,$97,$6E,$6F,$A6,$A7
	.db $6F,$6E,$B6,$A7,$6E,$6F,$A6,$A7,$6F,$6E,$B6,$A7,$6E,$6F,$E6,$E7
	.db $92,$93,$94,$95,$A2,$A3,$A4,$A5,$B2,$B3,$B4,$B5,$C2,$C3,$C4,$C5
	.db $D2,$D3,$D4,$D5,$E2,$E3,$E4,$E5,$98,$99,$9A,$9B,$A8,$A9,$AA,$AB
	.db $A8,$A9,$AA,$BB,$A8,$A9,$AA,$AB,$A8,$A9,$AA,$BB,$E7,$E7,$E7,$EB
	.db $6F,$6E,$6F,$6E,$6E,$6F,$6E,$6F,$6F,$6E,$90,$91,$6E,$6F,$A0,$A1
	.db $6F,$6E,$B0,$B1,$6E,$6F,$C0,$C1,$6F,$6E,$D0,$D1,$6E,$6F,$E0,$E1
	.db $6F,$6E,$96,$97,$6E,$6F,$A6,$A7,$6F,$6E,$B6,$A7,$6E,$6F,$E6,$E7
	.db $6F,$6E,$6F,$6E,$6E,$6F,$6E,$6F,$92,$93,$94,$95,$A2,$A3,$A4,$A5
	.db $B2,$B3,$B4,$B5,$C2,$C3,$C4,$C5,$D2,$D3,$D4,$D5,$E2,$E3,$E4,$E5
	.db $98,$99,$9A,$9B,$A8,$A9,$AA,$AB,$A8,$A9,$AA,$BB,$E7,$E7,$E7,$EB
	.db $04,$05,$06,$9E,$14,$15,$16,$AE,$24,$25,$26,$BE,$34,$35,$36,$CE
	.db $08,$09,$0A,$DE,$18,$19,$1A,$EE,$28,$29,$2A,$9F,$38,$39,$3A,$AF
	.db $9C,$05,$06,$07,$AC,$15,$16,$17,$BC,$25,$26,$27,$CC,$35,$36,$37
	.db $DC,$09,$0A,$0B,$EC,$19,$1A,$1B,$9D,$29,$2A,$2B,$AD,$39,$3A,$3B
	.db $F0,$F1,$F1,$F2,$F3,$F4,$F4,$F5,$F1,$F2,$F0,$F1,$F4,$F5,$F3,$F4
	.db $F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$F1,$F2,$F8,$F9,$F4,$F5,$FC,$FD
	.db $F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$FA,$FB,$F0,$F1,$FE,$FF,$F3,$F4
	.db $8C,$8D,$8C,$8D,$8D,$8C,$8D,$8C,$8C,$8D,$8C,$8D,$8D,$8C,$8D,$8C
	.db $48,$45,$46,$47,$58,$55,$56,$57,$68,$65,$66,$67,$78,$75,$76,$77
	.db $7A,$85,$86,$87,$58,$55,$56,$57,$68,$65,$66,$67,$78,$75,$76,$77
	.db $F0,$F1,$F1,$F2,$F3,$F4,$F4,$F5,$00,$00,$F0,$F1,$00,$00,$F3,$F4
	.db $F0,$F1,$F1,$F2,$F3,$F4,$F4,$F5,$F1,$F2,$00,$00,$F4,$F5,$00,$00
GraphicsSet3BlockPalettes:
	.db $55,$55,$00,$00,$00,$00,$55,$55,$55,$55,$00,$00,$00,$00,$AA,$FF
	.db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00
	.db $00,$00,$00,$00,$FF,$55,$55,$00,$00

GraphicsSet2BlockTiles:
	.db $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
	.db $10,$11,$12,$13,$20,$21,$22,$23,$30,$31,$32,$33,$40,$41,$42,$43
	.db $50,$51,$52,$53,$20,$21,$22,$23,$30,$31,$32,$33,$40,$41,$42,$43
	.db $50,$51,$52,$53,$20,$21,$22,$23,$30,$31,$32,$33,$60,$61,$62,$63
	.db $9C,$DC,$DC,$DD,$9C,$DC,$DC,$DD,$9C,$DC,$DC,$DD,$9C,$DC,$DC,$DD
	.db $5A,$5B,$5C,$6A,$6A,$6B,$6A,$6D,$6A,$6D,$6A,$6D,$7A,$6A,$7B,$6A
	.db $10,$11,$12,$13,$20,$21,$22,$23,$30,$31,$32,$33,$60,$61,$62,$25
	.db $50,$51,$25,$03,$20,$05,$03,$03,$04,$03,$03,$03,$14,$03,$03,$03
	.db $24,$03,$03,$03,$34,$03,$03,$03,$44,$03,$03,$03,$54,$03,$03,$03
	.db $10,$06,$07,$08,$20,$16,$17,$03,$15,$03,$03,$03,$03,$03,$03,$03
	.db $4A,$4B,$4C,$4D,$5A,$5B,$5C,$6A,$6A,$6B,$6A,$6D,$7A,$7B,$6A,$6A
	.db $70,$71,$72,$73,$80,$81,$01,$83,$90,$91,$92,$93,$70,$70,$70,$70
	.db $09,$0A,$0B,$0C,$19,$1A,$1B,$1C,$29,$2A,$2B,$2C,$39,$3A,$3B,$3C
	.db $0D,$0A,$0B,$0C,$1D,$1A,$1B,$1C,$2D,$2A,$2B,$2C,$3D,$3A,$3B,$3C
	.db $0D,$0A,$0B,$0E,$1D,$1A,$1B,$1E,$2D,$2A,$2B,$2E,$3D,$3A,$3B,$3E
	.db $70,$70,$70,$70,$64,$65,$66,$67,$74,$01,$01,$01,$84,$01,$01,$01
	.db $94,$95,$96,$97,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70
	.db $70,$70,$70,$70,$68,$70,$70,$70,$78,$79,$70,$70,$01,$89,$8A,$70
	.db $98,$99,$9A,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70
	.db $A7,$A0,$A1,$A2,$A7,$B0,$B1,$B2,$A7,$C0,$C1,$C2,$A7,$D0,$D1,$D2
	.db $01,$01,$01,$E2,$01,$01,$01,$F2,$01,$01,$01,$F2,$01,$01,$01,$F2
	.db $01,$01,$01,$F2,$01,$01,$01,$F2,$01,$01,$F0,$E0,$01,$01,$F1,$E1
	.db $A7,$A7,$A7,$A7,$B7,$A7,$A7,$A7,$C7,$A7,$A7,$A7,$D7,$A7,$A7,$A7
	.db $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$58,$03,$03,$03,$48
	.db $03,$03,$03,$69,$03,$03,$48,$20,$03,$03,$59,$30,$03,$03,$69,$40
	.db $03,$58,$53,$50,$48,$22,$23,$20,$37,$32,$33,$30,$37,$42,$43,$40
	.db $37,$52,$53,$50,$47,$22,$23,$20,$57,$32,$33,$30,$55,$62,$63,$60
	.db $57,$12,$13,$10,$37,$22,$23,$20,$31,$32,$33,$30,$41,$42,$43,$40
	.db $51,$52,$53,$50,$21,$22,$23,$20,$31,$A8,$A9,$AA,$41,$B8,$B9,$BA
	.db $51,$52,$53,$50,$21,$22,$23,$20,$31,$32,$33,$36,$41,$42,$43,$46
	.db $51,$52,$53,$36,$21,$22,$23,$46,$31,$32,$33,$36,$61,$62,$63,$46
	.db $11,$12,$13,$10,$21,$22,$23,$20,$31,$32,$33,$30,$41,$42,$43,$40
	.db $51,$52,$53,$50,$21,$22,$23,$20,$AB,$32,$33,$C8,$BB,$42,$43,$D8
	.db $51,$52,$53,$50,$27,$26,$27,$26,$82,$82,$82,$82,$82,$82,$82,$82
	.db $82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
	.db $51,$52,$53,$50,$21,$22,$23,$20,$C9,$CA,$CB,$30,$D9,$DA,$DB,$40
	.db $51,$52,$53,$50,$21,$22,$23,$20,$46,$32,$33,$30,$36,$42,$43,$40
	.db $46,$52,$53,$50,$36,$22,$23,$20,$46,$32,$33,$30,$36,$62,$63,$60
	.db $A3,$A4,$A5,$A6,$B3,$B4,$B5,$B6,$C3,$C4,$C5,$C6,$D3,$D4,$D5,$D6
	.db $F3,$01,$01,$01,$F3,$01,$01,$01,$F3,$01,$01,$01,$F3,$01,$01,$01
	.db $18,$28,$38,$18,$1D,$1A,$1B,$1C,$2D,$2A,$2B,$2C,$3D,$3A,$3B,$3C
	.db $4A,$6A,$6A,$6A,$5A,$5B,$5C,$6A,$6A,$6B,$6A,$6D,$7A,$7B,$6A,$6A
	.db $6A,$6A,$6A,$4A,$5A,$5B,$5C,$6A,$6A,$6B,$6A,$6D,$7A,$7B,$6A,$6A
	.db $8B,$8C,$CD,$8B,$9B,$9C,$DD,$9B,$8D,$9C,$DD,$8D,$9B,$9C,$DD,$9B
	.db $8D,$9C,$DD,$8D,$9B,$9C,$DD,$9B,$8D,$9C,$DD,$8D,$9B,$9C,$DD,$9B
	.db $8C,$CC,$CD,$8B,$9C,$DC,$DD,$9B,$9C,$DC,$DD,$8D,$9C,$DC,$DD,$9B
	.db $9C,$DC,$DD,$9B,$9C,$DC,$DD,$8D,$9C,$DC,$DD,$9B,$9C,$DC,$DD,$8D
	.db $8B,$8C,$CC,$CD,$9B,$9C,$DC,$DD,$8D,$9C,$DC,$DD,$9B,$9C,$DC,$DD
	.db $8D,$9C,$DC,$DD,$9B,$9C,$DC,$DD,$8D,$9C,$DC,$DD,$9B,$9C,$DC,$DD
	.db $8D,$9C,$9D,$9E,$9B,$9C,$8D,$8E,$8D,$9C,$8D,$8E,$9B,$9C,$8D,$8E
	.db $8D,$9C,$8D,$8E,$9B,$9C,$8D,$8E,$8D,$9C,$8D,$8E,$9B,$9C,$8D,$8E
	.db $AE,$AF,$DC,$DD,$DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD
	.db $DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD
	.db $9C,$DC,$9D,$9E,$9C,$DC,$8D,$8E,$9C,$DC,$8D,$8E,$9C,$DC,$8D,$8E
	.db $9C,$DC,$8D,$8E,$9C,$DC,$8D,$8E,$9C,$DC,$8D,$8E,$9C,$DC,$8D,$8E
	.db $8B,$8C,$CC,$CD,$9B,$9C,$DC,$DD,$8D,$9C,$DC,$DD,$9B,$9C,$DC,$DD
	.db $AE,$AF,$DC,$DD,$DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD
	.db $DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD,$DC,$9F,$DC,$DD
	.db $8D,$9C,$DC,$DD,$9B,$9C,$DC,$DD,$8D,$9C,$DC,$DD,$9B,$9C,$DC,$DD
	.db $8C,$CC,$CC,$CD,$9C,$DC,$DC,$DD,$9C,$DC,$DC,$DD,$9C,$DC,$DC,$DD
GraphicsSet2BlockPalettes:
	.db $00,$55,$55,$55,$55,$00,$55,$55,$55,$55,$00,$00,$AF,$AF,$AF,$00
	.db $00,$00,$00,$FF,$AA,$AA,$FF,$55,$55,$55,$55,$55,$55,$55,$55,$55
	.db $55,$55,$55,$55,$55,$55,$EF,$AA,$AF,$00,$00,$55,$55,$55,$55,$55
	.db $55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55



.org $FFFA
	.dw NMI
	.dw Reset
	.dw IRQ
