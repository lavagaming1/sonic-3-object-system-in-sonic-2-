s3_save_screen:

		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a5
		move.w	#$8F01,(a5)
		move.l	#$940F93FF,(a5)
		move.w	#$9780,(a5)
		move.l	#$50000083,(a5)
		move.w	#0,(VDP_data_port).l

loc_C5B0:
		move.w	(a5),d1
		btst	#1,d1
		bne.s	loc_C5B0
		move.w	#$8F02,(a5)
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6) ; disable hint and uhh do HV
		move.w	#$8238,(a6) ; 8230 + 8 ??
		move.w	#$8338,(a6) ; 833C somewhere in ??/
		move.w	#$8406,(a6) ;8406    (B addr)
		move.w	#$8700,(a6)  ; bg colors
		move.w	#$8B00,(a6) ; v scroll  by screen
		move.w	#$8C81,(a6)  ;40 cell mode
		move.w	#$9003,(a6)  ;128x32
		move.w	#$9280,(a6)  ; enable save screen "window"
		lea	(Sprite_Table_Input).w,a1
		moveq	#0,d0
		move.w	#$FF,d1

loc_C5F0:
		move.l	d0,(a1)+
		dbf	d1,loc_C5F0
	;	lea	(Object_RAM).w,a1
	;	moveq	#0,d0
	;	move.w	#(Kos_decomp_buffer-Object_RAM)/4-1,d1

