Snd_Menu_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice	SaveScreenVoices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $40

	smpsHeaderDAC       Snd_Menu_DAC
	smpsHeaderFM        Snd_Menu_FM1,	$0C, $12
	smpsHeaderFM        Snd_Menu_FM2,	$0C, $19
	smpsHeaderFM        Snd_Menu_FM3,	$0C, $19
	smpsHeaderFM        Snd_Menu_FM4,	$0C, $19
	smpsHeaderFM        Snd_Menu_FM5,	$0C, $19
	smpsHeaderPSG       Snd_Menu_PSG1,	$00, $06, $00, fTone_0C
	smpsHeaderPSG       Snd_Menu_PSG2,	$00, $06, $00, fTone_0C
	smpsHeaderPSG       Snd_Menu_PSG3,	$00, $04, $00, fTone_0C

; Unreachable
	smpsStop
	smpsStop

Snd_Menu_Call00:
	dc.b	dKick, $12, dKick, $06, dKick, dHiTom, $0C, dKick, $06, dKick, $12, dKick
	dc.b	$06, dKick, dMidTom, dLowTom, $0C
	smpsReturn

; DAC Data
Snd_Menu_DAC:
	dc.b	nRst, $2A

Snd_Menu_Loop00:
	smpsCall            Snd_Menu_Call00
	smpsLoop            $01, $03, Snd_Menu_Loop00
	dc.b	dKick, $12, dKick, $06, dKick, dHiTom, $0C, dKick, $06, dKick, $02, dHiTimpani
	dc.b	$03, dHiTimpani, $01, dHiTimpani, $0C, dHiTimpani, $06, dHiTimpani, $08, dHiTimpani, dMidTimpani

Snd_Menu_Loop01:
	smpsCall            Snd_Menu_Call00
	smpsLoop            $01, $03, Snd_Menu_Loop01
	dc.b	dLowTom, $06, dLowTom, dLowTom, $12, dLowTom, $06, dLowTom, dLowTom, $1E, dMidTom, $18

Snd_Menu_Loop02:
	smpsCall            Snd_Menu_Call00
	smpsLoop            $01, $07, Snd_Menu_Loop02
	dc.b	dKick, $12, dKick, $06, dKick, dHiTom, $0C, dKick, $06, dKick, dHiTimpani, $0C
	dc.b	dHiTimpani, $06, dHiTimpani, $0C, dLowTom

Snd_Menu_Loop03:
	smpsCall            Snd_Menu_Call00
	smpsLoop            $01, $02, Snd_Menu_Loop03
	dc.b	dKick, $12, dKick, $06, dKick, dHiTom, $0C, dKick, $06, dKick, $12, dKick
	dc.b	$06, dKick, dMidTom, dLowTom, $0C, dLowTom, $06, dLowTom, dLowTom, $12, dLowTom, $06
	dc.b	dLowTom, dLowTom, $1E, dMidTom, $18

Snd_Menu_Loop04:
	smpsCall            Snd_Menu_Call00
	smpsLoop            $01, $03, Snd_Menu_Loop04
	dc.b	dLowTom, $06, dKick, $0C, dLowTom, $06, dKick, dLowTom, dLowTom, dMidTom, $0C, dKick
	dc.b	$12, dKick, $06, dKick, dHiTom, $0C

Snd_Menu_Loop05:
	smpsCall            Snd_Menu_Call00
	smpsLoop            $01, $02, Snd_Menu_Loop05
	dc.b	dKick, $12, dKick, $06, dKick, dHiTom, $0C, dKick, $06, dKick, $12, dKick
	dc.b	$06, dKick, dMidTom, dLowTom, $0C, dLowTom, dKick, $06, dLowTom, $0C, dKick, $06
	dc.b	dLowTom, nRst, $36
	smpsJump            Snd_Menu_Loop00

; Unreachable
	smpsStop

; FM1 Data
Snd_Menu_FM1:
	dc.b	nRst, $2A

Snd_Menu_Jump04:
	smpsSetvoice        $00
	dc.b	nC1, $12, nG1, nC2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12
	dc.b	nF1, nBb1, $0C, nG0, $12, nD1, nG1, $0C, nC1, $12, nG1, nC2
	dc.b	$0C, nF1, $12, nC2, nF2, $0C, nBb0, $12, nC1, nD1, $0C, nRst
	dc.b	$30, nC1, $12, nG1, nC2, $0C, nF1, $12, nC2, nF2, $0C, nBb0
	dc.b	$12, nF1, nBb1, $0C, nG1, $12, nD2, nG2, $0C, nC1, $12, nG1
	dc.b	nC2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $06, nBb0, nBb0, nRst
	dc.b	$0C, nBb0, $06, nBb0, nBb0, nRst, $30, nF1, $12, nC2, nF2, $0C
	dc.b	nBb0, $12, nF1, nBb1, $0C, nEb1, $12, nBb1, nEb2, $0C, nEb1, $12
	dc.b	nBb1, nEb2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12, nF1, nBb1
	dc.b	$0C, nEb1, $12, nBb1, nEb2, $0C, nEb1, $12, nF1, nFs1, $0C, nG1
	dc.b	$12, nD2, nG2, $0C, nC1, $12, nG1, nC2, $0C, nF1, $12, nC2
	dc.b	nF2, $0C, nD1, $12, nA1, nD2, $0C, nG1, $12, nD2, nG2, $0C
	dc.b	nC1, $12, nG1, nC2, $0C, nF1, $12, nC1, nF0, $0C, nRst, $30
	dc.b	nC1, $12, nG1, nC2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12
	dc.b	nF1, nBb1, $0C, nG1, $12, nD2, nG2, $0C, nC1, $12, nG1, nC2
	dc.b	$0C, nF1, $12, nC2, nF2, $0C, nBb0, $06, nBb0, nBb0, nRst, $0C
	dc.b	nBb0, $06, nBb0, nBb0, nRst, $30, nF1, $12, nC2, nF2, $0C, nF1
	dc.b	$12, nC2, nF2, $0C, nF1, $12, nC2, nF2, $0C, nG1, $18, nFs1
	dc.b	nF1, $12, nC2, nF2, $0C, nF1, $12, nC2, nF2, $0C, nBb1, $12
	dc.b	nBb1, $06, nRst, nF1, nFs1, nG1, $0C, nG1, $06, nD2, $0C, nG2
	dc.b	$06, nD2, nG1, $0C, nF1, $12, nC2, nF2, $0C, nF1, $12, nC2
	dc.b	nF2, $0C, nF1, $12, nC2, nF2, $0C, nG1, $18, nFs1, nF1, $12
	dc.b	nC2, nF2, $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12, nC1, nD1
	dc.b	$0C, nRst, $30
	smpsJump            Snd_Menu_Jump04

