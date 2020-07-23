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
	lda #$90				;\Init PPU_CTRL
	sta Mirror_PPUCtrl			;|
	sta PPU_CTRL				;/
	jsr InitDemoDataPointer
	ldx #$00
	stx $053D
	stx SoundEffectID
	stx MusicID
	stx SilenceAudioFlag
	stx PauseGraphicsFlag
	stx InvSelectStartBits
	stx SelectStartBits
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
	sta CurrentLifeBonus
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
	jsr UnkFunc_B755
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
	lda SelectStartBits
	and #(BUTTON_SELECT|BUTTON_START)
	beq CODE_80D7
	jmp CODE_8071
CODE_8108:
	jsr CheckPauseGame
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
	sta UnkB_0528
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
	stx UnkB_10
CODE_81A6:
	jsr UnkFunc_B755
	jsr CODE_8E64
	jsr CODE_BCEE
	jsr CODE_8EC9
	dec UnkB_10
	bne CODE_81A6
	lda #$00
	sta SoundEffectID
	jmp UnkFunc_B755
CODE_81BD:
	stx UnkB_10
CODE_81BF:
	jsr UnkFunc_B755
	dec UnkB_10
	bne CODE_81BF
	rts
	
LoadLevelMusic:
	lda $49
	beq LoadLevelMusic_SkipBonus
	lda #MUSIC_BONUS
	bne LoadLevelMusic_Bonus
LoadLevelMusic_SkipBonus:
	ldy LevelSet
	lda LevelSet_MusicIDTable,y
LoadLevelMusic_Bonus:
	sta MusicID
	rts
LevelSet_MusicIDTable:
	.db MUSIC_JUNGLE
	.db MUSIC_JUNGLE
	.db MUSIC_DARK
	.db MUSIC_BEACH
	.db MUSIC_BEACH
	.db MUSIC_CAVE
	.db MUSIC_CAVE
	.db MUSIC_CAVE
	.db MUSIC_CAVE
	.db MUSIC_CAVE
	.db MUSIC_GRAY
	.db MUSIC_BONUS
CheckPauseGame:
	lda SelectStartBits
	and #BUTTON_START
	beq CheckPauseGame_Exit
	ldx #$01
	stx SilenceAudioFlag
	stx PauseGraphicsFlag
	lda #SE_PAUSE
	sta SoundEffectID
CheckPauseGame_PauseLoop:
	jsr UnkFunc_B755
	lda SelectStartBits
	and #BUTTON_START
	beq CheckPauseGame_PauseLoop
	lda #$00
	sta SilenceAudioFlag
	sta PauseGraphicsFlag
CheckPauseGame_Exit:
	rts












CODE_8305:
	lda $01
	rol
	ror $01
	ror $00
	dey
	bne CODE_8305
	rts
SignExtend:
	lda $00
	bpl SignExtend_SkipNeg
	lda #$FF
	.db $CD
SignExtend_SkipNeg:
	lda #$00
	sta $01
	rts
CODE_831C:
	lda #$01
	sta $4B
	sta $4A
	rts
CODE_8323:
	lda #$01
	sta $45
	sta $4D
	rts
CODE_832A:
	lda $4C
	bne CODE_839D
	lda $4A
	beq CODE_833D





































InitTimer:
	lda #$0A
	sta TimerHi
	lda #$FF
	sta TimerLo





CheckTopScore:
	ldx #$01
CheckTopScore_Loop:
	lda ScoreTop,x
	jsr ConvertDigit
	sta $00
	lda ScoreCurrent,x
	jsr ConvertDigit
	cmp $00
	bcc ConvertDigit_Exit
	bne ConvertDigit_SetTop
	inx
	cpx #$08
	bcc CheckTopScore_Loop
	rts
CheckTopScore_SetTop:
	ldx #$07
CheckTopScore_SetTopLoop:
	lda ScoreCurrent,x
	sta ScoreTop,x
	dex
	bne CheckTopScore_SetTopLoop
	rts
ConvertDigit:
	cmp #$FF
	beq ConvertDigit_Null
	sec
	sbc #$F5
	rts
ConvertDigit_Null:
	lda #$00
ConvertDigit_Exit:
	rts
CODE_890C:
	lda #$60
	sta $5A
	lda #$00
	sta $59
	lda #$14
	sta $5D
	lda #$2C
	jmp CODE_C301
CODE_891D:
	lda $48
	bne ConvertDigit_Exit
	jsr CODE_890C
	lda #$1C
	sta $5D
	lda #$18
	sta $5A
	lda #$18
	jsr CODE_C301
	lda #$24
	sta $5A
	lda #$0E
	ldy DemoFlag
	bne CODE_8940
	clc
	adc NumLives
	sbc #$00
CODE_8940:
	jmp CODE_C301
ColdBootString:
	.db "HECTOR"
CheckColdBoot:
	lda #$E4
	sta ScoreCurrent
	sta ScoreTop
	sta ScoreRoundBonus
	sta ScorePotBonus
	ldx #$05
CheckColdBoot_CheckStrLoop:
	lda ColdBootStringRAM,x
	cmp ColdBootString,x
	bne CheckColdBoot_Reset
	dex
	bpl CheckColdBoot_CheckStrLoop
	rts
CheckColdBoot_Reset:
	ldx #$05
CheckColdBoot_ResetStrLoop:
	lda ColdBootString,x
	sta ColdBootStringRAM,x
	dex
	bpl CheckColdBoot_ResetStrLoop
	ldy #$00
	jsr ResetColdBoot
	ldy #$09
ResetColdBoot:
	iny
	ldx #$06
	lda #$FF
ResetColdBoot_InitScore:
	sta ScoreCurrent,y
	iny
	dex
	bne ResetColdBoot_InitScore
	lda #$F5
	sta ScoreCurrent,y
	iny
	sta ScoreCurrent,y
	iny
	rts
PointsHiDigitPlace:
	.db $07,$07,$07,$06,$06,$06,$06,$06
	.db $05,$05,$05,$05,$05,$04,$04,$04
PointsHiDigit:
	.db $01,$02,$05,$01,$02,$03,$04,$05
	.db $01,$02,$03,$04,$05,$01,$02,$05
LifeBonusHiDigitPlace:
	.db $04,$03,$03,$00
LifeBonusHiDigit:
	.db $FA,$F6,$F7,$FF
CheckLifeBonus:
	lda #$01
CheckLifeBonus_L2:
	ldy DemoFlag
	bne GiveLife_SkipInc
	tay
	txa
	pha
	lda #$00
	jsr GivePoints
	ldx CurrentLifeBonus
	ldy LifeBonusHiDigitPlace,x
	lda ScoreCurrent,y
	cmp #$FF
	beq CheckLifeBonus_Skip
	cmp LifeBonusHiDigit,x
	bne CheckLifeBonus_Skip
	inc CurrentLifeBonus
	jsr GiveLife
CheckLifeBonus_Skip:
	jsr CODE_88D9
	pla
	tax
	rts
GiveLife:
	inc LifeSoundEffectFlag
	lda NumLives
	cmp #$09
	beq GiveLife_SkipInc
	inc NumLives
GiveLife_SkipInc:
	rts
GetPointsToGive:
	sta $02
	lda PointsHiDigit,y
	sta $01
	lda PointsHiDigitPlace,y
	sta $00
	tay
	clc
	adc $02
	sta $03
	tax
	rts
GivePoints:
	jsr GetPointsToGive









Sprite_FruitInit:
	lda EnemyID,x
	and #$07
	sta $0664,x
	tay
	lda Enemy_ScreenYPos,x
	sec
	sbc FruitYOffset,y
	sbc $3E
	sta Enemy_ScreenYPos,x
	lda FruitLifetime,y
	sta $0674,x
	lda #$00
	sta $0684,x
Sprite_FruitInit_Exit:
	rts
FruitYOffset:
	.db $48,$18,$4C,$0C,$48
FruitLifetime:
	.db $64,$64,$64,$32,$32
Sprite_FruitMain:
	ldy Enemy_Status,x
	dey













SpriteInitJumpTable:
	.dw Sprite_Null-1
	.dw Sprite_Null-1
	.dw Sprite_Null-1
	.dw Sprite_Null-1
	.dw Sprite04_Init-1
	.dw Sprite05_Init-1
	.dw Sprite_Pig1Init-1
	.dw Sprite_Null-1
	.dw Sprite_Null-1
	.dw Sprite09_Init-1
	.dw Sprite0A_Init-1
	.dw Sprite_CeilingInit-1
	.dw Sprite0C_Init-1
	.dw Sprite_Null-1
	.dw Sprite_SnailInit-1







RunSprite:
	ldy Enemy_Status,x
	iny
	
	lda Enemy_ID,x
	and #$7F
	asl
	tay
	lda SpriteMainJumpTable+1,y
	pha
	lda SpriteMainJumpTable,y
	pha
RunSprite_Exit:
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

































	lda #$20
	sta PPU_ADDR
	ldx #$00
	stx PPU_ADDR
	stx Mirror_PPUScrollY
	stx Mirror_PPUScrollX
	ldy #$08
	lda #$FF
	jsr FillVRAM
	jsr ClearOAMBuffer
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








