;;;;;;;;;;;;;;;;
;GAME VARIABLES;
;;;;;;;;;;;;;;;;
Temps			.equ $00
Mirror_PPUCtrl		.equ $04
Mirror_PPUMask		.equ $05
Mirror_PPUScrollX	.equ $06
Mirror_PPUScrollY	.equ $07
PadCur			.equ $08
SetCHRBankFlag		.equ $0A
GraphicsNMITaskFlag	.equ $0B
GlobalNMITaskFlag	.equ $0C
LifeSoundEffectFlag	.equ $0D
InvSelectStartBits	.equ $0E
SelectStartBits		.equ $0F
UnkB_10			.equ $10
UnkB_11			.equ $11
ClearBridgeFlag		.equ $12
WritePaletteFlag	.equ $13
WriteNormScrollFlag	.equ $14
WriteSlopeScrollFlag	.equ $15
WriteNormAttrFlag	.equ $16
WriteSlopeAttrFlag	.equ $17
UnkW_18			.equ $18
LevelDataPointer	.equ $1A
UnkW_1C			.equ $1C
UnkW_1E			.equ $1C



UnkW_26			.equ $26




AreaNum			.equ $37
RoundNum		.equ $38





NumLives		.equ $3F
DemoFlag		.equ $40
PauseGraphicsFlag	.equ $41
DemoCounter		.equ $42
DemoInput		.equ $43




LevelNum		.equ $51
LevelSet		.equ $52



DrawSpriteX		.equ $5A


DrawSpriteY		.equ $5D


TimerHi			.equ $76
TimerLo			.equ $77
UnkB_78			.equ $78
UnkB_79			.equ $79
UnkB_7A			.equ $7A
UnkB_7B			.equ $7B
UnkPW_7C		.equ $7C
EnemySettingsPointer	.equ $82


EnemySettingsIndex	.equ $87


UnkW_99			.equ $99
UnkB_9B			.equ $9B
DemoDataPointer		.equ $9C
UnkB_9E			.equ $9E
UnkB_9F			.equ $9F
SoundEffectID		.equ $A0
SoundEffectInit		.equ $A1
SoundEffectTimers	.equ $A2
UnkB_A6			.equ $A6
UnkB_A7			.equ $A7
UnkW_A8			.equ $A8
UnkB_AA			.equ $AA
MusicID			.equ $AB
SilenceAudioFlag	.equ $AC
MusicPointers		.equ $AD
MusicNoteLengths	.equ $B5
MusicNoteTimers		.equ $B9
UnkPB_BD		.equ $BD
UnkPB_C1		.equ $C1
UnkPB_C9		.equ $C9
UnkPB_D1		.equ $D1
UnkPB_D5		.equ $D5
MusicLoopPointers	.equ $D9
MusicReturnPointers	.equ $E1
MusicPitchShift		.equ $E9
UnkPB_EC		.equ $EC
UnkPB_F0		.equ $F0
UnkPB_F4		.equ $F4
UnkB_F8			.equ $F8
MusicNoiseRepeatCounter	.equ $F9
CurMusicChan		.equ $FA
NumMusChansPlaying	.equ $FB
CurMusicByte		.equ $FC
PaletteVRAMBuffer	.equ $0140
SlopeScrollAttrBuffer	.equ $0160
SlopeScrollTileBuffer	.equ $01E0
UnkPB_03E0		.equ $03E0
UnkPB_0420		.equ $0420
UnkPB_0460		.equ $0460
UnkPB_0498		.equ $0498
SlopeScrollVRAMBuffer	.equ $04B4
NormScrollVRAMBuffer	.equ $04D4
SlopeAttrVRAMBuffer	.equ $04F2
NormAttrVRAMBuffer	.equ $04FA
CurrentStrips		.equ $0502
UnkPB_0506		.equ $0506
UnkPB_050B		.equ $050B
UnkPB_0510		.equ $0510
UnkPB_0515		.equ $0515
NormScrollVRAMDest	.equ $051A
SlopeScrollVRAMDestA	.equ $051C
SlopeScrollVRAMDestB	.equ $051E
SlopeScrollDir		.equ $0520
NormAttrVRAMDest	.equ $0521
SlopeAttrVRAMDestA	.equ $0523
SlopeAttrVRAMDestB	.equ $0525
SlopeAttrDir		.equ $0527
UnkB_0528		.equ $0528
CurrentLifeBonus	.equ $0529




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
Enemy_Unk05A4		.equ $05A4
Enemy_SubYPos		.equ $05B4
Enemy_ScreenYPos	.equ $05C4
Enemy_YVel		.equ $05D4
Enemy_WorldXPos		.equ $05E4
Enemy_WorldYPos		.equ $05F4
Enemy_ColiWidth		.equ $0604
Enemy_ColiHeight	.equ $0614
Enemy_Unk0624		.equ $0624
Enemy_Unk0634		.equ $0634
Enemy_Sprite		.equ $0644
Enemy_Unk0654		.equ $0654
Enemy_Unk0664		.equ $0664
Enemy_Unk0674		.equ $0674
UnkB_0684		.equ $0684
UnkB_0686		.equ $0686
ColdBootStringRAM	.equ $0694
ScoreCurrent		.equ $069A
ScoreTop		.equ $06A3
ScoreRoundBonus		.equ $06AC
ScorePotBonus		.equ $06B5
OAMBuffer		.equ $0700

;;;;;;;;;;;;;;
;GAME DEFINES;
;;;;;;;;;;;;;;
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
ENEMY_FLOWER2		.equ $21
ENEMY_FROGR_POT		.equ $22
ENEMY_SQUIDR1		.equ $23
ENEMY_LONGFISH		.equ $24
ENEMY_SQUIDR2		.equ $25
ENEMY_ICICLE1		.equ $26
ENEMY_ICICLE2		.equ $27
ENEMY_SQUIDB1		.equ $28
ENEMY_SQUIDB2		.equ $29
ENEMY_PROJSNAKEFIRE	.equ $2A
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

MUSIC_TITLE		.equ $01
MUSIC_JUNGLE		.equ $02
MUSIC_DARK		.equ $03
MUSIC_BEACH		.equ $04
MUSIC_CAVE		.equ $05
MUSIC_GRAY		.equ $06
MUSIC_BONUS		.equ $07
MUSIC_EGGPLANT		.equ $08
MUSIC_DEATH		.equ $09
MUSIC_GAMEOVER		.equ $0A
MUSIC_ENDING		.equ $0B
MUSIC_BOSS		.equ $0C
MUSIC_AREACLEAR		.equ $0D
MUSIC_ROUNDCLEAR	.equ $0E

SE_BIGJUMP		.equ $01
SE_TRIP			.equ $02
SE_FRUIT		.equ $03
SE_HARDOBJ		.equ $04
SE_STONE		.equ $05
SE_PROJ			.equ $06
SE_SQUID		.equ $07
SE_TRAMPOLINE		.equ $08
SE_FROG			.equ $09
SE_GETITEM		.equ $0A
SE_FIRE			.equ $0B
SE_DEATH		.equ $0C
SE_DEFEAT		.equ $0D
SE_SPLASH		.equ $0E
SE_LOSEITEM		.equ $0F
SE_1UP			.equ $10
SE_PAUSE		.equ $11
SE_BLIP			.equ $12
SE_SMALLJUMP		.equ $13