; Unreachable
	smpsStop

; FM2 Data
Snd_Menu_FM2:
	smpsSetvoice        $12
	smpsAlterNote       $00
	smpsModSet          $03, $01, $FC, $05
	smpsPan             panCenter, $00
	dc.b	nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3

Snd_Menu_Jump03:
	dc.b	nA3, $03, nBb3, nA3, $0C, nG3, $26, nA3, $08, nBb3, nC4, nA3
	dc.b	nG3, nG3, $03, nA3, nG3, $0C, nF3, $21, nCs3, $03, nD3, $0C
	dc.b	nEb3, $06, nF3, $08, nG3, nD3, nF3, $12, nEb3, $0F, nA3, $03
	dc.b	nBb3, $0C, nA3, $12, nG3, nA3, $0C, nG3, $03, nA3, nG3, $0C
	dc.b	nF3, $24, nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3, nA3, $03
	dc.b	nBb3, nA3, $0C, nG3, $26, nA3, $08, nBb3, nC4, nA3, nG3, nG3
	dc.b	$03, nA3, nG3, $0C, nF3, $22, nFs3, $04, nG3, $08, nA3, nB3
	dc.b	nC4, nD4, nEb4, $12, nG3, nBb3, $0C, nA3, $12, nG3, nA3, $0C
	dc.b	nBb3, $06, nBb3, nBb3, $12, nBb3, $06, nBb3, nBb3, $2A
	smpsSetvoice        $0F
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $06, $05
	dc.b	nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4, nEb5, $0C, nD5, $18
	dc.b	nRst, $0C, nBb4, $03, nRst, nC5, nRst, nD5, $12, nG5, nD5, $0C
	dc.b	nC5, $18, nRst, $0C, nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4
	dc.b	nEb5, $0C, nD5, $12, nF5, nD5, $0C, nC5, $03, nD5, nC5, $0C
	dc.b	nBb4, $36, nRst, $0C, nD5, $03, nRst, nE5, nRst, nF5, $12, nBb4
	dc.b	nF5, $0C, nE5, $18, nRst, $0C, nC5, $03, nRst, nD5, nRst, nE5
	dc.b	$12, nA5, nE5, $0C, nD5, $18, nRst, $0C, nA4, $06, nBb4, nC5
	dc.b	$03, nRst, $09, nD5, $03, nRst, nBb4, nRst, $09, nC5, $03, nRst
	dc.b	$09, nA4, $03, nRst, $09, nBb4, $03, nRst, $09, nG4, $03, nRst
	dc.b	$09, nA4, $0C, nAb4, $02, nG4, nFs4, nF4, $06, nRst, $30
	smpsSetvoice        $12
	smpsAlterNote       $00
	smpsModSet          $03, $01, $FC, $05
	smpsPan             panCenter, $00
	dc.b	nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3, nA3, $03, nBb3, nA3
	dc.b	$0C, nG3, $26, nA3, $08, nBb3, nC4, nA3, nG3, nG3, $03, nA3
	dc.b	nG3, $0C, nF3, $22, nFs3, $04, nG3, $08, nA3, nB3, nC4, nD4
	dc.b	nEb4, $12, nG3, nBb3, $0C, nA3, $12, nG3, nA3, $0C, nBb3, $06
	dc.b	nBb3, nBb3, $12, nBb3, $06, nBb3, nBb3, $3C
	smpsSetvoice        $0D
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4, nRst, $09, nBb3, $03
	dc.b	nRst, nC4, nRst, $09, nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	smpsSetvoice        $0B
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nG3, $03, nRst, nA3, $06, nBb3, $0C
	smpsSetvoice        $0D
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $06, nG3, $03, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	smpsSetvoice        $0F
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $06, $05
	dc.b	nBb4, $06, nA4, nF4, nD4, nBb3, nA3, nG3, $0C, nRst, $30
	smpsSetvoice        $0D
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4, nRst, $09, nBb3, $03
	dc.b	nRst, nC4, nRst, $09, nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	smpsSetvoice        $0B
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nG3, $03, nRst, nA3, $06, nBb3, $0C
	smpsSetvoice        $0D
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	smpsSetvoice        $0F
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $06, $05
	dc.b	nBb4, $06, nA4, nF4, nD4, nBb3, nA3, nG3, $0C
	smpsSetvoice        $12
	smpsAlterNote       $00
	smpsModSet          $03, $01, $FC, $05
	smpsPan             panCenter, $00
	dc.b	nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3
	smpsJump            Snd_Menu_Jump03

; Unreachable
	smpsStop

; FM3 Data
Snd_Menu_FM3:
	smpsSetvoice        $12
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $04, $05
	smpsPan             panCenter, $00
	dc.b	nBb2, $0C, nBb2, $06, nBb2, $08, nA2, nBb2

