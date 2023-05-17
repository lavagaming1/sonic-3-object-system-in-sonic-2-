Sound5E_WingFortress_Header:
	smpsHeaderStartSong 2
	smpsHeaderVoice     Sound5E_WingFortress_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM4, Sound5E_WingFortress_FM4,	$FA, $0B

; FM3 Data
Sound5E_WingFortress_FM4:
	smpsSetvoice        $00
	dc.b	nF2, $08, $08, $08

Sound5E_WingFortress_Voices:
;	Voice $00
;	$3C
;	$00, $01, $00, $01, 	$1F, $0D, $12, $14, 	$10, $00, $1F, $00
;	$09, $13, $0A, $12, 	$FF, $0F, $FF, $0F, 	$00, $A0, $00, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $00, $01, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $12, $0D, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $1F, $00, $10
	smpsVcDecayRate2    $12, $0A, $13, $09
	smpsVcDecayLevel    $00, $0F, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $20, $00