DATA_B702:
	.db $E0,$20
DATA_B704:
	.db $03,$04
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
UnkFunc_B755:
	lda #$FF
	sta GraphicsNMITaskFlag
CODE_B759:
	lda GraphicsNMITaskFlag
	bne CODE_B759
	jsr CODE_C2C2
	jsr ReadJoypads
	jsr LoadDemoInput
	jsr CODE_B782
	lda LifeSoundEffectFlag
	beq CODE_B771
	lda #$10
	sta SoundEffectID
CODE_B771:
	inc $66
	lda $66
	cmp #$10
	bcc CODE_B77D
	lda #$00
	sta $66
CODE_B77D:
	lda #$00
	sta LifeSoundEffectFlag
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
	lda #<LevelSetTable			;\Init demo data pointer
	sta DemoDataPointer			;|(points to level set table?)
	lda #>LevelSetTable			;|
	sta DemoDataPointer+1			;/
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
LevelPaletteTable:
	.db $00,$1F,$21,$4F			;Area 1
	.db $1F,$BF,$2F,$4F			;Area 2
	.db $6F,$0F,$1F,$4F			;Area 3
	.db $00,$3F,$CF,$4F			;Area 4
	.db $1F,$9F,$7F,$4F			;Area 5
	.db $1F,$52,$3F,$4F			;Area 6
	.db $DF,$1F,$AF,$4F			;Area 7
	.db $3F,$1F,$8F,$4F			;Area 8
LevelPaletteData:
	.db $2A,$1A,$2C,$2C,$17,$27,$29,$17,$27,$29,$17,$2C
	.db $20,$11,$21,$18,$28,$21,$21,$17,$27,$1A,$29,$21
	.db $17,$27,$07,$18,$28,$38,$30,$3C,$21,$26,$06,$30
	.db $20,$11,$21,$20,$21,$10,$00,$00,$00,$00,$00,$00
	.db $18,$08,$01,$01,$17,$27,$09,$17,$27,$09,$17,$01
	.db $13,$22,$04,$17,$27,$37,$30,$33,$21,$26,$06,$30
	.db $27,$37,$17,$0F,$0F,$0F,$26,$36,$15,$21,$11,$01
	.db $2C,$3C,$11,$0F,$0F,$0F,$26,$36,$15,$23,$13,$04
	.db $26,$36,$16,$0F,$0F,$0F,$26,$36,$15,$29,$19,$09
	.db $18,$28,$08,$1A,$2A,$3A,$0F,$0F,$0F,$26,$06,$30
	.db $10,$20,$00,$00,$10,$30,$0F,$0F,$0F,$26,$06,$30
	.db $18,$28,$07,$1B,$29,$39,$26,$06,$30,$2C,$1C,$0C
	.db $21,$30,$11,$18,$28,$38,$30,$3C,$21,$3C,$21,$11
	.db $21,$30,$11,$0F,$0F,$0F,$30,$33,$21,$21,$13,$03
DATA_B9F4:
	.db <DATA_B9FA
	.db <DATA_BA01
	.db <DATA_BA0E
DATA_B9F7:
	.db >DATA_B9FA
	.db >DATA_BA01
	.db >DATA_BA0E
DATA_B9FA:
	.db $30,$01,$00,$26,$06,$2C,$FF
DATA_BA01:
	.db $20,$01,$03,$3C,$21,$11,$36,$01,$03,$26,$06,$30,$FF
DATA_BA0E:
	.db $20,$01,$03,$30,$23,$13,$36,$01,$03,$26,$06,$30,$FF









CheckPlayerEnemyCollision:
	lda $72
	bne CheckEnemyEnemyCollision_NoColi
	lda $6A
	bmi CheckEnemyEnemyCollision_NoColi
	ldy #$00
CheckEnemyEnemyCollision:
	lda Enemy_ColiHeight,x
	clc
	adc Enemy_ColiHeight,y
	sta $00
	lda Enemy_ScreenYPos,x
	sec
	sbc Enemy_ScreenYPos,y
	bcs CheckEnemyEnemyCollision_NegDy
	eor #$FF
	adc #$01
CheckEnemyEnemyCollision_NegDy:
	cmp $00
	bcs CheckEnemyEnemyCollision_NoColi
	lda Enemy_ColiWidth,x
	clc
	adc Enemy_ColiWidth,y
	sta $00
	lda Enemy_ScreenXPos,x
	sec
	sbc Enemy_ScreenXPos,x
	sta $01
	lda Enemy_XVel,x
	sbc Enemy_XVel,y
	bmi CheckEnemyEnemyCollision_NegDx
	bne CheckEnemyEnemyCollision_NoColi
	lda $01
	cmp $00
	bcs CheckEnemyEnemyCollision_NoColi
CheckEnemyEnemyCollision_Coli:
	sec
	rts
CheckEnemyEnemyCollision_NegDx:
	eor #$FF
	bne CheckEnemyEnemyCollision_NoColi
	lda $01
	eor #$FF
	cmp $00
	bcc CheckEnemyEnemyCollision_Coli
CheckEnemyEnemyCollision_NoColi:
	clc
	rts












ClearOAMBuffer:
	ldx #$00
	lda #$F0
ClearOAMBuffer_Loop:
	sta OAMBuffer,x
	inx
	bne ClearOAMBuffer_Loop
	rts
UnkFunc_C4EF:
	jsr UnkFunc_B755

ReadJoypads:
	ldx #$01
	stx JOY1
	dex
	stx JOY1
	ldy #$08
ReadJoypads_Loop:
	jsr ReadSingleJoypad
	inx
	jsr ReadSingleJoypad
	dex
	dey
	bne ReadJoypads_Loop
	rts
ReadSingleJoypad:
	asl PadCur,x
	lda JOY1,x
	lsr
	bcs ReadSingleJoypad_SetBit
	lsr
	bcs ReadSingleJoypad_SetBit
	rts
ReadSingleJoypad_SetBit:
	inc PadCur,x
	rts
SoundEffectJumpTable:
	.dw SoundEffect00_Init-1
	.dw SoundEffect_NullMain-1
	.dw SoundEffect01_Init-1
	.dw SoundEffect01_Main-1
	.dw SoundEffect02_Init-1
	.dw SoundEffect02_Main-1
	.dw SoundEffect03_Init-1
	.dw SoundEffect03_Main-1
	.dw SoundEffect04_Init-1
	.dw SoundEffect_NullMain-1
	.dw SoundEffect05_Init-1
	.dw SoundEffect_SpringMain-1
	.dw SoundEffect06_Init-1
	.dw SoundEffect06_Main-1
	.dw SoundEffect07_Init-1
	.dw SoundEffect07_Main-1
	.dw SoundEffect08_Init-1
	.dw SoundEffect_SpringMain-1
	.dw SoundEffect09_Init-1
	.dw SoundEffect09_Main-1
	.dw SoundEffect0A_Init-1
	.dw SoundEffect0A_Main-1
	.dw SoundEffect0B_Init-1
	.dw SoundEffect0B_Main-1
	.dw SoundEffect0C_Init-1
	.dw SoundEffect0C_Main-1
	.dw SoundEffect0D_Init-1
	.dw SoundEffect_NullMain-1
	.dw SoundEffect0E_Init-1
	.dw SoundEffect0E_Main-1
	.dw SoundEffect0F_Init-1
	.dw SoundEffect_NullMain-1
	.dw SoundEffect10_Init-1
	.dw SoundEffect_NonBreakMain-1
	.dw SoundEffect11_Init-1
	.dw SoundEffect_NonBreakMain-1
	.dw SoundEffect12_Init-1
	.dw SoundEffect_NullMain-1
	.dw SoundEffect13_Init-1
	.dw SoundEffect_NullMain-1
SoundEffectLengthTable:
	.db $00,$00,$00,$00,$00,$1E,$00,$00,$00,$0E,$00,$00,$00,$0E,$00,$00
	.db $00,$06,$00,$00,$00,$20,$00,$00,$00,$0C,$00,$00,$00,$1E,$00,$00
	.db $00,$14,$00,$00,$00,$14,$00,$00,$00,$18,$00,$00,$00,$00,$00,$3C
	.db $20,$20,$00,$00,$00,$08,$00,$00,$00,$00,$00,$30,$00,$0C,$00,$00
	.db $40,$40,$40,$40,$38,$38,$38,$38,$00,$04,$00,$00,$00,$0F,$00,$00














SoundEffect00_Init:
	lda #$00
	sta DMC_RAW
	sta TRI_LINEAR
	sta NOISE_VOL
	lda #$10
	sta SQ1_VOL
	sta SQ2_VOL
	lda #$0F
	sta SND_CHN
	rts
HandleSoundEffects:
	ldx #$03
HandleSoundEffects_Loop:
	lda SoundEffectTimers,x
	beq HandleSoundEffects_SkipDec
	dec SoundEffectTimers,x
