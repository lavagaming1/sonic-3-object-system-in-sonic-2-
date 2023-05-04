MTZ_Header:
	smpsHeaderStartSong 2
	smpsHeaderVoice     MTZ_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $EA

	smpsHeaderDAC       MTZ_DAC
	smpsHeaderFM        MTZ_FM1,	$F4, $0E
	smpsHeaderFM        MTZ_FM2,	$18, $0A
	smpsHeaderFM        MTZ_FM3,	$0C, $14
	smpsHeaderFM        MTZ_FM4,	$0C, $16
	smpsHeaderFM        MTZ_FM5,	$0C, $16
	smpsHeaderPSG       MTZ_PSG1,	$E8, $06, $00, $00
	smpsHeaderPSG       MTZ_PSG2,	$DC, $08, $00, $00
	smpsHeaderPSG       MTZ_PSG3,	$00, $02, $00, fTone_03

; PSG1 Data
MTZ_PSG1:
	smpsStop

; PSG2 Data
MTZ_PSG2:
	smpsStop

; FM1 Data
MTZ_FM1:
	smpsStop


; FM3 Data
MTZ_FM3:
	smpsStop

; FM4 Data
MTZ_FM4:
	smpsStop



; FM5 Data
MTZ_FM5:
	smpsStop

; FM2 Data
MTZ_FM2:
	smpsStop


; DAC Data
MTZ_DAC:
	dc.b	dVLowTimpani, $0C, dLowTimpani, $0C, dTimpani, $0C, dMidTimpani, $1C, dHiTimpani, $0C
	smpsJump            MTZ_DAC


; PSG3 Data
MTZ_PSG3:
	smpsStop

MTZ_Voices:
;	Voice $00
;	$3C
;	$31, $52, $50, $30, 	$52, $53, $52, $53, 	$08, $00, $08, $00
;	$04, $00, $04, $00, 	$10, $0B, $10, $0D, 	$19, $80, $0B, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $05, $05, $03
	smpsVcCoarseFreq    $00, $00, $02, $01
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $13, $12, $13, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $08, $00, $08
	smpsVcDecayRate2    $00, $04, $00, $04
	smpsVcDecayLevel    $00, $01, $00, $01
	smpsVcReleaseRate   $0D, $00, $0B, $00
	smpsVcTotalLevel    $00, $0B, $00, $19

;	Voice $01
;	$3A
;	$01, $07, $01, $01, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $01, 	$1F, $FF, $1F, $0F, 	$17, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $01, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $28, $17

;	Voice $02
;	$3A
;	$01, $40, $01, $31, 	$1F, $1F, $1F, $1F, 	$0B, $04, $04, $04
;	$02, $04, $03, $02, 	$5F, $1F, $5F, $2F, 	$18, $05, $11, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $00, $04, $00
	smpsVcCoarseFreq    $01, $01, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $04, $04, $0B
	smpsVcDecayRate2    $02, $03, $04, $02
	smpsVcDecayLevel    $02, $05, $01, $05
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $11, $05, $18

;	Voice $03
;	$29
;	$16, $14, $58, $54, 	$1F, $1F, $DF, $1F, 	$00, $00, $01, $00
;	$00, $00, $03, $00, 	$06, $06, $06, $0A, 	$1B, $1C, $16, $00
	smpsVcAlgorithm     $01
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $05, $05, $01, $01
	smpsVcCoarseFreq    $04, $08, $04, $06
	smpsVcRateScale     $00, $03, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $01, $00, $00
	smpsVcDecayRate2    $00, $03, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0A, $06, $06, $06
	smpsVcTotalLevel    $00, $16, $1C, $1B

;	Voice $04
;	$08
;	$09, $70, $30, $00, 	$1F, $1F, $5F, $5F, 	$12, $0E, $0A, $0A
;	$00, $04, $04, $03, 	$2F, $2F, $2F, $2F, 	$25, $30, $0E, $84
	smpsVcAlgorithm     $00
	smpsVcFeedback      $01
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $07, $00
	smpsVcCoarseFreq    $00, $00, $00, $09
	smpsVcRateScale     $01, $01, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0A, $0E, $12
	smpsVcDecayRate2    $03, $04, $04, $00
	smpsVcDecayLevel    $02, $02, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $04, $0E, $30, $25

;	Voice $05
;	$08
;	$09, $70, $30, $00, 	$1F, $1F, $5F, $5F, 	$12, $0E, $0A, $0A
;	$00, $04, $04, $03, 	$2F, $2F, $2F, $2F, 	$25, $30, $13, $84
	smpsVcAlgorithm     $00
	smpsVcFeedback      $01
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $07, $00
	smpsVcCoarseFreq    $00, $00, $00, $09
	smpsVcRateScale     $01, $01, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0A, $0E, $12
	smpsVcDecayRate2    $03, $04, $04, $00
	smpsVcDecayLevel    $02, $02, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $04, $13, $30, $25