Snd_Menu_Jump02:
	smpsSetvoice        $12
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $04, $05
	smpsPan             panCenter, $00
	dc.b	nA2, $03, nBb2, nA2, $0C, nG2, $26, nA2, $08, nBb2, nC3, nA2
	dc.b	nG2, nG2, $03, nA2, nG2, $0C, nF2, $21, nCs2, $03, nD2, $0C
	dc.b	nEb2, $06, nF2, $08, nG2, nD2, nF2, $12, nEb2, $0F, nA2, $03
	dc.b	nBb2, $0C, nA2, $12, nG2, nA2, $0C, nG2, $03, nA2, nG2, $0C
	dc.b	nF2, $24, nBb2, $0C, nBb2, $06, nBb2, $08, nA2, nBb2, nA2, $03
	dc.b	nBb2, nA2, $0C, nG2, $26, nA2, $08, nBb2, nC3, nA2, nG2, nG2
	dc.b	$03, nA2, nG2, $0C, nF2, $22, nFs2, $04, nG2, $08, nA2, nB2
	dc.b	nC3, nD3, nEb3, $12, nG2, nBb2, $0C, nA2, $12, nG2, nA2, $0C
	dc.b	nBb2, $06, nBb2, nBb2, $12, nBb2, $06, nBb2, nBb2, $30
	smpsSetvoice        $0F
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $06, $05
	smpsFMAlterVol      $14
	dc.b	nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4, nEb5, $0C, nD5, $18
	dc.b	nRst, $0C, nBb4, $03, nRst, nC5, nRst, nD5, $12, nG5, nD5, $0C
	dc.b	nC5, $18, nRst, $0C, nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4
	dc.b	nEb5, $0C, nD5, $12, nF5, nD5, $0C, nC5, $03, nD5, nC5, $0C
	dc.b	nBb4, $36, nRst, $0C, nD5, $03, nRst, nE5, nRst, nF5, $12, nBb4
	dc.b	nF5, $0C, nE5, $18, nRst, $0C, nC5, $03, nRst, nD5, nRst, nE5
	dc.b	$12, nA5, nE5, $0C, nD5, $18, nRst, $0C, nA4, $06, nBb4, nC5
	dc.b	$03, nRst, $09, nD5, $03, nRst, nBb4, nRst, $09, nC5, $03, nRst
	dc.b	$09, nA4, $03, nRst, $09, nBb4, $03, nRst, $09, nG4, $03, nRst
	dc.b	$09, nA4, $0C, nAb4, $02, nG4, nFs4, nF4, $06, nRst, $2A
	smpsFMAlterVol      $EC
	smpsSetvoice        $12
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $04, $05
	smpsPan             panCenter, $00
	dc.b	nBb2, $0C, nBb2, $06, nBb2, $08, nA2, nBb2, nA2, $03, nBb2, nA2
	dc.b	$0C, nG2, $26, nA2, $08, nBb2, nC3, nA2, nG2, nG2, $03, nA2
	dc.b	nG2, $0C, nF2, $22, nFs2, $04, nG2, $08, nA2, nB2, nC3, nD3
	dc.b	nEb3, $12, nG2, nBb2, $0C, nA2, $12, nG2, nA2, $0C, nBb2, $06
	dc.b	nBb2, nBb2, $12, nBb2, $06, nBb2, nBb2, $3C
	smpsSetvoice        $0D
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3, nRst, $09, nG3, $03
	dc.b	nRst, nA3, nRst, $09, nG3, $03, nRst, nA3, nRst, nG3, $0C
	smpsSetvoice        $0B
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb3, $03, nRst, nF3, $06, nG3, $0C
	smpsSetvoice        $0D
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nC3, $06, nEb3, $03, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	smpsSetvoice        $0F
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	dc.b	nG4, $06, nF4, nD4, nBb3, nG3, nF3, nD3, $0C, nRst, $30
	smpsSetvoice        $0D
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3, nRst, $09, nG3, $03
	dc.b	nRst, nA3, nRst, $09, nG3, $03, nRst, nA3, nRst, nG3, $0C
	smpsSetvoice        $0B
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb3, $03, nRst, nF3, $06, nG3, $0C
	smpsSetvoice        $0D
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	smpsSetvoice        $0F
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	dc.b	nG4, $06, nF4, nD4, nBb3, nG3, nF3, nD3, $0C
	smpsSetvoice        $12
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $04, $05
	smpsPan             panCenter, $00
	dc.b	nBb2, $08, nRst, $04, nBb2, $06, nBb2, $08, nA2, nBb2
	smpsJump            Snd_Menu_Jump02

; Unreachable
	smpsStop

; FM4 Data
Snd_Menu_FM4:
	dc.b	nRst, $2A
	smpsSetvoice        $0B
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00

Snd_Menu_Jump01:
	dc.b	nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst
	dc.b	nG3, nRst, nD4, nEb3, nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b	nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3, nRst, nEb3, nRst, nBb3
	dc.b	nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b	nRst, nD3, nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $0C
	smpsSetvoice        $10
	smpsFMAlterVol      $06
	dc.b	nG4, $06, nG5, nG4, nRst, $18
	smpsFMAlterVol      $FA
	smpsSetvoice        $0B
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst
	dc.b	nG3, nRst, nD4, nEb3, nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b	nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3, nRst, nEb3, nRst, nBb3
	dc.b	nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b	nRst, nF3, nF3, nF3, nRst, $0C, nF3, $06, nF3, nF3, nRst, $3C
	smpsSetvoice        $08
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, $0F, nEb3, $03, nRst, $0F, nD3, $0C, nRst, $06
	dc.b	nD3, $03, nRst, $0F, nD3, $0C, nRst, nD3, $03, nRst, $0F, nD3
	dc.b	$03, nRst, $0F, nC3, $0C, nRst, $06, nD3, $0C, nRst, $06, nEb3
	dc.b	$0C, nRst, nEb3, $03, nRst, $0F, nEb3, $03, nRst, $0F, nD3, $0C
	dc.b	nRst, $06, nD3, $03, nRst, $0F, nD3, $0C, nRst, $06, nG3, $03
	dc.b	nRst, nAb3, nRst, nBb3, nRst, nEb4, nRst, nD4, nRst, nBb3, nRst, nG3
	dc.b	$12, nRst, $30
	smpsSetvoice        $08
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nF3, $03, nRst, $0F, nF3, $03, nRst, $0F, nE3, $0C, nRst, $06
	dc.b	nE3, $03, nRst, $0F, nE3, $0C, nRst, nE3, $03, nRst, $0F, nE3
	dc.b	$03, nRst, $0F, nD3, $0C, nRst, $06, nE3, $0C, nRst, $06, nF3
	dc.b	$0C, nRst, nF3, $03, nRst, $0F, nF3, $03, nRst, $0F, nE3, $0C
	dc.b	nRst, $06, nE3, $03, nRst, $0F, nE3, $0C, nF3, nRst, $06, nF3
	dc.b	$0C, nRst, $06, nF3, nRst, $36
	smpsSetvoice        $0B
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst
	dc.b	nG3, nRst, nD4, nEb3, nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b	nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3, nRst, nEb3, nRst, nBb3
	dc.b	nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b	nRst, nF3, nF3, nF3, nRst, $0C, nF3, $06, nF3, nF3, nRst, $36
	smpsSetvoice        $08
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4, nRst, $09, nBb3, $03
	dc.b	nRst, nC4, nRst, $09, nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	smpsSetvoice        $0B
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nG3, $03, nRst, nA3, nRst, nBb3, nRst, $09
	smpsSetvoice        $08
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	$0C
	smpsSetvoice        $0B
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $06, nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $3C
	smpsSetvoice        $08
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4, nRst, $09, nBb3, $03
	dc.b	nRst, nC4, nRst, $09, nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	smpsSetvoice        $0B
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nG3, $03, nRst, nA3, nRst, nBb3, nRst, $09
	smpsSetvoice        $08
	smpsAlterNote       $03
	smpsModSet          $03, $01, $FD, $05
	smpsPan             panLeft, $00
	dc.b	nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4, nRst, $09, nC4, $03
	dc.b	nRst, nD4, nRst, $09, nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b	$0C
	smpsSetvoice        $0B
	smpsAlterNote       $04
	smpsModSet          $0F, $01, $FA, $05
	smpsPan             panLeft, $00
	dc.b	nD3, $06, nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $36
	smpsJump            Snd_Menu_Jump01