HandleSoundEffects_SkipDec:
	dex
	bpl HandleSoundEffects_Loop
	ldy #$00
	lda SoundEffectID
	bmi HandleSoundEffects_Run
	ldx SoundEffectInit
	bmi HandleSoundEffects_Set
	cmp #$14
	bcs HandleSoundEffects_Set
	ora #$80
	sta SoundEffectID
	asl
	asl
	tax
HandleSoundEffects_InitTimersLoop:
	lda SoundEffectLengthTable,x
	beq HandleSoundEffects_SkipInitChan
	sta SoundEffectTimers,y
HandleSoundEffects_SkipInitChan:
	inx
	iny
	cpy #$04
	bcc HandleSoundEffects_InitTimersLoop
	lda #$00
	sta SoundEffectInit
	beq HandleSoundEffects_Run
HandleSoundEffects_Set:
	stx SoundEffectID
HandleSoundEffects_Run:
	lda SoundEffectID
	asl
	asl
	tax
	tya
	bne HandleSoundEffects_SkipInit
	inx
	inx
HandleSoundEffects_SkipInit:
	lda SoundEffectJumpTable+1,x
	pha
	lda SoundEffectJumpTable,x
SoundEffect07_Main:
	pha
SoundEffect_NullMain:
	rts





















SilenceAudio:
	bmi SilenceAudio_Skip
	ora #$80
	sta SilenceAudioFlag
	lda #$10
	sta SQ1_VOL
	sta SQ2_VOL
	sta NOISE_VOL
	lda #$00
	sta TRI_LINEAR
	lda #$18
	sta SQ1_HI
	sta SQ2_HI
	sta TRI_HI
	sta NOISE_HI
SilenceAudio_Skip:
	rts
HandleMusic:
	lda SilenceAudioFlag
	bne SilenceAudio
	lda MusicID
	beq SilenceAudio_Skip
	bmi HandleMusic_SkipLoad
	lda MusicID
	cmp #$0F
	bcs HandleMusic_ClearID
	ora #$80
	sta MusicID
	asl
	asl
	asl
	tay
	ldx #$07
HandleMusic_InitPtrs:
	lda MusicDataPointers-1,y
	sta MusicPointers,x
	sta MusicLoopPointers,x
	dey
	dex
	bpl HandleMusic_InitPtrs
	inx
	
	
	
	
	
	
	
	stx MusicNoiseRepeatCounter
	inx
	stx MusicNoteTimers
	stx MusicNoteTimers+1
	stx MusicNoteTimers+2
	stx MusicNoteTimers+3
	stx MusicNoteLengths
	stx MusicNoteLengths+1
	stx MusicNoteLengths+2
	stx MusicNoteLengths+3
	lda #$08
	
	
	
	
	
	
	
HandleMusic_SkipLoad:
	lda #$03
	sta NumMusChansPlaying
	sta CurMusicChan
HandleMusic_Loop:
	ldx CurMusicChan
	dec MusicNoteTimers,x
	bne HandleMusic_SkipNewCmd
	jsr ProcessMusicChannel
HandleMusic_SkipNewCmd:
	dec CurMusicChan
	bpl HandleMusic_Loop
	lda NumMusChansPlaying
	bpl HandleMusic_Exit
HandleMusic_EndMusic:
	lda #$00
	sta MusicID
HandleMusic_Exit:
	rts
ProcessMusicChannel:
	ldx CurMusicChan
	cpx #$03
	bne ProcessMusicChannel_GetCmd
	lda MusicNoiseRepeatCounter
	beq ProcessMusicChannel_GetCmd
	
ProcessMusicChannel_GetCmd:
	jsr GetMusicByte
	sta CurMusicByte
	tay
	bmi ProcessMusicChannel_NotNote
	jmp ProcessMusicChannel_Note
ProcessMusicChannel_NotNote:
	and #$F0
	cmp #$F0
	bne ProcessMusicChannel_Length
	sec
	lda #$FF
	sbc CurMusicByte
	asl
	tay
	lda SpecialMusicCommandJumpTable+1,y
	pha
	lda SpecialMusicCommandJumpTable,y
	pha
	rts
SpecialMusicCommandJumpTable:
	.dw SpecialMusicCommandFF_EndTrack-1
	.dw SpecialMusicCommandFE_LoopTrack-1
	.dw SpecialMusicCommandFD-1
	.dw SpecialMusicCommandFC-1
	.dw SpecialMusicCommandFB-1
	.dw SpecialMusicCommandFA-1
	.dw SpecialMusicCommandF9-1
	.dw SpecialMusicCommandF8-1
	.dw SpecialMusicCommandF7_SetLoopPoint-1
	.dw SpecialMusicCommandF6_Call-1
	.dw SpecialMusicCommandF5_GlobalPitchShift-1
	.dw SpecialMusicCommandF4_ChanPitchShift-1
	.dw SpecialMusicCommandF3_Return-1
	.dw SpecialMusicCommandF2-1
ProcessMusicChannel_Length:
	ldx CurMusicChan
	lda CurMusicByte
	and #$7F
	sta MusicNoteLengths,x
	







SpecialMusicCommandF7_SetLoopPoint:
	jsr DoSetLoopPoint			;(any reason why this has to be a jsr?)
	jmp ProcessMusicChannel
DoSetLoopPoint:
	lda CurMusicChan			;\Save loop point
	asl					;|
	tax					;|
	lda MusicPointers,x			;|
	sta MusicLoopPointers,x			;|
	lda MusicPointers+1,x			;|
	sta MusicLoopPointers+1,x		;/
	rts
SpecialMusicCommandFE_LoopTrack:
	lda CurMusicChan			;\Restore loop point
	asl					;|
	tax					;|
	lda MusicLoopPointers,x			;|
	sta MusicPointers,x			;|
	lda MusicLoopPointers+1,x		;|
	sta MusicPointers+1,x			;/
	jmp ProcessMusicChannel
SpecialMusicCommandF6_Call:
	jsr GetMusicByte			;\Get call pointer
	pha					;|
	jsr GetMusicByte			;|
	pha					;/
	lda CurMusicChan			;\Save pointer
	asl					;|
	tax					;|
	lda MusicPointers,x			;|
	sta MusicReturnPointers,x		;|
	lda MusicPointers+1,x			;|
	sta MusicReturnPointers+1,x		;/
	pla					;\Set pointer to call
	sta MusicPointers+1,x			;|
	pla					;|
	sta MusicPointers,x			;/
	jmp ProcessMusicChannel
SpecialMusicCommandF3_Return:
	lda CurMusicChan			;\Restore pointer
	asl					;|
	tax					;|
	lda MusicReturnPointers,x		;|
	sta MusicPointers,x			;|
	lda MusicReturnPointers+1,x		;|
	sta MusicPointers+1,x			;/
	jmp ProcessMusicChannel
SpecialMusicCommandF4_ChanPitchShift:
	jsr GetMusicByte			;\Set pitch shift for this channel
	ldx CurMusicChan			;|
	sta MusicPitchShift,x			;/
	jmp ProcessMusicChannel
SpecialMusicCommandF5_GlobalPitchShift:
	jsr GetMusicByte			;\Set pitch shift for all channels
	sta MusicPitchShift			;|
	sta MusicPitchShift+1			;|
	sta MusicPitchShift+2			;/
	jmp ProcessMusicChannel
SpecialMusicCommandF2:
	ldx CurMusicChan
	lda #$08
	
GetMusicByte:
	lda CurMusicChan
	asl
	tax
	lda (MusicPointers,x)
	inc MusicPointers,x
	bne GetMusicByte_SkipCarry
	inc MusicPointers+1,x
GetMusicByte_SkipCarry:
	rts
FrequencyTableLo:
	.db $AE,$4E,$F3,$9F,$4D,$01,$B9,$75,$35,$F8,$BF,$89
FrequencyTableHi:
	.db $06,$06,$05,$05,$05,$05,$04,$04,$04,$03,$03,$03





NoisePatchData:
	.db $00,$00,$06,$20
	.db $01,$00,$0E,$20
	.db $1C,$00,$02,$68
	.db $00,$00,$04,$20
	.db $00,$00,$0C,$20
	.db $1A,$00,$04,$A8
	.db $1A,$00,$04,$48
