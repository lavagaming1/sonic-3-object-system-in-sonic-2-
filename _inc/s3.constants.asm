; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Equates section - Names for variables.  
;anim_frame_duration=anim_frame_timer
; ---------------------------------------------------------------------------
; size variables - you'll get an informational error if you need to change these...
; they are all in units of bytes
Size_of_DAC_samples =		$2F00
Size_of_SEGA_sound =		$6174
Size_of_Snd_driver_guess =      $1580; approximate post-compressed size of the Z80 sound driver
;flip_type =               $27
; ---------------------------------------------------------------------------
; Object Status Table offsets (for everything between Object_RAM and Primary_Collision)
; ---------------------------------------------------------------------------
; universally followed object conventions:
;id =			  0 ; object ID (if you change this, change insn1op and insn2op in s2.macrosetup.asm, if you still use them)
inertia =                     $1C
anim_frame_duration =         $24
next_anim =                   $21
speedshoes_time =             $36
invincibility_time  =         $35
invulnerable_time =           $34
spindash_flag =               $3D
Super_Peelout_flag =         $3D ;same flag as spindash for math reasons
pinball_mode =               $3D ; $3E
flip_turned =                 $2D
spindash_counter =            $3E
restart_countdown =           spindash_counter
layer =			$46 ; collision plane, track switching...
layer_plus =		$47 ; always same as layer+1 ?? used for collision somehow
;---------------------------------------------------------------------------------
;   varables used in the sega screen
;--------------------------------------------------------------------------------
NextObj  = $30
;.....///////////////////////////..........respawn_index =
; ---------------------------------------------------------------------------
; Object Status Table offsets (for everything between Object_RAM and Primary_Collision)
; ---------------------------------------------------------------------------
; universally followed object conventions:
render_flags =		  4 ; bitfield ; refer to SCHG for details
height_pixels =		  6 ; byte
width_pixels =		  7 ; byte
priority =		  8 ; word ; in units of $80
art_tile =		 $A ; word ; PCCVH AAAAAAAAAAA ; P = priority, CC = palette line, V = y-flip; H = x-flip, A = starting cell index of art
mappings =		 $C ; long
x_pos =			$10 ; word, or long when extra precision is required
y_pos =			$14 ; word, or long when extra precision is required
x_sub =			  $12 ; and
y_sub =			  $16 ; and $F
mapping_frame =		$22 ; byte
respawn_index =		$48
; ---------------------------------------------------------------------------
; conventions followed by most objects:
routine =		  5 ; byte
x_vel =			$18 ; word
y_vel =			$1A ; word
y_radius =		$1E ; byte ; collision height / 2
x_radius =		$1F ; byte ; collision width / 2
anim =			$20 ; byte
prev_anim =		$21 ; byte ; when this isn't equal to anim the animation restarts
anim_frame =		$23 ; byte
anim_frame_timer =	$24 ; byte
angle =			$26 ; byte ; angle about axis into plane of the screen (00 = vertical, 360 degrees = 256)
status =		$2A ; bitfield ; refer to SCHG for details
; bit 0: leftfacing. bit 1: inair. bit 2: spinning. bit 3: onobject. bit 4: rolljumping. bit 5: pushing. bit 6: underwater.
; ---------------------------------------------------------------------------
; conventions followed by many objects but not Sonic/Tails/Knuckles:
x_pixel =		x_pos ; word ; x-coordinate for objects using screen positioning
y_pixel =		y_pos ; word ; y-coordinate for objects using screen positioning
collision_flags =	$28 ; byte ; TT SSSSSS ; TT = collision type, SSSSSS = size
collision_property =	$29 ; byte ; usage varies, bosses use it as a hit counter
shield_reaction =	$2B ; byte ; bit 3 = bounces off shield, bit 4 = negated by fire shield, bit 5 = negated by lightning shield, bit 6 = negated by bubble shield
subtype =		$2C ; byte
ObjTimer =              $2E
secondary_subtype =     subtype+1  ; byte tho its only used in some cases gets used by   anim_frame_timer in some codes
ros_bit =		$3B ; byte ; the bit to be cleared when an object is destroyed if the ROS flag is set
ChildTrackedY =         $3C
ros_addr =		$3C ; word ; the RAM address whose bit to clear when an object is destroyed if the ROS flag is set
routine_secondary =	$3C ; byte ; used by monitors for this purpose at least
Current_Sprite =        $25 ; byte ; used in some objects that dont use wdth or heghit sprite but a radius one
vram_art =		$40 ; word ; address of art in VRAM (same as art_tile * $20)
parent =		$42 ; word ; address of the object that owns or spawned this one, if applicable
child_dx = 		$42 ; byte ; X offset of child relative to parent   ; 4 bytes in ChildGetSavedFromParentDistance
child_dy = 		$43 ; byte ; Y offset of child relative to parent
parent3 = 		$46 ; word ; parent of child objects
parent2 =		$48 ; word ; several objects use this instead
respawn_addr =		$48 ; word ; the address of this object's entry in the respawn table
; ---------------------------------------------------------------------------
; conventions specific to Sonic/Tails/Knuckles:
ground_vel =		$1C ; word ; overall velocity along ground, not updated when in the air
double_jump_property =	$25 ; byte ; remaining frames of flight / 2 for Tails, gliding-related for Knuckles
flip_angle =		$27 ; byte ; angle about horizontal axis (360 degrees = 256)
status_secondary =	$2B ; byte ; see SCHG for details
air_left =		$2C ; byte
flip_type =		$2D ; byte ; bit 7 set means flipping is inverted, lower bits control flipping type
object_control =	$2E ; byte ; bit 0 set means character can jump out, bit 7 set means he can't
double_jump_flag =	$2F ; byte ; meaning depends on current character, see SCHG for details
flips_remaining =	$30 ; byte
flip_speed =		$31 ; byte
move_lock =		$32 ; word ; horizontal control lock, counts down to 0
invulnerability_timer =	$34 ; byte ; decremented every frame
invincibility_timer =	$35 ; byte ; decremented every 8 frames
speed_shoes_timer =	$36 ; byte ; decremented every 8 frames
status_tertiary =	$37 ; byte ; see SCHG for details
character_id =		$38 ; byte ; 0 for Sonic, 1 for Tails, 2 for Knuckles
scroll_delay_counter =	$39 ; byte ; incremented each frame the character is looking up/down, camera starts scrolling when this reaches 120
next_tilt =		$3A ; byte ; angle on ground in front of character
tilt =			$3B ; byte ; angle on ground
stick_to_convex =	$3C ; byte ; used to make character stick to convex surfaces such as the rotating discs in CNZ
spin_dash_flag =	$3D ; byte ; bit 1 indicates spin dash, bit 7 indicates forced roll
high_jump =             $3E
spin_dash_counter =	$3E ; word
jumping =		$40 ; byte
interact =		$42 ; word ; RAM address of the last object the character stood on
default_y_radius =	$44 ; byte ; default value of y_radius
default_x_radius =	$45 ; byte ; default value of x_radius
top_solid_bit =		$46 ; byte ; the bit to check for top solidity (either $C or $E)
lrb_solid_bit =		$47 ; byte ; the bit to check for left/right/bottom solidity (either $D or $F)

;=============================================================================
;some sonic 3 equs that match sonic 2
;=============================================================================
;ground_vel =		inertia
obj_control  =          $2E
;Sprites_drawn =  Sprite_count
;============================================================================
;some sonic 1 equs that match sonic 2
;============================================================================
ob2ndRout =             routine_secondary
obVelX =                x_vel
obVelY =                y_vel
;============================================================================
LastLoadedDPLC      = $34
Art_Address         = $38
DPLC_Address        = $3C
; ---------------------------------------------------------------------------
; conventions followed by some/most bosses:
boss_subtype		= 2+x_pos ;$A
boss_invulnerable_time	= $48 ;objoff_14 ;$40 ;$18 ;$14 ????
boss_sine_count		= mapping_frame ;$1A	;mapping_frame
boss_routine		= angle	;angle
boss_defeated		= $44 ;objoff_2C
boss_hitcount2		= $29 ;objoff_32
boss_hurt_sonic		= $3C ;objoff_38	; flag set by collision response routine when sonic has just been hurt (by boss?)
; ---------------------------------------------------------------------------
; Player Status Variables
Status_Facing       = 0
Status_InAir        = 1
Status_Roll         = 2
Status_OnObj        = 3
Status_RollJump     = 4
Status_Push         = 5
Status_Underwater   = 6

; Elemental Shield DPLC variables
;LastLoadedDPLC      = $34
;Art_Address         = $38
;DPLC_Address        = $3C