; Unreachable
	smpsStop

; FM5 Data
Snd_Menu_FM5:
	dc.b	nRst, $2A

Snd_Menu_Jump00:
	smpsSetvoice        $0B
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb2, $06, nRst, nBb2, nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst
	dc.b	nG2, nRst, nD3, nEb2, nRst, nD2, nRst, nA2, nF2, nRst, nC3, nRst
	dc.b	nD2, nRst, nA2, nRst, nG2, nRst, nD3, nD2, nRst, nEb2, nRst, nBb2
	dc.b	nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b	nRst, nBb2, nRst, $0C, nC3, $06, nRst, $0C, nD3, $06, nRst, $0C
	smpsSetvoice        $10
	smpsFMAlterVol      $06
	dc.b	nG4, $06, nG5, nG4, nRst, $18
	smpsFMAlterVol      $FA
	smpsSetvoice        $0B
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb2, $06, nRst, nBb2, nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst
	dc.b	nG2, nRst, nD3, nEb2, nRst, nD2, nRst, nA2, nF2, nRst, nC3, nRst
	dc.b	nD2, nRst, nA2, nRst, nG2, nRst, nD3, nD2, nRst, nEb2, nRst, nBb2
	dc.b	nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b	nRst, nD3, nD3, nD3, nRst, $0C, nD3, $06, nD3, nD3, nRst, $3C
	smpsSetvoice        $08
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nAb2, $03, nRst, $0F, nAb2, $03, nRst, $0F, nAb2, $0C, nRst, $06
	dc.b	nAb2, $03, nRst, $0F, nAb2, $0C, nRst, nG2, $03, nRst, $0F, nG2
	dc.b	$03, nRst, $0F, nG2, $0C, nRst, $06, nF2, $0C, nRst, $06, nG2
	dc.b	$0C, nRst, nAb2, $03, nRst, $0F, nAb2, $03, nRst, $0F, nAb2, $0C
	dc.b	nRst, $06, nAb2, $03, nRst, $0F, nAb2, $0C, nRst, $06, nBb2, $03
	dc.b	nRst, nC3, nRst, nD3, nRst, nG3, nRst, nF3, nRst, nD3, nRst, nBb2
	dc.b	$12, nRst, $30
	smpsSetvoice        $08
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nBb2, $03, nRst, $0F, nBb2, $03, nRst, $0F, nBb2, $0C, nRst, $06
	dc.b	nBb2, $03, nRst, $0F, nBb2, $0C, nRst, nA2, $03, nRst, $0F, nA2
	dc.b	$03, nRst, $0F, nA2, $0C, nRst, $06, nG2, $0C, nRst, $06, nA2
	dc.b	$0C, nRst, nBb2, $03, nRst, $0F, nBb2, $03, nRst, $0F, nBb2, $0C
	dc.b	nRst, $06, nBb2, $03, nRst, $0F, nBb2, $0C, nA2, nRst, $06, nA2
	dc.b	$0C, nRst, $06, nA2, nRst, $36
	smpsSetvoice        $0B
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb2, $06, nRst, nBb2, nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst
	dc.b	nG2, nRst, nD3, nEb2, nRst, nD2, nRst, nA2, nF2, nRst, nC3, nRst
	dc.b	nD2, nRst, nA2, nRst, nG2, nRst, nD3, nD2, nRst, nEb2, nRst, nBb2
	dc.b	nG2, nRst, nD3, nRst, nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b	nRst, nD3, nD3, nD3, nRst, $0C, nD3, $06, nD3, nD3, nRst, $36
	smpsSetvoice        $08
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3, nRst, $09, nG3, $03
	dc.b	nRst, nA3, nRst, $09, nG3, $03, nRst, nA3, nRst, nG3, $0C
	smpsSetvoice        $0B
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb3, $03, nRst, nF3, nRst, nG3, nRst, $09
	smpsSetvoice        $08
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	$0C
	smpsSetvoice        $0B
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nBb2, $06, nRst, $0C, nC3, $06, nRst, $0C, nD3, $06, nRst, $3C
	smpsSetvoice        $08
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3, nRst, $09, nG3, $03
	dc.b	nRst, nA3, nRst, $09, nG3, $03, nRst, nA3, nRst, nG3, $0C
	smpsSetvoice        $0B
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nEb3, $03, nRst, nF3, nRst, nG3, nRst, $09
	smpsSetvoice        $08
	smpsAlterNote       $FD
	smpsModSet          $03, $01, $03, $05
	smpsPan             panRight, $00
	dc.b	nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3, nRst, $09, nA3, $03
	dc.b	nRst, nBb3, nRst, $09, nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b	$0C
	smpsSetvoice        $0B
	smpsAlterNote       $FC
	smpsModSet          $0F, $01, $06, $05
	smpsPan             panRight, $00
	dc.b	nBb2, $06, nRst, $0C, nC3, $06, nRst, $0C, nD3, $06, nRst, $36
	smpsJump            Snd_Menu_Jump00

; Unreachable
	smpsStop

; PSG1 Data
Snd_Menu_PSG1:
	smpsPSGvoice        fTone_04
	smpsAlterNote       $00
	dc.b	nRst, $2A