MusicDataPointers:
	.dw MusicTitle_Sq1,MusicTitle_Sq2,MusicTitle_Tri,MusicTitle_Noise
	.dw MusicJungle_Sq1,MusicJungle_Sq2,MusicJungle_Tri,MusicJungle_Noise
	.dw MusicDark_Sq1,MusicDark_Sq2,MusicDark_Tri,MusicDark_Noise
	.dw MusicBeach_Sq1,MusicBeach_Sq2,MusicBeach_Tri,MusicBeach_Noise
	.dw MusicCave_Sq1,MusicCave_Sq2,MusicCave_Tri,MusicCave_Noise
	.dw MusicGray_Sq1,MusicGray_Sq2,MusicGray_Tri,MusicGray_Noise
	.dw MusicBonus_Sq1,MusicBonus_Sq2,MusicBonus_Tri,MusicBonus_Noise
	.dw MusicEggplant_Sq1,MusicEggplant_Sq2,MusicEggplant_Tri,MusicEggplant_Noise
	.dw MusicDeath_Sq1,MusicDeath_Sq2,MusicDeath_Tri,MusicDeath_Noise
	.dw MusicGameOver_Sq1,MusicGameOver_Sq2,MusicGameOver_Tri,MusicGameOver_Noise
	.dw MusicEnding_Sq1,MusicEnding_Sq2,MusicEnding_Tri,MusicEnding_Noise
	.dw MusicBoss_Sq1,MusicBoss_Sq2,MusicBoss_Tri,MusicBoss_Noise
	.dw MusicAreaClear_Sq1,MusicAreaClear_Sq2,MusicAreaClear_Tri,MusicAreaClear_Noise
	.dw MusicRoundClear_Sq1,MusicRoundClear_Sq2,MusicRoundClear_Tri,MusicRoundClear_Noise
;MUSIC DATA
;Each piece consists of a list of commands:
;00-7E	This is interpreted differently depending on whether or not the channel is noise
;For noise, the low 4 bits are written to MusicNoiseRepeatCounter, and the high 4 bits control the percussion patch to use.
;For everything else, the high 4 bits control the octave, and the low 4 bits control the note in the octave.
;7F	Play rest
;80-EF	Set note length
;F2-FF	Special commands:
;F2		Unknown
;F3		Return from call (for current channel)
;F4 XX		Pitch shift current channel
;F5 XX		Pitch shift all channels
;F6 XX XX	Call another short piece of music (for current channel)
;F7		Set loop point at current location (for current channel, default location is beginning of song)
;F8 XX		Unknown
;F9		Unknown
;FA XX		Unknown
;FB XX		Unknown
;FC		Unknown
;FD XX		Unknown
;FE		Loop back to loop point (or beginning if F7 was never used)
;FF		End channel, without looping
;TODO: Separate called pieces from main tracks
MusicTitle_Sq1:
	.db $8B,$7F,$FD,$02,$96,$22,$F6,$03,$CD,$96,$3A,$FB,$01,$86,$22,$85
	.db $22,$8B,$22,$86,$4A,$85,$4A,$8B,$4A,$86,$12,$85,$12,$86,$12,$85
	.db $7F,$86,$3A,$85,$3A,$86,$3A,$85,$7F,$FC,$FB,$02,$8B,$2A,$A1,$7F
	.db $D8,$32,$FF
MusicTitle_Sq2:
	.db $8B,$7F,$FD,$02,$96,$49,$F6,$32,$CD,$22,$12,$FB,$01,$8B,$02,$12
	.db $22,$2A,$3A,$4A,$52,$03,$FC,$FB,$02,$8B,$02,$A1,$7F,$D8,$0A,$FF
MusicTitle_Tri:
	.db $8B,$7F,$FD,$02,$F6,$77,$CD,$F9,$FB,$01,$FA,$06,$8B,$29,$4A,$29
	.db $4A,$01,$02,$01,$02,$FC,$FB,$02,$8B,$4A,$A1,$7F,$D8,$52,$FF,$84
	.db $12,$83,$11,$FD,$02,$8B,$11,$96,$1F,$16,$8B,$12,$02,$84,$12
MusicTitle_Noise:
	.db $83,$11,$8B,$11,$96,$13,$8B,$11,$FB,$01,$7F,$13,$7F,$12,$84,$12
	.db $83,$11,$FC,$FB,$02,$11,$03,$83,$13,$82,$11,$83,$13,$82,$11,$83
	.db $13,$82,$11,$83,$13,$82,$11,$83,$13,$82,$11,$83,$13,$82,$11
MusicBoss_Noise:
	.db $FF,$96,$2A,$12,$22,$8B,$03,$0B,$13,$AC,$4A,$8B,$3A,$96,$22,$4A
	.db $03,$13,$8B,$4B,$43,$3B,$96,$13,$8B,$13,$0B,$13,$2B,$23,$2B,$3B
	.db $96,$23,$13,$03,$0B,$13,$8B,$7F,$4A,$03,$52,$12,$2A,$4A,$0B,$F3
	.db $96,$02,$49,$02,$8B,$4A,$4A,$4A,$86,$22,$85,$2A,$86,$03,$85,$13
	.db $86,$23,$85,$2B,$86,$3B,$85,$23,$86,$13,$85,$03,$8B,$4A,$02,$96
	.db $22,$A1,$4A,$8B,$4A,$23,$1B,$13,$96,$4A,$8B,$13,$0B,$13,$13,$0B
	.db $13,$23,$96,$52,$3A,$8B,$4A,$2A,$4A,$02,$4A,$7F,$7F,$12,$3A,$12
	.db $39,$51,$22,$4A,$F3,$8B,$FA,$06,$29,$4A,$01,$4A,$11,$4A,$21,$4A
	.db $39,$2A,$39,$2A,$F9,$86,$01,$85,$3B,$86,$4B,$85,$53,$86,$01,$85
	.db $53,$86,$4B,$85,$3B,$8B,$FA,$06,$29,$4A,$29,$4A,$21,$4A,$19,$4A
	.db $51,$4A,$12,$4A,$31,$4A,$51,$4A,$39,$3A,$49,$4A,$51,$52,$59,$5A
	.db $F9,$96,$02,$0A,$12,$8B,$7F,$32,$8B,$FA,$06,$11,$12,$09,$0A,$01
	.db $02,$01,$02,$F3
MusicJungle_Sq1:
	.db $88,$02,$12,$7F,$2A,$4A,$7F,$03,$7F,$23,$7F,$1B,$13,$7F,$7F,$02
	.db $F7,$F4,$02,$F6,$F2,$CF,$F4,$00,$52,$F9,$C0,$F6,$F2,$CF,$4A,$F9
	.db $C0,$7F,$88,$03,$7F,$0B,$13,$A0,$7F,$8B,$03,$03,$8A,$0B,$88,$13
	.db $7F,$F4,$02,$F6,$01,$D0,$F4,$00,$52,$F9,$C0,$F6,$F2,$CF,$4A,$F9
	.db $88,$7F,$2A,$22,$2A,$4A,$2A,$4A,$03,$F6,$0A,$D0,$90,$2B,$88,$F6
	.db $13,$D0,$F6,$0A,$D0,$2B,$2B,$F6,$13,$D0,$03,$03,$7F,$0B,$13,$7F
	.db $7F,$4A,$03,$03,$7F,$0B,$13,$7F,$4B,$7F,$2B,$7F,$7F,$E8,$FE
MusicJungle_Sq2:
	.db $88,$49,$02,$7F,$12,$2A,$7F,$4A,$7F,$03,$7F,$5A,$52,$7F,$7F,$01
	.db $F7,$F4,$02,$F6,$1B,$D0,$F4,$00,$52,$3A,$F9,$C0,$F6,$1B,$D0,$4A
	.db $2A,$F9,$C0,$7F,$88,$4A,$7F,$4A,$4A,$A0,$7F,$8B,$4A,$4A,$8A,$4A
	.db $88,$4A,$7F,$F4,$02,$F6,$2A,$D0,$F4,$00,$52,$3A,$F9,$C0,$F6,$1B
	.db $D0,$4A,$2A,$88,$F9,$7F,$2A,$22,$2A,$2A,$02,$2A,$4A,$90,$4A,$88
	.db $03,$A0,$1B,$88,$2A,$90,$4A,$88,$03,$90,$1B,$88,$2B,$1B,$4A,$90
	.db $13,$88,$03,$A0,$13,$88,$52,$13,$13,$52,$13,$7F,$2B,$13,$52,$3A
	.db $4A,$7F,$3A,$52,$7F,$7F,$7F,$3A,$4A,$7F,$3A,$52,$7F,$23,$7F,$03
	.db $7F,$7F,$E8,$FE
MusicJungle_Tri:
	.db $88,$29,$49,$7F,$02,$12,$7F,$2A,$7F,$4A,$7F,$2A,$02,$7F,$7F,$01
	.db $F7,$7F,$88,$2A,$7F,$7F,$29,$7F,$7F,$49,$02,$2A,$7F,$2A,$29,$7F
	.db $2A,$2A,$2A,$90,$FA,$08,$01,$02,$01,$F9,$88,$02,$7F,$F6,$32,$D0
	.db $FA,$08,$21,$02,$F9,$88,$22,$12,$21,$7F,$7F,$02,$7F,$51,$49,$51
	.db $90,$FA,$08,$29,$2A,$02,$29,$F9,$88,$29,$90,$49,$88,$49,$90,$49
	.db $01,$98,$29,$88,$02,$7F,$7F,$4A,$02,$8B,$29,$02,$8A,$49,$88,$2A
	.db $7F,$29,$01,$90,$FA,$08,$01,$01,$02,$01,$F9,$88,$F6,$32,$D0,$39
	.db $88,$02,$7F,$7F,$22,$12,$98,$39,$88,$02,$7F,$51,$49,$51,$90,$FA
	.db $08,$29,$2A,$02,$F9,$88,$29,$7F,$7F,$29,$21,$29,$49,$29,$49,$02
	.db $98,$49,$02,$88,$2A,$02,$98,$49,$02,$88,$2A,$02,$98,$51,$12,$88
	.db $42,$2A,$98,$51,$90,$12,$88,$2A,$0A,$51,$21,$39,$7F,$02,$01,$7F
	.db $7F,$7F,$21,$39,$7F,$02,$01,$7F,$52,$7F,$4A,$7F,$01,$11,$7F,$29
	.db $7F,$49,$90,$02,$0A,$12,$FE