; ---------------------------------------------------------------------------
; when childsprites are activated (i.e. bit #6 of render_flags set)
;mainspr_mapframe	= x_sub+1
;mainspr_width		= width_pixels
;mainspr_height		= height_pixels
;mainspr_childsprites 	= y_sub+1	; amount of child sprites
;-----------------------------------------------------------------------------
;mainspr_mapframe	= $11
;mainspr_width		= $14
;mainspr_height		= $15
mainspr_childsprites2 	= $12	; amount of child sprites
mainspr_childsprites 	= $16	; amount of child sprites
;-----------------------------------------------------------------------------
sub2_x_pos		= $18	;x_vel
sub2_y_pos		= $1A	;y_vel
sub2_mapframe		= $1D
sub3_x_pos		= $1E	;y_radius
sub3_y_pos		= $20	;anim
sub3_mapframe		= $23	;anim_frame
sub4_x_pos		= $24	;anim_frame_timer
sub4_y_pos		= $26	;angle
sub4_mapframe		= $29	;collision_property
sub5_x_pos		= $2A	;status
sub5_y_pos		= $2C	;subtype
sub5_mapframe		= $2F
sub6_x_pos		= $30
sub6_y_pos		= $32
sub6_mapframe		= $35
sub7_x_pos		= $36
sub7_y_pos		= $38
sub7_mapframe		= $3B
sub8_x_pos		= $3C
sub8_y_pos		= $3E
sub8_mapframe		= $41
sub9_x_pos		= $42
sub9_y_pos		= $44
sub9_mapframe		= $47
next_subspr		= $6
; ---------------------------------------------------------------------------
; unknown or inconsistently used offsets that are not applicable to sonic/tails:
; (provided because rearrangement of the above values sometimes requires making space in here too)
;sonic 3 and knuckles           ; corrected
objoff_12 =		2+x_pos;$12 ; note: x_pos can be 4 bytes, but sometimes the last 2 bytes of x_pos are used for other unrelated things
objoff_13 =		$13 ;3+x_pos ; unused
objoff_16 =		$14     ;2+y_pos	; unused
objoff_17 =		$15    ;3+y_pos ; unused

objoff_23 =		$23
objoff_2B =		$2B
objoff_2C =		$2C ; overlaps subtype, but a few objects use it for other things anyway
 enum               objoff_2D=$2D,objoff_2E=$2E,objoff_2F=$2F,objoff_30=$30,objoff_31=$31,objoff_32=$32,objoff_33=$33
 enum objoff_34=$34,objoff_35=$35,objoff_36=$36,objoff_37=$37,objoff_38=$38,objoff_39=$39,objoff_3A=$3A,objoff_3B=$3B
 enum objoff_3C=$3C,objoff_3D=$3D,objoff_3E=$3E,objoff_3F=$3F,objoff_40=$40,objoff_41=$41,objoff_42=$42,objoff_43=$43
 enum objoff_44=$44,objoff_45=$45,objoff_46=$46,objoff_47=$47,objoff_48=$48,objoff_49=$49

;objoff_12 =		2+x_pos;$12 ; note: x_pos can be 4 bytes, but sometimes the last 2 bytes of x_pos are used for other unrelated things
;objoff_13 =		$13 ;3+x_pos ; unused
;objoff_14 =		$14     ;2+y_pos	; unused
;objoff_15 =		$15    ;3+y_pos ; unused

;objoff_23 =		$23
;objoff_27_s2 =		$2B
;objoff_28_s2 =		$2C ; overlaps subtype, but a few objects use it for other things anyway
; enum                objoff_29_s2=$2D,objoff_2A_s2=$2E,objoff_2B_s2=$2F,objoff_2C_s2=$30,objoff_2D_s2=$31,objoff_2E_s2=$32,objoff_2F_s2=$33
; enum objoff_30_s2=$34,objoff_31_s2=$35,objoff_32_s2=$36,objoff_33_s2=$37,objoff_34_s2=$38,objoff_35_s2=$39,objoff_36_s2=$3A,objoff_37_s2=$3B
; enum objoff_38_s2=$3C,objoff_39_s2=$3D,objoff_3A_s2=$3E,objoff_3B_s2=$3F,objoff_3C_s2=$40,objoff_3D_s2=$41,objoff_3E_s2=$42,objoff_3F_s2=$43
 ;enum objoff_44=$44,objoff_45=$45,objoff_46=$46,objoff_47=$47,objoff_48=$48,objoff_49=$49
; ---------------------------------------------------------------------------
; Special Stage object properties:
ss_dplc_timer = $24 ;s2 => 23
ss_x_pos = objoff_2E ;objoff_2A;_s2
ss_x_sub = objoff_30 ;objoff_2C;_s2
ss_y_pos = objoff_32 ;objoff_2E;_s2
ss_y_sub = objoff_34;objoff_30;_s2
ss_init_flip_timer = objoff_36;objoff_32;_s2
ss_flip_timer = objoff_37 ;objoff_33_s2
ss_z_pos = objoff_38;objoff_34_s2
ss_hurt_timer = objoff_3A ;objoff_36_s2
ss_slide_timer = objoff_3B ;objoff_37_s2
ss_parent = objoff_3C ;objoff_38_s2
ss_rings_base = objoff_40 ;objoff_3C_s2	; word
ss_rings_hundreds = objoff_40 ;objoff_3C_s2
ss_rings_tens = objoff_41 ;objoff_3D_s2
ss_rings_units = objoff_42 ;objoff_3E_s2
ss_last_angle_index = objoff_43  ;objoff_3F_s2
; ---------------------------------------------------------------------------
; property of all objects:
object_size =		$4A  ; the size of an object
next_object =		object_size

; ---------------------------------------------------------------------------
; Bits 3-6 of an object's status after a SolidObject call is a
; bitfield with the following meaning:
p1_standing_bit   = 3
p2_standing_bit   = p1_standing_bit + 1

p1_standing       = 1<<p1_standing_bit
p2_standing       = 1<<p2_standing_bit

pushing_bit_delta = 2
p1_pushing_bit    = p1_standing_bit + pushing_bit_delta
p2_pushing_bit    = p1_pushing_bit + 1

p1_pushing        = 1<<p1_pushing_bit
p2_pushing        = 1<<p2_pushing_bit


standing_mask     = p1_standing|p2_standing
pushing_mask      = p1_pushing|p2_pushing

; ---------------------------------------------------------------------------
; The high word of d6 after a SolidObject call is a bitfield
; with the following meaning:
p1_touch_side_bit   = 0
p2_touch_side_bit   = p1_touch_side_bit + 1

p1_touch_side       = 1<<p1_touch_side_bit
p2_touch_side       = 1<<p2_touch_side_bit

touch_side_mask     = p1_touch_side|p2_touch_side

p1_touch_bottom_bit = p1_touch_side_bit + pushing_bit_delta
p2_touch_bottom_bit = p1_touch_bottom_bit + 1

p1_touch_bottom     = 1<<p1_touch_bottom_bit
p2_touch_bottom     = 1<<p2_touch_bottom_bit

touch_bottom_mask   = p1_touch_bottom|p2_touch_bottom

p1_touch_top_bit   = p1_touch_bottom_bit + pushing_bit_delta
p2_touch_top_bit   = p1_touch_top_bit + 1

p1_touch_top       = 1<<p1_touch_top_bit
p2_touch_top       = 1<<p2_touch_top_bit

touch_top_mask     = p1_touch_top|p2_touch_top

; ---------------------------------------------------------------------------
; Controller Buttons
;
; Buttons bit numbers
button_up:			EQU	0
button_down:			EQU	1
button_left:			EQU	2
button_right:			EQU	3
button_B:			EQU	4
button_C:			EQU	5
button_A:			EQU	6
button_start:			EQU	7
; Buttons masks (1 << x == pow(2, x))
button_up_mask:			EQU	1<<button_up	; $01
button_down_mask:		EQU	1<<button_down	; $02
button_left_mask:		EQU	1<<button_left	; $04
button_right_mask:		EQU	1<<button_right	; $08
button_B_mask:			EQU	1<<button_B	; $10
button_C_mask:			EQU	1<<button_C	; $20
button_A_mask:			EQU	1<<button_A	; $40
button_start_mask:		EQU	1<<button_start	; $80

; ---------------------------------------------------------------------------
; Casino night bumpers
bumper_id           = 0
bumper_x            = 2
bumper_y            = 4
next_bumper         = 6
prev_bumper_x       = bumper_x-next_bumper

; ---------------------------------------------------------------------------
; status_secondary bitfield variables
;
; status_secondary variable bit numbers
status_sec_hasShield:		EQU	0
status_sec_isInvincible:	EQU	1
status_sec_hasSpeedShoes:	EQU	2
Status_High_Jumping:             equ 3
Status_FireShield               EQU     4
Status_LtngShield               EQU     5
Status_BublShield               EQU     6
status_sec_isSliding:		EQU	7
; status_secondary variable masks (1 << x == pow(2, x))
status_sec_hasShield_mask:	EQU	1<<status_sec_hasShield		; $01
status_sec_isInvincible_mask:	EQU	1<<status_sec_isInvincible	; $02
status_sec_hasSpeedShoes_mask:	EQU	1<<status_sec_hasSpeedShoes	; $04
status_sec_isSliding_mask:	EQU	1<<status_sec_isSliding		; $80
Status_FireShield1:             EQU     1<<Status_FireShield
Status_LtngShield2:             EQU     1<<Status_LtngShield
Status_BublShield3:             EQU     1<<Status_BublShield

;$FFFFFEDA-$FFFFFEDF ; seems unused
;Collision_response_list: equ $FFFFE380  ;s3 standard
Saved_layer:            equ $FFFFFE3E
;$F100-$F5FF also unused

;VDP_Data_Port                  equ $00C00000
;VDP_Control_Port               equ $00C00004
; ---------------------------------------------------------------------------
; Player status_secondary variables
Status_Shield       = status_sec_hasShield
Status_Invincible   = status_sec_isInvincible
;Status_SpeedShoes   = 2

;Status_FireShield   = 4
;Status_LtngShield   = 5
;Status_BublShield   = 6
; Enemy_interact bitfield
;Enemy_interact:
Object_Destroyed =                    $1
Object_pressed_Button    =            $2
player_Running_Or_Object   =          $3
player_Ready_To_Plane   =          $4
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; Constants that can be used instead of hard-coded IDs for various things.
; The "id" function allows to remove elements from an array/table without having
; to change the IDs everywhere in the code.

cur_zone_id := 0 ; the zone ID currently being declared
cur_zone_str := "0" ; string representation of the above

; macro to declare a zone ID
; this macro also declares constants of the form zone_id_X, where X is the ID of the zone in stock Sonic 2
; in order to allow level offset tables to be made dynamic
zoneID macro zoneID,{INTLABEL}
__LABEL__ = zoneID
zone_id_{cur_zone_str} = zoneID
cur_zone_id := cur_zone_id+1
cur_zone_str := "\{cur_zone_id}"
    endm

; Zone IDs. These MUST be declared in the order in which their IDs are in stock Sonic 2, otherwise zone offset tables will screw up
green_hill_zone zoneID	$00
marble_zone zoneID		$01
wood_zone zoneID		$02
sky_palace_zone zoneID		$03
metropolis_zone zoneID		$04
metropolis_zone_2 zoneID	$05
wing_fortress_zone zoneID	$06
hill_top_zone zoneID		$07
hidden_palace_zone zoneID	$08
gumball_bouns zoneID		$09
oil_ocean_zone zoneID		$0A
mystic_cave_zone zoneID		$0B
casino_night_zone zoneID	$0C
chemical_plant_zone zoneID	$0D
death_egg_zone zoneID		$0E
aquatic_ruin_zone zoneID	$0F
sky_chase_zone zoneID		$10
;lava_reef_act2_zone zoneID	$12
;note : if you want extral level slots you have to add extra slots to anim tiles routine and music lists level size ect and more stuff acorrding to the warnings


; NOTE: If you want to shift IDs around, set useFullWaterTables to 1 in the assembly options

; set the number of zones
no_of_zones = cur_zone_id

; Zone and act IDs
green_hill_zone_act_1 =	(green_hill_zone<<8)|$00
green_hill_zone_act_2 =	(green_hill_zone<<8)|$01
;emerald_hill_zone_act_3 =	(emerald_hill_zone<<8)|$00
chemical_plant_zone_act_1 =	(chemical_plant_zone<<8)|$00
chemical_plant_zone_act_2 =	(chemical_plant_zone<<8)|$01
aquatic_ruin_zone_act_1 =	(aquatic_ruin_zone<<8)|$00
aquatic_ruin_zone_act_2 =	(aquatic_ruin_zone<<8)|$01
casino_night_zone_act_1 =	(casino_night_zone<<8)|$00
casino_night_zone_act_2 =	(casino_night_zone<<8)|$01
hill_top_zone_act_1 =		(hill_top_zone<<8)|$00
hill_top_zone_act_2 =		(hill_top_zone<<8)|$01
mystic_cave_zone_act_1 =	(mystic_cave_zone<<8)|$00
mystic_cave_zone_act_2 =	(mystic_cave_zone<<8)|$01
oil_ocean_zone_act_1 =		(oil_ocean_zone<<8)|$00
oil_ocean_zone_act_2 =		(oil_ocean_zone<<8)|$01
metropolis_zone_act_1 =		(metropolis_zone<<8)|$00
metropolis_zone_act_2 =		(metropolis_zone<<8)|$01
metropolis_zone_act_3 =		(metropolis_zone_2<<8)|$00
sky_chase_zone_act_1 =		(sky_chase_zone<<8)|$00
wing_fortress_zone_act_1 =	(wing_fortress_zone<<8)|$00
death_egg_zone_act_1 =		(death_egg_zone<<8)|$00
; Prototype zone and act IDs
wood_zone_act_1 =		(wood_zone<<8)|$00
wood_zone_act_2 =		(wood_zone<<8)|$01
hidden_palace_zone_act_1 =	(hidden_palace_zone<<8)|$00
hidden_palace_zone_act_2 =	(hidden_palace_zone<<8)|$01
marble_zone_act_1 =	(marble_zone<<8)|$00
marble_zone_act_2 =	(marble_zone<<8)|$01
sky_palace_zone_act_1 =	(sky_palace_zone<<8)|$00
sky_palace_zone_act_2 =	(sky_palace_zone<<8)|$01
;lava_reef_zone_act_2 =	(lava_reef_act2_zone<<8)|$00
gumball_bouns_stage_act_1 =	(gumball_bouns<<8)|$00


; ---------------------------------------------------------------------------
; some variables and functions to help define those constants (redefined before a new set of IDs)
offset :=	0		; this is the start of the pointer table
ptrsize :=	1		; this is the size of a pointer (should be 1 if the ID is a multiple of the actual size)
idstart :=	0		; value to add to all IDs

; function using these variables
id function ptr,((ptr-offset)/ptrsize+idstart)

; V-Int routines
offset :=	Vint_SwitchTbl
ptrsize :=	1
idstart :=	0

VintID_Lag =		id(Vint_Lag_ptr) ; 0
VintID_SEGA =		id(Vint_SEGA_ptr) ; 2
VintID_Title =		id(Vint_Title_ptr) ; 4
VintID_Unused6 =	id(Vint_Unused6_ptr) ; 6
VintID_Level =		id(Vint_Level_ptr) ; 8
VintID_S2SS =		id(Vint_S2SS_ptr) ; A
VintID_TitleCard =	id(Vint_TitleCard_ptr) ; C
VintID_UnusedE =	id(Vint_UnusedE_ptr) ; E
VintID_Pause =		id(Vint_Pause_ptr) ; 10
VintID_Fade =		id(Vint_Fade_ptr) ; 12
VintID_PCM =		id(Vint_PCM_ptr) ; 14
VintID_Menu =		id(Vint_Menu_ptr) ; 16
VintID_Ending =		id(Vint_Ending_ptr) ; 18
VintID_CtrlDMA =	id(Vint_CtrlDMA_ptr) ; 1A
VintID_Mapscreen =	id(Vint_Map)
VintID_Savescreen =	id(Vint_Save_Screen)
; Game modes
offset :=	GameModesArray
ptrsize :=	1
idstart :=	0

GameModeID_SegaScreen =		id(GameMode_SegaScreen) ; 0
GameModeID_TitleScreen =	id(GameMode_TitleScreen) ; 4
GameModeID_Demo =		id(GameMode_Demo) ; 8
GameModeID_Level =		id(GameMode_Level) ; C
GameModeID_SpecialStage =	id(GameMode_SpecialStage) ; 10
GameModeID_2PLevelSelect =	id(GameMode_2PLevelSelect) ; 1C
GameModeID_ContinueScreen =	id(GameMode_ContinueScreen) ; 14
GameModeID_EndingSequence =	id(GameMode_EndingSequence) ; 20
GameModeID_OptionsMenu =	id(GameMode_OptionsMenu) ; 24
GameModeID_LevelSelect =	id(GameMode_LevelSelect) ; 28
GameModeFlag_TitleCard =	7 ; flag bit
GameModeID_TitleCard =		1<<GameModeFlag_TitleCard ; flag mask
GameModeID_NOCHAOS =	id(GameMode_NOCHAOS) ;
GameModeID_save_screen =	id(GameMode_save_screen)

; palette IDs
offset :=	PalPointers
ptrsize :=	8
idstart :=	0

PalID_SEGA =	id(PalPtr_SEGA) ; 0
PalID_Title =	id(PalPtr_Title) ; 1
PalID_MenuB =	id(PalPtr_MenuB) ; 2
PalID_BGND =	id(PalPtr_BGND) ; 3
PalID_GHZ =	id(PalPtr_GHZ) ; 4
PalID_GHZ2 =	id(PalPtr_GHZ2) ; 5
PalID_WZ =	id(PalPtr_WZ) ; 6
PalID_GHZ3 =	id(PalPtr_GHZ3) ; 7
PalID_MTZ =	id(PalPtr_MTZ) ; 8
PalID_MTZ2 =	id(PalPtr_MTZ2) ; 9
PalID_WFZ =	id(PalPtr_WFZ) ; A
PalID_HTZ =	id(PalPtr_HTZ) ; B
PalID_HPZ =	id(PalPtr_HPZ) ; C
PalID_GHZ4 =	id(PalPtr_GHZ4) ; D
PalID_OOZ =	id(PalPtr_OOZ) ; E
PalID_MCZ =	id(PalPtr_MCZ) ; F
PalID_CNZ =	id(PalPtr_CNZ) ; 10
PalID_CPZ =	id(PalPtr_CPZ) ; 11
PalID_DEZ =	id(PalPtr_DEZ) ; 12
PalID_ARZ =	id(PalPtr_ARZ) ; 13
PalID_SCZ =	id(PalPtr_SCZ) ; 14
PalID_HPZ_U =	id(PalPtr_HPZ_U) ; 15
PalID_CPZ_U =	id(PalPtr_CPZ_U) ; 16
PalID_ARZ_U =	id(PalPtr_ARZ_U) ; 17
PalID_SS =	id(PalPtr_SS) ; 18
PalID_MCZ_B =	id(PalPtr_MCZ_B) ; 19
PalID_CNZ_B =	id(PalPtr_CNZ_B) ; 1A
PalID_SS1 =	id(PalPtr_SS1) ; 1B
PalID_SS2 =	id(PalPtr_SS2) ; 1C
PalID_SS3 =	id(PalPtr_SS3) ; 1D
PalID_SS4 =	id(PalPtr_SS4) ; 1E
PalID_SS5 =	id(PalPtr_SS5) ; 1F
PalID_SS6 =	id(PalPtr_SS6) ; 20
PalID_SS7 =	id(PalPtr_SS7) ; 21
PalID_GHZ_SunSet =	id(PalPtrGHZSunSet) ; 22
PalID_SS2_2p =	id(PalPtr_SS2_2p) ; 23
PalID_SS3_2p =	id(PalPtr_SS3_2p) ; 24
PalID_OOZ_B =	id(PalPtr_OOZ_B) ; 25
PalID_Menu =	id(PalPtr_Menu) ; 26
PalID_Result =	id(PalPtr_Result) ; 27
PalID_Knux =	id(PalPtr_Knux) ; 28
PalID_CPZ_K_U =	id(PalPtr_CPZ_K_U) ; 29
PalID_ARZ_K_U =	id(PalPtr_ARZ_K_U) ; 30
PalID_MZ =	id(PalPtr_MZ) ; 31
PalID_SPZ =	id(PalPtr_SPZ) ; 31
PalID_Amy =     id(PalPtr_Amy)
PalID_Gumball =  id(PalPtr_Gumball)
PalID_Knux_cutse =	id(PalPtr_Knux_On_cutsene) ; 28
Pal_LZ_ID =        id(PalPtr_LZ)
PalID_LZ_U =        id(PalPtr_LZ_U)
PalID_Conquest_Banner =        id(PalPtr_Conqest_Banner)
PalID_DeathEggTitle =        id(PalPtr_DeathEgg_Title)
PalID_AIZ =	id(PalPtr_AIZ) ; 4
PalID_AIZ2 =	id(PalPtr_AIZ2) ; 5
PalID_AIZ1_Main =        id(PalPtr_AIZ1_Done)
PalID_AIZ1_U =        id(PalPtr_AIZ_1_U)
PalID_S1SS_2 =        id(PalPtr_S1SS_New)
; PLC IDs
offset :=	ArtLoadCues
ptrsize :=	2
idstart :=	0

PLCID_Std1 =		id(PLCptr_Std1) ; 0
PLCID_Std2 =		id(PLCptr_Std2) ; 1
PLCID_StdWtr =		id(PLCptr_StdWtr) ; 2
PLCID_GameOver =	id(PLCptr_GameOver) ; 3
PLCID_GHZ1 =		id(PLCptr_GHZ1) ; 4
PLCID_GHZ2 =		id(PLCptr_GHZ2) ; 5
PLCID_Miles1up =	id(PLCptr_Miles1up) ; 6
PLCID_MilesLife =	id(PLCptr_MilesLife) ; 7
PLCID_Tails1up =	id(PLCptr_Tails1up) ; 8
PLCID_TailsLife =	id(PLCptr_TailsLife) ; 9
PLCID_Unused1 =		id(PLCptr_Unused1) ; A
PLCID_Unused2 =		id(PLCptr_Unused2) ; B
PLCID_Mtz1 =		id(PLCptr_Mtz1) ; C
PLCID_Mtz2 =		id(PLCptr_Mtz2) ; D
PLCID_Wfz1 =		id(PLCptr_Wfz1) ; 10
PLCID_Wfz2 =		id(PLCptr_Wfz2) ; 11
PLCID_Htz1 =		id(PLCptr_Htz1) ; 12
PLCID_Htz2 =		id(PLCptr_Htz2) ; 13
PLCID_Hpz1 =		id(PLCptr_Hpz1) ; 14
PLCID_Hpz2 =		id(PLCptr_Hpz2) ; 15
PLCID_Unused3 =		id(PLCptr_Unused3) ; 16
PLCID_Unused4 =		id(PLCptr_Unused4) ; 17
PLCID_Ooz1 =		id(PLCptr_Ooz1) ; 18
PLCID_Ooz2 =		id(PLCptr_Ooz2) ; 19
PLCID_Mcz1 =		id(PLCptr_Mcz1) ; 1A
PLCID_Mcz2 =		id(PLCptr_Mcz2) ; 1B
PLCID_Cnz1 =		id(PLCptr_Cnz1) ; 1C
PLCID_Cnz2 =		id(PLCptr_Cnz2) ; 1D
PLCID_Cpz1 =		id(PLCptr_Cpz1) ; 1E
PLCID_Cpz2 =		id(PLCptr_Cpz2) ; 1F
PLCID_Dez1 =		id(PLCptr_Dez1) ; 20
PLCID_Dez2 =		id(PLCptr_Dez2) ; 21
PLCID_Arz1 =		id(PLCptr_Arz1) ; 22
PLCID_Arz2 =		id(PLCptr_Arz2) ; 23
PLCID_Scz1 =		id(PLCptr_Scz1) ; 24
PLCID_Scz2 =		id(PLCptr_Scz2) ; 25
PLCID_Results =		id(PLCptr_Results) ; 26
PLCID_Signpost =	id(PLCptr_Signpost) ; 27
PLCID_CpzBoss =		id(PLCptr_CpzBoss) ; 28
PLCID_GHZBoss =		id(PLCptr_GHZBoss) ; 29
PLCID_HtzBoss =		id(PLCptr_HtzBoss) ; 2A
PLCID_ArzBoss =		id(PLCptr_ArzBoss) ; 2B
PLCID_MczBoss =		id(PLCptr_MczBoss) ; 2C
PLCID_CnzBoss =		id(PLCptr_CnzBoss) ; 2D
PLCID_MtzBoss =		id(PLCptr_MtzBoss) ; 2E
PLCID_OozBoss =		id(PLCptr_OozBoss) ; 2F
PLCID_FieryExplosion =	id(PLCptr_FieryExplosion) ; 30
PLCID_DezBoss =		id(PLCptr_DezBoss) ; 31
PLCID_GHZAnimals =	id(PLCptr_GHZAnimals) ; 32
PLCID_MczAnimals =	id(PLCptr_MczAnimals) ; 33
PLCID_HtzAnimals =	id(PLCptr_HtzAnimals) ; 34
PLCID_MtzAnimals =	id(PLCptr_MtzAnimals) ; 34
PLCID_WfzAnimals =	id(PLCptr_WfzAnimals) ; 34
PLCID_DezAnimals =	id(PLCptr_DezAnimals) ; 35
PLCID_HpzAnimals =	id(PLCptr_HpzAnimals) ; 36
PLCID_OozAnimals =	id(PLCptr_OozAnimals) ; 37
PLCID_SczAnimals =	id(PLCptr_SczAnimals) ; 38
PLCID_CnzAnimals =	id(PLCptr_CnzAnimals) ; 39
PLCID_CpzAnimals =	id(PLCptr_CpzAnimals) ; 3A
PLCID_ArzAnimals =	id(PLCptr_ArzAnimals) ; 3B
PLCID_SpecialStage =	id(PLCptr_SpecialStage) ; 3C
PLCID_SpecStageResults = id(PLCptr_SpecStageResults) ; 3D
PLCID_WfzBoss =		id(PLCptr_WfzBoss) ; 3E
PLCID_Tornado =		id(PLCptr_Tornado) ; 3F
PLCID_Capsule =		id(PLCptr_Capsule) ; 40
PLCID_Explosion =	id(PLCptr_Explosion) ; 41
PLCID_ResultsTails =	id(PLCptr_ResultsTails) ; 42
PLCID_KnucklesLife =	id(PLCptr_KnucklesLife)
PLCID_Std2Knuckles =	id(PLCptr_Std2Knuckles)
PLCID_ResultsKnuckles =	id(PLCptr_ResultsKnuckles)
PLCID_SignpostKnuckles =	id(PLCptr_SignpostKnuckles)
PLCID_AmyLife =      id(PLCptr_AmyLife)
PLCID_Std2amy =	id(PLCptr_Std2amy)
PLCID_MZ1 =		id(PLCptr_MZ1) ; 4
PLCID_MZ2 =		id(PLCptr_MZ2) ; 5
PLCID_ghz3dynamic =     id(PLCptr_GHZdynamic) ; 5
PLCID_ghz_cpz =         id(PLCptr_GHZ_CPZ_stage) ; 5
PLCID_Gumball =         id(PLCptr_Gumball) ; 5
PLCID_Gumball2 =        id(PLCptr_Gumball2) ; 5
PLCID_GHZ_ID =        id(PLCptr_GHZACT_1)
PLCID_GHZ2_ID =        id(PLCptr_GHZACT_2)
PLCID_S1_SSTAGES =    id(PLCptr_S1_SS_STAGES)  ;   PLCptr_GHZACT_1
PLCID_Load_E =    id(PLCptr_HudLoading)


; Music IDs
; Music IDs
offset :=   z80_MusicPointers
ptrsize := 2
idstart :=  1

MusID__First = idstart
MusID_2PResult =    id(Snd_AIZ1_Ptr)    ; 01
MusID_GHZ =     id(Snd_AIZ2_Ptr)    ; 02
MusID_MCZ_2P =      id(Snd_HCZ1_Ptr)    ; 03
MusID_OOZ =     id(Snd_HCZ2_Ptr)    ; 04
MusID_MTZ =     id(Snd_MGZ1_Ptr)    ; 05
MusID_HTZ =     id(Snd_MGZ2_Ptr)    ; 06
MusID_ARZ =     id(Snd_CNZ2_Ptr)    ; 07
MusID_CNZ_2P =      id(Snd_CNZ1_Ptr)    ; 08
MusID_CNZ =     id(Snd_FBZ1_Ptr)    ; 09
MusID_DEZ =     id(Snd_FBZ2_Ptr)    ; 0A
MusID_MCZ =     id(Snd_MHZ1_Ptr)    ; 0B
MusID_GHZ_2P =      id(Snd_MHZ2_Ptr)    ; 0C
MusID_SCZ =     id(Snd_SOZ1_Ptr)    ; 0D
MusID_CPZ =     id(Snd_SOZ2_Ptr)    ; 0E
MusID_WFZ =     id(Snd_LRZ1_Ptr)    ; 0F
MusID_HPZ =     id(Snd_LRZ2_Ptr)    ; 10
MusID_Options =     id(Snd_SSZ_Ptr)     ; 11
MusID_SpecStage =   id(Snd_DEZ1_Ptr)    ; 12
MusID_Boss =        id(Snd_DEZ2_Ptr)    ; 13
MusID_EndBoss =     id(Snd_Minib_SK_Ptr)    ; 14
MusID_Ending =      id(Snd_Boss_Ptr)    ; 15
MusID_SuperSonic =  id(Snd_DDZ_Ptr)     ; 16
MusID_Invincible =  id(Snd_PachBonus_Ptr)   ; 17
MusID_ExtraLife =   MusID_1UP       ; 18
MusID_Title =       id(Snd_SpecialS_Ptr)    ; 19
MusID_EndLevel =    id(Snd_SlotBonus_Ptr)   ; 1A
MusID_GameOver =    id(Snd_Knux_Ptr)    ; 1B
MusID_Continue =    id(Snd_Title_Ptr)   ; 1C
MusID_Emerald =     id(Snd_Emerald_Ptr) ; 1D
MusID_Credits =     id(Snd_ICZ2_Ptr)    ; 1E
MusID_Countdown =   id(Snd_Drown_Ptr)   ; 1F
MusID__End =        id(zMusIDPtr__End)  ; 20

; Sound IDs
offset :=   z80_SFXPointers
ptrsize :=  2
idstart :=  MusID__End

SndID__First = idstart
SndID_Ring =        id(Sound_33_Ptr)    ; 20
SndID_RingRight =   id(Sound_34_Ptr)    ; 21
SndID_Jump =        id(Sound_35_Ptr)    ; 22
SndID_Checkpoint =  id(Sound_36_Ptr)    ; 23
SndID_SpikeSwitch = id(Sound_37_Ptr)    ; 24
SndID_Hurt =        id(Sound_38_Ptr)    ; 25
SndID_Skidding =    id(Sound_39_Ptr)    ; 26
SndID_BlockPush =   id(Sound_3A_Ptr)    ; 27
SndID_HurtBySpikes =    id(Sound_3B_Ptr)    ; 28
SndID_Sparkle =     id(Sound_3C_Ptr)    ; 29
SndID_Beep =        id(Sound_3D_Ptr)    ; 2A
SndID_Bwoop =       id(Sound_3E_Ptr)    ; 2B
SndID_Splash =      id(Sound_3F_Ptr)    ; 2C
SndID_Swish =       id(Sound_40_Ptr)    ; 2D
SndID_BossHit =     id(Sound_41_Ptr)    ; 2E
SndID_InhalingBubble =  id(Sound_42_Ptr)    ; 2E
SndID_ArrowFiring = id(Sound_43_Ptr)    ; 2F ; MOVE
SndID_LavaBall =    id(Sound_43_Ptr)    ; 30
SndID_Shield =      id(Sound_44_Ptr)    ; 31
SndID_LaserBeam =   id(Sound_45_Ptr)    ; 32
SndID_Zap =     id(Sound_46_Ptr)    ; 33
SndID_Drown =       id(Sound_47_Ptr)    ; 34
SndID_FireBurn =    id(Sound_48_Ptr)    ; 36
SndID_Bumper =      id(Sound_49_Ptr)    ; 37
SndID_SpikesMove =  id(Sound_4A_Ptr)    ; 39
SndID_Rumbling =    id(Sound_4B_Ptr)    ; 3B
SndID_Smash =       id(Sound_4D_Ptr)    ; 3C
SndID_DoorSlam =    id(Sound_4F_Ptr)    ; 3D
SndID_SpindashRelease = id(Sound_50_Ptr)    ; 3E
SndID_Hammer =      id(Sound_51_Ptr)    ; 3F
SndID_Roll =        id(Sound_52_Ptr)    ; 40
SndID_ContinueJingle =  id(Sound_53_Ptr)    ; 41
SndID_CasinoBonus = id(Sound_54_Ptr)    ; 42
SndID_Explosion =   id(Sound_55_Ptr)    ; 43
SndID_WaterWarning =    id(Sound_56_Ptr)    ; 44
SndID_EnterGiantRing =  id(Sound_57_Ptr)    ; 45
SndID_BossExplosion =   id(Sound_58_Ptr)    ; 46
SndID_TallyEnd =    id(Sound_59_Ptr)    ; 48
SndID_RingSpill =   id(Sound_5A_Ptr)    ; 49
SndID_Flamethrower =    id(Sound_5C_Ptr)    ; 4A
SndID_Bonus =       id(Sound_5D_Ptr)    ; 4B
SndID_SpecStageEntry =  id(Sound_5E_Ptr)    ; 4C
SndID_SlowSmash =   id(Sound_5F_Ptr)    ; 4D
SndID_Spring =      id(Sound_60_Ptr)    ; 4E
SndID_Blip =        id(Sound_61_Ptr)    ; 4F
SndID_RingLeft =    id(Sound_62_Ptr)    ; 50
SndID_Signpost =    id(Sound_63_Ptr)    ; 53
SndID_CNZBossZap =  id(Sound_66_Ptr)    ; 54
SndID_Signpost2P =  id(Sound_67_Ptr)    ; 55
SndID_OOZLidPop =   id(Sound_68_Ptr)    ; 56
SndID_SlidingSpike =    id(Sound_69_Ptr)    ; 57
SndID_CNZElevator = id(Sound_6A_Ptr)    ; 58
SndID_PlatformKnock =   id(Sound_6B_Ptr)    ; 59
SndID_BonusBumper = id(Sound_6C_Ptr)    ; 5A
SndID_LargeBumper = id(Sound_6D_Ptr)    ; 5B
SndID_Gloop =       id(Sound_6E_Ptr)    ; 5C
SndID_PreArrowFiring =  id(Sound_6F_Ptr)    ; 5D
SndID_Fire =        id(Sound_70_Ptr)    ; 5E
SndID_ArrowStick =  id(Sound_71_Ptr)    ; 5F
SndID_Helicopter =  id(Sound_71_Ptr)    ; 60
SndID_SuperTransform =  id(Sound_72_Ptr)    ; 61
SndID_SpindashRev = id(Sound_73_Ptr)    ; 62
SndID_Rumbling2 =   id(Sound_74_Ptr)    ; 63
SndID_CNZLaunch =   id(Sound_75_Ptr)    ; 64
SndID_Flipper =     id(Sound_76_Ptr)    ; 65
SndID_HTZLiftClick =    id(Sound_77_Ptr)    ; 66
SndID_Leaves =      id(Sound_78_Ptr)    ; 67
SndID_MegaMackDrop =    id(Sound_79_Ptr)    ; 68
SndID_DrawbridgeMove =  id(Sound_7A_Ptr)    ; 69
SndID_QuickDoorSlam =   id(Sound_7B_Ptr)    ; 6A
SndID_DrawbridgeDown =  id(Sound_7C_Ptr)    ; 6B
SndID_LaserBurst =  id(Sound_7D_Ptr)    ; 6B
SndID_Scatter =     id(Sound_7E_Ptr)    ; 6C
SndID_LaserFloor =  id(Sound_7E_Ptr)    ; 6D
SndID_Teleport =    id(Sound_7F_Ptr)    ; 6E
SndID_Error =       id(Sound_80_Ptr)    ; 6F
SndID_MechaSonicBuzz =  id(Sound_81_Ptr)    ; 70
SndID_LargeLaser =  id(Sound_82_Ptr)    ; 71
SndID_OilSlide =    id(Sound_83_Ptr)    ; 72
SndID_SSDiamond =   $4F
SndID_Bwoop_s3 =     $AE
SndID__End =        id(Sound_End_Ptr)           ; F1

; Special sound IDs

; Special sound IDs

MusID_StopSFX =         FadeID__First+3     ; F8
MusID_FadeOut =         -$1F            ; F9
SndID_SegaSound =       SndID_Sega          ; FA
MusID_SpeedUp =             8           ; FB
MusID_SlowDown =        0               ; FC
MusID_Stop =            -2          ; FD
MusID_Pause =           1               ; FE
MusID_Unpause =         $80         ; FF

; 2P VS results screens
offset := TwoPlayerResultsPointers
ptrsize := 8
idstart := 0

VsRSID_Act =	id(VsResultsScreen_Act)		; 0
VsRSID_Zone =	id(VsResultsScreen_Zone)	; 1
VsRSID_Game =	id(VsResultsScreen_Game)	; 2
VsRSID_SS =	id(VsResultsScreen_SS)		; 3
VsRSID_SSZone =	id(VsResultsScreen_SSZone)	; 4

; Animation IDs
offset :=	SonicAniData
ptrsize :=	2
idstart :=	0

AniIDSonAni_Walk			= id(SonAni_Walk_ptr)			;  0 ;   0
AniIDSonAni_Run				= id(SonAni_Run_ptr)			;  1 ;   1
AniIDSonAni_Roll			= id(SonAni_Roll_ptr)			;  2 ;   2
AniIDSonAni_Roll2			= id(SonAni_Roll2_ptr)			;  3 ;   3
AniIDSonAni_Push			= id(SonAni_Push_ptr)			;  4 ;   4
AniIDSonAni_Wait			= id(SonAni_Wait_ptr)			;  5 ;   5
AniIDSonAni_Balance			= id(SonAni_Balance_ptr)		;  6 ;   6
AniIDSonAni_LookUp			= id(SonAni_LookUp_ptr)			;  7 ;   7
AniIDSonAni_Duck			= id(SonAni_Duck_ptr)			;  8 ;   8
AniIDSonAni_Spindash		= id(SonAni_Spindash_ptr)		;  9 ;   9
;AniIDSonAni_Blink			= id(SonAni_Blink_ptr)			; 10 ;  $A
;AniIDSonAni_GetUp			= id(SonAni_GetUp_ptr)			; 11 ;  $B
AniIDSonAni_Balance2		= id(SonAni_Balance2_ptr)		; 12 ;  $C
AniIDSonAni_Stop			= id(SonAni_Stop_ptr)			; 13 ;  $D
AniIDSonAni_Float			= id(SonAni_Float_ptr)			; 14 ;  $E
AniIDSonAni_Float2			= id(SonAni_Float2_ptr)			; 15 ;  $F
AniIDSonAni_Spring			= id(SonAni_Spring_ptr)			; 16 ; $10
AniIDSonAni_Hang			= id(SonAni_Hang_ptr)			; 17 ; $11
AniIDSonAni_Dash2			= id(SonAni_Dash2_ptr)			; 18 ; $12
AniIDSonAni_Dash3			= id(SonAni_Dash3_ptr)			; 19 ; $13
AniIDSonAni_Hang2			= id(SonAni_Hang2_ptr)			; 20 ; $14
AniIDSonAni_Bubble			= id(SonAni_Bubble_ptr)			; 21 ; $15
AniIDSonAni_DeathBW			= id(SonAni_DeathBW_ptr)		; 22 ; $16
AniIDSonAni_Drown			= id(SonAni_Drown_ptr)			; 23 ; $17
AniIDSonAni_Death			= id(SonAni_Death_ptr)			; 24 ; $18
AniIDSonAni_Hurt			= id(SonAni_Hurt_ptr)			; 25 ; $19
AniIDSonAni_Hurt2			= id(SonAni_Hurt2_ptr)			; 26 ; $1A
AniIDSonAni_Slide			= id(SonAni_Slide_ptr)			; 27 ; $1B
AniIDSonAni_Blank			= id(SonAni_Blank_ptr)			; 28 ; $1C
AniIDSonAni_Balance3		= id(SonAni_Balance3_ptr)		; 29 ; $1D
AniIDSonAni_Balance4		= id(SonAni_Balance4_ptr)		; 30 ; $1E
AniIDSupSonAni_Transform	= id(SupSonAni_Transform_ptr)	; 31 ; $1F
AniIDSonAni_sliding			= id(SonAni_slide_ptr)			; 32 ; $20
;AniIDSonAni_sonicEHZ			= id(SonAni_EHZ_ptr)		; 33 ; $21


offset :=	TailsAniData
ptrsize :=	2
idstart :=	0

AniIDTailsAni_Walk			= id(TailsAni_Walk_ptr)			;  0 ;   0
AniIDTailsAni_Run			= id(TailsAni_Run_ptr)			;  1 ;   1
AniIDTailsAni_Roll			= id(TailsAni_Roll_ptr)			;  2 ;   2
AniIDTailsAni_Roll2			= id(TailsAni_Roll2_ptr)		;  3 ;   3
AniIDTailsAni_Push			= id(TailsAni_Push_ptr)			;  4 ;   4
AniIDTailsAni_Wait			= id(TailsAni_Wait_ptr)			;  5 ;   5
AniIDTailsAni_Balance		= id(TailsAni_Balance_ptr)		;  6 ;   6
AniIDTailsAni_LookUp		= id(TailsAni_LookUp_ptr)		;  7 ;   7
AniIDTailsAni_Duck			= id(TailsAni_Duck_ptr)			;  8 ;   8
AniIDTailsAni_Spindash		= id(TailsAni_Spindash_ptr)		;  9 ;   9
AniIDTailsAni_Dummy1		= id(TailsAni_Dummy1_ptr)		; 10 ;  $A
AniIDTailsAni_Dummy2		= id(TailsAni_Dummy2_ptr)		; 11 ;  $B
AniIDTailsAni_Dummy3		= id(TailsAni_Dummy3_ptr)		; 12 ;  $C
AniIDTailsAni_Stop			= id(TailsAni_Stop_ptr)			; 13 ;  $D
AniIDTailsAni_Float			= id(TailsAni_Float_ptr)		; 14 ;  $E
AniIDTailsAni_Float2		= id(TailsAni_Float2_ptr)		; 15 ;  $F
AniIDTailsAni_Spring		= id(TailsAni_Spring_ptr)		; 16 ; $10
AniIDTailsAni_Hang			= id(TailsAni_Hang_ptr)			; 17 ; $11
AniIDTailsAni_Blink			= id(TailsAni_Blink_ptr)		; 18 ; $12
AniIDTailsAni_Blink2		= id(TailsAni_Blink2_ptr)		; 19 ; $13
AniIDTailsAni_Hang2			= id(TailsAni_Hang2_ptr)		; 20 ; $14
AniIDTailsAni_Bubble		= id(TailsAni_Bubble_ptr)		; 21 ; $15
AniIDTailsAni_DeathBW		= id(TailsAni_DeathBW_ptr)		; 22 ; $16
AniIDTailsAni_Drown			= id(TailsAni_Drown_ptr)		; 23 ; $17
AniIDTailsAni_Death			= id(TailsAni_Death_ptr)		; 24 ; $18
AniIDTailsAni_Hurt			= id(TailsAni_Hurt_ptr)			; 25 ; $19
AniIDTailsAni_Hurt2			= id(TailsAni_Hurt2_ptr)		; 26 ; $1A
AniIDTailsAni_Slide			= id(TailsAni_Slide_ptr)		; 27 ; $1B
AniIDTailsAni_Blank			= id(TailsAni_Blank_ptr)		; 28 ; $1C
AniIDTailsAni_Dummy4		= id(TailsAni_Dummy4_ptr)		; 29 ; $1D
AniIDTailsAni_Dummy5		= id(TailsAni_Dummy5_ptr)		; 30 ; $1E
AniIDTailsAni_HaulAss		= id(TailsAni_HaulAss_ptr)		; 31 ; $1F
AniIDTailsAni_Fly			= id(TailsAni_Fly_ptr)			; 32 ; $20
AniIDTailsAni_Flyingwith_sonic          = id(TailsAni_flying_ptr)
AniIDTailsAni_transform                 = id(TailsAni_Super_ptr)
AniIDTailsAni_Flying_Tired_Sonic        = id(TailsAni_flying_tired_ptr)
AniIDTailsAni_swiming_Tired_Sonic        = id(TailsAni_swim_tired_ptr)
AniIDTailsAni_swiming                   = id(TailsAni_swim_ptr)
AniIDTailsAni_Flying_Tired_Sonic2        = id(TailsAni_FlyTried_ptr)
AniIDTailsAni_Victory        = id(TailsAni_victory_ptr)


palette_line_size =	$10*2	; 16 word entries

; ---------------------------------------------------------------------------
; I run the main 68k RAM addresses through this function
; to let them work in both 16-bit and 32-bit addressing modes.
ramaddr function x,(-(x&$80000000)<<1)|x
Max_Rings = 511 ; default. maximum number possible is 759
    if Max_Rings > 759
    fatal "Maximum number of rings possible is 759"
    endif

Rings_Space = (Max_Rings+1)*2
; ---------------------------------------------------------------------------
; RAM variables - General
	phase	ramaddr($FFFF0000)	; Pretend we're in the RAM
Sprite_Table_2:
Sprite_table_buffer_2 =		ramaddr(   $FF7880 ) ; $280 bytes ; alternate sprite table for player 1 in competition mode
Sprite_table_buffer_P2 =	ramaddr(   $FF7B00 ) ; $280 bytes ; sprite table for player 2 in competition mode
Sprite_table_buffer_P2_2 =	ramaddr(   $FF7D80 ) ; $280 bytes ; alternate sprite table for player 2 in competition mode
RAM_start:
RAM_Start:

Chunk_table:
Chunk_Table:			ds.b	$8000	; was "Metablock_Table"
Chunk_Table_End:
Level_layout_header:
Level_Layout:			ds.b 8
Level_layout_main:              ds.b $FF8
Level_Layout_End:
Object_respawn_table_2 :=	Level_Layout+$400; $200 bytes ; respawn table used by glowing spheres bonus stage, because... Reasons?

Block_table:
Block_Table:			ds.b $1800		; block (16x16) definitions, 8 bytes per definition, space for $300 blocks
Block_Table_End:
;-----------------------------------------------------------------------------------------
HScroll_table:
TempArray_LayerDef:		ds.b	$200	; used by some layer deformation routines
;-----------------------------------------------------------------------------------------------
Decomp_Buffer:			ds.b	$200
Decomp_Buffer_End
Sprite_table_input:
Sprite_Table_Input:		ds.b	$400	; in custom format before being converted and stored in Sprite_Table/Sprite_Table_2
Sprite_Table_Input_End:

Object_RAM =		*			; $1FCC bytes ; $4A bytes per object, 110 objects
Player_1:
MainCharacter:			ds.b object_size	; main character in 1 player mode, player 1 in Competition mode
Player_2:
Sidekick:			ds.b object_size	; Tails in a Sonic and Tails game, player 2 in Competition mode
Reserved_object_3		ds.b object_size	; during a level, an object whose sole purpose is to clear the collision response list is stored here

Dynamic_object_RAM:
Dynamic_Object_RAM:	        ds.b object_size*90	; $1A04 bytes ; 90 objects
Dynamic_Object_RAM_End =	*
Level_object_RAM:             = Dynamic_Object_RAM_End	; $4EA bytes ; various fixed in-level objects
Object_slot_4:	              	ds.b object_size
Breathing_bubbles:		; unknown  in s3
Sonic_BreathingBubbles:		ds.b object_size	; for the main character
Tails_BreathingBubbles:		ds.b object_size	; for Tails in a Sonic and Tails game
SuperSonicStars: =			*			; for Super Sonic and Super Knuckles
Tails_tails_2P			ds.b object_size	; Tails' tails in Competition mode
Tails_Tails:			ds.b object_size	; Tails' tails
Amy_Dust:
Sonic_Dust:			ds.b object_size
Tails_Dust:			ds.b object_size
Sonic_Shield:			ds.b object_size
Tails_Shield:			ds.b object_size	; left over from Sonic 2 I'm guessing
Invincibility_stars:
Sonic_InvincibilityStars:	ds.b object_size*3
                                ds.b object_size
Tails_InvincibilityStars:	ds.b object_size*1
                                ds.b object_size
                                ds.b  object_size

Wave_Splash:			ds.b object_size	; Obj_HCZWaveSplash is loaded here
;---------------------------use the sonic 3 fixes ------------------------------------

Object_RAM_End =		*
;---------------------------------do what sonic 3 did ----------------------------------

Kos_decomp_buffer:              ds.b  $1000   ;($C62)
Plane_buffer:                  ; (480)
                                ds.b   $42C
Competition_saved_data:         ds.b  $54
Plane_buffer_End
Palette_cycle_counters:
                               	ds.b  $20  ; unused saucer data
Water_palette_data_addr:        ds.l  1
Kos_decomp_stored_registers	ds.w 20			; allows decompression to be spread over multiple frames
Kos_decomp_stored_SR		ds.w 1
Kos_decomp_queue		ds.l 2*4		; 2 longwords per entry, first is source location and second is decompression location
Kos_module_queue		ds.w 3*4		; 6 bytes per entry, first longword is source location and next word is VRAM destination
Kos_decomp_bookmark		ds.l 1
Kos_decomp_queue_count:         ds.w  1
Kos_decomp_destination =	Kos_decomp_queue+4
Kos_description_field		ds.w 1
_unkEEEA:                       ds.w 1
       ds.w 1



S1_SS_Ram:                                    ; gets cleared away during normal levels
SK_alone_flag:
End_SonicUnk:
IGnoreSfxFlag:
S1_SS_Background_V_scroll:
                    	ds.b    1
LZTaggedFlag:
HPZWarpFlag:
Freeze_flag:
                    	ds.b    1
Apparent_zone_and_act:
SS_Cycle_2:			ds.w    1
Scail_Object_Routine:
SS_Cycle_1:			ds.w    1
SK_special_stage_flag:
S1SS_Animate_Index:
Game_Mode_Scroll_Toggle:
                                ds.w    1
S1_SS_Ram_End
H_scroll_buffer:
Horiz_Scroll_Buf:	       	ds.b $380		; horizontal scroll table is built up here and then DMAed to VRAM
Horiz_Scroll_Buf_End:
;------------------------------------------------------------------------------------
Pos_table:
Sonic_Stat_Record_Buf:          ds.b	$100    ;in case an over lapp happen here
;------------------------------------------------------------------------------------
Collision_response_list:        ds.b	$80
Collision_response_list_End

;Primary_Collision:		ds.b	$300
;Secondary_Collision:		ds.b	$300
DMA_queue:
VDP_Command_Buffer:             ds.b	$FC ;7*$12	; stores 18 ($12) VDP commands to issue the next time ProcessDMAQueue is called
VDP_Command_Buffer_Slot:	ds.l	1	; stores the address of the next open slot for a queued VDP command



; change happened here with tails ai bug
Stat_table:					; used by Tails' AI in a Sonic and Tails game
Pos_table_P2: ; thionk
Tails_Pos_Record_Buf:		ds.b $100		; used by Player 2 in competition mode
Sonic_Pos_Record_Buf: 		ds.b $100
Amy_Pos_Record_Buf:             = Sonic_Pos_Record_Buf
Amy_Stat_Record_Buf:            = Sonic_Stat_Record_Buf
DMA_queue_slot:            = VDP_Command_Buffer_Slot






Ring_status_table:		ds.b	$600
Object_Respawn_Table:           ds.b    $100





Dataselect_entry:               ds.b  1
NextZoneType:                   ds.b  1

Ring_start_addr_ROM =		ramaddr( Ring_status_table+Rings_Space )
Ring_end_addr_ROM =			ramaddr( Ring_status_table+Rings_Space+4 )
Ring_start_addr_ROM_P2 =	ramaddr( Ring_status_table+Rings_Space+8 )
Ring_end_addr_ROM_P2 =		ramaddr( Ring_status_table+Rings_Space+12 )
Ring_free_RAM_start =		ramaddr( Ring_status_table+Rings_Space+16 )
Ring_Positions_End:

Camera_RAM:
Camera_X_pos:			ds.l	1
Camera_Y_pos:			ds.l	1
Camera_BG_X_pos:		ds.l	1	; only used sometimes as the layer deformation makes it sort of redundant
Camera_BG_Y_pos:		ds.l	1
Camera_BG2_X_pos:		ds.l	1	; used in CPZ
Camera_BG2_Y_pos:		ds.l	1	; used in CPZ
; must change that
Camera_BG3_X_pos:		ds.l	1	; unused (only initialised at beginning of level)?
Camera_BG3_Y_pos:		ds.l	1	; unused (only initialised at beginning of level)?
Camera_X_pos_P2:		ds.l	1
Camera_Y_pos_P2:		ds.l	1
;----------------------------------------------------------------------------------------------------------
	         ; only used sometimes as the layer deformation makes it sort of redundant (s2)
Camera_Y_pos_mask:	        ds.w    1
Camera_X_pos_BG_rounded:        	ds.w	1
;----------------------------------------------------------------------------------------------------------
Draw_delayed_position		ds.w 1			; position to redraw screen from. Screen is reloaded 1 row at a time to avoid game lag
Draw_delayed_rowcount		ds.w 1			; number of rows for screen redrawing. Screen is reloaded 1 row at a time to avoid game lag
	;	ds.l	1
;----------------------------------------------------------------------------------------------------------
	ds.w	1	; unused (only initialised at beginning of level)?
Scroll_forced_X_pos:                	ds.w	1	; $FFFFEE32-$FFFFEE33 ; seems unused
;-------------------------------------------------------------------------------------------------
Camera_X_pos_BG_copy: ds.w  1
Camera_Y_pos_BG_rounded:	ds.w	1
;------------------------------------------------------------------------------------------------
	ds.w	1	; unused (only initialised at beginning of level)?
Scroll_forced_Y_pos:             ds.w	1	; $FFFFEE3A-$FFFFEE3B ; seems unused
             	ds.l	1
Title_Dump:
Horiz_block_crossed_flag:	ds.b	1	; toggles between 0 and $10 when you cross a block boundary horizontally
Verti_block_crossed_flag:	ds.b	1	; toggles between 0 and $10 when you cross a block boundary vertically
Horiz_block_crossed_flag_BG:	ds.b	1	; toggles between 0 and $10 when background camera crosses a block boundary horizontally
Verti_block_crossed_flag_BG:	ds.b	1	; toggles between 0 and $10 when background camera crosses a block boundary vertically
Horiz_block_crossed_flag_BG2:	ds.b	1	; used in CPZ
                                ds.b	1	; $FFFFEE45 ; seems unused
Horiz_block_crossed_flag_BG3:	ds.b	1
           		        ds.b	1	; $FFFFEE47 ; seems unused
                	ds.b	1	; toggles between 0 and $10 when you cross a block boundary horizontally
           	ds.b	1	; toggles between 0 and $10 when you cross a block boundary vertically
Palette_timer_Tails             ds.b	1
Palette_frame_Tails:            ds.b    1
                                ds.b    2
                                ds.b    2    	; $FFFFEE4A-$FFFFEE4F ; seems unused
Scroll_flags:			ds.w	1	; bitfield ; bit 0 = redraw top row, bit 1 = redraw bottom row, bit 2 = redraw left-most column, bit 3 = redraw right-most column
Scroll_flags_BG:		ds.w	1	; bitfield ; bits 0-3 as above, bit 4 = redraw top row (except leftmost block), bit 5 = redraw bottom row (except leftmost block), bits 6-7 = as bits 0-1
Scroll_flags_BG2:		ds.w	1	; bitfield ; essentially unused; bit 0 = redraw left-most column, bit 1 = redraw right-most column
Scroll_flags_BG3:		ds.w	1	; bitfield ; for CPZ; bits 0-3 as Scroll_flags_BG but using Y-dependent BG camera; bits 4-5 = bits 2-3; bits 6-7 = bits 2-3
		ds.w	1	; bitfield ; bit 0 = redraw top row, bit 1 = redraw bottom row, bit 2 = redraw left-most column, bit 3 = redraw right-most column
		ds.w	1	; bitfield ; bits 0-3 as above, bit 4 = redraw top row (except leftmost block), bit 5 = redraw bottom row (except leftmost block), bits 6-7 = as bits 0-1
	ds.w	1	; bitfield ; essentially unused; bit 0 = redraw left-most column, bit 1 = redraw right-most column
	ds.w	1	; bitfield ; for CPZ; bits 0-3 as Scroll_flags_BG but using Y-dependent BG camera; bits 4-5 = bits 2-3; bits 6-7 = bits 2-3
Vscroll_buffer:
Camera_RAM_copy:		ds.l	2	; copied over every V-int
Camera_BG_copy:			ds.l	2	; copied over every V-int
Camera_BG2_copy:		ds.l	2	; copied over every V-int
Camera_BG3_copy:		ds.l	2	; copied over every V-int
             			ds.l	7	; copied over every V-int ; $32
             			ds.w    1
Vscroll_buffer_End

;----------------------------------------------------------------------------------------------------
Events_routine_bg:                                ds.w    1 ; used in s1 and 2 used in s3k case
;--------------------------------------------------------------------------------------------------
Scroll_flags_copy:		ds.w	1	; copied over every V-int
Scroll_flags_BG_copy:		ds.w	1	; copied over every V-int
Camera_X_pos_P2_copy:            ; uhhh same as  Camera_Y_pos_P2_copy
Scroll_flags_BG2_copy:		ds.w	1	; copied over every V-int
Scroll_flags_BG3_copy:		ds.w	1	; copied over every V-int
;-----------------------------------------------------------------------------------
Events_fg_5		ds.w	1	; copied over every V-int  (used in s2 in 2p mode used in s3k to do foreground thing)
;----------------------------------------------------------------------------------
Events_fg_1:        ds.w	1	; copied over every V-int
_unkEE9C:	ds.l	1	; copied over every V-int

;-----------------------------------------------------------------------------------------------------------------------------
Camera_X_pos_diff:
H_scroll_amount:			ds.w 1			; number of pixels camera scrolled horizontally in the last frame * $100
;------------------------------------------------------------------------------------------------------------------------------
Camera_Y_pos_diff:
V_scroll_amount:			ds.w 1			; number of pixels camera scrolled vertically in the last frame * $100
;-----------------------------------------------------------------------------------------------------------------------------
Camera_BG_X_pos_diff:	ds.w	1	; Effective camera change used in WFZ ending and HTZ screen shake
Camera_BG_Y_pos_diff:	ds.w	1	; Effective camera change used in WFZ ending and HTZ screen shake
;-----------------------------------------------------------------------------------------------------------------------------
Camera_X_pos_diff_P2:
H_scroll_amount_P2		ds.w 1
;-------------------------------------------------------------------------------------------
Camera_Y_pos_diff_P2:
V_scroll_amount_P2		ds.w 1
;-------------------------------------------------------------------------------------------
Screen_shake_flag:
Screen_Shaking_Flag_HTZ:	ds.b	1	; activates screen shaking code in HTZ's layer deformation routine
Screen_Shaking_Flag:		ds.b	1	; activates screen shaking code (if existent) in layer deformation routine
Scroll_lock:			ds.b	1	; set to 1 to stop all scrolling for P1
Scroll_lock_P2:			ds.b	1	; set to 1 to stop all scrolling for P2
Camera_target_min_X_pos:
unk_EEC0:			ds.l	1	; unused, except on write in LevelSizeLoad...
Camera_target_min_Y_pos:
unk_EEC4:			ds.w	1	; same as above. The write being a long also overwrites the address below
;----------------------------------------------------------------------------
Camera_max_Y_pos:
Camera_Max_Y_pos:		ds.w	1
;----------------------------------------------------------------------------
Camera_min_X_pos:
Camera_Min_X_pos:		ds.w	1
Camera_max_X_pos:
Camera_Max_X_pos:		ds.w	1
Camera_Min_Y_pos:		ds.w	1
Camera_min_Y_pos:             = Camera_Min_Y_pos
Camera_Max_Y_pos_now:		ds.w	1	; was "Camera_max_scroll_spd"...
Horiz_scroll_delay_val:		ds.w	1	; if its value is a, where a != 0, X scrolling will be based on the player's X position a-1 frames ago
;--------------------------------------------------------------------------------------------------------------------------------
Sonic_Pos_Record_Index:
Pos_table_index			ds.w 1			; goes up in increments of 4
;--------------------------------------------------------------------------------------------------------------------------------
Amy_Pos_Record_Index:		= Sonic_Pos_Record_Index
;--------------------------------------------------------------------------------------------------------------------------------
Horiz_scroll_delay_val_P2:
H_scroll_frame_offset_P2	ds.w 1
;---------------------------------------------------------------------------------------------------------------------------------
Tails_Pos_Record_Index:		ds.w	1	; into Tails_Pos_Record_Buf
Distance_from_top:
Camera_Y_pos_bias:		ds.w	1	; added to y position for lookup/lookdown, $60 is center
Distance_from_top_P2:
Camera_Y_pos_bias_P2:		ds.w	1	; for Tails
Deform_lock:			ds.b	1	; set to 1 to stop all deformation
Super_Tails_flag:		ds.b	1	; $FFFFEEDD ; seems unused
;-------------------------------------------------------------------------------
Camera_Max_Y_Pos_Changing:
Camera_max_Y_pos_changing	ds.b 1			; set when the maximum camera Y pos is undergoing a change
;-------------------------------------------------------------------------------
Dynamic_resize_routine:
Dynamic_Resize_Routine:		ds.b	1
_unkEE98:                  ds.w	1	; $FFFFEEE0-$FFFFEEE1
Camera_Y_pos_P2_copy:         ; gets written as a long and since title screen isnt sky chase its used here
Camera_BG_X_offset:		ds.w	1	; Used to control background scrolling in X in WFZ ending and HTZ screen shake
Camera_BG_Y_offset:		ds.w	1	; Used to control background scrolling in Y in WFZ ending and HTZ screen shake
HTZ_Terrain_Delay:		ds.w	1	; During HTZ screen shake, this is a delay between rising and sinking terrain during which there is no shaking
HTZ_Terrain_Direction:		ds.b	1	; During HTZ screen shake, 0 if terrain/lava is rising, 1 if lowering
          		ds.w	1	; $FFFFEEE9-$FFFFEEEB ; seems unused
Fast_V_scroll_flag:
                                ds.b    1
;---------------------------------------------------------------
V_scroll_value_P2_copy:
Vscroll_Factor_P2_HInt:	ds.l	1
;------------------------------------------------------------------
Camera_X_pos_copy:		ds.l	1
Camera_Y_pos_copy:		ds.l	1
;------------------------------------------------------------------------------------------------------------------------------
Tails_Min_X_pos:
Camera_min_X_pos_P2		ds.w 1
;--------------------------------------------------------------------------------------------------------------------
Tails_Max_X_pos:		ds.w	1
Camera_min_Y_pos_P2:
Tails_Min_Y_pos:		ds.w	1 ; seems not actually implemented (only written to)
Tails_Max_Y_pos:		ds.w	1
Scroll_force_positions:         ds.b    1
                                ds.b    1
Camera_X_pos_rounded:           ds.w    1
Camera_Y_pos_rounded:           ds.w    1
Camera_Y_diff:                  ds.w    1 ; needs to free 1 word
Screen_shake_offset:            ds.w    1
Camera_X_diff:                  ds.w    1
Screen_shake_last_offset:            ds.w    1
_unkEE8E:                       ds.w    1
CyclesToWate:                   ds.w    1
cycleTimer:
                                ds.b    $6

Camera_RAM_End:

VRAM_buffer:
Block_cache:			ds.b	$80
VRAM_buffer_End
Ring_consumption_table:		ds.b	$80	; contains RAM addresses of rings currently being consumed
Ring_consumption_table_End:

Target_water_palette:
Underwater_target_palette:		ds.b palette_line_size	; This is used by the screen-fading subroutines.
Underwater_target_palette_line2:	ds.b palette_line_size	; While Underwater_palette contains the blacked-out palette caused by the fading,
Underwater_target_palette_line3:	ds.b palette_line_size	; Underwater_target_palette will contain the palette the screen will ultimately fade in to.
Underwater_target_palette_line4:	ds.b palette_line_size
Water_palette:
Underwater_palette			ds.b $80		; this is what actually gets displayed
Underwater_palette_line_2 =		Underwater_palette+$20	; $20 bytes
Underwater_palette_line_3 =		Underwater_palette+$40	; $20 bytes
Underwater_palette_line4 =		Underwater_palette+$60	; $20 bytes

_unkF712:                       ds.b   $1C
rTailNext =  _unkF712+2
                                ds.b   4
QucikSetFlagRoutine:
                  ds.b   1
Hyper_Sonic_flash_timer:        ds.b   1

Level_trigger_array:            ds.b   $10

                               ds.w 1

                               ds.b    6
Animated_Object_LastLoadedDPLC: ds.b	1	; $FFFFF100-$FFFFF5FF ; unused, leftover from the Sonic 1 sound driver (and used by it when you port it to Sonic 2)
Shield_LastLoadedDPLC:    ds.b    2         ;1 for fire shield 2 for light shield 3 - for bubble
Apparent_zone:                  ds.b    1
                              ;  ds.b	$4A0
Saved_data                      ds.b    $54     ;data select
Flying_carrying_Sonic_flag:     ds.b    1
                                ds.b    1       ;unused

GameMode_Routine:               ds.b    1
Game_mode:
Game_Mode:			ds.b	1	; 1 byte ; see GameModesArray (master level trigger, Mstr_Lvl_Trigger)
Ctrl_1_Logical:					; 2 bytes
Ctrl_1_Held_Logical:		ds.b	1	; 1 byte
Ctrl_1_Press_Logical:		ds.b	1	; 1 byte
Ctrl_1:						; 2 bytes
Ctrl_1_Held:			ds.b	1	; 1 byte ; (pressed and held were switched around before)
Ctrl_1_Press:			ds.b	1	; 1 byte
Ctrl_2:						; 2 bytes
Ctrl_2_Held:			ds.b	1	; 1 byte
Ctrl_1_logical =		Ctrl_1_Logical;*			; both held and pressed
Ctrl_1_held_logical =		Ctrl_1_Held_Logical
Ctrl_1_pressed_logical =	Ctrl_1_Press_Logical		; both held and pressed
Ctrl_1_held =			Ctrl_1_Held			; all held buttons
Ctrl_1_pressed =		Ctrl_1_Press			; buttons being pressed newly this frame			; both held and pressed
Ctrl_2_held =			Ctrl_2_Held
Ctrl_2_pressed =		Ctrl_2_Press
Ctrl_2_Press:			ds.b	1	; 1 byte
Level_music:                    ds.b	2
Camera_Y_pos_BG_copy:            ds.b	2	; $FFFFF608-$FFFFF60B ; seems unused    ; unused sst dont use that fuck
VDP_Reg1_val:			ds.w	1	; normal value of VDP register #1 when display is disabled
VDP_reg_1_command:              = VDP_Reg1_val
WaterPalShiftingSavedValue:     ds.w    1
                                 	; $FFFFF60E-$FFFFF613 ; seems unused
Ctrl_1_title:                		ds.b	1
Saved_status_secondary:         ds.b	2       ;3left word
Saved2_status_secondary:        ds.b    1       ;no more bytes left also takes byte
Demo_timer:
Demo_Time_left:			ds.w	1	; 2 bytes

V_scroll_value:
Vscroll_Factor:
Vscroll_Factor_FG:			ds.w	1
V_scroll_value_BG:
Vscroll_Factor_BG:			ds.w	1
_unkF61A:
unk_F61A:			ds.l	1	; Only ever cleared, never used
V_scroll_value_P2:
Vscroll_Factor_P2:
Vscroll_Factor_P2_FG:		ds.w	1
Vscroll_Factor_P2_BG:		ds.w	1
Teleport_timer:			ds.b	1	; timer for teleport effect
Teleport_active_flag:
Teleport_flag:			ds.b	1	; set when a teleport is in progress
H_int_counter_command:
Hint_counter_reserve:		ds.w	1	; Must contain a VDP command word, preferably a write to register $0A. Executed every V-INT.
H_int_counter =			Hint_counter_reserve+1
Palette_fade_info:
Palette_fade_range =		*	        ; Range affected by the palette fading routines
Palette_fade_start:		ds.b	1	; Offset from the start of the palette to tell what range of the palette will be affected in the palette fading routines
Palette_fade_length:		ds.b	1	; Number of entries to change in the palette fading routines

MiscLevelVariables:
VIntSubE_RunCount:		ds.b	1
Reverse_gravity_flag:		ds.b	1	; $FFFFF629 ; seems unused
V_int_routine:
Vint_routine:			ds.b	1	; was "Delay_Time" ; routine counter for V-int
Ctrl_2_pressed_logical:		ds.b	1	; $FFFFF62B ; seems unused
Sprites_drawn:
Sprite_count:			ds.b	1	; the number of sprites drawn in the current frame
Emeralds_converted_flag:	ds.b	1
Palette_fade_timer:	        ds.b    2 ; $FFFFF62D-$FFFFF631 ; seems unused
Palette_fade_count:                                ds.b    1
                                ds.b    1
Palette_cycle_counter1:
PalCycle_Frame:			ds.w	1	; ColorID loaded in PalCycle
Palette_cycle_counter0:
PalCycle_Timer:			ds.w	1	; number of frames until next PalCycle call
RNG_seed:			ds.l	1	; used for random number generation
Game_paused:			ds.w	1
Tails_CPU_idle_timer:          	ds.b	4	; $FFFFF63C-$FFFFF63F ; seems unused ; might also get unused

DMA_data_thunk:			ds.w	1	; Used as a RAM holder for the final DMA command word. Data will NOT be preserved across V-INTs, so consider this space reserved.
Events_fg_0:                    ds.w	1	; $FFFFF642-$FFFFF643 ; seems unused
H_int_flag:
Hint_flag:			ds.w	1	; unless this is 1, H-int won't run


Water_level:
Water_Level_1:			ds.w	1
Mean_water_level:
Water_Level_2:			ds.w	1
Water_Level_3:			ds.w	1
Water_on:			ds.b	1	; is set based on Water_flag
Water_routine:			ds.b	1
Water_fullscreen_flag:		ds.b	1	; was "Water_move"
Do_Updates_in_H_int:	ds.b	1

PalCycle_Frame_CNZ:		ds.w	1
PalCycle_Frame2:		ds.w	1
PalCycle_Frame3:		ds.w	1
PalCycle_Frame2_CNZ:	ds.w	1
AIZ1_palette_cycle_flag:        ds.b    1
Disable_wall_grab:                    ds.b    1
H_scroll_frame_offset:		ds.b	2	; $FFFFF658-$FFFFF65B ; seems unused
Palette_frame:			ds.w	1
Palette_timer:			ds.b	1	; was "Palette_frame_count"
Super_Sonic_palette:		ds.b	1
Super_Amy_palette:           = Super_Sonic_palette
Palette_frame_count:           = Palette_timer

HPZfallingTImer:
Picture_frame:
Title_Bg_Speed:   ; some sort of buffer   that ends At PalCycle_Timer3
DEZ_Eggman:						; Word
DEZ_Shake_Timer:				; Word
WFZ_LevEvent_Subrout:			; Word
SegaScr_PalDone_Flag:			; Byte (cleared once as a word)
Credits_Trigger:		ds.b	1	; cleared as a word a couple times
Ending_PalCycle_flag:	ds.b	1

SegaScr_VInt_Subrout:
Ending_VInt_Subrout:
WFZ_BG_Y_Speed:			ds.w	1
SS_Mech_X = Title_Bg_Speed
SS_Mech_Y = WFZ_BG_Y_Speed
Super_palette_status:		ds.w	1	; $FFFFF664-$FFFFF665 ; seems unused
PalCycle_Timer2:		ds.w	1
PalCycle_Timer3:		ds.w	1
Ctrl_2_logical:
Ctrl_2_Logical:					; 2 bytes
Ctrl_2_Held_Logical:		ds.b	1	; 1 byte
Ctrl_2_Press_Logical:		ds.b	1	; 1 byte
Sonic_Look_delay_counter:	ds.w	1	; 2 bytes
Amy_Look_delay_counter:	        = Sonic_Look_delay_counter
Tails_Look_delay_counter:	ds.w	1	; 2 bytes
Super_Sonic_frame_count:	ds.w	1
Super_Amy_frame_count:	        = Super_Sonic_frame_count
Camera_ARZ_BG_X_pos:		ds.l	1
Secondary_collision_addr:	ds.l	1	; $FFFFF676-$FFFFF67F ; seems unused
Primary_collision_addr:         ds.l	1 ;all of them were $A
                                ds.b    2
MiscLevelVariables_End

Plc_Buffer:			ds.b	$60	; Pattern load queue (each entry is 6 bytes)
Plc_Buffer_Only_End:
				; these seem to store nemesis decompression state so PLC processing can be spread out across frames
Plc_Buffer_Reg0:		ds.l	1
Plc_Buffer_Reg4:		ds.l	1
Plc_Buffer_Reg8:		ds.l	1
Plc_Buffer_RegC:		ds.l	1
Plc_Buffer_Reg10:		ds.l	1
Plc_Buffer_Reg14:		ds.l	1
Plc_Buffer_Reg18:		ds.w	1	; amount of current entry remaining to decompress
Plc_Buffer_Reg1A:		ds.w	1
                                ds.b	4	; seems unused
Plc_Buffer_End:


Misc_Variables:
               			ds.w	1 ;b was w	; unused

; extra variables for the second player (CPU) in 1-player mode
Tails_control_counter:		ds.w	1	; how long until the CPU takes control
Tails_respawn_counter:		ds.w	1
                            	ds.w	1	; unused
Tails_CPU_routine:		ds.w	1
Tails_CPU_target_x:		ds.w	1
Tails_CPU_target_y:		ds.w	1
Tails_interact_ID:		ds.b	1	; object ID of last object stood on
Tails_CPU_jumping:		ds.b	1

Rings_manager_routine:		ds.b	1
Level_started_flag:		ds.b	1
Ring_start_addr_RAM:	        ds.w	1
Ring_start_addr_RAM_P2:	        ds.w	1
				ds.w	2	; 2 words freed here
CNZ_Bumper_routine:		ds.b	1
CNZ_Bumper_UnkFlag:		ds.b	1	; Set only, never used again
CNZ_Visible_bumpers_start:			ds.l	1
CNZ_Visible_bumpers_end:			ds.l	1
CNZ_Visible_bumpers_start_P2:			ds.l	1
CNZ_Visible_bumpers_end_P2:			ds.l	1

Screen_redraw_flag:			ds.b	1	; if whole screen needs to redraw, such as when you destroy that piston before the boss in WFZ
CPZ_UnkScroll_Timer:	ds.b	1	; Used only in unused CPZ scrolling function
WFZ_SCZ_Fire_Toggle:	ds.b	1
          		ds.b	1	; $FFFFF72F ; seems unused
Water_flag:			ds.b	1	; if the level has water or oil
				ds.b	1	; $FFFFF731 ; seems unused
		              	; index into button press demo data, for player 2
Demo_press_counter_2P:		ds.w	1	; frames remaining until next button press, for player 2
Tornado_Velocity_X:		ds.w	1	; speed of tails' plane in scz ($FFFFF736)
_unkFAA4:                          ; used in instance  loc_8A2A0
Tornado_Velocity_Y:		ds.w	1
ScreenShift:			ds.b	1
                               ds.b	4 ; 1C bytes over lapps on the bosses
Boss_CollisionRoutine:		ds.b	1
BossSavedShade:
Boss_AnimationArray:		ds.b	$10	; up to $10 bytes; 2 bytes per entry

Ending_Routine:
Target_camera_max_X_pos:
Boss_X_pos:			ds.w	1
Flying_picking_Sonic_timer:
				ds.w	1	; Boss_MoveObject reads a long, but all other places in the game use only the high word
_unkFA82:

Boss_Y_pos:			ds.b	1
_unkFAA3:
                                ds.b    1
_unkFA84:
                		ds.w	1	; same here
_unkFA86:

Boss_X_vel:			ds.w	1
Camera_target_max_Y_pos:
Boss_Y_vel:			ds.w	1
Boss_Countdown:		ds.w	1
Target_camera_max_Y_pos:
                	ds.w	1	; $FFFFF75E-$FFFFF75F ; unused

Max_speed:
Sonic_top_speed:		ds.w	1
Acceleration:
Sonic_acceleration:		ds.w	1
Deceleration:
Sonic_deceleration:		ds.w	1

Sonic_LastLoadedDPLC:		ds.b	1	; mapping frame number when Sonic last had his tiles requested to be transferred from ROM to VRAM. can be set to a dummy value like -1 to force a refresh DMA. was: Sonic_mapping_frame
Player_prev_frame:             = Sonic_LastLoadedDPLC
_unkFACD:                        ds.b	1	; $FFFFF767 ; seems unused
Primary_Angle			ds.b 1
Primary_Angle_save		ds.b 1	; Used in FindFloor/FindWall
Secondary_Angle			ds.b 1
Secondary_Angle_save	ds.b 1	; Used in FindFloor/FindWall
Object_load_routine:
Obj_placement_routine:		ds.b	1
_unkFAA8:			ds.b	1	; $FFFFF76D ; used insted of $FFFFF792 ins s1
                 		ds.w	1	; Camera_X_pos_coarse from the previous frame

Object_load_addr_front:		ds.l	1	; contains the address of the next object to load when moving right
Object_load_addr_back:		ds.l	1	; contains the address of the last object loaded when moving left
Object_respawn_index_front:	ds.w 1
Object_respawn_index_back:	ds.w 1
Camera_Y_pos_coarse:            ds.w 1
Camera_Y_pos_coarse_back:       ds.w 1
unk_F780:			ds.b	6	; seems to be an array of horizontal chunk positions, used for object position range checks
unk_F786:			ds.b	3
unk_F789:			ds.b	3
Camera_X_pos_coarse_back:       ds.w	1
Object_index_addr:              ds.l	1	;the Obj_Index pointer used by the object manger

Demo_button_index:		ds.w	1	; index into button press demo data, for player 1
Demo_press_counter:		ds.b	1	; frames remaining until next button press, for player 1
             			ds.b	1	; $FFFFF793 ; seems unused
PalChangeSpeed:			ds.w	1
Collision_addr:			ds.l	1
				ds.b	$2	; $FFFFF79A-$FFFFF7A6 ; seems unused
Special_V_int_routine:		ds.w    1
LRZ_rocks_addr_front:		ds.l    1
LRZ_rocks_addr_back:		ds.l    1
LRZ_rocks_routine:              ds.b    1
Boss_defeated_flag:		ds.b	1
				ds.b	1	; $FFFFF7A8-$FFFFF7A9 ; seems unused
Level_Mode_Toggel:		ds.b    1
Boss_flag:
Current_Boss_ID:		ds.b	1
                                ds.b	1	; $FFFFF7AB-$FFFFF7AF ; repace ment for FFFFF780 and FFFFF780
Glide_Mode:                     ds.b    1
                                ds.b    1
AIZ_vine_angle:                 ds.w    1
Pal_fade_delay2:
MTZ_Platform_Cog_X:			ds.w	1	; X position of moving MTZ platform for cog animation.
HPZSavedY_BG:        ; word
MTZCylinder_Angle_Sonic:	ds.b	1
MTZCylinder_Angle_Tails:	ds.b	1
Spritemask_flag:                ds.b    2
Use_normal_sprite_table:        ds.w    1
Switch_sprite_table:            ds.w    1
                               ds.b    1
                          	ds.b    1
PalIdShift:                     ds.b	1	; $FFFFF7B4-$FFFFF7BD ; seems unused
                                ds.b    1
BigRingGraphics:	ds.w	1	; S1 holdover
waterValues:                ds.l    1
waterShiftValue:           = waterValues+2
				ds.b	3	; $FFFFF7C0-$FFFFF7C6 ; seems unused
WindTunnel_flag:		ds.b	1
Update_HUD_ring_count:		ds.b	1	; $FFFFF7C8 ; seems unused
WindTunnel_holding_flag:			ds.b	1
Ctrl_1_locked:          	ds.b	1	; $FFFFF7CA-$FFFFF7CB ; seems unused
Ctrl_2_locked:                  ds.b    1
Control_Locked:			ds.b	1
control_locked:                 = Control_Locked
            			ds.b	1  ;unused
                    		ds.b	1	; $FFFFF7CE ;unused
Bounses_Finished:              	ds.b	1
Chain_bonus_counter:
Chain_Bonus_counter:		ds.w	1	; counts up when you destroy things that give points, resets when you touch the ground
Bonus_Countdown_1:		ds.w	1	; level results time bonus or special stage sonic ring bonus
Bonus_Countdown_2:		ds.w	1	; level results ring bonus or special stage tails ring bonus
Update_Bonus_score:		ds.b	1
          			ds.b	1
                                ds.b    2	; $FFFFF7D7-$FFFFF7D9 ; seems unused
Camera_X_pos_coarse:		ds.w	1	; (Camera_X_pos - 128) / 256
                		ds.w	1
Tails_LastLoadedDPLC:		ds.b	1	; mapping frame number when Tails last had his tiles requested to be transferred from ROM to VRAM. can be set to a dummy value like -1 to force a refresh DMA.
TailsTails_LastLoadedDPLC:	ds.b	1	; mapping frame number when Tails' tails last had their tiles requested to be transferred from ROM to VRAM. can be set to a dummy value like -1 to force a refresh DMA.
ButtonVine_Trigger:		ds.b	$10	; 16 bytes flag array, #subtype byte set when button/vine of respective subtype activated
Anim_Counters:			ds.b	$10	; $FFFFF7F0-$FFFFF7FF
Misc_Variables_End:
Sprite_table_buffer:
Sprite_Table:			ds.b	$280	; Sprite attribute table buffer
Sprite_Table_End:


Normal_palette			ds.b $80
Normal_palette_line_2:
Normal_palette_line2 =		Normal_palette+$20	; $20 bytes
Normal_palette_line_3:
Normal_palette_line3 =		Normal_palette+$40	; $20 bytes
Normal_palette_line_4:
Normal_palette_line4 =		Normal_palette+$60	; $20 bytes
Normal_palette_End:

Target_palette			ds.b $80		; used by palette fading routines
Target_palette_line_2 =		Target_palette+$20
Target_palette_line2 =		Target_palette+$20	; $20 bytes
Target_palette_line_3 =		Target_palette+$40
Target_palette_line3 =		Target_palette+$40	; $20 bytes
Target_palette_line_4 =		Target_palette+$60
Target_palette_line4 =		Target_palette+$60	; $20 bytes
Target_palette_End:

Stack_contents			ds.b $100		; stack contents
System_Stack:						; this is the top of the stack, it grows downwards
SS_2p_Flag:				ds.w	1	; $FFFFFE00-$FFFFFE01 ; seems unused
Restart_level_flag:
Level_Inactive_flag:		ds.w	1	; (2 bytes)
Timer_frames:			ds.w	1	; (2 bytes)
Level_frame_counter:                   = Timer_frames
Debug_object:			ds.b	1
Special_bonus_entry_flag:       ds.b	1	; $FFFFFE07 ; seems unused

Debug_placement_routine:
Debug_placement_mode:		ds.b	1
Debug_placement_type:		ds.b	1	; the whole word is tested, but the debug mode code uses only the low byte
Debug_camera_delay:
Debug_Accel_Timer:	ds.b	1
Debug_camera_speed:
Debug_Speed:		ds.b	1
V_int_run_count:
Vint_runcount:			ds.l	1
Current_zone_and_act:
Current_ZoneAndAct:				; 2 bytes
Current_zone:
Current_Zone:			ds.b	1	; 1 byte
Current_act:
Current_Act:			ds.b	1	; 1 byte
Life_count:			ds.b	1
Apparent_act:   		ds.b	1
Background_collision_flag:      ds.b 1	; $FFFFFE13-$FFFFFE15 ; seems unused
TimeZone:                        ds.b    1
Current_Special_StageAndAct:	; 2 bytes
Current_special_stage:
Current_Special_Stage:		ds.b	1
Current_Special_Act:		ds.b	1
Continue_count:			ds.b	1
Super_Sonic_flag:		ds.b	1
Super_Amy_flag:	         	= Super_Sonic_flag
Time_Over_flag:			ds.b	1
Extra_life_flags:		ds.b	1

; If set, the respective HUD element will be updated.
Update_HUD_lives:		ds.b	1
Update_HUD_rings:		ds.b	1
Update_HUD_timer:		ds.b	1
Update_HUD_score:		ds.b	1

Ring_count:			ds.w	1	; 2 bytes
Timer:						; 4 bytes
Timer_minute_word:				; 2 bytes
				ds.b	1	; filler
Timer_minute:			ds.b	1	; 1 byte
Timer_second:			ds.b	1	; 1 byte
Timer_centisecond:				; inaccurate name (the seconds increase when this reaches 60)
Timer_frame:			ds.b	1	; 1 byte

Score:				ds.l	1	; 4 bytes
Saved_apparent_zone_and_act:    ds.w	1
Saved_zone_and_act:             ds.w    1
Last_star_post_hit:
Last_star_pole_hit:		ds.b	1	; 1 byte -- max activated starpole ID in this act
Saved_last_star_post_hit:
Saved_Last_star_pole_hit:	ds.b	1
Saved_X_pos:
Saved_x_pos:			ds.w	1
Saved_Y_pos:
Saved_y_pos:			ds.w	1
Saved_ring_count:
Saved_Ring_count:		ds.w	1
Saved_timer:
Saved_Timer:			ds.l	1
Saved_art_tile:			ds.w	1
Saved_solid_bits:
Saved_Solid_bits:			ds.w	1
Saved_camera_X_pos:
Saved_Camera_X_pos:		ds.w	1
Saved_camera_Y_pos:
Saved_Camera_Y_pos:		ds.w	1
Saved_Camera_BG_X_pos:		ds.w	1
Saved_Camera_BG_Y_pos:		ds.w	1
Saved_Camera_BG2_X_pos:		ds.w	1
Saved_Camera_BG2_Y_pos:		ds.w	1
Saved_Camera_BG3_X_pos:		ds.w	1
Saved_Camera_BG3_Y_pos:		ds.w	1
Saved_mean_water_level: ; i think
Saved_Water_Level:		ds.w	1
Saved_Water_routine:		ds.b	1
Saved_water_full_screen_flag:
Saved_Water_move:		ds.b	1
Saved_extra_life_flags:
Saved_Extra_life_flags:		ds.b	1
Saved_Extra_life_flags_2P:	ds.b	1	; stored, but never restored
Saved_camera_max_Y_pos:
Saved_Camera_Max_Y_pos:		ds.w	1
Saved_dynamic_resize_routine:
Saved_Dynamic_Resize_Routine:	ds.b	1
_unkFAA2:                       ds.b    1
Saved2_zone_and_act:           	ds.w	1
Saved2_apparent_zone_and_act:   ds.w    1
Oscillating_table:         ; ($42 bytes)
Oscillating_Numbers:
Oscillation_Control:			ds.w	1
Oscillating_variables:
Oscillating_Data:				ds.w	$20
Oscillating_Numbers_End
Logspike_anim_counter:		ds.b	1
Logspike_anim_frame:		ds.b	1
_unkFEB0:
Rings_anim_counter:		ds.b	1
Rings_frame:
Rings_anim_frame:		ds.b	1
Diamonds_AnimTimer:
Unknown_anim_counter:		ds.b	1	; I think this was $FFFFFEC4 in the alpha
DiamondsFrame:
Unknown_anim_frame:		ds.b	1
Ring_spill_anim_counter:	ds.b	1	; scattered rings
Ring_spill_anim_frame:		ds.b	1
Ring_spill_anim_accum:		ds.w	1
_unkFEB1:                       ds.b    1  ; find dump ram for it somewhere
Slot_machine_goal_frame_timer:  ds.b    1
Slot_machine_goal_frame:        ds.b    1
Slot_machine_peppermint_frame_timer:  ds.b    1
Slot_machine_peppermint_frame:                                ds.b    1
				ds.b	1	; $FFFFFEA9-$FFFFFEAF ; seems unused, but cleared once
Oscillating_variables_End
				ds.b	$7	; $FFFFFEB0-$FFFFFEBF ; seems unused
Init_Entry_ScreenEvent:		ds.b    1
ScreenEventEntry:               ds.b    1
s3k_level_mode:				ds.b     1
Glide_screen_shake:             ds.l     1
                                ds.b    1
                                ds.b     1
; values for the second player (some of these only apply to 2-player games)

Tails_top_speed:		ds.w	1	; Tails_max_vel
Tails_acceleration:		ds.w	1
Tails_deceleration:		ds.w	1
SS_Walls_Timer:
Life_count_2P:   ds.b	1
SS_Walls_Frame:
Extra_life_flags_2P:		ds.b	1
Update_HUD_lives_2P:		ds.b	1
Update_HUD_rings_2P:		ds.b	1
Update_HUD_timer_2P:		ds.b	1
Update_HUD_score_2P:		ds.b	1	; mostly unused
Time_Over_flag_2P:		ds.b	1
                                ds.b    1
Kos_modules_left:		ds.b	1
                                ds.b    1	; $FFFFFECD-$FFFFFECF ; seems unused
Ring_count_P2:
Ring_count_2P:			ds.w	1
Timer_P2:
Timer_2P:					; 4 bytes
Timer_minute_word_2P:				; 2 bytes
End_of_level_flag:		ds.b	1	; filler
Timer_minute_2P:		ds.b	1	; 1 byte
Timer_second_2P:		ds.b	1	; 1 byte
Timer_centisecond_2P:				; inaccurate name (the seconds increase when this reaches 60)
Timer_frame_2P:			ds.b	1	; 1 byte
Score_P2:
Score_2P:			ds.l	1
Kos_last_module_size:		ds.w	1
BlockListAddr                    ds.l    1	; $FFFFFEDA-$FFFFFEDF ; seems unused
Last_star_pole_hit_2P:		ds.b	1
Saved_Last_star_pole_hit_2P:	ds.b	1
Saved_x_pos_2P:			ds.w	1
Saved_y_pos_2P:			ds.w	1
Saved_Ring_count_2P:		ds.w	1
Saved_Timer_2P:			ds.l	1
Saved_art_tile_2P:		ds.w	1
Saved_Solid_bits_2P:			ds.w	1
Rings_Collected:		ds.w	1	; number of rings collected during an act in two player mode
Rings_Collected_2P:		ds.w	1
Monitors_Broken:		ds.w	1	; number of monitors broken during an act in two player mode
Monitors_Broken_2P:		ds.w	1
Loser_Time_Left:				; 2 bytes
				ds.b	1	; seconds
				ds.b	1	; frames


Results_Screen_2P:		ds.w	1	; 0 = act, 1 = zone, 2 = game, 3 = SS, 4 = SS all
Screen_Y_wrap_value:		ds.w	1	; $FFFFFF12-$FFFFFF1F ; seems unused
                                ds.w    1 ; unused
Screen_X_wrap_value:            ds.w    1
Plane_double_update_flag:       ds.l    1
Layout_row_index_mask:          ds.w    1

Events_bg:			ds.b	$18	; $FFFFFEFA-$FFFFFF0F ; seems unused
Results_Data_2P:


Plane_buffer_2_addr:		ds.l	1	; 2 bytes (player 1 then player 2)
BlocksSets_Number:		ds.b	1	; $FFFFFF3A-$FFFFFF3F ; seems unused
_unkFA89:			ds.w    1
                                ds.b    1
Perfect_rings_left:		ds.w	1
Perfect_rings_flag:			ds.w	1
Kos_module_destination:		ds.w	1	; $FFFFFF44-$FFFFFF4B ; seems unused
                                ds.w    1   ; free
                                ds.l    1  ; leaps over to Level_repeat_offset
SS_Total_Won:
CreditsScreenIndex:
SlotMachineInUse:			ds.w	1
SlotMachineVariables:	; $12 values
SlotMachine_Routine:	ds.b	1
SlotMachine_Timer:		ds.b	1
				ds.b	1	; $FFFFFF50 ; seems unused except for 1 write
SlotMachine_Index:		ds.b	1
SlotMachine_Reward:		ds.w	1
SlotMachine_Slot1Pos:	ds.w	1
SlotMachine_Slot1Speed:	ds.b	1
SlotMachine_Slot1Rout:	ds.b	1
SlotMachine_Slot2Pos:	ds.w	1
SlotMachine_Slot2Speed:	ds.b	1
SlotMachine_Slot2Rout:	ds.b	1
SlotMachine_Slot3Pos:	ds.w	1
SlotMachine_Slot3Speed:	ds.b	1
SlotMachine_Slot3Rout:	ds.b	1

Level_repeat_offset:           ds.l	1	; $FFFFFF60-$FFFFFF6F ; seems unused
Events_fg_4:                   ds.l     1
Events_routine_fg:             ds.l    1
Title_Unc_ArtLoader:      ds.b    1
                                ds.w    1
Debug_Out:                      ds.b    1
Player_mode:			ds.w	1	; 0 = Sonic and Tails, 1 = Sonic, 2 = Tails
Player_option:			ds.w	1	; 0 = Sonic and Tails, 1 = Sonic, 2 = Tails

Play_Style:		ds.w	1       ;Two_player_items
Enemy_interact:                ds.b    1
                                ds.b   1 ;odd
Dataselect_nosave_player:
				ds.b	6	; $FFFFFF76-$FFFFFF7F ; seems unused
_unkFA88:                       ds.w    1
LevSel_HoldTimer:		ds.w	1
Level_select_zone:		ds.w	1
Sound_test_sound:		ds.w	1
Title_screen_option:		ds.b	1
				ds.b	1	; $FFFFFF87 ; unused
Current_Zone_2P:		ds.b	1
Current_Act_2P:			ds.b	1
Two_player_mode_copy:		ds.w	1
Options_menu_box:		ds.b	1
				ds.b	1	; $FFFFFF8D ; unused
Total_Bonus_Countdown:		ds.w	1

Level_Music:			ds.w	1
Bonus_Countdown_3:		ds.w	1
Collected_special_ring_array:   ds.l	1	; $FFFFFF94-$FFFFFF97 ; seems unused
Game_Over_2P:			ds.w	1

		ds.b	1	; $FFFFFF9A-$FFFFFF9F ; seems unused
Super_emerald_count:             ds.b    1
Respawn_table_keep:      ds.b    1
MHZ_pollen_counter:             ds.b    1
Emerald_flicker_flag:           ds.w    1
Slotted_object_bits:		ds.w	1
_unkEF44_1:                     ds.l    1
Save_pointer:                   ds.l    1
SRAM_mask_interrupts_flag:      ds.w    1


Got_Emerald:			ds.b	1
Emerald_count:			ds.b	1
Collected_emeralds_array:
Got_Emeralds_array:		ds.b	7	; 7 bytes
				ds.b	7	; $FFFFFFB9-$FFFFFFBF ; filler
Next_extra_life_score:
Next_Extra_life_score:		ds.l	1
Next_extra_life_score_P2:
Next_Extra_life_score_2P:	ds.l	1
Level_Has_Signpost:		ds.w	1	; 1 = signpost, 0 = boss or nothing
Signpost_prev_frame:	ds.b	1
                                  ds.b	1	; ;  unused
Debug_P1_mappings:             	ds.l	1    ; freed denug mode
Debug_P2_mappings:              ds.w    1

Level_select_flag:		ds.b	1
Slow_motion_flag:		ds.b	1	; This NEEDs to be after Level_select_flag because of the call to CheckCheats
Debug_options_flag:		ds.b	1	; if set, allows you to enable debug mode and "night mode"
S1_hidden_credits_flag:		ds.b	1	; Leftover from Sonic 1. This NEEDs to be after Debug_options_flag because of the call to CheckCheats
Correct_cheat_entries:		ds.w	1
Correct_cheat_entries_2:	ds.w	1	; for 14 continues or 7 emeralds codes
Competition_mode:
Two_player_mode:		ds.w	1	; flag (0 for main game)
unk_FFDA:			ds.w	1	; Written to once at title screen, never read from
unk_FFDC:			ds.b	1	; Written to near loc_175EA, never read from
unk_FFDD:			ds.b	1	; Written to near loc_175EA, never read from
unk_FFDE:			ds.b	1	; Written to near loc_175EA, never read from
unk_FFDF:			ds.b	1	; Written to near loc_175EA, never read from

; Values in these variables are passed to the sound driver during V-INT.
; They use a playlist index, not a sound test index.
Music_to_play:			ds.b	1
SFX_to_play:			ds.b	1	; normal
SFX_to_play_2:			ds.b	1	; alternating stereo
unk_FFE3:			ds.b	1
Music_to_play_2:		ds.b	1	; alternate (higher priority?) slot
	              		ds.b	1	; $FFFFFFE5-$FFFFFFEF ; seems unused   restored from sonic 1 tho we dont need it anymore

V_int_jump :=			*			; contains an instruction to jump to the V-int handler
				ds.b 6			; Sonic 3 has a different address... So uh... Yes
V_int_addr :=			V_int_jump+2		; long
Demo_mode_flag:			ds.w	1 ; 1 if a demo is playing (2 bytes)
Demo_number:			ds.w	1 ; which demo will play next (2 bytes)
Ending_demo_number:		ds.w	1 ; zone for the ending demos (2 bytes, unused)
H_int_jump:			ds.b	6
H_int_addr :=			H_int_jump+2		; long
Graphics_flags:
Graphics_Flags:			ds.w	1 ; misc. bitfield
Debug_mode_flag:		ds.w	1 ; (2 bytes)
Checksum_fourcc:		ds.l	1 ; (4 bytes)
RAM_End
    if * > 0	; Don't declare more space than the RAM can contain!
	fatal "The RAM variable declarations are too large by $\{*} bytes."
    endif

	phase	ramaddr(Pos_table_P2)
SStage_scalar_index_0		ds.w 1			; unknown scalar table index value
SStage_scalar_index_1		ds.w 1			; unknown scalar table index value
SStage_scalar_index_2		ds.w 1			; unknown scalar table index value
SStage_scalar_result_0		ds.l 1			; unknown scalar table results values
SStage_scalar_result_1		ds.l 1			; unknown scalar table results values
SStage_scalar_result_2		ds.l 1			; unknown scalar table results values

           dephase
; RAM variables - SEGA screen
	phase	Object_RAM	; Move back to the object RAM
SegaScr_Object_RAM:
				; Unused slot
				ds.b	object_size
SegaScreenObject:		; Sega screen
				ds.b	object_size
SegaHideTM:				; Object that hides TM symbol on JP region
				ds.b	object_size

				ds.b	($80-3)*object_size
SegaScr_Object_RAM_End:


; RAM variables - Title screen
	phase	Object_RAM	; Move back to the object RAM
TtlScr_Object_RAM:
				; Unused slot
				ds.b	object_size
IntroSonic:			; stars on the title screen
				ds.b	object_size
IntroTails:
				ds.b	object_size
IntroLargeStar:
TitleScreenPaletteChanger:
				ds.b	object_size
TitleScreenPaletteChanger3:
				ds.b	object_size
IntroEmblemTop:
				ds.b	object_size
IntroSmallStar1:
				ds.b	object_size
IntroSonicHand:
				ds.b	object_size
IntroTailsHand:
				ds.b	object_size
TitleScreenPaletteChanger2:
				ds.b	object_size

				ds.b	6*object_size

TitleScreenMenu:
				ds.b	object_size
IntroSmallStar2:
				ds.b	object_size

				ds.b	($70-2)*object_size
TtlScr_Object_RAM_End:


; RAM variables - Special stage
	phase	RAM_Start	; Move back to start of RAM
SSRAM_ArtNem_SpecialSonicAndTails:
				ds.b	$353*$20	; $353 art blocks
SSRAM_MiscKoz_SpecialPerspective:
				ds.b	$1AFC
SSRAM_MiscNem_SpecialLevelLayout:
				ds.b	$180
				ds.b	$9C	; padding
SSRAM_MiscKoz_SpecialObjectLocations:
				ds.b	$1AE0

	phase	Sprite_Table_Input
SS_Sprite_Table_Input:		ds.b	$400	; in custom format before being converted and stored in Sprite_Table
SS_Sprite_Table_Input_End:

	phase	Object_RAM	; Move back to the object RAM
SS_Object_RAM:
				ds.b	object_size
				ds.b	object_size
SpecialStageHUD:		; HUD in the special stage
				ds.b	object_size
SpecialStageStartBanner:
				ds.b	object_size
SpecialStageNumberOfRings:
				ds.b	object_size
SpecialStageShadow_Sonic:
				ds.b	object_size
SpecialStageShadow_Tails:
				ds.b	object_size
SpecialStageTails_Tails:
				ds.b	object_size
SS_Dynamic_Object_RAM:
				ds.b	$18*object_size
SpecialStageResults:
				ds.b	object_size
				ds.b	$C*object_size
SpecialStageResults2:
				ds.b	object_size
				ds.b	$51*object_size
SS_Dynamic_Object_RAM_End:
				ds.b	object_size
SS_Object_RAM_End:

				; The special stage mode also uses the rest of the RAM for
				; different purposes.
SS_Misc_Variables:
PNT_Buffer:			ds.b	$700
PNT_Buffer_End:
SS_Horiz_Scroll_Buf_2:		ds.b	$400

SSTrack_mappings_bitflags:				ds.l	1
SSTrack_mappings_uncompressed:			ds.l	1
SSTrack_anim:							ds.b	1
SSTrack_last_anim_frame:				ds.b	1
SpecialStage_CurrentSegment:			ds.b	1
SSTrack_anim_frame:						ds.b	1
SS_Alternate_PNT:						ds.b	1
SSTrack_drawing_index:					ds.b	1
SSTrack_Orientation:					ds.b	1
SS_Alternate_HorizScroll_Buf:			ds.b	1
SSTrack_mapping_frame:					ds.b	1
SS_Last_Alternate_HorizScroll_Buf:		ds.b	1
SS_New_Speed_Factor:					ds.l	1
SS_Cur_Speed_Factor:					ds.l	1
		ds.b	5
SSTrack_duration_timer:					ds.b	1
		ds.b	1
SS_player_anim_frame_timer:				ds.b	1
SpecialStage_LastSegment:				ds.b	1
SpecialStage_Started:					ds.b	1
		ds.b	4
SSTrack_last_mappings_copy:				ds.l	1
SSTrack_last_mappings:					ds.l	1
		ds.b	4
SSTrack_LastVScroll:					ds.w	1
		ds.b	3
SSTrack_last_mapping_frame:				ds.b	1
SSTrack_mappings_RLE:					ds.l	1
SSDrawRegBuffer:						ds.w	6
SSDrawRegBuffer_End
		ds.b	2
SpecialStage_LastSegment2:	ds.b	1
SS_unk_DB4D:	ds.b	1
		ds.b	$14
SS_Ctrl_Record_Buf:
				ds.w	$F
SS_Last_Ctrl_Record:
				ds.w	1
SS_Ctrl_Record_Buf_End
SS_CurrentPerspective:	ds.l	1
SS_Check_Rings_flag:		ds.b	1
SS_Pause_Only_flag:		ds.b	1
SS_CurrentLevelObjectLocations:	ds.l	1
SS_Ring_Requirement:	ds.w	1
SS_CurrentLevelLayout:	ds.l	1
		ds.b	1
SS_2P_BCD_Score:	ds.b	1
		ds.b	1
SS_NoCheckpoint_flag:	ds.b	1
		ds.b	2
SS_Checkpoint_Rainbow_flag:	ds.b	1
SS_Rainbow_palette:	ds.b	1
SS_Perfect_rings_left:	ds.w	1
		ds.b	2
SS_Star_color_1:	ds.b	1
SS_Star_color_2:	ds.b	1
SS_NoCheckpointMsg_flag:	ds.b	1
		ds.b	1
SS_NoRingsTogoLifetime:	ds.w	1
SS_RingsToGoBCD:		ds.w	1
SS_HideRingsToGo:	ds.b	1
SS_TriggerRingsToGo:	ds.b	1
			ds.b	$58	; unused
SS_Misc_Variables_End:

	phase	ramaddr(Horiz_Scroll_Buf)	; Still in SS RAM
SS_Horiz_Scroll_Buf_1:		ds.b	$400
SS_Horiz_Scroll_Buf_1_End:

	phase	ramaddr($FFFFF73E)	; Still in SS RAM
SS_Offset_X:			ds.w	1
SS_Offset_Y:			ds.w	1
SS_Swap_Positions_Flag:	ds.b	1

	phase	ramaddr(Sprite_Table)	; Still in SS RAM
SS_Sprite_Table:			ds.b	$280	; Sprite attribute table buffer
SS_Sprite_Table_End:
				ds.b	$80	; unused, but SAT buffer can spill over into this area when there are too many sprites on-screen


; RAM variables - Continue screen
	phase	Object_RAM	; Move back to the object RAM
ContScr_Object_RAM:
				ds.b	object_size
				ds.b	object_size
ContinueText:			; "CONTINUE" on the Continue screen
				ds.b	object_size
ContinueIcons:			; The icons in the Continue screen
				ds.b	$D*object_size

				; Free slots
				ds.b	$70*object_size
ContScr_Object_RAM_End:


; RAM variables - 2P VS results screen
	phase	Object_RAM	; Move back to the object RAM
VSRslts_Object_RAM:
VSResults_HUD:			; Blinking text at the bottom of the screen
				ds.b	object_size

				; Free slots
				ds.b	$7F*object_size
VSRslts_Object_RAM_End:


; RAM variables - Menu screens
	phase	Object_RAM	; Move back to the object RAM
Menus_Object_RAM:		; No objects are loaded in the menu screens
				ds.b	$80*object_size
Menus_Object_RAM_End:


; RAM variables - Ending sequence
	phase	Object_RAM
EndSeq_Object_RAM:
				ds.b	object_size
				ds.b	object_size
Tails_Tails_Cutscene:		; Tails' tails on the cut scene
				ds.b	object_size
EndSeqPaletteChanger:
				ds.b	object_size
CutScene:
				ds.b	object_size
				ds.b	($80-5)*object_size
EndSeq_Object_RAM_End:

	dephase		; Stop pretending

	!org	0	; Reset the program counter


; ---------------------------------------------------------------------------
; VDP addressses
VDP_data_port =			$C00000 ; (8=r/w, 16=r/w)
VDP_control_port =		$C00004 ; (8=r/w, 16=r/w)
PSG_input =			$C00011

; ---------------------------------------------------------------------------
; Z80 addresses
Z80_RAM =			$A00000 ; start of Z80 RAM
Z80_RAM_End =			$A02000 ; end of non-reserved Z80 RAM
Z80_Bus_Request =		$A11100
Z80_Reset =			$A11200

SRAM_access_flag =		$A130F1
Security_Addr =			$A14000
; ---------------------------------------------------------------------------

; I/O Area
HW_Version =			$A10001
HW_Port_1_Data =		$A10003
HW_Port_2_Data =		$A10005
HW_Expansion_Data =		$A10007
HW_Port_1_Control =		$A10009
HW_Port_2_Control =		$A1000B
HW_Expansion_Control =		$A1000D
HW_Port_1_TxData =		$A1000F
HW_Port_1_RxData =		$A10011
HW_Port_1_SCtrl =		$A10013
HW_Port_2_TxData =		$A10015
HW_Port_2_RxData =		$A10017
HW_Port_2_SCtrl =		$A10019
HW_Expansion_TxData =		$A1001B
HW_Expansion_RxData =		$A1001D
HW_Expansion_SCtrl =		$A1001F
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
; Art tile stuff
flip_x              =      (1<<11)
flip_y              =      (1<<12)
palette_bit_0       =      5
palette_bit_1       =      6
palette_line_0      =      (0<<13)
palette_line_1      =      (1<<13)
palette_line_2      =      (2<<13)
palette_line_3      =      (3<<13)
high_priority_bit   =      7
high_priority       =      (1<<15)
palette_mask        =      $6000
tile_mask           =      $07FF
nontile_mask        =      $F800
drawing_mask        =      $7FFF

; ---------------------------------------------------------------------------
; VRAM and tile art base addresses.
; VRAM Reserved regions.
VRAM_Plane_A_Name_Table                  = $C000	; Extends until $CFFF
VRAM_Plane_B_Name_Table                  = $E000	; Extends until $EFFF
VRAM_Plane_A_Name_Table_2P               = $A000	; Extends until $AFFF
VRAM_Plane_B_Name_Table_2P               = $8000	; Extends until $8FFF
VRAM_Plane_Table_Size                    = $1000	; 64 cells x 32 cells x 2 bytes per cell
VRAM_Sprite_Attribute_Table              = $F800	; Extends until $FA7F
VRAM_Sprite_Attribute_Table_Size         = $0280	; 640 bytes
VRAM_Horiz_Scroll_Table                  = $FC00	; Extends until $FF7F
VRAM_Horiz_Scroll_Table_Size             = $0380	; 224 lines * 2 bytes per entry * 2 PNTs

; VRAM Reserved regions, Sega screen.
VRAM_SegaScr_Plane_A_Name_Table          = $C000	; Extends until $DFFF
VRAM_SegaScr_Plane_B_Name_Table          = $A000	; Extends until $BFFF
VRAM_SegaScr_Plane_Table_Size            = $2000	; 128 cells x 32 cells x 2 bytes per cell

; VRAM Reserved regions, Special Stage.
VRAM_SS_Plane_A_Name_Table1              = $C000	; Extends until $DFFF
VRAM_SS_Plane_A_Name_Table2              = $8000	; Extends until $9FFF
VRAM_SS_Plane_B_Name_Table               = $A000	; Extends until $BFFF
VRAM_SS_Plane_Table_Size                 = $2000	; 128 cells x 32 cells x 2 bytes per cell
VRAM_SS_Sprite_Attribute_Table           = $F800	; Extends until $FA7F
VRAM_SS_Sprite_Attribute_Table_Size      = $0280	; 640 bytes
VRAM_SS_Horiz_Scroll_Table               = $FC00	; Extends until $FF7F
VRAM_SS_Horiz_Scroll_Table_Size          = $0380	; 224 lines * 2 bytes per entry * 2 PNTs

; VRAM Reserved regions, Title screen.
VRAM_TtlScr_Plane_A_Name_Table           = $C000	; Extends until $CFFF
VRAM_TtlScr_Plane_B_Name_Table           = $E000	; Extends until $EFFF
VRAM_TtlScr_Plane_Table_Size             = $1000	; 64 cells x 32 cells x 2 bytes per cell

; VRAM Reserved regions, Ending sequence and credits.
VRAM_EndSeq_Plane_A_Name_Table           = $C000	; Extends until $DFFF
VRAM_EndSeq_Plane_B_Name_Table1          = $E000	; Extends until $EFFF (plane size is 64x32)
VRAM_EndSeq_Plane_B_Name_Table2          = $4000	; Extends until $5FFF
VRAM_EndSeq_Plane_Table_Size             = $2000	; 64 cells x 64 cells x 2 bytes per cell

; VRAM Reserved regions, menu screen.
VRAM_Menu_Plane_A_Name_Table             = $C000	; Extends until $CFFF
VRAM_Menu_Plane_B_Name_Table             = $E000	; Extends until $EFFF
VRAM_Menu_Plane_Table_Size               = $1000	; 64 cells x 32 cells x 2 bytes per cell

; From here on, art tiles are used; VRAM address is art tile * $20.
ArtTile_VRAM_Start                    = $0000

; Common to 1p and 2p menus.
ArtTile_ArtNem_FontStuff              = $0010

; Sega screen
ArtTile_ArtNem_Sega_Logo              = $0001
ArtTile_ArtNem_Trails                 = $0080
ArtTile_ArtUnc_Giant_Sonic            = $0088

; Title screen
ArtTile_ArtNem_Title                  = $0000
ArtTile_ArtNem_TitleSprites           = $06E4
ArtTile_ArtNem_MenuJunk               = $03F2
ArtTile_ArtNem_Player1VS2             = $0402
ArtTile_ArtNem_CreditText             = $0500
ArtTile_ArtNem_FontStuff_TtlScr       = $0680

; Credits screen
ArtTile_ArtNem_CreditText_CredScr     = $0001

; Menu background.
ArtTile_ArtNem_MenuBox                = $0070

; Level select icons.
ArtTile_ArtNem_LevelSelectPics        = $0090

; 2p results screen.
ArtTile_ArtNem_1P2PWins               = $0070
ArtTile_ArtNem_SpecialPlayerVSPlayer  = $03DF
ArtTile_ArtNem_2p_Signpost            = $05E8
ArtTile_TwoPlayerResults              = $0600

; Special stage stuff.
ArtTile_ArtNem_SpecialEmerald         = $0174
ArtTile_ArtNem_SpecialMessages        = $01A2
ArtTile_ArtNem_SpecialHUD             = $01FA
ArtTile_ArtNem_SpecialFlatShadow      = $023C
ArtTile_ArtNem_SpecialDiagShadow      = $0262
ArtTile_ArtNem_SpecialSideShadow      = $029C
ArtTile_ArtNem_SpecialExplosion       = $02B5
ArtTile_ArtNem_SpecialSonic           = $02E5
ArtTile_ArtNem_SpecialTails           = $0300
ArtTile_ArtNem_SpecialTails_Tails     = $0316
ArtTile_ArtNem_SpecialRings           = $0322
ArtTile_ArtNem_SpecialStart           = $038A
ArtTile_ArtNem_SpecialBomb            = $038A
ArtTile_ArtNem_SpecialStageResults    = $0590
ArtTile_ArtNem_SpecialBack            = $0700
ArtTile_ArtNem_SpecialStars           = $077F
ArtTile_ArtNem_SpecialTailsText       = $07A4

; Ending.
ArtTile_EndingCharacter               = $0019
ArtTile_ArtNem_EndingFinalTornado     = $0156
ArtTile_ArtNem_EndingPics             = $0328
ArtTile_ArtNem_EndingMiniTornado      = $0493

; S1 Ending
ArtTile_ArtNem_S1EndFlicky            = $05A5
ArtTile_ArtNem_S1EndRabbit            = $0553
ArtTile_ArtNem_S1EndPenguin           = $0573
ArtTile_ArtNem_S1EndSeal              = $0585
ArtTile_ArtNem_S1EndPig               = $0593
ArtTile_ArtNem_S1EndChicken           = $0565
ArtTile_ArtNem_S1EndSquirrel          = $05B3

; Continue screen.
ArtTile_ArtNem_ContinueTails          = $0500
ArtTile_ArtNem_ContinueText           = $0500
ArtTile_ArtNem_ContinueText_2         = ArtTile_ArtNem_ContinueText + $24
ArtTile_ArtNem_MiniContinue           = $0524
ArtTile_ContinueScreen_Additional     = $0590
ArtTile_ContinueCountdown             = $06FC

; ---------------------------------------------------------------------------
; Level art stuff.
ArtTile_ArtKos_LevelArt               = $0000
ArtTile_ArtKos_NumTiles_GHZ           = $0393
ArtTile_ArtKos_NumTiles_CPZ           = $0364
ArtTile_ArtKos_NumTiles_ARZ           = $03F6
ArtTile_ArtKos_NumTiles_CNZ           = $0331
ArtTile_ArtKos_NumTiles_HTZ_Main      = $01FC ; Until this tile, equal to GHZ tiles.
ArtTile_ArtKos_NumTiles_HTZ_Sup       = $0183 ; Overwrites several GHZ tiles.
ArtTile_ArtKos_NumTiles_HTZ           = ArtTile_ArtKos_NumTiles_HTZ_Main + ArtTile_ArtKos_NumTiles_HTZ_Sup - 1
ArtTile_ArtKos_NumTiles_MCZ           = $03A9
ArtTile_ArtKos_NumTiles_OOZ           = $02AA
ArtTile_ArtKos_NumTiles_MTZ           = $0319
ArtTile_ArtKos_NumTiles_SCZ           = $036E
ArtTile_ArtKos_NumTiles_WFZ_Main      = $0307 ; Until this tile, equal to SCZ tiles.
ArtTile_ArtKos_NumTiles_WFZ_Sup       = $0073 ; Overwrites several SCZ tiles.
ArtTile_ArtKos_NumTiles_WFZ           = ArtTile_ArtKos_NumTiles_WFZ_Main + ArtTile_ArtKos_NumTiles_WFZ_Sup - 1
ArtTile_ArtKos_NumTiles_DEZ           = $0326 ; Skips several CPZ tiles.
; Save screen.
ArtTile_ArtKos_Save_Misc              = $029F
ArtTile_ArtKos_Save_Extra             = $0454
ArtTile_ArtKos_S3MenuBG               = $0001
; ---------------------------------------------------------------------------
; Shared badniks and objects.

; Objects that use the same art tiles on all levels in which
; they are loaded, even if not all levels load them.
ArtTile_ArtNem_WaterSurface           = $0400
ArtTile_ArtNem_Button                 = $0424
ArtTile_ArtNem_HorizSpike             = $00E3
ArtTile_ArtNem_Spikes                 = $0434
ArtTile_ArtNem_DignlSprng             = $0500   ;ghz_dnamic tile load
ArtTile_ArtNem_VrtclSprng_2           = $000A
ArtTile_ArtNem_LeverSpring            = $0440
ArtTile_ArtNem_VrtclSprng             = $0456
ArtTile_ArtNem_HrzntlSprng            = $0470

; GHZ, HTZ
ArtTile_ArtKos_Checkers               = ArtTile_ArtKos_LevelArt+$0158
ArtTile_ArtUnc_Flowers1               = $03A9
ArtTile_ArtUnc_Flowers2               = $03AB
ArtTile_ArtUnc_Flowers3               = $05FA
ArtTile_ArtUnc_Flowers4               = $03AB
ArtTile_ArtNem_Buzzer                 = $03D2

; WFZ, SCZ
ArtTile_ArtNem_WfzHrzntlPrpllr        = $03CD
ArtTile_ArtNem_Clouds                 = $054F
ArtTile_ArtNem_WfzVrtclPrpllr         = $0561
ArtTile_ArtNem_Balkrie                = $0565
ArtTile_ArtNem_dinobot                = $0500

; ---------------------------------------------------------------------------
; Level-specific objects and badniks.

; GHZ
ArtTile_ArtUnc_GHZPulseBall           = $057E
ArtTile_ArtNem_Waterfall              = $039E
ArtTile_ArtNem_GHZ_Bridge             = $05F2
ArtTile_ArtNem_Buzzer_Fireball        = $03BE	; Actually unused
ArtTile_ArtNem_Coconuts               = $03EE
ArtTile_ArtNem_Masher                 = $0414
ArtTile_ArtUnc_GHZMountains           = $0500


; MTZ
ArtTile_ArtNem_Shellcracker           = $031C
ArtTile_ArtUnc_Lava                   = $0340
ArtTile_ArtUnc_MTZCylinder            = $034C
ArtTile_ArtUnc_MTZAnimBack_1          = $035C
ArtTile_ArtUnc_MTZAnimBack_2          = $0362
ArtTile_ArtNem_MtzSupernova           = $0368
ArtTile_ArtNem_MtzWheel               = $0378
ArtTile_ArtNem_MtzWheelIndent         = $03F0
ArtTile_ArtNem_LavaCup                = $03F9
ArtTile_ArtNem_BoltEnd_Rope           = $03FD
ArtTile_ArtNem_MtzSteam               = $0405
ArtTile_ArtNem_MtzSpikeBlock          = $0414
ArtTile_ArtNem_MtzSpike               = $041C
ArtTile_ArtNem_MtzMantis              = $043C
ArtTile_ArtNem_MtzAsstBlocks          = $0500
ArtTile_ArtNem_MtzLavaBubble          = $0536
ArtTile_ArtNem_MtzCog                 = $055F
ArtTile_ArtNem_MtzSpinTubeFlash       = $056B

; WFZ
ArtTile_ArtNem_WfzScratch             = $0379
ArtTile_ArtNem_WfzTiltPlatforms       = $0393
ArtTile_ArtNem_WfzVrtclLazer          = $039F
ArtTile_ArtNem_WfzWallTurret          = $03AB
ArtTile_ArtNem_WfzHrzntlLazer         = $03C3
ArtTile_ArtNem_WfzConveyorBeltWheel   = $03EA
ArtTile_ArtNem_WfzHook                = $03FA
ArtTile_ArtNem_WfzHook_Fudge          = ArtTile_ArtNem_WfzHook + 4 ; Bad mappings...
ArtTile_ArtNem_WfzBeltPlatform        = $040E
ArtTile_ArtNem_WfzGunPlatform         = $041A
ArtTile_ArtNem_WfzUnusedBadnik        = $0450
ArtTile_ArtNem_WfzLaunchCatapult      = $045C
ArtTile_ArtNem_WfzSwitch              = $0461
ArtTile_ArtNem_WfzThrust              = $0465
ArtTile_ArtNem_WfzFloatingPlatform    = $046D
ArtTile_ArtNem_BreakPanels            = $048C

; SCZ
ArtTile_ArtNem_Turtloid               = $038A
ArtTile_ArtNem_Nebula                 = $036E

; HTZ
ArtTile_ArtNem_Rexon                  = $037E
ArtTile_ArtNem_HtzFireball1           = $039E
ArtTile_ArtNem_HtzRock                = $0490
ArtTile_ArtNem_HtzSeeSaw              = $03C6
ArtTile_ArtNem_Sol                    = $03DE
ArtTile_ArtNem_HtzZipline             = $03E6
ArtTile_ArtNem_HtzFireball2           = $0416
ArtTile_ArtNem_HtzValveBarrier        = $0426
ArtTile_ArtUnc_HTZMountains           = $0500
ArtTile_ArtUnc_HTZClouds              = ArtTile_ArtUnc_HTZMountains + $18
ArtTile_ArtNem_Spiker                 = $0520

; OOZ
ArtTile_ArtUnc_OOZPulseBall           = $02B6
ArtTile_ArtUnc_OOZSquareBall1         = $02BA
ArtTile_ArtUnc_OOZSquareBall2         = $02BE
ArtTile_ArtUnc_Oil1                   = $02C2
ArtTile_ArtUnc_Oil2                   = $02D2
ArtTile_ArtNem_OOZBurn                = $02E2
ArtTile_ArtNem_OOZElevator            = $02F4
ArtTile_ArtNem_SpikyThing             = $030C
ArtTile_ArtNem_BurnerLid              = $032C
ArtTile_ArtNem_StripedBlocksVert      = $0332
ArtTile_ArtNem_Oilfall                = $0336
ArtTile_ArtNem_Oilfall2               = $0346
ArtTile_ArtNem_BallThing              = $0354
ArtTile_ArtNem_LaunchBall             = $0368
ArtTile_ArtNem_OOZPlatform            = $039D
ArtTile_ArtNem_PushSpring             = $03C5
ArtTile_ArtNem_OOZSwingPlat           = $03E3
ArtTile_ArtNem_StripedBlocksHoriz     = $03FF
ArtTile_ArtNem_OOZFanHoriz            = $0403
ArtTile_ArtNem_Aquis                  = $0500
ArtTile_ArtNem_Octus                  = $0538

; MCZ
ArtTile_ArtNem_Flasher                = $03A8
ArtTile_ArtNem_Crawlton               = $03C0
ArtTile_ArtNem_Crate                  = $03D4
ArtTile_ArtNem_MCZCollapsePlat        = $03F4
ArtTile_ArtNem_VineSwitch             = $040E
ArtTile_ArtNem_VinePulley             = $041E
ArtTile_ArtNem_MCZGateLog             = $043C

; CNZ
ArtTile_ArtNem_Crawl                  = $8340
ArtTile_ArtNem_BigMovingBlock         = $036C
ArtTile_ArtNem_CNZSnake               = $037C
ArtTile_ArtNem_CNZBonusSpike          = $0380
ArtTile_ArtNem_CNZElevator            = $0384
ArtTile_ArtNem_CNZCage                = $0388
ArtTile_ArtNem_CNZHexBumper           = $0394
ArtTile_ArtNem_CNZRoundBumper         = $039A
ArtTile_ArtNem_CNZFlipper             = $03B2
ArtTile_ArtNem_CNZMiniBumper          = $03E6
ArtTile_ArtNem_CNZDiagPlunger         = $0402
ArtTile_ArtNem_CNZVertPlunger         = $0422

; Specific to 1p CNZ
ArtTile_ArtUnc_CNZFlipTiles_1         = $0330
ArtTile_ArtUnc_CNZFlipTiles_2         = $0540
ArtTile_ArtUnc_CNZSlotPics_1          = $0550
ArtTile_ArtUnc_CNZSlotPics_2          = $0560
ArtTile_ArtUnc_CNZSlotPics_3          = $0570

; Specific to 2p CNZ
ArtTile_ArtUnc_CNZFlipTiles_1_2p      = $0330
ArtTile_ArtUnc_CNZFlipTiles_2_2p      = $0740
ArtTile_ArtUnc_CNZSlotPics_1_2p       = $0750
ArtTile_ArtUnc_CNZSlotPics_2_2p       = $0760
ArtTile_ArtUnc_CNZSlotPics_3_2p       = $0770

; CPZ
ArtTile_ArtUnc_CPZAnimBack            = $0370
ArtTile_ArtNem_CPZMetalThings         = $0373
ArtTile_ArtNem_ConstructionStripes_2  = $0394
ArtTile_ArtNem_CPZBooster             = $039C
ArtTile_ArtNem_CPZElevator            = $03A0
ArtTile_ArtNem_CPZAnimatedBits        = $03B0
ArtTile_ArtNem_CPZTubeSpring          = $03E0
ArtTile_ArtNem_CPZStairBlock          = $0418
ArtTile_ArtNem_CPZMetalBlock          = $0430
ArtTile_ArtNem_CPZDroplet             = $043C
ArtTile_ArtNem_Grabber                = $0500
ArtTile_ArtNem_Spiny                  = $052D

; DEZ
ArtTile_ArtUnc_DEZAnimBack            = $0326
ArtTile_ArtNem_ConstructionStripes_1  = $0328

; ARZ
ArtTile_ArtNem_ARZBarrierThing        = $03F8
ArtTile_ArtNem_Leaves                 = $0410
ArtTile_ArtNem_ArrowAndShooter        = $0417
ArtTile_ArtUnc_Waterfall3             = $0428
ArtTile_ArtUnc_Waterfall2             = $042C
ArtTile_ArtUnc_Waterfall1_1           = $0430
ArtTile_ArtNem_Whisp                  = $0500
ArtTile_ArtNem_Grounder               = $0509
ArtTile_ArtNem_ChopChop               = $053B
ArtTile_ArtUnc_Waterfall1_2           = $0557
ArtTile_ArtNem_BigBubbles             = $055B

; ---------------------------------------------------------------------------
; Bosses
; Common tiles for some bosses (any for which no eggpod tiles are defined,
; except for WFZ and DEZ bosses).
ArtTile_ArtNem_Eggpod_4               = $0500
; Common tiles for all bosses.
ArtTile_ArtNem_FieryExplosion         = $0580

; CPZ boss
ArtTile_ArtNem_EggpodJets_1           = $0418
ArtTile_ArtNem_Eggpod_3               = $0420
ArtTile_ArtNem_CPZBoss                = $0500
ArtTile_ArtNem_BossSmoke_1            = $0570

; GHZ boss
ArtTile_ArtNem_Eggpod_1               = $03A0
ArtTile_ArtNem_GHZBoss                = $0400
ArtTile_ArtNem_EggChoppers            = $056C

; HTZ boss
ArtTile_ArtNem_Eggpod_2               = $03C1
ArtTile_ArtNem_HTZBoss                = $0421
ArtTile_ArtNem_BossSmoke_2            = $05E4

; ARZ boss
ArtTile_ArtNem_ARZBoss                = $03E0

; MCZ boss
ArtTile_ArtNem_MCZBoss                = $03C0
ArtTile_ArtUnc_FallingRocks           = $0560

; CNZ boss
ArtTile_ArtNem_CNZBoss                = $0407
ArtTile_ArtNem_CNZBoss_Fudge          = ArtTile_ArtNem_CNZBoss - $60 ; Badly reused mappings...

; MTZ boss
ArtTile_ArtNem_MTZBoss                = $037C
ArtTile_ArtNem_EggpodJets_2           = $0560

; OOZ boss
ArtTile_ArtNem_OOZBoss                = $038C

; WFZ and DEZ
ArtTile_ArtNem_RobotnikUpper          = $0500
ArtTile_ArtNem_RobotnikRunning        = $0518
ArtTile_ArtNem_RobotnikLower          = $0564

; WFZ boss
ArtTile_ArtNem_WFZBoss                = $0379

; DEZ
ArtTile_ArtNem_DEZBoss                = $0330
ArtTile_ArtNem_DEZWindow              = $0378
ArtTile_ArtNem_SilverSonic            = $0380
ArtTile_Player_3                      = $0795
; ---------------------------------------------------------------------------
; Universal locations.

; Animals.
ArtTile_ArtNem_Animal_1               = $0580
ArtTile_ArtNem_Animal_2               = $0594

; Game over.
ArtTile_ArtNem_Game_Over              = $04DE

; Titlecard.
ArtTile_ArtNem_TitleCard              = $0580
ArtTile_LevelName                     = $05DE

; End of level.
ArtTile_ArtNem_Signpost               = $0434
ArtTile_HUD_Bonus_Score               = $0520
ArtTile_ArtNem_Perfect                = $0540
ArtTile_ArtNem_ResultsText            = $05B0 ;5B0
ArtTile_ArtUnc_Signpost               = $05E8
ArtTile_ArtNem_MiniCharacter          = $05F4
ArtTile_ArtNem_Capsule                = $0494
ArtTile_ArtNem_Sonic1_Capsule         = $0400

; Tornado.
ArtTile_ArtNem_Tornado                = $0500
ArtTile_ArtNem_TornadoThruster        = $0561

; Some common objects; these are loaded on all aquatic levels.
ArtTile_ArtNem_Explosion              = $05A4
ArtTile_ArtNem_Bubbles                = $05E8
ArtTile_ArtNem_SuperSonic_stars       = $05F2

; Universal (used on all standard levels).
ArtTile_ArtNem_Checkpoint             = $047C
ArtTile_ArtNem_TailsDust              = $04DF
ArtTile_ArtNem_SonicDust              = $04EF
;ArtTile_ArtNem_SonicDust              = $05E8
ArtTile_ArtNem_Numbers                = $04AC
ArtTile_ArtNem_Shield                 = $04BE
ArtTile_Shield                        = $04BE
;ArtUnc_FireShield                     = $04BE
ArtTile_ArtNem_Invincible_stars       = $04BE
ArtTile_ArtNem_Powerups               = $0680
ArtTile_ArtNem_Ring                   = $06BC
ArtTile_ArtNem_HUD                    = ArtTile_ArtNem_Powerups + $4A
ArtTile_ArtUnc_Sonic                  = $0780
ArtTile_ArtUnc_Tails                  = $079F
ArtTile_ArtUnc_Tails_Tails            = $07AF

; ---------------------------------------------------------------------------
; HUD. The HUD components are linked in a chain, and linked to
; power-ups, because the mappings of monitors and lives counter(s)
; depend on one another. If you want to alter these (for example,
; because you need the VRAM for something else), you will probably
; have to edit the mappings (or move the power-ups and HUD as a
; single block unit).
ArtTile_HUD_Score_E                   = ArtTile_ArtNem_HUD + $18
ArtTile_HUD_Score                     = ArtTile_HUD_Score_E + 2
ArtTile_HUD_Rings                     = ArtTile_ArtNem_HUD + $30
ArtTile_HUD_Minutes                   = ArtTile_ArtNem_HUD + $28
ArtTile_HUD_Seconds                   = ArtTile_HUD_Minutes + 4
ArtTile_ArtUnc_2p_life_counter        = ArtTile_ArtNem_HUD + $2A
ArtTile_ArtUnc_2p_life_counter_lives  = ArtTile_ArtUnc_2p_life_counter + 9
ArtTile_ArtNem_life_counter           = ArtTile_ArtNem_HUD + $10A
ArtTile_ArtNem_life_counter_lives     = ArtTile_ArtNem_life_counter + 9

; ---------------------------------------------------------------------------
; 2p-mode HUD.
ArtTile_Art_HUD_Text_2P               = ArtTile_ArtNem_HUD
ArtTile_Art_HUD_Numbers_2P            = ArtTile_HUD_Score_E

; ---------------------------------------------------------------------------
; Unused objects, objects with mappings never loaded, objects with
; missing mappings and/or tiles, objects whose mappings and/or tiles
; are never loaded.
ArtTile_ArtNem_MZ_Platform            = $02B8
ArtTile_ArtUnc_HPZPulseOrb_1          = $02E8
ArtTile_ArtUnc_HPZPulseOrb_2          = $02F0
ArtTile_ArtUnc_HPZPulseOrb_3          = $02F8
ArtTile_ArtNem_HPZ_Bridge             = $0300
ArtTile_ArtNem_HPZ_Waterfall          = $0315
ArtTile_ArtNem_HPZPlatform            = $034A
ArtTile_ArtNem_HPZOrb                 = $035A
ArtTile_ArtNem_HPZ_Emerald            = $0382
ArtTile_ArtNem_GHZ_Spiked_Log         = $0564
ArtTile_ArtNem_Unknown                = $03FA
ArtTile_ArtNem_BigRing                = $03B8
ArtTile_ArtNem_FloatPlatform          = $0418
ArtTile_ArtNem_BigRing_Flash          = $0500
ArtTile_ArtNem_EndPoints              = $04B6
ArtTile_ArtNem_BreakWall              = $0466
ArtTile_ArtNem_GHZ_Purple_Rock        = $0494
ArtTile_ArtNem_motobug                = $0439
ArtTile_ArtNem_newtorn                = $03FE
ArtTile_Player_1                      = $0780
ArtTile_Player_2                      = $06A0
ArtTile_Player_2_Tail                 = $06B0
;P1_character :=			ramaddr( $FFFFFFDA ) ; byte ; 0 := Sonic, 1 := Tails, 2 := Knuckles
;P2_character :=			ramaddr( $FFFFFFDB ) ; byte