Snd_Menu_Jump07:
	smpsPSGvoice        fTone_04
	smpsCall            Snd_Menu_Call03
	dc.b	nD3, nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06, nRst, $0C, nG4
	dc.b	$06, nG5, nG4, nRst, $18
	smpsCall            Snd_Menu_Call03
	dc.b	nF3, nF3, nF3, nRst, $0C, nF3, $06, nF3, nF3, nRst, $3C, nEb3
	dc.b	$03, nRst, $0F, nEb3, $03, nRst, $0F, nD3, $0C, nRst, $06, nD3
	dc.b	$03, nRst, $0F, nD3, $0C, nRst, nD3, $03, nRst, $0F, nD3, $03
	dc.b	nRst, $0F, nC3, $0C, nRst, $06, nD3, $0C, nRst, $06, nEb3, $0C
	dc.b	nRst, nEb3, $03, nRst, $0F, nEb3, $03, nRst, $0F, nD3, $0C, nRst
	dc.b	$06, nD3, $03, nRst, $0F, nD3, $0C, nRst, $06, nG3, $03, nRst
	dc.b	nAb3, nRst, nBb3, nRst, nEb4, nRst, nD4, nRst, nBb3, nRst, nG3, $12
	dc.b	nRst, $30, nF3, $03, nRst, $0F, nF3, $03, nRst, $0F, nE3, $0C
	dc.b	nRst, $06, nE3, $03, nRst, $0F, nE3, $0C, nRst, nE3, $03, nRst
	dc.b	$0F, nE3, $03, nRst, $0F, nD3, $0C, nRst, $06, nE3, $0C, nRst
	dc.b	$06, nF3, $0C, nRst, nF3, $03, nRst, $0F, nF3, $03, nRst, $0F
	dc.b	nE3, $0C, nRst, $06, nE3, $03, nRst, $0F, nE3, $0C, nF3, nRst
	dc.b	$06, nF3, $0C, nRst, $06, nF3, nRst, $36
	smpsCall            Snd_Menu_Call03
	smpsCall            Snd_Menu_Call04
	dc.b	nF4, $02, nRst, $04, nF5, $06, nF4, $02, nRst, $0A, nF4, $06
	dc.b	nF5, $06, nF4, $02, nRst, $0A, nF4, $06, nF5, $06, nF4, $02
	dc.b	nRst, $0A
	smpsCall            Snd_Menu_Call05
	smpsJump            Snd_Menu_Jump07

Snd_Menu_Call03:
	dc.b	nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst
	dc.b	nG3, nRst, nD4, nEb3, nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b	nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3, nRst, nEb3, nRst, nBb3
	dc.b	nG3, nRst, nD4, nRst, nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b	nRst
	smpsReturn

Snd_Menu_Call04:
	dc.b	nF3, $06, nF3, nF3, nRst, $0C, nF3, $06, nF3, nF3, nRst, $36
	smpsReturn

Snd_Menu_Call05:
	dc.b	nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b	nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4
	dc.b	$0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4
	dc.b	$06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5
	dc.b	nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C
	dc.b	nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b	nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4
	dc.b	$0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4
	dc.b	$06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5
	dc.b	nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C
	dc.b	nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b	nF5, nF4, $36
	smpsReturn

; Unreachable
	smpsStop

; PSG2 Data
Snd_Menu_PSG2:
	smpsPSGvoice        fTone_04
	smpsAlterNote       $FF
	dc.b	nRst, $2A

Snd_Menu_Jump06:
	smpsPSGvoice        fTone_04
	smpsCall            Snd_Menu_Call03
	dc.b	nBb3, nRst, $0C, nC4, $06, nRst, $0C, nD4, $06, nRst, $0C, nG5
	dc.b	$06, nG6, nG5, nRst, $18
	smpsCall            Snd_Menu_Call03
	dc.b	nD4, nD4, nD4, nRst, $0C, nD4, $06, nD4, nD4, nRst, $3C, nAb2
	dc.b	$03, nRst, $0F, nAb2, $03, nRst, $0F, nAb2, $0C, nRst, $06, nAb2
	dc.b	$03, nRst, $0F, nAb2, $0C, nRst, nG2, $03, nRst, $0F, nG2, $03
	dc.b	nRst, $0F, nG2, $0C, nRst, $06, nF2, $0C, nRst, $06, nG2, $0C
	dc.b	nRst, nAb2, $03, nRst, $0F, nAb2, $03, nRst, $0F, nAb2, $0C, nRst
	dc.b	$06, nAb2, $03, nRst, $0F, nAb2, $0C, nRst, $06, nBb2, $03, nRst
	dc.b	nC3, nRst, nD3, nRst, nG3, nRst, nF3, nRst, nD3, nRst, nBb2, $12
	dc.b	nRst, $30, nBb2, $03, nRst, $0F, nBb2, $03, nRst, $0F, nBb2, $0C
	dc.b	nRst, $06, nBb2, $03, nRst, $0F, nBb2, $0C, nRst, nA2, $03, nRst
	dc.b	$0F, nA2, $03, nRst, $0F, nA2, $0C, nRst, $06, nG2, $0C, nRst
	dc.b	$06, nA2, $0C, nRst, nBb2, $03, nRst, $0F, nBb2, $03, nRst, $0F
	dc.b	nBb2, $0C, nRst, $06, nBb2, $03, nRst, $0F, nBb2, $0C, nA2, nRst
	dc.b	$06, nA2, $0C, nRst, $06, nA2, nRst, $36
	smpsCall            Snd_Menu_Call03
	smpsCall            Snd_Menu_Call04
	dc.b	nF4, $06, nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b	nF5, nF4, $0C
	smpsCall            Snd_Menu_Call05
	smpsJump            Snd_Menu_Jump06

; Unreachable
	smpsStop

; PSG3 Data
Snd_Menu_PSG3:
	smpsPSGvoice        fTone_02
	smpsPSGform         $E7
	dc.b	nRst, $2A

Snd_Menu_Jump05:
	smpsCall            Snd_Menu_Call01
	smpsCall            Snd_Menu_Call01
	smpsCall            Snd_Menu_Call01
	smpsFMAlterVol      $FD, $D3
	dc.b	$06
	smpsFMAlterVol      $03, $D3
	dc.b	$03, nBb6, nBb6, $06, nBb6, nBb6, nBb6, nBb6, nBb6, $0C
	smpsFMAlterVol      $FD, $D3
	dc.b	$0C, nBb6, $06, nBb6, $08, nBb6, nBb6, $02
	smpsFMAlterVol      $03, $80
	dc.b	$06
	smpsCall            Snd_Menu_Call01
	smpsCall            Snd_Menu_Call01
	smpsFMAlterVol      $FD, $D3
	dc.b	$06
	smpsFMAlterVol      $03, $D3
	dc.b	$03, nBb6

Snd_Menu_Loop06:
	dc.b	nBb6, $06
	smpsLoop            $00, $0D, Snd_Menu_Loop06
	dc.b	nBb6, $32, nBb6, $34
	smpsCall            Snd_Menu_Call02
	smpsCall            Snd_Menu_Call02
	smpsCall            Snd_Menu_Call02
	smpsCall            Snd_Menu_Call02
	smpsCall            Snd_Menu_Call02
	smpsCall            Snd_Menu_Call02
	smpsCall            Snd_Menu_Call02
	dc.b	nBb6, $06, nBb6, $03, nBb6, nBb6, $06, nBb6, nBb6, nBb6, nBb6, nBb6
	dc.b	$36
	smpsCall            Snd_Menu_Call01
	smpsCall            Snd_Menu_Call01
	smpsFMAlterVol      $FD, $D3
	dc.b	$06
	smpsFMAlterVol      $03, $D3
	dc.b	$03, nBb6