MusicJungle_Noise:
	.db $88,$42,$7F,$41,$90,$43,$88,$42,$02,$41,$7F,$F7,$FD,$06,$90,$31
	.db $88,$42,$FC,$42,$7F,$41,$90,$32,$FD,$06,$90,$31,$88,$42,$FC,$42
	.db $7F,$41,$90,$32,$FD,$02,$90,$31,$88,$42,$FC,$8B,$42,$8A,$41,$FD
	.db $03,$90,$31,$88,$42,$FC,$42,$7F,$41,$90,$32,$FD,$06,$90,$31,$88
	.db $42,$FC,$7F,$41,$7F,$43,$7F,$43,$7F,$41,$90,$31,$88,$45,$7F,$41
	.db $90,$31,$88,$43,$7F,$42,$FD,$04,$90,$31,$88,$42,$FC,$7F,$44,$7F
	.db $41,$90,$31,$88,$42,$41,$7F,$42,$7F,$90,$31,$88,$41,$90,$43,$88
	.db $42,$FE,$7F,$88,$52,$7F,$5A,$03,$A0,$7F,$88,$52,$7F,$5A,$03,$7F
	.db $03,$5A,$03,$FA,$08,$90,$13,$13,$03,$F3,$90,$2B,$88,$33,$A0,$3B
	.db $88,$13,$F3,$33,$90,$3B,$88,$4B,$3B,$13,$F3,$7F,$88,$3A,$7F,$3A
	.db $3A,$A0,$7F,$88,$3A,$7F,$3A,$3A,$7F,$3A,$32,$3A,$FA,$08,$90,$52
	.db $52,$F3,$39,$90,$12,$88,$0A,$90,$02,$39,$98,$F3
MusicDark_Sq1:
	.db $F8,$40,$8F,$7F,$5A,$03,$5A,$52,$5A,$0B,$1B,$F7,$9E,$FA,$0F,$23
	.db $33,$1B,$F9,$8F,$5A,$85,$59,$0A,$1A,$88,$22,$87,$7F,$8F,$23,$7F
	.db $33,$1B,$7F,$5A,$7F,$F4,$03,$F6,$1F,$D1,$F4,$0C,$F6,$29,$D1,$F4
	.db $05,$F6,$32,$D1,$F4,$03,$F6,$39,$D1,$F4,$00,$F6,$46,$D1,$FE
MusicDark_Sq2:
	.db $F8,$00,$F6,$4D,$D1,$F7,$9E,$FA,$0F,$3A,$4A,$32,$32,$F9,$8F,$7F
	.db $3A,$7F,$4A,$32,$7F,$32,$7F,$F6,$1F,$D1,$F6,$29,$D1,$F6,$32,$D1
	.db $F6,$39,$D1,$F6,$46,$D1,$FE
MusicDark_Tri:
	.db $F6,$4D,$D1,$F7,$9E,$FA,$0F,$22,$59,$49,$1A,$F9,$8F,$7F,$21,$7F
	.db $59,$49,$7F,$1A,$7F,$9E,$49,$8F,$51,$AD,$59,$8F,$51,$59,$7F,$4A
	.db $42,$22,$3A,$32,$0A,$02,$12,$1A,$12,$1A,$9E,$7F,$88,$1A,$87,$59
	.db $88,$22,$87,$59,$88,$32,$87,$7F,$88,$4A,$87,$7F,$8F,$03,$85,$5A
	.db $03,$5A,$8F,$4A,$7F,$7F,$7F,$03,$4A,$7F,$32,$59,$85,$59,$02,$59
	.db $8F,$51,$59,$FE
MusicDark_Noise:
	.db $E9,$7F,$85,$13,$F7,$9E,$13,$8F,$11,$85,$13,$8F,$FD,$02,$12,$7F
	.db $FC,$9E,$12,$8F,$12,$02,$12,$BC,$02,$8F,$14,$04,$13,$85,$13,$8F
	.db $11,$02,$13,$7F,$12,$02,$85,$13,$FE,$9E,$5A,$8F,$4A,$AD,$1A,$8F
	.db $12,$1A,$F3,$7F,$49,$41,$21,$39,$31,$09,$01,$F3,$29,$31,$29,$31
	.db $BC,$7F,$F3,$7F,$8F,$7F,$32,$4A,$03,$1B,$03,$7F,$32,$1A,$85,$F3
	.db $59,$02,$59,$8F,$51,$59,$F3,$8F,$7F,$5A,$52,$4A,$42,$3A,$32,$2A
	.db $F3
MusicBeach_Sq1:
	.db $F8,$40,$8C,$FA,$18,$29,$F9,$4B,$FA,$18,$23,$F9,$2B,$FA,$18,$5A
	.db $F9,$03,$4A,$02,$2A,$D4,$7F,$F7,$A4,$4A,$03,$98,$13,$A4,$42,$23
	.db $98,$13,$C8,$4A,$8C,$03,$13,$23,$23,$13,$23,$7F,$13,$7F,$42,$4A
	.db $03,$3B,$2B,$7F,$03,$3A,$4A,$52,$0B,$43,$33,$7F,$0B,$52,$32,$2A
	.db $7F,$7F,$4A,$03,$03,$4A,$03,$2A,$02,$12,$22,$2A,$3A,$4A,$52,$FE
MusicBeach_Sq2:
	.db $8C,$FA,$18,$49,$F9,$2B,$FA,$18,$5A,$F9,$03,$FA,$18,$42,$F9,$4A
	.db $2A,$49,$12,$D4,$7F,$F7,$A4,$2A,$4A,$98,$4A,$59,$8C,$22,$5A,$7F
	.db $42,$22,$59,$98,$22,$8C,$2A,$98,$12,$8C,$22,$2A,$4A,$03,$03,$22
	.db $03,$7F,$42,$7F,$22,$2A,$4A,$23,$13,$7F,$4A,$22,$02,$32,$52,$2B
	.db $1B,$7F,$52,$32,$0A,$49,$7F,$7F,$02,$4A,$4A,$02,$4A,$49,$7F,$59
	.db $51,$49,$51,$02,$12,$FE
MusicBeach_Tri:
	.db $8C,$FA,$18,$29,$F9,$04,$FA,$18,$43,$F9,$4B,$FA,$18,$23,$F9,$2B
	.db $03,$2A,$29,$7F,$39,$0A,$7F,$02,$98,$31,$F7,$98,$29,$8C,$02,$2A
	.db $7F,$02,$7F,$29,$98,$21,$8C,$41,$22,$7F,$59,$7F,$21,$98,$29,$8C
	.db $7F,$02,$4A,$02,$7F,$29,$42,$42,$02,$39,$7F,$01,$7F,$02,$29,$7F
	.db $29,$02,$7F,$7F,$4A,$02,$31,$7F,$31,$0A,$7F,$52,$32,$0A,$29,$7F
	.db $7F,$49,$02,$02,$49,$02,$29,$D4,$7F,$FE
MusicBeach_Noise:
	.db $98,$04,$11,$BC,$7F,$84,$13,$F7,$98,$12,$8C,$12,$7F,$11,$98,$11
	.db $8C,$12,$7F,$12,$84,$13,$98,$12,$8C,$12,$7F,$11,$7F,$11,$98,$12
	.db $8C,$12,$98,$12,$8C,$12,$7F,$11,$7F,$12,$7F,$12,$7F,$84,$13,$8C
	.db $13,$98,$11,$8C,$13,$11,$06,$84,$13,$FE
MusicCave_Sq1:
	.db $8B,$03,$03,$5A,$7F,$42,$7F,$1B,$1B,$7F,$22,$1A,$12,$0A,$A1,$7F
	.db $F7,$8B,$02,$02,$7F,$0A,$0A,$7F,$3A,$3A,$03,$7F,$3A,$7F,$7F,$7F
	.db $42,$23,$A1,$1B,$03,$96,$42,$8B,$1A,$42,$1A,$7F,$A1,$7F,$8B,$2A
	.db $22,$22,$7F,$7F,$0A,$0A,$7F,$7F,$3A,$7F,$3A,$3A,$42,$42,$22,$7F
	.db $7F,$39,$41,$31,$39,$A1,$7F,$FE
