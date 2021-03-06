LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;

PACKAGE FISC_DEFINES IS
	---------- FISC ISA DEFINES -----------
	constant FISC_INSTRUCTION_SZ    : integer := 32; -- Each instruction is 32 bits wide
	constant FISC_INTEGER_SZ        : integer := 64; -- Each integer value is 64 bits wide
	constant FISC_REGISTER_COUNT    : integer := 32; -- The ISA uses 32 registers, each is 64 bits wide
	
	-- Instruction Formats: --
	constant R_FMT_OPCODE_SZ        : integer := 11; -- The opcode is composed of 11 bits (maximum)
	constant R_FMT_RM_SZ            : integer := 5;
	constant R_FMT_SHAMT_SZ         : integer := 6;
	constant R_FMT_RN_SZ            : integer := 5;
	constant R_FMT_RD_SZ            : integer := 5;
	
	constant I_FMT_OPCODE_SZ        : integer := 10;
	constant I_FMT_ALUI_SZ          : integer := 12;
	constant I_FMT_RN_SZ            : integer := 5;
	constant I_FMT_RD_SZ            : integer := 5;
	
	constant D_FMT_OPCODE_SZ        : integer := 11;
	constant D_FMT_DT_ADDR_SZ       : integer := 9;
	constant D_FMT_OP_SZ            : integer := 2;
	constant D_FMT_RN_SZ            : integer := 5;
	constant D_FMT_RT_SZ            : integer := 5;
	
	constant B_FMT_OPCODE_SZ        : integer := 6;
	constant B_FMT_BR_ADDR          : integer := 26;
	
	constant CB_FMT_OPCODE_SZ       : integer := 8;
	constant CB_FMT_COND_BR_ADDR_SZ : integer := 19;
	constant CB_FMT_RT_SZ           : integer := 5;
	
	constant IW_FMT_OPCODE_SZ       : integer := 11;
	constant IW_FMT_MOVI_SZ         : integer := 16;
	constant IW_FMT_RD_SZ           : integer := 5;
	
	-- Instruction Opcodes: --
	constant ADD    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"458"; -- Add --
	constant ADDI   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"488"; -- Add Immediate --
	constant ADDIS  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"588"; -- Add Immediate and Set flags --
	constant ADDS   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"558"; -- Add and Set Flags --
	constant AND_I  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"450"; -- Logical And --
	constant ANDI   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"490"; -- Logical And Immediate --
	constant ANDIS  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"790"; -- Logical And Immediate and Set flags --
	constant ANDS   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"750"; -- Logical And and Set Flags --
	constant B      : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"0A0"; -- Branch unconditionally --
	constant BEQ    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BNE    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BLT    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BGT    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BGE    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BLO    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BLS    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BHI    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BHS    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BMI    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BPL    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BVS    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BVC    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"2A0"; -- Branch conditionally --
	constant BL     : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"4A0"; -- Branch unconditionally and link (callee address) --
	constant BR     : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"6B0"; -- Branch unconditionally using register's value as the address --
	constant CBNZ   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"5A8"; -- Conditional Branch if Not Zero --
	constant CBZ    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"5A0"; -- Conditional Branch if Zero --
	constant EOR    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"650"; -- Logical Exclusive Or --
	constant EORI   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"690"; -- Logical Exclusive Or Immediate --
	constant LDUR   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"7C2"; -- Load double word (64 bits) into Register with Unscaled Offset (offset is of atomic size/not aligned, e.g. 1 byte) --
	constant LDURB  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"1C2"; -- Load Byte into Register with Unscalled Offset --
	constant LDURH  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"3C2"; -- Load Half Word (16 bits) into Register with Unscaled Offset --
	constant LDURSW : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"5C4"; -- Load Signed Word (32 bits signed) into Register with Unscaled Offset --
	constant LDXR   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"642"; -- Load Exclusive Register --
	constant LSL    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"69B"; -- Logical Shift Left --
	constant LSR    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"69A"; -- Logical Shift Right --
	constant MOVK   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"794"; -- Move Wide with Keep (without removing the 1's from the register) --
	constant MOVZ   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"694"; -- Move Wide with Zero (removes all 1's) --
	constant ORR    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"550"; -- Logical Inclusive Or --
	constant ORRI   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"590"; -- Logical Inclusive Or Immediate --
	constant STUR   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"7C0"; -- Store Register's Double Word (64 bits) into Memory with Unscaled Offset (on the mem's address) --
	constant STURB  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"1C0"; -- Store Register's Byte into Memory with Unscaled Offset --
	constant STURH  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"3C0"; -- Store Register's Half Word (16 bits) into Memory with Unscaled Offset --
	constant STURW  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"5C0"; -- Store Register's Word (32 bits) into Memory with Unscaled Offset --
	constant STXR   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"640"; -- Store Exclusive Register --
	constant SUB    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"658"; -- Subtract --
	constant SUBI   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"688"; -- Subtract Immediate  --
	constant SUBIS  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"788"; -- Subtract Immediate and Set Flags --
	constant SUBS   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"758"; -- Subtract and Set Flags --
	constant MUL    : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"4D8"; -- Multiply --
	constant SDIV   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"4D6"; -- Signed Divide --
	constant SMULH  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"4DA"; -- Signed Multiply High --
	constant UDIV   : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"4D6"; -- Unsigned Divide --
	constant UMULH  : std_logic_vector(R_FMT_OPCODE_SZ downto 0) := x"4DE"; -- Unsigned Multiply High --
	---------------------------------------
	
	---------- MICROCODE DEFINES ----------
	constant MICROCODE_CTRL_WIDTH           : integer := 32; -- The width of the control bus that will be connected to the pipeline
	constant MICROCODE_FUNC_WIDTH           : integer := 32;
	constant MICROCODE_CTRL_DEPTH           : integer := 80;
	constant MICROCODE_SEGMENT_MAXCOUNT     : integer := 80;
	constant MICROCODE_CTRL_DEPTH_ENC       : integer := integer(ceil(log2(real(MICROCODE_CTRL_DEPTH)))) - 1;
	constant MICROCODE_SEGMENT_MAXCOUNT_ENC : integer := integer(ceil(log2(real(MICROCODE_SEGMENT_MAXCOUNT)))) - 1;
	constant MICROCODE_CALLSTACK_SIZE       : integer := 80;
	---------------------------------------
	
	---------------- L1 INSTRUCTION CACHE DEFINES -------------------
	constant L1_IC_ADDR_WIDTH    : integer := 64; -- Size of the address to be used on the L1 Cache and RAM
	constant L1_IC_WAYCOUNT      : integer := 1;  -- Associativity level
	constant L1_IC_DATABLOCKSIZE : integer := 32; -- Size of the data field (in bytes)
	constant L1_IC_SETCOUNT      : integer := 32; -- Each set contains L1_IC_DATABLOCKSIZE * L1_IC_WAYCOUNT bytes. Therefore, the total cache size (in bytes) is => L1_IC_SETCOUNT * L1_IC_DATABLOCKSIZE * L1_IC_WAYCOUNT
	
	constant L1_IC_BYTE_OFF      : integer := integer(ceil(log2(real(L1_IC_DATABLOCKSIZE / 4)))) + 2;
	constant L1_IC_TAGWIDTH      : integer := L1_IC_ADDR_WIDTH - integer(ceil(log2(real(L1_IC_SETCOUNT)))) - L1_IC_BYTE_OFF;
	constant L1_IC_INDEXOFF      : integer := L1_IC_ADDR_WIDTH - L1_IC_TAGWIDTH - 1;
	constant L1_IC_INDEXWIDTH    : integer := integer(ceil(log2(real(L1_IC_SETCOUNT))));
	constant L1_IC_WORDOFF       : integer := integer(ceil(log2(real(L1_IC_DATABLOCKSIZE/(FISC_INSTRUCTION_SZ/8))))) + 2;
	-----------------------------------------------------------------
	
	-- CPU Finite State Machine --
	constant s_fetching   : std_logic_vector(2 downto 0) := "000"; -- Fetching Instructions normally (PC = PC + 4)
	constant s_savectx    : std_logic_vector(2 downto 0) := "001"; -- Saving context (SPSR = CPSR (disables ints), ELR = PC)
	constant s_changemode : std_logic_vector(2 downto 0) := "010"; -- Change CPU mode (CPSR(2 downto 0) = IRQ/SIRQ/EX mode)
	constant s_jmpint     : std_logic_vector(2 downto 0) := "011"; -- Jumping into the Interrupt vector (PC = IVP + INT_ID)
	constant s_jmpex      : std_logic_vector(2 downto 0) := "100"; -- Jumping into the Exception vector (PC = EVP + ESR)
	constant s_runint     : std_logic_vector(2 downto 0) := "101"; -- Running Interrupt Handler (PC = PC + 4)
	constant s_runex      : std_logic_vector(2 downto 0) := "110"; -- Running Exception Handler (PC = PC + 4)
	constant s_restorectx : std_logic_vector(2 downto 0) := "111"; -- Restoring the context (PC = ELR, CPSR = SPSR (enables ints))
	------------------------------
	
	------------------
	-- Misc Functions:
	------------------
	procedure DEBUG (debug_msg : in string);
	function  itoa  (vector : std_logic_vector) return string;
	function  uns   (vector : std_logic_vector) return unsigned;
	function  idx   (vector : std_logic_vector) return integer;
	------------------
END FISC_DEFINES;

PACKAGE BODY FISC_DEFINES IS
	
	-- Output debug message to console:
	procedure DEBUG (
		debug_msg : in string	
	) is begin
		report lf & "** >> " & debug_msg & lf & "** END OF NOTICE **";
	end DEBUG;
	
	-- Convert unsigned into string
	function itoa(vector : std_logic_vector) return string
	is begin
		return INTEGER'IMAGE(to_integer(uns(vector)));
	end itoa;
	
	-- Convert std_logic_vector into unsigned
	function uns(vector : std_logic_vector) return unsigned
	is begin
		return unsigned(vector);
	end uns;
	
	-- Convert std_logic_vector into integer. This function is being used while indexing arrays
	function idx(vector : std_logic_vector) return integer
	is begin
		return to_integer(uns(vector));
	end idx;
	
END FISC_DEFINES;