Snd_Menu_Loop07:
	dc.b	nBb6, $06
	smpsLoop            $00, $0D, Snd_Menu_Loop07
	dc.b	nBb6, $32, nBb6, $34, nBb6, $06, nBb6, $03, nBb6, nBb6, $06
	smpsFMAlterVol      $FD, $D3
	smpsFMAlterVol      $03, $D3
	dc.b	nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6

Snd_Menu_Loop08:
	dc.b	nBb6, $06, nBb6, $03, nBb6, nBb6, $06
	smpsFMAlterVol      $FD, $D3
	smpsFMAlterVol      $03, $D3
	dc.b	nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6
	smpsLoop            $00, $06, Snd_Menu_Loop08
	dc.b	nBb6, $06, nBb6, $03, nBb6, nBb6, $06
	smpsFMAlterVol      $FD, $D3
	smpsFMAlterVol      $03, $D3
	dc.b	nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6
	dc.b	nBb6, $03, nBb6, nBb6, $06
	smpsFMAlterVol      $FD, $D3
	smpsFMAlterVol      $03, $D3
	dc.b	nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6
	dc.b	nBb6, $03, nBb6, nBb6, $06
	smpsFMAlterVol      $FD, $D3
	dc.b	nBb6
	smpsJump            Snd_Menu_Jump05

Snd_Menu_Call01:
	smpsFMAlterVol      $FD, $D3
	dc.b	$06
	smpsFMAlterVol      $03, $D3
	dc.b	$03, nBb6

Snd_Menu_Loop0A:
	dc.b	nBb6, $06
	smpsLoop            $01, $0E, Snd_Menu_Loop0A
	smpsReturn

Snd_Menu_Call02:
	dc.b	nBb6, $06, nBb6, $03, nBb6

Snd_Menu_Loop09:
	dc.b	nBb6, $06
	smpsLoop            $01, $0E, Snd_Menu_Loop09
	smpsReturn

; Unreachable
	smpsStop

SaveScreenVoices:
; Synth Bass 2
;	Voice $00
;	$3C
;	$01, $00, $00, $00, 	$1F, $1F, $15, $1F, 	$11, $0D, $12, $05
;	$07, $04, $09, $02, 	$55, $3A, $25, $1A, 	$1A, $80, $07, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $15, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $12, $0D, $11
	smpsVcDecayRate2    $02, $09, $04, $07
	smpsVcDecayLevel    $01, $02, $03, $05
	smpsVcReleaseRate   $0A, $05, $0A, $05
	smpsVcTotalLevel    $00, $07, $00, $1A

; Trumpet 1
;	Voice $01
;	$3D
;	$01, $01, $01, $01, 	$94, $19, $19, $19, 	$0F, $0D, $0D, $0D
;	$07, $04, $04, $04, 	$25, $1A, $1A, $1A, 	$15, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $19, $19, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $0D, $0D, $0F
	smpsVcDecayRate2    $04, $04, $04, $07
	smpsVcDecayLevel    $01, $01, $01, $02
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $00, $00, $00, $15

; Slap Bass 2
;	Voice $02
;	$03
;	$00, $D7, $33, $02, 	$5F, $9F, $5F, $1F, 	$13, $0F, $0A, $0A
;	$10, $0F, $02, $09, 	$35, $15, $25, $1A, 	$13, $16, $15, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $0D, $00
	smpsVcCoarseFreq    $02, $03, $07, $00
	smpsVcRateScale     $00, $01, $02, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0A, $0F, $13
	smpsVcDecayRate2    $09, $02, $0F, $10
	smpsVcDecayLevel    $01, $02, $01, $03
	smpsVcReleaseRate   $0A, $05, $05, $05
	smpsVcTotalLevel    $00, $15, $16, $13

; Synth Bass 1
;	Voice $03
;	$34
;	$70, $72, $31, $31, 	$1F, $1F, $1F, $1F, 	$10, $06, $06, $06
;	$01, $06, $06, $06, 	$35, $1A, $15, $1A, 	$10, $83, $18, $83
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $01, $01, $02, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $10
	smpsVcDecayRate2    $06, $06, $06, $01
	smpsVcDecayLevel    $01, $01, $01, $03
	smpsVcReleaseRate   $0A, $05, $0A, $05
	smpsVcTotalLevel    $03, $18, $03, $10

; Bell Synth 1
;	Voice $04
;	$3E
;	$77, $71, $32, $31, 	$1F, $1F, $1F, $1F, 	$0D, $06, $00, $00
;	$08, $06, $00, $00, 	$15, $0A, $0A, $0A, 	$1B, $80, $80, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $01, $02, $01, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $06, $0D
	smpsVcDecayRate2    $00, $00, $06, $08
	smpsVcDecayLevel    $00, $00, $00, $01
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $00, $00, $00, $1B

; Bell Synth 2
;	Voice $05
;	$34
;	$33, $41, $7E, $74, 	$5B, $9F, $5F, $1F, 	$04, $07, $07, $08
;	$00, $00, $00, $00, 	$FF, $FF, $EF, $FF, 	$23, $80, $29, $87
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $04, $03
	smpsVcCoarseFreq    $04, $0E, $01, $03
	smpsVcRateScale     $00, $01, $02, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1B
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $07, $07, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0E, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $07, $29, $00, $23

; Synth Brass 1
;	Voice $06
;	$3A
;	$01, $07, $31, $71, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $28, $18

; Synth like Bassoon
;	Voice $07
;	$3C
;	$32, $32, $71, $42, 	$1F, $18, $1F, $1E, 	$07, $1F, $07, $1F
;	$00, $00, $00, $00, 	$1F, $0F, $1F, $0F, 	$1E, $80, $0C, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $03, $03
	smpsVcCoarseFreq    $02, $01, $02, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1E, $1F, $18, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1F, $07, $1F, $07
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0C, $00, $1E