MusicCave_Sq2:
	.db $8B,$02,$02,$59,$7F,$41,$7F,$03,$03,$7F,$21,$19,$11,$09,$A1,$7F
	.db $F7,$8B,$01,$01,$7F,$09,$09,$7F,$39,$39,$22,$1A,$22,$1A,$22,$1A
	.db $22,$42,$A1,$03,$42,$96,$1A,$8B,$02,$1A,$87,$02,$59,$88,$51,$87
	.db $49,$41,$88,$39,$8B,$31,$29,$21,$21,$7F,$7F,$09,$09,$7F,$7F,$12
	.db $7F,$12,$12,$1A,$1A,$02,$7F,$7F,$39,$41,$31,$39,$A1,$7F,$FE
MusicCave_Tri:
	.db $8B,$02,$02,$59,$7F,$41,$7F,$42,$42,$7F,$21,$19,$11,$09,$A1,$7F
	.db $F7,$8B,$01,$01,$7F,$09,$09,$7F,$39,$39,$02,$7F,$39,$7F,$7F,$7F
	.db $02,$03,$42,$43,$42,$1A,$1B,$1A,$02,$03,$41,$02,$41,$7F,$A1,$7F
	.db $8B,$29,$21,$21,$7F,$7F,$09,$09,$7F,$7F,$59,$7F,$59,$59,$02,$02
	.db $84,$49,$02,$83,$22,$84,$4A,$03,$83,$23,$84,$03,$4A,$83,$22,$8B
	.db $39,$41,$31,$39,$A1,$7F,$FE
MusicCave_Noise:
	.db $8B,$13,$7F,$11,$7F,$12,$06,$12,$F7,$8B,$FD,$08,$51,$7F,$41,$11
	.db $FC,$FD,$02,$22,$02,$FC,$11,$7F,$15,$02,$14,$7F,$96,$21,$FE
MusicGray_Sq1:
	.db $F8,$40,$8A,$2A,$7F,$85,$2A,$2A,$8A,$32,$32,$32,$3A,$B2,$7F,$F7
	.db $8A,$4A,$7F,$4A,$4A,$4A,$4A,$42,$7F,$42,$22,$7F,$22,$3A,$7F,$3A
	.db $32,$7F,$32,$2A,$3A,$2A,$12,$7F,$49,$41,$7F,$41,$41,$7F,$41,$1A
	.db $7F,$1A,$1A,$7F,$1A,$1A,$22,$1A,$22,$1A,$22,$1A,$7F,$7F,$22,$2A
	.db $3A,$FE
MusicGray_Sq2:
	.db $F8,$00,$8A,$12,$7F,$85,$12,$12,$8A,$1A,$1A,$1A,$22,$B2,$7F,$F7
	.db $8A,$2A,$7F,$2A,$2A,$2A,$2A,$22,$7F,$22,$59,$7F,$59,$12,$7F,$12
	.db $49,$7F,$49,$12,$12,$12,$49,$7F,$29,$19,$7F,$19,$19,$7F,$19,$41
	.db $7F,$41,$41,$7F,$41,$41,$49,$41,$49,$41,$49,$41,$7F,$7F,$0A,$12
	.db $22,$FE
MusicGray_Tri:
	.db $8A,$59,$7F,$85,$59,$59,$8A,$02,$02,$02,$0A,$7F,$7F,$49,$59,$0A
	.db $F7,$8A,$12,$7F,$12,$12,$12,$12,$0A,$7F,$0A,$41,$7F,$85,$59,$51
	.db $8A,$49,$7F,$49,$11,$7F,$11,$11,$7F,$11,$11,$7F,$11,$01,$7F,$01
	.db $01,$7F,$85,$01,$39,$8A,$02,$7F,$02,$02,$7F,$02,$02,$0A,$02,$0A
	.db $02,$0A,$02,$7F,$7F,$49,$59,$0A,$FE
MusicGray_Noise:
	.db $F5,$02,$8A,$11,$7F,$85,$12,$8A,$14,$02,$13,$F7,$FD,$04,$8A,$11
	.db $7F,$12,$7F,$12,$7F,$14,$FC,$FE
MusicBonus_Sq1:
	.db $F8,$00,$86,$F6,$E6,$D4,$4B,$02,$43,$02,$4B,$02,$13,$03,$F6,$E6
	.db $D4,$03,$13,$23,$2B,$3B,$2B,$23,$1B,$FE
MusicBonus_Sq2:
	.db $F8,$00,$86,$F6,$EF,$D4,$03,$7F,$5A,$7F,$03,$7F,$52,$4A,$F6,$EF
	.db $D4,$4A,$52,$03,$13,$23,$13,$03,$5A,$FE
MusicBonus_Tri:
	.db $86,$02,$02,$7F,$3A,$7F,$7F,$03,$3A,$92,$29,$02,$86,$4A,$2A,$02
	.db $02,$7F,$3A,$7F,$03,$7F,$3A,$2A,$2A,$22,$7F,$2A,$7F,$12,$7F,$FE
MusicBonus_Noise:
	.db $86,$FD,$03,$51,$13,$71,$13,$FC,$FD,$02,$72,$61,$7F,$FC,$FE,$52
	.db $13,$2B,$52,$7F,$13,$7F,$2B,$F3,$3A,$52,$13,$3A,$7F,$52,$7F,$13
	.db $F3
MusicEggplant_Sq1:
	.db $F8,$00,$92,$3A,$7F,$42,$7F,$4A,$7F,$7F,$7F,$3A,$7F,$42,$4A,$7F
	.db $4A,$42,$4A,$52,$7F,$52,$7F,$4A,$7F,$42,$7F,$EC,$7F,$89,$1A,$12
	.db $1A,$12,$FE
MusicEggplant_Sq2:
	.db $F8,$00,$92,$22,$7F,$2A,$7F,$32,$7F,$7F,$7F,$22,$7F,$2A,$32,$7F
	.db $32,$2A,$32,$3A,$7F,$3A,$7F,$32,$7F,$2A,$7F,$EC,$7F,$89,$59,$51
	.db $59,$51,$FE
MusicEggplant_Tri:
	.db $B6,$02,$03,$92,$02,$59,$B6,$02,$A4,$03,$92,$02,$59,$02,$1A,$7F
	.db $1A,$7F,$12,$7F,$0A,$7F,$98,$51,$29,$39,$A4,$41,$7F,$FE
MusicEggplant_Noise:
	.db $FD,$04,$A4,$21,$92,$22,$FC,$A4,$24,$98,$23,$92,$21,$03,$FE
MusicDeath_Sq1:
	.db $88,$03,$7F,$03,$0B,$13,$7F,$84,$43,$88,$4B,$7F,$2B,$8C,$7F,$84
	.db $02,$59,$86,$51,$49,$88,$41,$8A,$39,$90,$F2,$31,$FF
MusicDeath_Sq2:
	.db $88,$4A,$7F,$4A,$4A,$52,$7F,$84,$1B,$88,$23,$7F,$4A,$8C,$7F,$84
	.db $02,$59,$86,$51,$49,$88,$41,$8A,$39,$90,$F2,$31,$FF
MusicDeath_Tri:
	.db $88,$2A,$7F,$2A,$32,$3A,$7F,$01,$8C,$7F,$88,$29,$8C,$7F,$84,$02
	.db $59,$86,$51,$49,$88,$41,$8A,$39,$90,$F2,$31,$FF
MusicDeath_Noise:
	.db $88,$11,$7F,$13,$7F,$11,$8C,$7F,$88,$11,$8C,$7F,$84,$12,$86,$12
	.db $88,$12,$8A,$11,$FF
MusicGameOver_Sq1:
	.db $87,$03,$13,$8E,$23,$85,$13,$23,$84,$13,$8E,$2A,$3A,$9C,$4A,$8E
	.db $4A,$13,$9C,$42,$8E,$42,$0B,$FA,$64,$B6,$3A,$85,$32,$84,$2A,$EF
	.db $22,$FF
MusicGameOver_Sq2:
	.db $87,$4A,$52,$8E,$03,$85,$4A,$03,$84,$4A,$8E,$12,$22,$AA,$2A,$F9
	.db $87,$12,$22,$AA,$2A,$87,$0A,$1A,$FA,$64,$B6,$02,$85,$59,$84,$51
	.db $EF,$49,$FF
MusicGameOver_Tri:
	.db $C6,$7F,$8E,$02,$9C,$02,$8E,$02,$59,$9C,$59,$8E,$59,$FA,$64,$DB
	.db $49,$EF,$29
MusicGameOver_Noise:
	.db $FF
MusicEnding_Sq1:
	.db $8B,$01,$02,$09,$0A,$84,$11,$49,$83,$51,$84,$02,$12,$83,$22,$84
	.db $2A,$3A,$83,$4A,$84,$52,$03,$83,$13,$8B,$23,$22,$F6,$03,$CD,$84
	.db $3A,$4A,$83,$52,$84,$5A,$03,$83,$0B,$8B,$13,$03,$22,$3A,$5A,$13
	.db $4A,$86,$42,$85,$4A,$96,$03,$8B,$52,$03,$96,$13,$2B,$AC,$2B,$8B
	.db $4B,$FF