;loc_C600:
;		move.l	d0,(a1)+
;		dbf	d1,loc_C600
                clearRAM Chunk_Table,Chunk_Table_End
                clearRAM Object_RAM,Object_RAM_End
		clearRAM Camera_RAM,Camera_RAM_End
		clearRAM Results_Data_2P,Results_Data_2P_End
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		clr.w	(Events_bg+$10).w
		clr.w	(Events_bg+$12).w
		clr.w   (Vscroll_Factor).w
		clr.w   (Vscroll_Factor_FG).w
		clr.w   (Vscroll_Factor_BG).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(Chunk_Table).l,a1
		move.w	#1,d0
		jsr	(Eni_Decomp).l
		lea	(Chunk_Table).l,a1
		move.l	#$60000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(MapEni_SaveScreen_Layout).l,a0
		lea	(Chunk_Table).l,a1
		move.w	#$829F,d0
		jsr	(Eni_Decomp).l
		lea	word_CD58(pc),a0
		jsr	sub_C866(pc)
		move.l	#$6C400002,(VDP_control_port).l
		lea	(ArtNem_FontStuff).l,a0
		jsr	(Nem_Decomp).l
		lea	byte_DB1C(pc),a1
		move.w	#$CC06,d0
		jsr	sub_D9F4(pc)
		move.w	#$CC0C,d0
		jsr	sub_D9F4(pc)
		move.w	#$CCEC,d0
		jsr	sub_D9F4(pc)
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(Chunk_Table).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_S3MenuBG),a2	; Transfer destination
		jsr	(KosArt_To_VDP).l
		move.l	#locret_C56E,(_unkEF44_1).w
		move.b	#VintID_Savescreen,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_SaveScreenMisc).l,a0			; Decompress source
		lea	(Chunk_Table).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Save_Misc),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#VintID_Savescreen,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_SaveScreen).l,a0			; Decompress source
		lea	(Chunk_Table).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Save_Extra),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#VintID_Savescreen,(V_int_routine).w
		jsr	(Wait_VSync).l
                lea	(Pal_SaveMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#7,d0

loc_C710:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_C710
		lea	Pal_Save_Chars(pc),a0
		moveq	#$F,d0

loc_C71C:

		move.l	(a0)+,(a1)+
		dbf	d0,loc_C71C
		lea	(Object_RAM).w,a0
		lea	ObjDat_SaveScreen(pc),a1
		moveq	#$C-1,d0

loc_C72C:
		move.l	(a1)+,(a0)
		move.w	#$829F,art_tile(a0)
		move.l	#Map_SaveScreen,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,objoff_12(a0)	; copy of object's x_pos
		move.w	(a1)+,y_pos(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,objoff_2E(a0)	; used for save slot id
		move.b	#$40,render_flags(a0)	; set's multi-sprite flag
		lea	next_object(a0),a0
		dbf	d0,loc_C72C
		jsr	(Init_SpriteTable).l
		jsr	(RunObjects).l
		jsr	(Render_Sprites).l
		lea	(Normal_palette_line4).w,a0
		lea	(Target_palette_line4).w,a1
		moveq	#7,d0

loc_C77A:
		move.l	(a0),(a1)+
		clr.l	(a0)+
		dbf	d0,loc_C77A
		lea	(ArtKos_SaveScreenS3Zone).l,a0
		lea	(Chunk_Table).l,a1
		jsr	(Kos_Decomp).l
		lea	(Chunk_Table+$2BC0).l,a0
		lea	(Chunk_Table+$2300).l,a1
		move.w	#$22F,d0

loc_C7A4:
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		dbf	d0,loc_C7A4
		lea	(ArtKos_SaveScreenSKZone).l,a0
		jsr	(Kos_Decomp).l
		lea	(ArtKos_SaveScreenPortrait).l,a0
		jsr	(Kos_Decomp).l
		lea	-$8C0(a1),a0
		move.w	#$14F,d0

loc_C7CC:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_C7CC
		moveq	#$1,d0
		jsr	(PlaySound).l
		move.l	#loc_C890,(_unkEF44_1).w
		move.b	#VintID_Savescreen,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

SaveScreen_MainLoop:
		move.b	#VintID_Savescreen,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(RunObjects).l
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		move.w	d0,(Horiz_Scroll_Buf+2).w
		jsr	(Render_Sprites).l
		lea	(Normal_palette_line3+$2).w,a0
		moveq	#$E,d0
		move.w	(Emerald_flicker_flag).w,d1
		addq.w	#1,d1
		cmpi.w	#3,d1
		blo.s	loc_C83C
		moveq	#0,d1

loc_C83C:
		move.w	d1,(Emerald_flicker_flag).w
		beq.s	loc_C84E
		lea	Pal_Save_Emeralds(pc),a1

loc_C846:
		move.w	(a1)+,(a0)+
		dbf	d0,loc_C846
		bra.s	loc_C856
; ---------------------------------------------------------------------------

loc_C84E:
		move.w	#$EEE,(a0)+
		dbf	d0,loc_C84E

loc_C856:
		cmpi.b	#GameModeID_save_screen,(Game_mode).w	; are we still in the savescreen mode?
		beq.s	SaveScreen_MainLoop	; if so, loop
		moveq	#sfx_EnterSS,d0
		jmp	(PlaySound).l

; =============== S U B R O U T I N E =======================================


sub_C866:
		move.w	(a0)+,d7

loc_C868:
		movea.l	(a0)+,a1
		move.w	(a0)+,d0
		bsr.s	sub_C87E
		move.w	(a0)+,d1
		move.w	(a0)+,d2
		jsr	(Plane_Map_To_VRAM_2).l
		dbf	d7,loc_C868
		rts
; End of function sub_C866


; =============== S U B R O U T I N E =======================================


sub_C87E:
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		rts
; End of function sub_C87E

; ---------------------------------------------------------------------------
; selects whether to display the static screen, or new screen
; and is called during vblank
next_SaveSlot = $A

loc_C890:
		move.w	(Level_frame_counter).w,d0
		andi.w	#$C,d0
		lea	(MapPtrs_SaveScreenStatic).l,a2
		movea.l	(a2,d0.w),a2
		lea	(Saved_data).w,a0
		move.w	#$C21A,d7
		moveq	#7,d6

loc_C8B2:
		lea	(MapUnc_SaveScreenNEW).l,a1
		tst.b	(a0)		; is a game in progress?
		bmi.s	loc_C8BE
		movea.l	a2,a1

loc_C8BE:
		move.w	d7,d0
		bsr.s	sub_C87E
		moveq	#9,d1
		moveq	#6,d2
		jsr	(Plane_Map_To_VRAM_2).l
		addi.w	#$1A,d7
		lea	next_SaveSlot(a0),a0
		dbf	d6,loc_C8B2
		lea	(Dynamic_Object_RAM+object_size).w,a3	; load the first save slot object
		move.w	#$CA20,d7
		lea	(Saved_data).w,a0
		moveq	#7,d3

loc_C8E6:
		move.w	d7,d0
		subq.w	#2,d0
		jsr	sub_C87E(pc)
		move.l	d0,4(a6)
		move.w	#$82B1,(a6)
		lea	byte_DB2B(pc),a1
		tst.b	(a0)
		bmi.s	loc_C946
		lea	byte_DB36(pc),a1
		move.b	$3A(a3),d0  ;3A
		cmp.b	$37(a3),d0  ;37
		bne.s	loc_C912
		tst.b	$3B(a3)     ;3B
		bne.s	loc_C946

loc_C912:
		lea	byte_DB31(pc),a1
		move.w	d7,d0
		subq.w	#2,d0
		jsr	sub_D9F4(pc)
		move.w	$36(a3),d0   ;36
		add.w	d0,d0
		moveq	#0,d1
		move.b	byte_C95E(pc,d0.w),d1
		bpl.s	loc_C932
		move.w	#$8000,d1
		bra.s	loc_C936
; ---------------------------------------------------------------------------

loc_C932:
		addi.w	#$A562,d1

loc_C936:
		move.w	d1,(a6)
		moveq	#0,d1
		move.b	byte_C95E+1(pc,d0.w),d1
		addi.w	#$A562,d1
		move.w	d1,(a6)
		bra.s	loc_C94C
; ---------------------------------------------------------------------------

loc_C946:
		move.w	d7,d0
		jsr	sub_D9F4(pc)

loc_C94C:
		addi.w	#$1A,d7
		lea	next_SaveSlot(a0),a0
		lea	next_object(a3),a3
		dbf	d3,loc_C8E6
		bra.s	loc_C97A
; ---------------------------------------------------------------------------
; shows level number 1-14
; NOTE: $FF acts as zero
byte_C95E:
		dc.b  $FF,   1	; 01
		dc.b  $FF,   2	; 02
		dc.b  $FF,   3	; 03
		dc.b  $FF,   4	; 04
		dc.b  $FF,   5	; 05
		dc.b  $FF,   6	; 06
		dc.b  $FF,   7	; 07
		dc.b  $FF,   8	; 08
		dc.b  $FF,   9	; 09
		dc.b    1,   0	; 10
		dc.b    1,   1	; 11
		dc.b    1,   2	; 12
		dc.b    1,   3	; 13
		dc.b    1,   4	; 14
		even
; ---------------------------------------------------------------------------

loc_C97A:
		lea	word_DA8A(pc),a2
		lea	(Dynamic_Object_RAM+object_size).w,a3
		move.w	#$D220,d7
		lea	(Saved_data).w,a0
		moveq	#7,d6

loc_C98C:
		move.w	$34(a3),d0 ;34
		bne.s	loc_C994
		moveq	#1,d0

loc_C994:
		tst.b	(a0)
		bpl.s	loc_C99A
		moveq	#0,d0

loc_C99A:
		lsl.w	#5,d0
		movea.l	a2,a1
		adda.w	d0,a1
		move.w	d7,d0
		bsr.w	sub_C87E
		moveq	#2,d1
		moveq	#4,d2
		jsr	(Plane_Map_To_VRAM_2).l
		tst.b	(a0)
		bpl.s	loc_C9CC
		lea	word_DB08(pc),a1
		move.w	d7,d0
		addq.w	#6,d0
		bsr.w	sub_C87E
		moveq	#1,d1
		moveq	#4,d2
		jsr	(Plane_Map_To_VRAM_2).l
		bra.s	loc_CA02
; ---------------------------------------------------------------------------

loc_C9CC:
		move.b	$3E(a3),d0 ;3E
		jsr	sub_CA14(pc)
		move.w	d7,d0
		addq.w	#6,d0
		bsr.w	sub_C87E
		moveq	#1,d1
		moveq	#1,d2
		jsr	(Plane_Map_To_VRAM_2).l
		move.b	$3F(a3),d0  ;3F
		jsr	sub_CA14(pc)
		move.w	d7,d0
		addi.w	#$306,d0
		bsr.w	sub_C87E
		moveq	#1,d1
		moveq	#1,d2
		jsr	(Plane_Map_To_VRAM_2).l

loc_CA02:
		addi.w	#$1A,d7
		lea	next_SaveSlot(a0),a0
		lea	next_object(a3),a3
		dbf	d6,loc_C98C

		rts

; =============== S U B R O U T I N E =======================================


sub_CA14:
		moveq	#0,d1

loc_CA16:
		addq.w	#1,d1
		subi.b	#$A,d0
		bcc.s	loc_CA16
		subq.w	#1,d1
		addi.b	#$A,d0
		lea	(_unkEEEA).w,a1
		lsl.w	#2,d1
		bne.s	loc_CA2E
		moveq	#$28,d1

loc_CA2E:
		move.w	word_CA4C(pc,d1.w),(a1)
		move.w	word_CA4E(pc,d1.w),4(a1)
		andi.w	#$FF,d0
		lsl.w	#2,d0
		move.w	word_CA4C(pc,d0.w),2(a1)
		move.w	word_CA4E(pc,d0.w),6(a1)
		rts
; End of function sub_CA14

; ---------------------------------------------------------------------------
word_CA4C:	dc.w $A49A
word_CA4E:	dc.w $A49B
		dc.w $A49C
		dc.w $A49D
		dc.w $A49E
		dc.w $A49F
		dc.w $A4A0
		dc.w $A4A1
		dc.w $A4A2
		dc.w $A4A3
		dc.w $A4A4
		dc.w $A4A5
		dc.w $A4A6
		dc.w $A4A7
		dc.w $A4A8
		dc.w $A4A9
		dc.w $A4AA
		dc.w $A4AB
		dc.w $A4AC
		dc.w $A4AD
		dc.w $8000
		dc.w $8000
Pal_Save_Chars:	binclude "art/Save Menu/Palettes/Chars.bin"
	even

Pal_Save_Emeralds:	binclude "art/Save Menu/Palettes/Emeralds.bin"
	even

Pal_Save_FinishCard1:	binclude "art/Save Menu/Palettes/Finish Card 1.bin"
	even
Pal_Save_FinishCard2:	binclude "art/Save Menu/Palettes/Finish Card 2.bin"
	even
Pal_Save_FinishCard3:	binclude "art/Save Menu/Palettes/Finish Card 3.bin"
	even

Pal_Save_ZoneCard1:		binclude "art/Save Menu/Palettes/Zone Card 1.bin"
	even
Pal_Save_ZoneCard2:		binclude "art/Save Menu/Palettes/Zone Card 2.bin"
	even
Pal_Save_ZoneCard3:		binclude "art/Save Menu/Palettes/Zone Card 3.bin"
	even
Pal_Save_ZoneCard4:		binclude "art/Save Menu/Palettes/Zone Card 4.bin"
	even
Pal_Save_ZoneCard5:		binclude "art/Save Menu/Palettes/Zone Card 5.bin"
	even
Pal_Save_ZoneCard6:		binclude "art/Save Menu/Palettes/Zone Card 6.bin"
	even
Pal_Save_ZoneCard7:		binclude "art/Save Menu/Palettes/Zone Card 7.bin"
	even
Pal_Save_ZoneCard8:		binclude "art/Save Menu/Palettes/Zone Card 8.bin"
	even
Pal_Save_ZoneCard9:		binclude "art/Save Menu/Palettes/Zone Card 9.bin"
	even
Pal_Save_ZoneCardA:		binclude "art/Save Menu/Palettes/Zone Card A.bin"
	even
Pal_Save_ZoneCardB:		binclude "art/Save Menu/Palettes/Zone Card B.bin"
	even
Pal_Save_ZoneCardC:		binclude "art/Save Menu/Palettes/Zone Card C.bin"
	even
Pal_Save_ZoneCardD:		binclude "art/Save Menu/Palettes/Zone Card D.bin"
	even
Pal_Save_ZoneCardE:		binclude "art/Save Menu/Palettes/Zone Card E.bin"
	even
Pal_Save_ZoneCardF:		binclude "art/Save Menu/Palettes/Zone Card F.bin"
	even
Pal_Save_ZoneCard10:	binclude "art/Save Menu/Palettes/Zone Card 10.bin"
	even
Pal_Save_ZoneCard11:	binclude "art/Save Menu/Palettes/Zone Card 11.bin"
	even
Pal_Save_ZoneCard12:	binclude "art/Save Menu/Palettes/Zone Card 12.bin"
	even
Pal_SaveMenuBG:	binclude "art/Save Menu/Palettes/BG.bin"
        even
word_CD58:	dc.w $11
		dc.l Chunk_Table+$222
		dc.w $C102
		dc.w $A
		dc.w $B
		dc.l Chunk_Table
		dc.w $C118
		dc.w $C
		dc.w $14
		dc.l Chunk_Table
		dc.w $C132
		dc.w $C
		dc.w $14
		dc.l Chunk_Table
		dc.w $C14C
		dc.w $C
		dc.w $14
		dc.l Chunk_Table
		dc.w $C166
		dc.w $C
		dc.w $14
		dc.l Chunk_Table
		dc.w $C180
		dc.w $C
		dc.w $14
		dc.l Chunk_Table
		dc.w $C19A
		dc.w $C
		dc.w $14
		dc.l Chunk_Table+$104
		dc.w $CE18
		dc.w $C
		dc.w $A
		dc.l Chunk_Table+$104
		dc.w $CE32
		dc.w $C
		dc.w $A
		dc.l Chunk_Table+$104
		dc.w $CE4C
		dc.w $C
		dc.w $A
		dc.l Chunk_Table+$104
		dc.w $CE66
		dc.w $C
		dc.w $A
		dc.l Chunk_Table+$104
		dc.w $CE80
		dc.w $C
		dc.w $A
		dc.l Chunk_Table+$104
		dc.w $CE9A
		dc.w $C
		dc.w $A
		dc.l Chunk_Table
		dc.w $C1B4
		dc.w $C
		dc.w $14
		dc.l Chunk_Table
		dc.w $C1CE
		dc.w $C
		dc.w $14
		dc.l Chunk_Table+$222
		dc.w $C1E8
		dc.w $A
		dc.w $B
		dc.l Chunk_Table+$104
		dc.w $CEB4
		dc.w $C
		dc.w $A
		dc.l Chunk_Table+$104
		dc.w $CECE
		dc.w $C
		dc.w $A
		even
Map_SaveScreen:	include "art/Save Menu/Map - Save Screen General.asm"
                even
ObjDat_SaveScreen:
		dc.l Draw_Sprite				; "Data Select" Text
		dc.w $120						; x_pos, objoff_12 (x_pos copy)
		dc.w $14C						; y_pos
		dc.b 3							; mapping_frame
		dc.b 0							; unused
		dc.l Obj_SaveScreen_Selector	; Highlights the current selected slot
		dc.w $120						; x_pos, objoff_12 (x_pos copy)
		dc.w $E2						; y_pos
		dc.b 1							; mapping_frame
		dc.b 0							; unused
		dc.l Obj_SaveScreen_Delete_Save	; Delete Icon that erases a saved game
		dc.w $448						; x_pos, objoff_12 (x_pos copy)
		dc.w $D8						; y_pos
		dc.b $D							; mapping_frame
		dc.b 0							; unused
		dc.l Obj_SaveScreen_NoSave_Slot ; Slot that starts a non-saving game
		dc.w $B0						; x_pos, objoff_12 (x_pos copy)
		dc.w $C8						; y_pos
		dc.b 0							; unused
		dc.b 0							; unused
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w $110						; x_pos, objoff_12 (x_pos copy)
		dc.w $108						; y_pos
		dc.b 0							; mapping_frame
		dc.b 0							; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w $178						; x_pos, objoff_12 (x_pos copy)
		dc.w $108						; y_pos
		dc.b 0							; unused
		dc.b 1							; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w $1E0						; x_pos, objoff_12 (x_pos copy)
		dc.w $108						; y_pos
		dc.b 0							; unused
		dc.b 2							; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w $248						; x_pos, objoff_12 (x_pos copy)
		dc.w $108						; y_pos
		dc.b 0							; unused
		dc.b 3							; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w $2B0						; x_pos, objoff_12 (x_pos copy)
		dc.w $108						; y_pos
		dc.b 0							; unused
		dc.b 4							; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w $318						; x_pos, objoff_12 (x_pos copy)
		dc.w $108						; y_pos
		dc.b 0							; unused
		dc.b 5							; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w $380						; x_pos, objoff_12 (x_pos copy)
		dc.w $108						; y_pos
		dc.b 0							; unused
		dc.b 6							; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w $3E8						; x_pos, objoff_12 (x_pos copy)
		dc.w $108						; y_pos
		dc.b 0							; unused
		dc.b 7							; Save Slot ID Number
		even
; ---------------------------------------------------------------------------

Obj_SaveScreen_Selector:
		move.w	#$A8,d0
		moveq	#0,d1
		moveq	#0,d2
		move.b	(Dataselect_entry).w,d2
		subq.w	#1,d2
		bcs.s	loc_D1E6

loc_D1C6:
		moveq	#$C,d4

loc_D1C8:
		addq.w	#8,d0
		cmpi.w	#$120,d0
		bls.s	loc_D1DE
		subq.w	#8,d0
		addq.w	#8,d1
		cmpi.w	#$2C0,d1
		bls.s	loc_D1DE
		subq.w	#8,d1
		addq.w	#8,d0

loc_D1DE:
		dbf	d4,loc_D1C8
		dbf	d2,loc_D1C6

loc_D1E6:
		move.w	d0,$12(a0)
		move.w	d1,(Camera_X_pos_copy).w
		neg.w	d1
		move.w	d1,(Horiz_Scroll_Buf+2).w
		move.l	#loc_D1FA,(a0)

loc_D1FA:
		tst.w	(Events_bg+$12).w
		bne.s	loc_D212
		btst	#4,(Ctrl_1_pressed).w
		beq.s	loc_D212
		move.b	#4,(Game_mode).w
		bra.w	loc_D2CE
; ---------------------------------------------------------------------------

loc_D212:
		tst.w	(Events_bg+$10).w
		bne.w	loc_D2CE
		tst.w	$30(a0)
		bne.s	loc_D28A
		moveq	#0,d0
		btst	#2,(Ctrl_1_pressed).w
		beq.s	loc_D254
		tst.w	(Events_bg+$12).w
		beq.s	loc_D238
		cmpi.b	#1,(Dataselect_entry).w
		beq.s	loc_D254

loc_D238:
		tst.b	(Dataselect_entry).w
		beq.s	loc_D254
		subq.b	#1,(Dataselect_entry).w
		moveq	#sfx_SlotMachine,d0
		tst.w	(Events_bg+$12).w
		beq.s	loc_D24C
		moveq	#sfx_SmallBumpers,d0

loc_D24C:
		jsr	(Play_Sound_2).l
		moveq	#-8,d0

loc_D254:
		btst	#3,(Ctrl_1_pressed).w
		beq.s	loc_D27A
		cmpi.b	#9,(Dataselect_entry).w
		beq.s	loc_D27A
		addq.b	#1,(Dataselect_entry).w
		moveq	#sfx_SlotMachine,d0
		tst.w	(Events_bg+$12).w
		beq.s	loc_D272
		moveq	#sfx_SmallBumpers,d0

loc_D272:
		jsr	(Play_Sound_2).l
		moveq	#8,d0

loc_D27A:
		move.w	d0,$2E(a0)
		beq.s	loc_D288
		move.w	#$D,$30(a0)
		bra.s	loc_D28A
; ---------------------------------------------------------------------------

loc_D288:
		bra.s	loc_D2CE
; ---------------------------------------------------------------------------

loc_D28A:
		move.w	$12(a0),d0
		move.w	(Camera_X_pos_copy).w,d1
		move.w	$2E(a0),d2
		bmi.s	loc_D2B0
		add.w	d2,d0
		cmpi.w	#$120,d0
		bls.s	loc_D2C2
		sub.w	d2,d0
		add.w	d2,d1
		cmpi.w	#$2C0,d1
		bls.s	loc_D2C2
		sub.w	d2,d1
		add.w	d2,d0
		bra.s	loc_D2C2
; ---------------------------------------------------------------------------

loc_D2B0:
		add.w	d2,d0
		cmpi.w	#$120,d0
		bhs.s	loc_D2C2
		sub.w	d2,d0
		add.w	d2,d1
		bpl.s	loc_D2C2
		sub.w	d2,d1
		add.w	d2,d0

loc_D2C2:
		move.w	d0,$12(a0)
		move.w	d1,(Camera_X_pos_copy).w
		subq.w	#1,$30(a0)

loc_D2CE:
		moveq	#8,d2
		move.b	(Dataselect_entry).w,d1
		beq.s	loc_D2E0
		neg.w	d2
		cmpi.b	#9,d1
		beq.s	loc_D2E0
		moveq	#0,d2

loc_D2E0:
		add.w	$12(a0),d2
		move.w	d2,$10(a0)
		moveq	#2,d0
		cmpi.w	#$F0,d2
		blo.s	loc_D2F8
		cmpi.w	#$148,d2
		bhi.s	loc_D2F8
		moveq	#1,d0

loc_D2F8:
		move.b	d0,$22(a0)
		btst	#2,(Level_frame_counter+1).w
		beq.s	locret_D30A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_D30A:
		rts
; ---------------------------------------------------------------------------

Obj_SaveScreen_NoSave_Slot:
		move.b	#$F,$1D(a0)
		move.w	(Dataselect_nosave_player).w,d0
		addq.w	#4,d0
		move.b	d0,$22(a0)
		tst.b	(Dataselect_entry).w
		bne.s	loc_D396
		move.w	(Player_2+object_control).w,d0
		or.w	(Events_bg+$12).w,d0
		bne.s	loc_D396
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#$E0,d0
		beq.s	loc_D376
		move.b	#$C,(Game_mode).w
		move.w	(Dataselect_nosave_player).w,(Player_option).w
		clr.w	(Current_zone_and_act).w
	;	clr.w	(Apparent_zone_and_act).w
	;	clr.w	(Current_special_stage).w
		clr.b	(Emerald_count).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
		clr.l	(Collected_special_ring_array).w
		clr.b	(Emeralds_converted_flag).w
		clr.l	(Save_pointer).w
		jsr	(Set_Lives_and_Continues).l
		moveq	#PLCID_Std1,d0
         	jsr	LoadPLC2
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D376:
		move.w	(Dataselect_nosave_player).w,d0
		jsr	sub_D6D0(pc)
		move.w	d0,(Dataselect_nosave_player).w
		addq.w	#4,d0
		move.b	d0,$22(a0)
		move.w	#1,$16(a0)
		btst	#4,(Level_frame_counter+1).w
		bne.s	loc_D39A

loc_D396:
		clr.w	$16(a0)

loc_D39A:
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

Obj_SaveScreen_Save_Slot:
		jsr	(Create_New_Sprite3).l
		bne.s	loc_D3B0
		move.l	#Obj_SaveScreen_Emeralds,(a1)
		move.w	a0,parent2(a1)

loc_D3B0:
		moveq	#0,d0
		move.b	$2E(a0),d0
		mulu.w	#$A,d0
		addi.l	#Saved_data,d0
		move.l	d0,$30(a0)
		movea.l	d0,a1
		move.b	2(a1),d0
		lsr.b	#4,d0
		move.b	d0,$35(a0)
		move.b	3(a1),d0
		move.b	d0,$37(a0)
		move.b	d0,$3A(a0)
		move.b	(a1),d0
		andi.b	#3,d0
		move.b	d0,$3B(a0)
		move.w	$0006(a1),d0
		lea	(Collected_emeralds_array).w,a2
		jsr	sub_DA1E(pc)
		move.b	d1,$3C(a0)
		move.b	d2,$3D(a0)
		tst.b	9(a1)
		bne.s	loc_D41A
		cmpi.b	#3,8(a1)
		bhs.s	loc_D41A
		move.b	#3,8(a1)
		move.l	a1,-(sp)
		st	(SRAM_mask_interrupts_flag).w
		jsr	Write_SaveGame(pc)
		movea.l	(sp)+,a1

loc_D41A:
		move.b	8(a1),$3E(a0)
		move.b	9(a1),$3F(a0)
		move.l	#loc_D42C,(a0)

loc_D42C:
		clr.w	$16(a0)
		movea.l	$30(a0),a1
		move.b	(Dataselect_entry).w,d0
		subq.b	#1,d0
		cmp.b	$2E(a0),d0
		beq.s	Load_Level_Icons
		move.b	3(a1),$37(a0)
		clr.w	$38(a0)

loc_D44A:
		move.w	$34(a0),d0
		addq.w	#4,d0
		move.b	d0,$22(a0)
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

Load_Level_Icons:
		tst.b	(a1)
		bmi.w	loc_D5FE
		move.w	$36(a0),d1
		jsr	Load_Icon_Art(pc)
		move.b	#$17,$23(a0)
		move.w	$36(a0),d1
		cmp.b	$3A(a0),d1
		bne.s	loc_D4A4
		move.b	$3B(a0),d0
		beq.s	loc_D4A4
		addq.b	#1,$23(a0)
		cmpi.b	#1,d0
		beq.s	loc_D496
		addq.b	#1,$23(a0)
		cmpi.b	#2,d0
		beq.s	loc_D496
		addq.b	#2,$23(a0)
		bra.s	loc_D4A4
; ---------------------------------------------------------------------------

loc_D496:
		cmpi.w	#1,$34(a0)
		bls.s	loc_D4A4
		move.b	#$23,$23(a0)

loc_D4A4:
		tst.w	$38(a0)
		bne.s	loc_D4B6
		tst.b	$3B(a0)
		beq.w	loc_D534
		st	$38(a0)

loc_D4B6:
		tst.w	(Player_2+object_control).w
		bne.s	loc_D44A
		tst.w	(Events_bg+$12).w
		beq.s	loc_D4D0
		clr.b	$1D(a0)
		move.w	#2,$16(a0)
		bra.w	loc_D44A
; ---------------------------------------------------------------------------

loc_D4D0:
		moveq	#$B,d6
		cmpi.w	#3,$34(a0)
		beq.s	loc_D4EE
		moveq	#$C,d6
		cmpi.w	#2,$34(a0)
		beq.s	loc_D4EE
		cmpi.b	#2,$3B(a0)
		blo.s	loc_D4EE
		moveq	#$D,d6

loc_D4EE:
		moveq	#0,d2
		move.w	$36(a0),d1
		move.b	(Ctrl_1_pressed).w,d0
		btst	#1,d0
		beq.s	loc_D508
		moveq	#sfx_Switch,d2
		subq.w	#1,d1
		bpl.s	loc_D518
		move.w	d6,d1
		bra.s	loc_D518
; ---------------------------------------------------------------------------

loc_D508:
		btst	#0,d0
		beq.s	loc_D518
		moveq	#sfx_Switch,d2
		addq.w	#1,d1
		cmp.w	d6,d1
		bls.s	loc_D518
		moveq	#0,d1

loc_D518:
		move.w	d1,$36(a0)
		move.l	d2,d0
		jsr	(Play_Sound_2).l
		move.b	#$1A,$1D(a0)
		btst	#4,(Level_frame_counter+1).w
		beq.s	loc_D53C
		bra.s	loc_D540
; ---------------------------------------------------------------------------

loc_D534:
		tst.w	(Player_2+object_control).w
		bne.w	loc_D44A

loc_D53C:
		clr.b	$1D(a0)

loc_D540:
		move.w	#2,$16(a0)
		tst.w	(Events_bg+$12).w
		bne.w	loc_D44A
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#$E0,d0
		beq.w	loc_D44A
		move.w	4(a1),(Collected_special_ring_array+2).w
		move.b	3(a1),d0
		tst.b	$3B(a0)
		beq.s	loc_D57A
		move.w	$36(a0),d0
		cmp.b	$3A(a0),d0
		bhs.w	loc_D44A
		clr.l	(Collected_special_ring_array).w

loc_D57A:
		jsr	sub_DA4E(pc)
		move.w	d0,(Current_zone_and_act).w
	;	move.w	d0,(Apparent_zone_and_act).w
		moveq	#0,d0
		move.b	2(a1),d0
		lsr.b	#4,d0
		move.w	d0,(Player_option).w
		move.b	2(a1),d0
		andi.b	#$F,d0
		move.b	d0,(Current_special_stage).w
		move.w	6(a1),d0
		lea	(Collected_emeralds_array).w,a2
		jsr	sub_DA1E(pc)
		move.b	d1,(Emerald_count).w
		move.b	d2,(Super_emerald_count).w
		move.l	a1,(Save_pointer).w
		jsr	(Set_Lives_and_Continues).l
		move.b	8(a1),d0
		beq.s	loc_D5CE
		cmpi.b	#3,d0
		bhs.s	loc_D5DE
		tst.b	9(a1)
		bne.s	loc_D5DE

loc_D5CE:
		move.b	#3,8(a1)
		subq.b	#1,9(a1)
		bcc.s	loc_D5DE
		clr.b	9(a1)

loc_D5DE:
		move.b	8(a1),(Life_count).w
		move.b	9(a1),(Continue_count).w
		st	(SRAM_mask_interrupts_flag).w
		jsr	Write_SaveGame(pc)
		move.b	#$C,(Game_mode).w 
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D5FE:
		move.b	#$F,$1D(a0)
		clr.b	$23(a0)
		move.w	(Player_2+object_control).w,d0
		or.w	(Events_bg+$12).w,d0
		bne.w	loc_D44A
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#$E0,d0
		beq.s	loc_D67A
		move.b	#$C,(Game_mode).w 
		clr.l	(a1)
		clr.l	4(a1)
		move.w	#$300,8(a1)
		move.w	$34(a0),d0
		move.w	d0,(Player_option).w
		lsl.b	#4,d0
		move.b	d0,2(a1)
		clr.w	(Current_zone_and_act).w
	;	clr.w	(Apparent_zone_and_act).w
		clr.w	(Current_special_stage).w
		clr.b	(Emerald_count).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
	;	clr.l	(Collected_special_ring_array).w
		clr.b	(Emeralds_converted_flag).w
		move.l	a1,(Save_pointer).w
		jsr	(Set_Lives_and_Continues).l
		st	(SRAM_mask_interrupts_flag).w
		jsr	Write_SaveGame(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D67A:
		move.w	$34(a0),d0
		jsr	sub_D6D0(pc)
		move.w	d0,$34(a0)
		addq.w	#4,d0
		move.b	d0,$22(a0)
		move.w	#1,$16(a0)
		btst	#4,(Level_frame_counter+1).w
		bne.s	Set_ChildSprites
		clr.w	$16(a0)

Set_ChildSprites:
		move.w	$12(a0),d0
		sub.w	(Camera_X_pos_copy).w,d0
		move.w	d0,$10(a0)
		move.w	$14(a0),d1
		move.w	d0,$18(a0)
		move.w	d1,$1A(a0)
		move.w	d0,$1E(a0)
		move.w	d1,$20(a0)
		cmpi.b	#$1A,$1D(a0)
		bne.s	loc_D6CA
		subq.w	#8,$1A(a0)

loc_D6CA:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_D6D0:
		moveq	#0,d2
		tst.w	(Player_2+$30).w ;30
		bne.s	loc_D6FA
		move.b	(Ctrl_1_pressed).w,d1
		lsr.w	#1,d1
		bcc.s	loc_D6EE
		moveq	#sfx_Switch,d2
		addq.w	#1,d0
		cmpi.w	#2,d0
		bls.s	loc_D6FA
		moveq	#0,d0
		bra.s	loc_D6FA
; ---------------------------------------------------------------------------

loc_D6EE:
		lsr.w	#1,d1
		bcc.s	loc_D6FA
		moveq	#sfx_Switch,d2
		subq.w	#1,d0
		bpl.s	loc_D6FA
		moveq	#2,d0

loc_D6FA:
		tst.w	d2
		beq.s	locret_D70A
		move.l	d0,-(sp)
		move.l	d2,d0
		jsr	(Play_Sound_2).l
		move.l	(sp)+,d0

locret_D70A:
		rts
; End of function sub_D6D0

; ---------------------------------------------------------------------------

Obj_SaveScreen_Emeralds:
		move.b	#$40,4(a0)
		move.w	#$829F,$A(a0)
		move.l	#Map_SaveScreen,$C(a0)
		move.b	#$40,7(a0)
		move.w	#7,$16(a0)
		movea.w	parent2(a0),a1
		movea.l	$30(a1),a2
		move.w	6(a2),d4
		move.w	$10(a1),d0
		move.w	$14(a1),d1
		move.w	d0,$10(a0)
		move.w	d1,$14(a0)
		lea	$18(a0),a1
		moveq	#$10,d2
		moveq	#6,d3

loc_D750:
		clr.b	5(a1)
		moveq	#0,d6
		rol.w	#2,d4
		move.w	d4,d5
		andi.w	#3,d5
		beq.s	loc_D774
		cmpi.w	#3,d5
		bne.s	loc_D768
		moveq	#$C,d6

loc_D768:
		add.b	d2,d6
		move.w	d0,(a1)
		move.w	d1,2(a1)
		move.b	d6,5(a1)

loc_D774:
		addq.w	#1,d2
		addq.w	#6,a1
		dbf	d3,loc_D750
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SaveScreen_Delete_Save:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	loc_D78C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_D78C:
		bra.w	loc_D7A4
; ---------------------------------------------------------------------------
		bra.w	loc_D7C0
; ---------------------------------------------------------------------------
		bra.w	loc_D7EA
; ---------------------------------------------------------------------------
		bra.w	loc_D884
; ---------------------------------------------------------------------------
		bra.w	loc_D8A4
; ---------------------------------------------------------------------------
		bra.w	loc_D8C4
; ---------------------------------------------------------------------------

loc_D7A4:
		move.b	#$40,4(a0)
		move.b	#$30,7(a0)
		move.w	#1,$16(a0)
		move.b	#8,$1D(a0)
		addq.b	#4,5(a0)

loc_D7C0:
		cmpi.b	#9,(Dataselect_entry).w
		bne.w	loc_D8A0
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#$E0,d0
		beq.w	loc_D8A0
		moveq	#sfx_Starpost,d0
		jsr	(Play_Sound_2).l
		st	(Events_bg+$12).w
		addq.b	#4,5(a0)
		bra.w	loc_D8A0
; ---------------------------------------------------------------------------

loc_D7EA:
		jsr	sub_D912(pc)
		jsr	sub_D94A(pc)
		tst.w	(Player_2+object_control).w
		bne.s	loc_D83C
		move.b	(Ctrl_1_pressed).w,d0
		btst	#4,d0
		bne.s	loc_D854
		andi.w	#$E0,d0
		beq.s	loc_D83C
		cmpi.b	#9,(Dataselect_entry).w
		beq.s	loc_D854
		moveq	#0,d0
		move.b	(Dataselect_entry).w,d0
		subq.w	#1,d0
		mulu.w	#$A,d0
		addi.l	#Saved_data,d0
		move.l	d0,$2E(a0)
		movea.l	d0,a1
		tst.b	(a1)
		bmi.s	loc_D854
		moveq	#sfx_Starpost,d0
		jsr	(Play_Sound_2).l
		st	(Events_bg+$10).w
		addq.b	#8,5(a0)

loc_D83C:
		move.w	(Player_2+x_pos).w,d0
		move.w	d0,$10(a0)
		move.w	d0,$18(a0)
		move.w	$14(a0),$1A(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D854:
		clr.b	$24(a0)
		clr.b	$23(a0)
		clr.b	$25(a0)
		clr.b	$28(a0)
		move.b	#$D,$22(a0)
		move.b	#8,$1D(a0)
		move.w	(Player_2+x_pos).w,d0
		add.w	(Camera_X_pos_copy).w,d0
		move.w	d0,$12(a0)
		addq.b	#4,5(a0)
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

loc_D884:
		clr.w	(Events_bg+$12).w
		move.w	$12(a0),d0
		cmpi.w	#$448,d0
		blo.s	loc_D89A
		move.b	#4,5(a0)
		bra.s	loc_D8A0
; ---------------------------------------------------------------------------

loc_D89A:
		addq.w	#8,d0
		move.w	d0,$12(a0)

loc_D8A0:
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

loc_D8A4:
		jsr	sub_D912(pc)
		jsr	sub_D94A(pc)
		cmpi.b	#$B,$1D(a0)
		bne.s	loc_D8BE
		move.b	#$C,$1D(a0)
		addq.b	#4,5(a0)

loc_D8BE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D8C4:
		jsr	sub_D912(pc)
		btst	#3,(Ctrl_1_pressed).w
		bne.s	loc_D8FE
		btst	#2,(Ctrl_1_pressed).w
		beq.s	loc_D90C
		moveq	#sfx_Perfect,d0
		jsr	(Play_Sound_2).l
		movea.l	$2E(a0),a1
		move.w	#$8000,(a1)
		clr.l	2(a1)
		clr.w	6(a1)
		move.w	#$300,8(a1)
		st	(SRAM_mask_interrupts_flag).w
		jsr	Write_SaveGame(pc)

loc_D8FE:
		move.b	#8,5(a0)
		clr.w	(Events_bg+$10).w
		bra.w	loc_D854
; ---------------------------------------------------------------------------

loc_D90C:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_D912:
		subq.b	#1,$24(a0)
		bpl.s	locret_D938
		move.b	#5,$24(a0)

loc_D91E:
		moveq	#0,d0
		move.b	$23(a0),d0
		addq.b	#1,$23(a0)
		move.b	byte_D93A(pc,d0.w),d0
		bpl.s	loc_D934
		clr.b	$23(a0)
		bra.s	loc_D91E
; ---------------------------------------------------------------------------

loc_D934:
		move.b	d0,$22(a0)

locret_D938:
		rts
; End of function sub_D912

; ---------------------------------------------------------------------------
byte_D93A:	dc.b   $D,  $E,  $D,  $E,  $D,  $E,  $D,  $E,  $D,  $E,  $D,  $D,  $D,  $D, $FF,   0
                even
; =============== S U B R O U T I N E =======================================


sub_D94A:
		subq.b	#1,$25(a0)
		bpl.s	locret_D968
		move.b	#3,$25(a0)
		addq.b	#1,$28(a0)
		move.b	$28(a0),d0
		andi.b	#3,d0
		addq.b	#8,d0
		move.b	d0,$1D(a0)

locret_D968:
		rts
; End of function sub_D94A


; =============== S U B R O U T I N E =======================================


Load_Icon_Art:
		cmp.b	$3A(a0),d1
		bne.s	loc_D9A2
		tst.b	$3B(a0)
		beq.s	loc_D9A2
		cmpi.w	#1,$34(a0)
		bls.s	loc_D9C8
		cmpi.b	#3,$3B(a0)
		beq.s	loc_D9C8
		moveq	#$E,d1
		cmpi.w	#3,$34(a0)
		beq.s	loc_D992
		addq.w	#2,d1

loc_D992:
		cmpi.b	#1,$3B(a0)
		beq.s	loc_D99C
		addq.w	#1,d1

loc_D99C:
		move.w	#$A380,d2
		bra.s	loc_D9A6
; ---------------------------------------------------------------------------

loc_D9A2:
		move.w	#$B740,d2

loc_D9A6:
		move.l	a1,-(sp)
		move.w	d1,-(sp)
		mulu.w	#$8C0,d1
		addi.l	#Chunk_Table,d1
		move.w	#$460,d3
		jsr	(Add_To_DMA_Queue).l
		move.w	(sp)+,d0
		movea.l	(sp)+,a1
		lea	Pal_Save_ZoneCard1(pc),a2
		bra.s	loc_D9E2
; ---------------------------------------------------------------------------

loc_D9C8:
		lea	Pal_Save_FinishCard1(pc),a2
		moveq	#0,d0
		cmpi.b	#1,$3B(a0)
		beq.s	loc_D9E2
		addq.w	#1,d0
		cmpi.b	#2,$3B(a0)
		beq.s	loc_D9E2
		addq.w	#1,d0

loc_D9E2:
		lsl.w	#5,d0
		adda.w	d0,a2
		lea	(Normal_palette_line4).w,a3
		moveq	#7,d0

loc_D9EC:
		move.l	(a2)+,(a3)+
		dbf	d0,loc_D9EC
		rts
; End of function Load_Icon_Art


; =============== S U B R O U T I N E =======================================


sub_D9F4:
		lea	(VDP_data_port).l,a6
		jsr	sub_C87E(pc)
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	#$A552,d5
		moveq	#0,d6

loc_DA08:
		move.b	(a1)+,d6
		bne.s	loc_DA12
		move.w	#$8000,(a6)
		bra.s	loc_DA08
; ---------------------------------------------------------------------------

loc_DA12:
		bmi.s	locret_DA1C
		move.w	d5,d4
		add.w	d6,d4
		move.w	d4,(a6)
		bra.s	loc_DA08
; ---------------------------------------------------------------------------

locret_DA1C:
		rts
; End of function sub_D9F4


; =============== S U B R O U T I N E =======================================


sub_DA1E:
		clr.b	(Emeralds_converted_flag).w
		moveq	#0,d1
		moveq	#0,d2
		moveq	#6,d3

loc_DA28:
		rol.w	#2,d0
		move.w	d0,d4
		andi.w	#3,d4
		move.b	d4,(a2)+
		beq.s	loc_DA3E
		addq.w	#1,d1
		cmpi.w	#3,d4
		bne.s	loc_DA3E
		addq.w	#1,d2

loc_DA3E:
		cmpi.w	#2,d4
		blo.s	loc_DA48
		st	(Emeralds_converted_flag).w

loc_DA48:
		dbf	d3,loc_DA28
		rts
; End of function sub_DA1E


; =============== S U B R O U T I N E =======================================


sub_DA4E:
		cmpi.w	#3,$34(a0)
		bne.s	loc_DA62
		cmpi.b	#$B,d0
		bne.s	loc_DA62
		move.w	#$A01,d0
		bra.s	locret_DA6C
; ---------------------------------------------------------------------------

loc_DA62:
		andi.w	#$F,d0
		add.w	d0,d0
		move.w	LevelList_DA6E(pc,d0.w),d0

locret_DA6C:
		rts
; End of function sub_DA4E
EHZ  =  0
ID1  =  $100
ID2  =  $200
ID3  =  $300
MTZ  =  $400
MTZ3 =  $500
WFZ  =  $600
HTZ  =  $700
HPZ  =  $800
ID9  =  $900
OOZ  =  $A00
MCZ  =  $B00
CNZ  =  $C00
CPZ  =  $D00
DEZ  =  $E00
ARZ  =  $F00
SCZ  =  $1000
; ---------------------------------------------------------------------------
LevelList_DA6E:	
        dc.w EHZ
		dc.w CPZ
		dc.w ARZ
		dc.w CNZ
		dc.w HTZ
		dc.w MCZ
		dc.w OOZ
		dc.w MTZ
		dc.w SCZ
		dc.w DEZ
		dc.w $1601
		dc.w $A00
		dc.w $B00
		dc.w $C00
		even 
word_DA8A:	dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w 0
		dc.w $A4C2
		dc.w $A4C4
		dc.w $A4AE
		dc.w $A4C3
		dc.w $A4C5
		dc.w $A4AF
		dc.w $A4B0
		dc.w $A4B3
		dc.w $A000
		dc.w $A4B1
		dc.w $A4B4
		dc.w $A4AE
		dc.w $A4B2
		dc.w $A4B5
		dc.w $A4AF
		dc.w 0
		dc.w $A4C6
		dc.w $A4C8
		dc.w $A4AE
		dc.w $A4C7
		dc.w $A4C9
		dc.w $A4AF
		dc.w $A4B6
		dc.w $A4B9
		dc.w $A000
		dc.w $A4B7
		dc.w $A4BA
		dc.w $A4AE
		dc.w $A4B8
		dc.w $A4BB
		dc.w $A4AF
		dc.w 0
		dc.w $A4CA
		dc.w $A4CC
		dc.w $A4AE
		dc.w $A4CB
		dc.w $A4CD
		dc.w $A4AF
		dc.w $A4BC
		dc.w $A4BF
		dc.w $A000
		dc.w $A4BD
		dc.w $A4C0
		dc.w $A4AE
		dc.w $A4BE
		dc.w $A4C1
		dc.w $A4AF
word_DB08:	dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
		dc.w $8000
byte_DB1C:	dc.b  $2B, $2C, $FF, $30, $1E, $33, $22, $FF, $21, $22, $29, $22, $31, $22, $FF
                even
byte_DB2B:	dc.b    0,   0,   0,   0,   0, $FF
                even
byte_DB31:	dc.b  $37, $2C, $2B, $22, $FF
                even
byte_DB36:	dc.b  $20, $29, $22, $1E, $2F, $FF
            even
KosArt_To_VDP:
		movea.l	a1,a3		; a1 will be changed by Kos_Decomp, so we're backing it up to a3
		jsr	(Kos_Decomp).l

		move.l	a3,d1		; move the backed-up a1 to d1
		andi.l	#$FFFFFF,d1	; d1 will be used in the DMA transfer as the Source Address

		move.l	a1,d3		; move end address of decompressed art to d3
		sub.l	a3,d3		; subtract 'start address of decompressed art' from 'end address of decompressed art', giving you the size of the decompressed art
		lsr.l	#1,d3		; divide size of decompressed art by two, d3 will be used in the DMA transfer as the Transfer Length (size/2)

		move.w	a2,d2		; move VRAM address to d2, d2 will be used in the DMA transfer as the Destination Address

		movea.l	a1,a3		; backup a1, this allows the same address to be used by multiple calls to KosArt_To_VDP without constant redefining
		jsr	(Add_To_DMA_Queue).l	; transfer *Transfer Length* of data from *Source Address* to *Destination Address*
		movea.l	a3,a1		; restore a1
		rts
; End of function KosArt_To_VDP
SRAM_Load:
	;	tst.w	(SK_alone_flag).w
	;	bne.w	locret_C260		; Don't bother if we're playing only Sonic and Knuckles
		clr.w	(SRAM_mask_interrupts_flag).w	; No interrupt shenanigans needed
		lea	($200011).l,a0
		lea	($2000BD).l,a1
		lea	(Competition_saved_data).w,a2
		moveq	#$29,d0
		move.w	#$4C44,d1		; RAM integrity value
		jsr	Get_From_SRAM(pc)
		beq.s	loc_C190		; If the data read was successful, branch
		lea	SaveData_GeneralDefault(pc),a0
		lea	(Competition_saved_data).w,a1
		moveq	#$28,d0

loc_C186:
		move.w	(a0)+,(a1)+		; Reset the general save data to the default
		dbf	d0,loc_C186
		jsr	Write_SaveGeneral2(pc)	; Write default data back to SRAM

loc_C190:
		lea	($200281).l,a0
		lea	($20032D).l,a1
		lea	(Saved_data).w,a2
		moveq	#$29,d0
		move.w	#$4244,d1		; RAM integrity value for save game data
		jsr	Get_From_SRAM(pc)
		bne.s	loc_C1C0		; If the data read was not successful, branch
		lea	(Saved_data).w,a0
		moveq	#7,d0

loc_C1B2:
		tst.b	(a0)
		bpl.w	loc_C256		; If any of the save files are active, then we're done here
		lea	$A(a0),a0
		dbf	d0,loc_C1B2			; if not then we load them up with default data

loc_C1C0:
		lea	SaveData_GameDefault(pc),a0
		lea	(Saved_data).w,a1
		moveq	#$28,d0

loc_C1CA:
		move.w	(a0)+,(a1)+
		dbf	d0,loc_C1CA			; Write default game data
		lea	($200169).l,a0
		lea	($2001F5).l,a1
		lea	($FF0000).l,a2		; Attempt to see if there's any existing S3 save data
		moveq	#$19,d0
		move.w	#$4244,d1
		jsr	Get_From_SRAM(pc)
		bne.s	loc_C252		; If write was not successful, branch
		lea	(Saved_data).w,a0	; If there's valid data from Sonic 3, we'll now go through the process of migrating it to SK
		lea	($FF0000).l,a1
		lea	SaveData_S3LevRef(pc),a2
		moveq	#5,d0

loc_C1FE:
		tst.b	(a1)
		bmi.s	loc_C248		; If not an active save slot, branch
		clr.b	(a0)
		move.b	1(a1),4(a0)		; Special stage ring memory migration
		move.b	7(a1),5(a0)
		move.b	2(a1),d1
		lsl.b	#4,d1
		move.b	d1,2(a0)		; Character ID is stored differently
		moveq	#0,d1
		move.b	3(a1),d1
		move.b	(a2,d1.w),3(a0)	; Current level IDs are changed slightly between S3 and SK and need to be converted
		move.b	4(a1),d1
		or.b	d1,2(a0)		; The last completed special stage was previously its own byte
		move.b	6(a1),d1
		moveq	#0,d2
		moveq	#6,d3

loc_C236:
		lsl.b	#1,d1
		bcc.s	loc_C23E
		ori.w	#1,d2

loc_C23E:
		lsl.w	#2,d2
		dbf	d3,loc_C236
		move.w	d2,6(a0)	; The chaos/super emerald data is interleaved in SK and needs to be converted

loc_C248:
		lea	$A(a0),a0
		addq.w	#8,a1
		dbf	d0,loc_C1FE

loc_C252:
		jsr	Write_SaveGame(pc)

loc_C256:
		clr.w	(Dataselect_nosave_player).w
		move.b	#1,(Dataselect_entry).w

locret_C260:
		rts
; End of function SRAM_Load

; ---------------------------------------------------------------------------
SaveData_GeneralDefault:
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200, $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200, $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200, $4C44
SaveData_GameDefault:
		dc.w  $8000,     0,     0,     0,  $300, $8000,     0,     0,     0,  $300, $8000,     0,     0,     0,  $300, $8000
		dc.w      0,     0,     0,  $300, $8000,     0,     0,     0,  $300, $8000,     0,     0,     0,  $300, $8000,     0
		dc.w      0,     0,  $300, $8000,     0,     0,     0,  $300, $4244
SaveData_S3LevRef:
		dc.b 0
		dc.b 1
		dc.b 2
		dc.b 3
		dc.b 0
		dc.b 4
		dc.b 5
		dc.b 6

; =============== S U B R O U T I N E =======================================


Get_From_SRAM:
		movea.l	a2,a3
		move.w	d0,d2
		bsr.s	Read_SRAM
		beq.s	locret_C31E
		movea.l	a1,a0
		movea.l	a3,a2
		move.w	d2,d0
		bsr.s	Read_SRAM

locret_C31E:
		rts
; End of function Get_From_SRAM


; =============== S U B R O U T I N E =======================================


Read_SRAM:
		tst.w	(SRAM_mask_interrupts_flag).w
		beq.s	loc_C32A
		move	#$2700,sr		; Disable interrupts if EF56 is set

loc_C32A:
		move.b	#1,(SRAM_access_flag).l	; Access SRAM
		movea.l	a2,a6
		move.w	d0,d6

loc_C336:
		movep.w	0(a0),d3
		move.w	d3,(a2)+		; Read data from SRAM
		addq.w	#4,a0
		dbf	d0,loc_C336
		move.b	#0,(SRAM_access_flag).l	; No longer access SRAM
		tst.w	(SRAM_mask_interrupts_flag).w
		beq.s	loc_C354
		move	#$2300,sr		; Restore interrupts if EF56 is set

loc_C354:
		subq.w	#1,d6
		bsr.s	Create_SRAMChecksum	; Get the checksum of the given data
		cmp.w	(a6),d7		; Compare the result
		bne.s	locret_C360
		cmp.w	-2(a6),d1	; Also compare the data before with the data given in d1

locret_C360:
		rts
; End of function Read_SRAM


; =============== S U B R O U T I N E =======================================


Create_SRAMChecksum:
		moveq	#0,d7

loc_C364:
		move.w	(a6)+,d5
		eor.w	d5,d7
		lsr.w	#1,d7
		bcc.s	loc_C370
		eori.w	#$8810,d7

loc_C370:
		dbf	d6,loc_C364
		rts
; End of function Create_SRAMChecksum


; =============== S U B R O U T I N E =======================================


Write_SRAM:
		movea.l	a2,a6
		move.w	d0,d6
		subq.w	#1,d6
		bsr.s	Create_SRAMChecksum
		move.w	d7,(a6)
		tst.w	(SRAM_mask_interrupts_flag).w
		beq.s	loc_C38A
		move	#$2700,sr		; If EF56 is set, disable interrupts while saving is occuring

loc_C38A:
		move.b	#1,(SRAM_access_flag).l	; Send I/O signal to SRAM, mapping it to $200001
		movea.l	a2,a3
		move.w	d0,d1

loc_C396:
		move.w	(a2)+,d2
		movep.w	d2,0(a0)	; Copy data to SRAM
		addq.w	#4,a0
		dbf	d0,loc_C396

loc_C3A2:
		move.w	(a3)+,d2
		movep.w	d2,0(a1)	; Copy data to backup SRAM
		addq.w	#4,a1
		dbf	d1,loc_C3A2
		move.b	#0,(SRAM_access_flag).l	; Stop SRAM access
		tst.w	(SRAM_mask_interrupts_flag).w
		beq.s	locret_C3C0
		move	#$2300,sr		; Restore interrupts if EF56 was set

locret_C3C0:
		rts
; End of function Write_SRAM


; =============== S U B R O U T I N E =======================================


Write_SaveGeneral:
		st	(SRAM_mask_interrupts_flag).w
; End of function Write_SaveGeneral


; =============== S U B R O U T I N E =======================================


Write_SaveGeneral2:
		move.l	a0,-(sp)
		move.w	d7,-(sp)
		lea	($200011).l,a0		; Save general SRAM
		lea	($2000BD).l,a1		; Save general Backup SRAM
		lea	(Competition_saved_data).w,a2	; Save general RAM
		moveq	#$29,d0
		bsr.s	Write_SRAM
		move.w	(sp)+,d7
		movea.l	(sp)+,a0
		rts
; End of function Write_SaveGeneral2


; =============== S U B R O U T I N E =======================================


Write_SaveGame:
		move.l	a0,-(sp)
		move.w	d7,-(sp)
		lea	($200281).l,a0		; Save game SRAM
		lea	($20032D).l,a1		; Save game backup SRAM
		lea	(Saved_data).w,a2	; Save game RAM
		moveq	#$29,d0
		jsr	Write_SRAM(pc)
		move.w	(sp)+,d7
		movea.l	(sp)+,a0
		rts
; End of function Write_SaveGame

; ---------------------------------------------------------------------------
SaveGame_NextLevel:	dc.b    1,   1,   2,   2,   3,   3,   4,   4,   8,   8,   5,   5,   6,   6,   7,   7,   9,   9,  $A,  $A
		dc.b   $C,  $C,  $D,  $D,  $E,  $E,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b    0,   0,   0,   0,  $A,  $B,  $D,   0
                  even
; =============== S U B R O U T I N E =======================================


SaveGame:
	;	tst.w	(SK_alone_flag).w
	;	bne.w	loc_C4CC			; If this is SK, saving is disabled
		move.l	(Save_pointer).w,d0
		beq.w	loc_C4CC			; If not playing on a save file, get out
		movea.l	d0,a1
		move.w	(Current_ZoneAndAct).w,d0
		ror.b	#1,d0
		lsr.w	#7,d0
		move.b	SaveGame_NextLevel(pc,d0.w),d0
		move.b	(a1),d1
		andi.w	#3,d1
		beq.s	loc_C464
		cmp.b	3(a1),d0		; If game is complete, make it uncomplete if last level is less than the current level
		blo.s	loc_C4B4		; Think of, say, getting all the super emeralds then going to Doomsday on a completed save file
		andi.b	#-4,(a1)

loc_C464:
		move.b	d0,3(a1)			; Move next level into current level
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_C478
		cmpi.b	#$C,d0
		blo.s	loc_C4B0
		bra.s	loc_C498		; If playing as Knuckles and level code is Death egg or higher, make it a completed save file
; ---------------------------------------------------------------------------

loc_C478:
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_C488
		cmpi.b	#$D,d0
		blo.s	loc_C4B0
		bra.s	loc_C498		; If playing as Knuckles and level code is Doomsday or higher, make it a completed save file
; ---------------------------------------------------------------------------

loc_C488:
		cmpi.b	#$D,d0
		bhi.s	loc_C498		; If next level above Doomsday's code, make it a completed save file
		bne.s	loc_C4B0
		cmpi.b	#7,(Emerald_count).w	; If next level IS Doomsday but the emeralds aren't collected, make it a completed save file
		bhs.s	loc_C4B0

loc_C498:
		moveq	#1,d0
		cmpi.b	#7,(Emerald_count).w
		blo.s	loc_C4AE		; code 1 is completed without all emeralds
		addq.b	#1,d0
		cmpi.b	#7,(Super_emerald_count).w
		blo.s	loc_C4AE		; code 2 is completed with all chaos emeralds
		addq.b	#1,d0			; code 3 is completed with all super emeralds

loc_C4AE:
		move.b	d0,(a1)

loc_C4B0:
		clr.w	4(a1)			; Clear the special stage ring collection memory

loc_C4B4:
		move.b	(Life_count).w,d0		; Get number of lives
		cmpi.b	#$63,d0
		bls.s	loc_C4C0
		moveq	#$63,d0

loc_C4C0:
		move.b	d0,8(a1)				; Put number of lives into memory
		move.b	d0,(Life_count).w
		jsr	Write_SaveGame(pc)

loc_C4CC:
		clr.l	(Collected_special_ring_array).w	; Clear special stage ring collection RAM
		rts
; End of function SaveGame


; =============== S U B R O U T I N E =======================================


SaveGame_SpecialStage:
	;	tst.w	(SK_alone_flag).w
	;	bne.s	locret_C530			; If playing Sonic and Knuckles, don't bother
		move.l	(Save_pointer).w,d0
		beq.s	locret_C530
		movea.l	d0,a1				; Get address of save slot
	;	tst.b	(SK_special_stage_flag).w
	;	bne.s	loc_C4F8
		andi.b	#-$10,2(a1)
		move.b	(Current_special_stage).w,d0
		andi.b	#$F,d0
		or.b	d0,2(a1)			; Write last played special stage only if Sonic 3 special stages are in effect

loc_C4F8:
		lea	(Collected_emeralds_array).w,a2
		moveq	#0,d0
		moveq	#6,d1

loc_C500:
		move.b	(a2)+,d2
		andi.b	#3,d2
		or.b	d2,d0
		lsl.w	#2,d0
		dbf	d1,loc_C500
		move.w	d0,6(a1)		; Compress emerald collection RAM and put it into Save Game
		move.w	(Collected_special_ring_array+2).w,4(a1)	; Special stage entry ring memory is copied as well
		move.b	(Continue_count).w,d0
		cmpi.b	#$63,d0
		bls.s	loc_C524
		moveq	#$63,d0

loc_C524:
		move.b	d0,9(a1)		; Save number of continues
		move.b	d0,(Continue_count).w
		jmp	Write_SaveGame(pc)
; ---------------------------------------------------------------------------

locret_C530:
		rts
; End of function SaveGame_SpecialStage


; =============== S U B R O U T I N E =======================================


SaveGame_LivesContinues:
	;	tst.w	(SK_alone_flag).w
	;	bne.s	locret_C56C		; If playing Sonic and Knuckles, don't bother
		move.l	(Save_pointer).w,d0
		beq.s	locret_C56C
		movea.l	d0,a1
		move.b	(Life_count).w,d0
		cmpi.b	#$63,d0
		bls.s	loc_C54C
		moveq	#$63,d0

loc_C54C:
		move.b	d0,8(a1)		; Save number of lives
		move.b	d0,(Life_count).w
		move.b	(Continue_count).w,d0
		cmpi.b	#$63,d0
		bls.s	loc_C560
		moveq	#$63,d0

loc_C560:
		move.b	d0,9(a1)		; Save number of continues
		move.b	d0,(Continue_count).w
		jmp	Write_SaveGame(pc)
; ---------------------------------------------------------------------------

locret_C56C:
		rts
; End of function SaveGame_LivesContinues

; ---------------------------------------------------------------------------

locret_C56E:
		rts
Init_SpriteTable:
		clr.w	(Spritemask_flag).w
		clr.l	(Use_normal_sprite_table).w
		tst.w	(Competition_mode).w
		beq.s	loc_1AA9E
		lea	(Sprite_Table).w,a0
		bsr.s	Init_SpriteTable2
		bsr.s	Init_SpriteTable_2Player
		lea	(Sprite_Table_2).l,a0
		bsr.s	Init_SpriteTable2
		bsr.s	Init_SpriteTable_2Player
		lea	($FF7B00).l,a0
		bsr.s	Init_SpriteTable2
		lea	($FF7D80).l,a0
		bra.s	Init_SpriteTable2
; ---------------------------------------------------------------------------

loc_1AA9E:
		lea	(Sprite_Table).w,a0
; End of function Init_SpriteTable


; =============== S U B R O U T I N E =======================================


Init_SpriteTable2:
		moveq	#0,d0
		moveq	#1,d1
		moveq	#$4F,d7

loc_1AAA8:
		move.w	d0,(a0)
		move.b	d1,3(a0)
		addq.w	#1,d1
		addq.w	#8,a0
		dbf	d7,loc_1AAA8
		move.b	d0,-5(a0)
		rts
; End of function Init_SpriteTable2


; =============== S U B R O U T I N E =======================================


Init_SpriteTable_2Player:
		lea	-$280(a0),a0
		move.l	#$EB0301,(a0)+
		move.l	#1,(a0)+
		move.l	#$EB0302,(a0)+
		move.l	#0,(a0)
		rts
; End of function Init_SpriteTable_2Player