; Bell Horn type thing
;	Voice $08
;	$3C
;	$71, $72, $3F, $34, 	$8D, $52, $9F, $1F, 	$09, $00, $00, $0D
;	$00, $00, $00, $00, 	$23, $08, $02, $F7, 	$15, $80, $1D, $87
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $04, $0F, $02, $01
	smpsVcRateScale     $00, $02, $01, $02
	smpsVcAttackRate    $1F, $1F, $12, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $00, $00, $09
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $00, $00, $02
	smpsVcReleaseRate   $07, $02, $08, $03
	smpsVcTotalLevel    $07, $1D, $00, $15

; Synth Bass 3
;	Voice $09
;	$3D
;	$01, $01, $00, $00, 	$8E, $52, $14, $4C, 	$08, $08, $0E, $03
;	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$1B, $80, $80, $9B
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $01, $01
	smpsVcRateScale     $01, $00, $01, $02
	smpsVcAttackRate    $0C, $14, $12, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $08, $08
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $1B, $00, $00, $1B

; Synth Trumpet
;	Voice $0A
;	$3A
;	$01, $01, $01, $02, 	$8D, $07, $07, $52, 	$09, $00, $00, $03
;	$01, $02, $02, $00, 	$52, $02, $02, $28, 	$18, $22, $18, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $01, $01, $01
	smpsVcRateScale     $01, $00, $00, $02
	smpsVcAttackRate    $12, $07, $07, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $00, $00, $09
	smpsVcDecayRate2    $00, $02, $02, $01
	smpsVcDecayLevel    $02, $00, $00, $05
	smpsVcReleaseRate   $08, $02, $02, $02
	smpsVcTotalLevel    $00, $18, $22, $18

; Wood Block
;	Voice $0B
;	$3C
;	$36, $31, $76, $71, 	$94, $9F, $96, $9F, 	$12, $00, $14, $0F
;	$04, $0A, $04, $0D, 	$2F, $0F, $4F, $2F, 	$33, $80, $1A, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $01, $06, $01, $06
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $1F, $16, $1F, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $14, $00, $12
	smpsVcDecayRate2    $0D, $04, $0A, $04
	smpsVcDecayLevel    $02, $04, $00, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $00, $33

; Tubular Bell
;	Voice $0C
;	$34
;	$33, $41, $7E, $74, 	$5B, $9F, $5F, $1F, 	$04, $07, $07, $08
;	$00, $00, $00, $00, 	$FF, $FF, $EF, $FF, 	$23, $90, $29, $97
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $04, $03
	smpsVcCoarseFreq    $04, $0E, $01, $03
	smpsVcRateScale     $00, $01, $02, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1B
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $07, $07, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0E, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $17, $29, $10, $23

; Strike Bass
;	Voice $0D
;	$38
;	$63, $31, $31, $31, 	$10, $13, $1A, $1B, 	$0E, $00, $00, $00
;	$00, $00, $00, $00, 	$3F, $0F, $0F, $0F, 	$1A, $19, $1A, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $06
	smpsVcCoarseFreq    $01, $01, $01, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $1A, $13, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $19, $1A

; Elec Piano
;	Voice $0E
;	$3A
;	$31, $25, $73, $41, 	$5F, $1F, $1F, $9C, 	$08, $05, $04, $05
;	$03, $04, $02, $02, 	$2F, $2F, $1F, $2F, 	$29, $27, $1F, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $02, $03
	smpsVcCoarseFreq    $01, $03, $05, $01
	smpsVcRateScale     $02, $00, $00, $01
	smpsVcAttackRate    $1C, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $04, $05, $08
	smpsVcDecayRate2    $02, $02, $04, $03
	smpsVcDecayLevel    $02, $01, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1F, $27, $29

; Bright Piano
;	Voice $0F
;	$04
;	$71, $41, $31, $31, 	$12, $12, $12, $12, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$23, $80, $23, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $04, $07
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $12, $12, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $23, $00, $23

; Church Bell
;	Voice $10
;	$14
;	$75, $72, $35, $32, 	$9F, $9F, $9F, $9F, 	$05, $05, $00, $0A
;	$05, $05, $07, $05, 	$2F, $FF, $0F, $2F, 	$1E, $80, $14, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $02, $05, $02, $05
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $00, $05, $05
	smpsVcDecayRate2    $05, $07, $05, $05
	smpsVcDecayLevel    $02, $00, $0F, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $14, $00, $1E

; Synth Brass 2
;	Voice $11
;	$3D
;	$01, $00, $01, $02, 	$12, $1F, $1F, $14, 	$07, $02, $02, $0A
;	$05, $05, $05, $05, 	$2F, $2F, $2F, $AF, 	$1C, $80, $82, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $01, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $1F, $1F, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $02, $02, $07
	smpsVcDecayRate2    $05, $05, $05, $05
	smpsVcDecayLevel    $0A, $02, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $02, $00, $1C

; Bell Piano
;	Voice $12
;	$1C
;	$73, $72, $33, $32, 	$94, $99, $94, $99, 	$08, $0A, $08, $0A
;	$00, $05, $00, $05, 	$3F, $4F, $3F, $4F, 	$1E, $80, $19, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $02, $03, $02, $03
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $19, $14, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $08, $0A, $08
	smpsVcDecayRate2    $05, $00, $05, $00
	smpsVcDecayLevel    $04, $03, $04, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $19, $00, $1E

; Wet Wood Bass
;	Voice $13
;	$31
;	$33, $01, $00, $00, 	$9F, $1F, $1F, $1F, 	$0D, $0A, $0A, $0A
;	$0A, $07, $07, $07, 	$FF, $AF, $AF, $AF, 	$1E, $1E, $1E, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $03
	smpsVcCoarseFreq    $00, $00, $01, $03
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0A, $0A, $0D
	smpsVcDecayRate2    $07, $07, $07, $0A
	smpsVcDecayLevel    $0A, $0A, $0A, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1E, $1E, $1E

; Silent Bass
;	Voice $14
;	$3A
;	$70, $76, $30, $71, 	$1F, $95, $1F, $1F, 	$0E, $0F, $05, $0C
;	$07, $06, $06, $07, 	$2F, $4F, $1F, $5F, 	$21, $12, $28, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $07, $07
	smpsVcCoarseFreq    $01, $00, $06, $00
	smpsVcRateScale     $00, $00, $02, $00
	smpsVcAttackRate    $1F, $1F, $15, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $05, $0F, $0E
	smpsVcDecayRate2    $07, $06, $06, $07
	smpsVcDecayLevel    $05, $01, $04, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $28, $12, $21