MusicEnding_Sq2:
	.db $8B,$01,$02,$09,$0A,$11,$12,$84,$12,$22,$83,$2A,$84,$3A,$4A,$83
	.db $52,$8B,$4A,$49,$F6,$32,$CD,$84,$1A,$22,$83,$2A,$84,$32,$3A,$83
	.db $42,$8B,$4A,$22,$49,$02,$32,$5A,$32,$86,$2A,$85,$32,$96,$4A,$8B
	.db $3A,$4A,$84,$52,$4A,$83,$42,$84,$3A,$42,$83,$4A,$84,$52,$4A,$83
	.db $42,$84,$3A,$4A,$83,$52,$8B,$4A,$86,$52,$85,$03,$86,$13,$85,$23
	.db $86,$2B,$85,$3B,$8B,$03,$FF
MusicEnding_Tri:
	.db $8B,$01,$02,$09,$0A,$11,$12,$21,$22,$F6,$77,$CD,$21,$22,$19,$1A
	.db $11,$12,$11,$F9,$86,$0A,$85,$12,$84,$01,$02,$83,$01,$84,$02,$01
	.db $83,$02,$84,$01,$02,$83,$01,$84,$02,$01,$83,$02,$84,$01,$02,$83
	.db $01,$84,$02,$01,$83,$02,$84,$01,$02,$83,$01,$84,$02,$01,$83,$02
	.db $8B,$29,$86,$39,$85,$49,$86,$51,$85,$02,$86,$12,$85,$22,$8B,$29
	.db $FF
MusicEnding_Noise:
	.db $F5,$02,$FD,$08,$83,$13,$82,$11,$FC,$8B,$7F,$96,$1F,$86,$11,$85
	.db $11,$8B,$7F,$96,$15,$8B,$12,$02,$84,$12,$83,$11,$8B,$12,$7F,$96
	.db $12,$84,$12,$83,$11,$8B,$11,$96,$13,$86,$11,$85,$11,$FD,$0C,$83
	.db $13,$82,$11,$FC,$8B,$11,$FF
MusicBoss_Sq1:
	.db $F8,$1F,$F4,$06,$F6,$22,$D8,$F6,$0B,$D8,$F4,$01,$91,$1B,$83,$23
	.db $2B,$33,$83,$3B,$43,$4B,$84,$53,$83,$5B,$04,$0C,$84,$14,$F9,$F4
	.db $04,$F6,$22,$D8,$F4,$01,$F6,$0B,$D8,$F9,$84,$3B,$3B,$85,$23,$84
	.db $23,$0B,$85,$0B,$84,$52,$52,$85,$3A,$84,$3A,$22,$85,$22,$FE
MusicBoss_Sq2:
	.db $F8,$1F,$F4,$03,$F6,$22,$D8,$F4,$09,$F6,$53,$D8,$F4,$01,$1B,$13
	.db $85,$0B,$91,$03,$83,$0B,$13,$1B,$83,$23,$2B,$33,$84,$3B,$F9,$F6
	.db $22,$D8,$F6,$53,$D8,$F9,$23,$23,$85,$0B,$84,$0B,$52,$85,$52,$84
	.db $3A,$3A,$85,$22,$84,$22,$0A,$85,$0A,$FE
MusicBoss_Tri:
	.db $F4,$03,$F6,$67,$D8,$F4,$01,$0A,$12,$22,$84,$2A,$9A,$32,$32,$9E
	.db $2A,$83,$22,$1A,$12,$83,$0A,$02,$59,$84,$51,$F9,$F6,$67,$D8,$12
	.db $0A,$02,$84,$59,$97,$51,$94,$51,$F9,$83,$22,$3A,$52,$84,$0B,$0B
	.db $85,$52,$84,$52,$3A,$85,$3A,$84,$22,$22,$85,$0A,$84,$0A,$51,$85
	.db $51,$FE,$FA,$FF,$84,$52,$5A,$85,$03,$84,$0B,$13,$85,$1B,$84,$23
	.db $1B,$85,$13,$84,$0B,$03,$85,$5A,$F3,$83,$51,$52,$39,$84,$52,$83
	.db $21,$52,$39,$84,$52,$83,$0A,$0B,$51,$84,$0B,$83,$39,$0B,$51,$84
	.db $0B,$83,$22,$23,$0A,$84,$23,$83,$51,$23,$0A,$84,$23,$83,$3A,$3B
	.db $22,$84,$3B,$83,$0A,$3B,$22,$84,$3B,$F3,$FA,$FF,$91,$22,$84,$2A
	.db $85,$32,$84,$3A,$42,$85,$4A,$84,$52,$4A,$85,$42,$84,$F3,$8D,$21
	.db $21,$39,$39,$51,$51,$FA,$FF,$0A,$83,$F3
MusicAreaClear_Sq1:
	.db $F6,$CE,$D8,$F4,$03,$F6,$CE,$D8,$F4,$00,$A4,$3B,$86,$3B,$3B,$88
	.db $3A,$5A,$13,$3B,$7F,$13,$E0,$4B,$FF
MusicAreaClear_Sq2:
	.db $F6,$E9,$D8,$F4,$03,$F6,$E9,$D8,$F4,$00,$A4,$13,$86,$13,$13,$88
	.db $12,$3A,$5A,$13,$7F,$5A,$E0,$23,$FF
MusicAreaClear_Tri:
	.db $83,$FD,$10,$11,$12,$FC,$FD,$10,$29,$2A,$FC,$A4,$5A,$86,$5A,$5A
	.db $88,$59,$12,$3A,$5A,$7F,$3A,$E0,$0B,$FF
MusicAreaClear_Noise:
	.db $E0,$02,$83,$1A,$86,$7F,$12,$88,$14,$7F,$11,$83,$1C,$1C,$FF,$86
	.db $13,$8C,$4A,$86,$4A,$8C,$4A,$32,$FA,$20,$90,$4A,$84,$F9,$5A,$0B
	.db $83,$13,$23,$13,$23,$13,$23,$13,$23,$F3,$86,$32,$8C,$12,$86,$12
	.db $8C,$12,$49,$FA,$20,$90,$12,$84,$F9,$22,$2A,$83,$32,$3A,$32,$3A
	.db $32,$3A,$32,$3A,$F3
MusicRoundClear_Sq1:
	.db $87,$03,$8E,$2B,$87,$2B,$8E,$2B,$03,$9C,$1B,$53,$87,$4B,$7F,$2B
	.db $4B,$D4,$F2,$04,$FF
MusicRoundClear_Sq2:
	.db $87,$02,$8E,$4A,$87,$4A,$8E,$4A,$02,$9C,$52,$3B,$87,$03,$7F,$4A
	.db $03,$D4,$4B,$F2,$FF
MusicRoundClear_Tri:
	.db $87,$2B,$03,$2B,$4B,$2B,$03,$2B,$4B,$1B,$52,$1B,$3B,$53,$3B,$53
	.db $1C,$85,$2A,$4A,$84,$03,$87,$2B,$4B,$D4,$F2,$2A
MusicRoundClear_Noise:
	.db $FF
LevelSetTable:
	.db $00,$03,$05,$02			;Area 1
	.db $04,$06,$07,$02			;Area 2
	.db $08,$01,$03,$02			;Area 3
	.db $00,$0A,$09,$02			;Area 4
	.db $04,$07,$08,$02			;Area 5
	.db $03,$05,$0A,$02			;Area 6
	.db $09,$04,$07,$02			;Area 7
	.db $0A,$03,$08,$02			;Area 8
	.db $0B
LevelSetFlags:
	.db $00,$00,$05,$59,$59,$22,$27,$22,$23,$24,$18,$00
GraphicsSetDataOffsetTable:
	.dw GraphicsSet1RoomData
	.dw GraphicsSet1RoomStrips
	.dw GraphicsSet1RoomsTopHalfStrips
	.dw GraphicsSet1RoomsBottomHalfStrips
	.dw GraphicsSet1BlockTiles
	.dw GraphicsSet1BlockPalettes
	.dw GraphicsSet2RoomData
	.dw GraphicsSet2RoomStrips
	.dw GraphicsSet2RoomsTopHalfStrips
	.dw GraphicsSet2RoomsBottomHalfStrips
	.dw GraphicsSet2BlockTiles
	.dw GraphicsSet2BlockPalettes
	.dw GraphicsSet3RoomData
	.dw GraphicsSet3RoomStrips
	.dw GraphicsSet3RoomsTopHalfStrips
	.dw GraphicsSet3RoomsBottomHalfStrips
	.dw GraphicsSet3BlockTiles
	.dw GraphicsSet3BlockPalettes
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
;ROOM DATA
;Each room (256px wide section of level) consists of 3 bytes,
;the format is as follows:
;aaaaaaBB bbbbCCCC ccdddddd
;aaaaaa: Strip for column 1
;BBbbbb: Strip for column 2
;CCCCcc: Strip for column 3
;dddddd: Strip for column 4
GraphicsSet1RoomData:
	.db $00,$10,$83,$10,$51,$45,$14,$51,$45,$18,$72,$09
	.db $48,$82,$4A,$28,$51,$45,$2C,$C2,$CC,$14,$F4,$50
	.db $3D,$14,$50,$3D,$14,$51,$45,$14,$51,$40,$51,$45
	.db $34,$E3,$4E,$4C,$15,$15,$14,$53,$D1,$59,$85,$D8
	.db $59,$86,$5A
GraphicsSet1RoomStrips:
	.db $00,$00,$01,$00,$02,$00,$03,$00
	.db $04,$01,$05,$02,$06,$03,$07,$00
	.db $08,$00,$09,$00,$0A,$01,$05,$05
	.db $05,$06,$0B,$0A,$05,$07,$05,$08
	.db $05,$09,$05,$04,$0C,$00,$0D,$00
	.db $0E,$00,$0F,$00,$10,$0B,$11,$0B
	.db $12,$0B,$11,$0C,$12,$0C
GraphicsSet1RoomBottomHalfStrips:
	.db $05,$06,$07,$07,$07
	.db $15,$06,$07,$07,$07
	.db $16,$06,$07,$07,$07
	.db $17,$06,$07,$07,$07
	.db $13,$13,$13,$13,$13
	.db $20,$21,$22,$23,$23
	.db $24,$25,$26,$27,$27
	.db $28,$29,$2A,$2A,$2A
	.db $2C,$2D,$2E,$2E,$2E
	.db $2F,$30,$31,$31,$31
	.db $38,$39,$3A,$3A,$3A
	.db $42,$43,$43,$43,$43
	.db $3C,$3C,$3C,$3C,$3C
GraphicsSet1RoomsTopHalfStrips:
	.db $00,$00,$01,$02,$03,$04
	.db $00,$00,$01,$08,$09,$0A
	.db $00,$00,$01,$0B,$0C,$0D
	.db $00,$00,$01,$0E,$0F,$10
	.db $11,$11,$12,$13,$13,$14
	.db $13,$13,$13,$13,$13,$13
	.db $13,$13,$13,$1C,$13,$18
	.db $13,$13,$13,$19,$1A,$1B
	.db $13,$13,$13,$13,$1C,$1D
	.db $13,$13,$13,$13,$19,$1B
	.db $13,$13,$13,$13,$13,$1E
	.db $13,$13,$13,$13,$13,$2B
	.db $13,$13,$13,$13,$13,$1D
	.db $00,$00,$01,$02,$1F,$04
	.db $00,$00,$01,$32,$33,$34
	.db $00,$00,$01,$35,$36,$37
	.db $3B,$3B,$3D,$3E,$3F,$40
	.db $3B,$3B,$3C,$41,$3C,$3C
	.db $3B,$3B,$3C,$3C,$3C,$3C
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
GraphicsSet3RoomData:
	.db $00,$00,$00,$00,$00,$01,$08,$20,$83,$10,$41,$04
	.db $14,$51,$45,$18,$61,$86,$1C,$71,$C7,$20,$91,$C7
	.db $1C,$A2,$C7,$20,$92,$09,$30,$20,$82,$34,$00,$00
	.db $38,$E1,$C7,$38,$E3,$87,$38,$E3,$8E,$38,$F2,$47
	.db $45,$14,$51,$41,$04,$10,$41,$04,$51,$49,$24,$92
	.db $45,$14,$53,$8A,$28,$A2,$4D,$14,$51,$50,$41,$04
	.db $10,$41,$14,$04,$20,$9D,$74,$00,$01,$74,$00,$00
	.db $55,$65,$96,$59,$65,$96,$59,$65,$97,$61,$96,$98
	.db $55,$65,$97,$61,$86,$18,$55,$B7,$16,$59,$B7,$16
	.db $5D,$86,$15,$59,$B7,$17,$5D,$96,$95,$59,$E7,$DF
	.db $7D,$F7,$DF,$81,$F7,$DF,$7D,$F8,$56,$08,$20,$82
GraphicsSet3RoomsBottomHalfStrips:
	.db $06,$07,$07,$07,$07
	.db $08,$09,$09,$09,$09
	.db $0A,$0A,$0A,$0A,$0A
	.db $0C,$0D,$0D,$0D,$0D
	.db $0B,$0B,$0B,$0B,$0B
	.db $0E,$0E,$0E,$0E,$0E
	.db $10,$10,$10,$10,$10
	.db $24,$24,$24,$24,$24
	.db $0C,$0D,$0D,$0D,$0D
	.db $24,$24,$24,$0C,$0D
	.db $25,$26,$26,$26,$26
	.db $21,$21,$21,$21,$21
	.db $0D,$0D,$0D,$0D,$0D
GraphicsSet3RoomsTopHalfStrips:
	.db $00,$01,$02,$03,$04,$05
	.db $00,$01,$1D,$1E,$04,$05
	.db $0B,$0B,$0B,$0B,$0B,$0B
	.db $0E,$0E,$0F,$10,$10,$10
	.db $0E,$0E,$0F,$11,$12,$13
	.db $0E,$0E,$0F,$14,$15,$16
	.db $0E,$0E,$0F,$17,$18,$19
	.db $0E,$0E,$0F,$1A,$1B,$1C
	.db $00,$01,$1F,$20,$04,$05
	.db $24,$24,$24,$24,$24,$24
	.db $24,$24,$24,$24,$24,$0C
	.db $21,$21,$21,$21,$21,$21
	.db $22,$22,$22,$22,$22,$22
	.db $23,$23,$23,$23,$23,$23
	.db $28,$28,$28,$28,$28,$28
	.db $27,$27,$27,$27,$27,$27
GraphicsSet3RoomStrips:
	.db $00,$00,$00,$01,$00,$02,$01,$02
	.db $02,$03,$02,$04,$02,$05,$03,$05
	.db $04,$05,$05,$05,$06,$05,$07,$05
	.db $08,$02,$00,$03,$03,$06,$04,$06
	.db $09,$07,$09,$03,$0A,$0C,$09,$08
	.db $02,$08,$0B,$0A,$0B,$00,$0B,$01
	.db $0B,$0B,$0C,$0B,$0D,$0B,$0C,$00
	.db $0D,$00,$00,$0A,$0E,$00,$02,$00
	.db $02,$0A,$0F,$00,$09,$09
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
GraphicsSet2RoomData:
	.db $00,$00,$42,$0C,$31,$03,$14,$61,$87,$0C,$82,$43
	.db $14,$61,$86,$18,$61,$87,$0C,$31,$46,$18,$61,$86
	.db $18,$A4,$0B,$30,$D3,$8F,$45,$24,$D4,$45,$55,$94
	.db $5D,$86,$54,$5E,$06,$94,$45,$B7,$1D,$45,$E7,$DD
	.db $0C,$30,$C3
GraphicsSet2RoomsTopHalfStrips:
	.db $00,$00,$00,$01,$02,$03
	.db $00,$00,$00,$06,$07,$08
	.db $00,$00,$00,$09,$00,$00
	.db $00,$00,$00,$00,$00,$00
	.db $00,$00,$0B,$00,$00,$00
	.db $00,$00,$00,$00,$00,$0C
	.db $00,$00,$00,$00,$00,$0D
	.db $00,$00,$00,$00,$00,$0E
	.db $00,$00,$0F,$10,$00,$00
	.db $00,$00,$11,$12,$00,$00
	.db $00,$00,$13,$14,$15,$0D
	.db $00,$00,$16,$00,$00,$0D
	.db $00,$17,$18,$19,$1A,$28
	.db $00,$1B,$1C,$1D,$1E,$28
	.db $00,$1F,$20,$21,$22,$28
	.db $00,$1F,$23,$24,$25,$28
	.db $00,$00,$26,$27,$27,$0D
GraphicsSet2RoomsBottomHalfStrips:
	.db $05,$05,$05,$05,$05
	.db $0A,$05,$05,$05,$05
	.db $29,$05,$05,$05,$05
	.db $2A,$05,$05,$05,$05
	.db $2B,$2C,$2C,$2C,$2C
	.db $2D,$2E,$2E,$2E,$2E
	.db $3B,$04,$04,$04,$04
	.db $2F,$30,$30,$30,$30
	.db $00,$2F,$30,$30,$30
	.db $00,$2F,$31,$32,$32
	.db $2F,$30,$33,$34,$34
	.db $3B,$04,$35,$36,$36
	.db $00,$37,$38,$39,$39
	.db $00,$37,$3A,$3A,$3A
GraphicsSet2RoomStrips:
	.db $00,$00,$01,$01,$02,$01,$03,$01
	.db $04,$01,$05,$02,$06,$00,$07,$03
	.db $08,$01,$09,$01,$0A,$00,$0B,$00
	.db $0C,$00,$0D,$00,$0E,$00,$0F,$00
	.db $10,$00,$03,$04,$03,$05,$04,$06
	.db $03,$07,$08,$05,$09,$06,$03,$08
	.db $08,$09,$09,$0A,$03,$0A,$03,$0B
	.db $04,$0C,$03,$0D,$08,$0B,$09,$0C
	.db $04,$09
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



;;;;;;;;;;;;
;INTERRUPTS;
;;;;;;;;;;;;
;Unused bytes
	.db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.db $FF
;.org $FFFA
	.dw NMI
	.dw Reset
	.dw IRQ