; Picked Bass
;	Voice $15
;	$28
;	$71, $00, $30, $01, 	$1F, $1F, $1D, $1F, 	$13, $13, $06, $05
;	$03, $03, $02, $05, 	$4F, $4F, $2F, $3F, 	$0E, $14, $1E, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $00, $07
	smpsVcCoarseFreq    $01, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1D, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $06, $13, $13
	smpsVcDecayRate2    $05, $02, $03, $03
	smpsVcDecayLevel    $03, $02, $04, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1E, $14, $0E

; Xylophone
;	Voice $16
;	$3E
;	$38, $01, $7A, $34, 	$59, $D9, $5F, $9C, 	$0F, $04, $0F, $0A
;	$02, $02, $05, $05, 	$AF, $AF, $66, $66, 	$28, $80, $A3, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $07, $00, $03
	smpsVcCoarseFreq    $04, $0A, $01, $08
	smpsVcRateScale     $02, $01, $03, $01
	smpsVcAttackRate    $1C, $1F, $19, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0F, $04, $0F
	smpsVcDecayRate2    $05, $05, $02, $02
	smpsVcDecayLevel    $06, $06, $0A, $0A
	smpsVcReleaseRate   $06, $06, $0F, $0F
	smpsVcTotalLevel    $00, $23, $00, $28

; Sine Flute
;	Voice $17
;	$39
;	$32, $31, $72, $71, 	$1F, $1F, $1F, $1F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$1B, $32, $28, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $01, $02, $01, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $28, $32, $1B

; Pipe Organ
;	Voice $18
;	$07
;	$34, $74, $32, $71, 	$1F, $1F, $1F, $1F, 	$0A, $0A, $05, $03
;	$00, $00, $00, $00, 	$3F, $3F, $2F, $2F, 	$8A, $8A, $80, $80
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $07, $03
	smpsVcCoarseFreq    $01, $02, $04, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $05, $0A, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $02, $02, $03, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $0A, $0A

; Synth Brass 2
;	Voice $19
;	$3A
;	$31, $37, $31, $31, 	$8D, $8D, $8E, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $00, 	$1F, $FF, $1F, $0F, 	$17, $28, $26, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0E, $0D, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $26, $28, $17

; Harpischord
;	Voice $1A
;	$3B
;	$3A, $31, $71, $74, 	$DF, $1F, $1F, $DF, 	$00, $0A, $0A, $05
;	$00, $05, $05, $03, 	$0F, $5F, $1F, $5F, 	$32, $1E, $0F, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $04, $01, $01, $0A
	smpsVcRateScale     $03, $00, $00, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $0A, $0A, $00
	smpsVcDecayRate2    $03, $05, $05, $00
	smpsVcDecayLevel    $05, $01, $05, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0F, $1E, $32

; Metallic Bass
;	Voice $1B
;	$05
;	$04, $01, $02, $04, 	$8D, $1F, $15, $52, 	$06, $00, $00, $04
;	$02, $08, $00, $00, 	$1F, $0F, $0F, $2F, 	$16, $90, $84, $8C
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $04, $02, $01, $04
	smpsVcRateScale     $01, $00, $00, $02
	smpsVcAttackRate    $12, $15, $1F, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $00, $00, $06
	smpsVcDecayRate2    $00, $00, $08, $02
	smpsVcDecayLevel    $02, $00, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0C, $04, $10, $16

; Alternate Metallic Bass
;	Voice $1C
;	$2C
;	$71, $74, $32, $32, 	$1F, $12, $1F, $12, 	$00, $0A, $00, $0A
;	$00, $00, $00, $00, 	$0F, $1F, $0F, $1F, 	$16, $80, $17, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $02, $02, $04, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $1F, $12, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $00, $0A, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $01, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $17, $00, $16

; Backdropped Metallic Bass
;	Voice $1D
;	$3A
;	$01, $07, $01, $01, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $27, $8F
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0F, $27, $28, $18

; Sine like Bell
;	Voice $1E
;	$36
;	$7A, $32, $51, $11, 	$1F, $1F, $59, $1C, 	$0A, $0D, $06, $0A
;	$07, $00, $02, $02, 	$AF, $5F, $5F, $5F, 	$1E, $8B, $81, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $05, $03, $07
	smpsVcCoarseFreq    $01, $01, $02, $0A
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $1C, $19, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $06, $0D, $0A
	smpsVcDecayRate2    $02, $02, $00, $07
	smpsVcDecayLevel    $05, $05, $05, $0A
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $01, $0B, $1E

; Synth like Metallic with Small Bell
;	Voice $1F
;	$3C
;	$71, $72, $3F, $34, 	$8D, $52, $9F, $1F, 	$09, $00, $00, $0D
;	$00, $00, $00, $00, 	$23, $08, $02, $F7, 	$15, $85, $1D, $8A
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $04, $0F, $02, $01
	smpsVcRateScale     $00, $02, $01, $02
	smpsVcAttackRate    $1F, $1F, $12, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $00, $00, $09
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $00, $00, $02
	smpsVcReleaseRate   $07, $02, $08, $03
	smpsVcTotalLevel    $0A, $1D, $05, $15

; Nice Synth like lead
;	Voice $20
;	$3E
;	$77, $71, $32, $31, 	$1F, $1F, $1F, $1F, 	$0D, $06, $00, $00
;	$08, $06, $00, $00, 	$15, $0A, $0A, $0A, 	$1B, $8F, $8F, $8F
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $01, $02, $01, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $06, $0D
	smpsVcDecayRate2    $00, $00, $06, $08
	smpsVcDecayLevel    $00, $00, $00, $01
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $0F, $0F, $0F, $1B

; Rock Organ
;	Voice $21
;	$07
;	$34, $74, $32, $71, 	$1F, $1F, $1F, $1F, 	$0A, $0A, $05, $03
;	$00, $00, $00, $00, 	$3F, $3F, $2F, $2F, 	$8A, $8A, $8A, $8A
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $07, $03
	smpsVcCoarseFreq    $01, $02, $04, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $05, $0A, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $02, $02, $03, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0A, $0A, $0A, $0A

; Strike like Slap Bass
;	Voice $22
;	$20
;	$36, $35, $30, $31, 	$DF, $DF, $9F, $9F, 	$07, $06, $09, $06
;	$07, $06, $06, $08, 	$20, $10, $10, $F8, 	$19, $37, $13, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $00, $05, $06
	smpsVcRateScale     $02, $02, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $09, $06, $07
	smpsVcDecayRate2    $08, $06, $06, $07
	smpsVcDecayLevel    $0F, $01, $01, $02
	smpsVcReleaseRate   $08, $00, $00, $00
	smpsVcTotalLevel    $00, $13, $37, $19

