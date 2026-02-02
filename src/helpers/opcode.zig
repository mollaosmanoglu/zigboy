pub const Opcode = struct {
    bytes: u8,
    cycles: u8,
};

pub const OPCODES = [256]Opcode{
    .{ .bytes = 1, .cycles = 4 }, // 0x00 NOP
    .{ .bytes = 3, .cycles = 12 }, // 0x01 LD BC,d16
    .{ .bytes = 1, .cycles = 8 }, // 0x02 LD (BC),A
    .{ .bytes = 1, .cycles = 8 }, // 0x03 INC BC
    .{ .bytes = 1, .cycles = 4 }, // 0x04 INC B
    .{ .bytes = 1, .cycles = 4 }, // 0x05 DEC B
    .{ .bytes = 2, .cycles = 8 }, // 0x06 LD B,d8
    .{ .bytes = 1, .cycles = 4 }, // 0x07 RLCA
    .{ .bytes = 3, .cycles = 20 }, // 0x08 LD (a16),SP
    .{ .bytes = 1, .cycles = 8 }, // 0x09 ADD HL,BC
    .{ .bytes = 1, .cycles = 8 }, // 0x0A LD A,(BC)
    .{ .bytes = 1, .cycles = 8 }, // 0x0B DEC BC
    .{ .bytes = 1, .cycles = 4 }, // 0x0C INC C
    .{ .bytes = 1, .cycles = 4 }, // 0x0D DEC C
    .{ .bytes = 2, .cycles = 8 }, // 0x0E LD C,d8
    .{ .bytes = 1, .cycles = 4 }, // 0x0F RRCA
    .{ .bytes = 2, .cycles = 4 }, // 0x10 STOP
    .{ .bytes = 3, .cycles = 12 }, // 0x11 LD DE,d16
    .{ .bytes = 1, .cycles = 8 }, // 0x12 LD (DE),A
    .{ .bytes = 1, .cycles = 8 }, // 0x13 INC DE
    .{ .bytes = 1, .cycles = 4 }, // 0x14 INC D
    .{ .bytes = 1, .cycles = 4 }, // 0x15 DEC D
    .{ .bytes = 2, .cycles = 8 }, // 0x16 LD D,d8
    .{ .bytes = 1, .cycles = 4 }, // 0x17 RLA
    .{ .bytes = 2, .cycles = 12 }, // 0x18 JR r8
    .{ .bytes = 1, .cycles = 8 }, // 0x19 ADD HL,DE
    .{ .bytes = 1, .cycles = 8 }, // 0x1A LD A,(DE)
    .{ .bytes = 1, .cycles = 8 }, // 0x1B DEC DE
    .{ .bytes = 1, .cycles = 4 }, // 0x1C INC E
    .{ .bytes = 1, .cycles = 4 }, // 0x1D DEC E
    .{ .bytes = 2, .cycles = 8 }, // 0x1E LD E,d8
    .{ .bytes = 1, .cycles = 4 }, // 0x1F RRA
    .{ .bytes = 2, .cycles = 8 }, // 0x20 JR NZ,r8 (12 if taken)
    .{ .bytes = 3, .cycles = 12 }, // 0x21 LD HL,d16
    .{ .bytes = 1, .cycles = 8 }, // 0x22 LD (HL+),A
    .{ .bytes = 1, .cycles = 8 }, // 0x23 INC HL
    .{ .bytes = 1, .cycles = 4 }, // 0x24 INC H
    .{ .bytes = 1, .cycles = 4 }, // 0x25 DEC H
    .{ .bytes = 2, .cycles = 8 }, // 0x26 LD H,d8
    .{ .bytes = 1, .cycles = 4 }, // 0x27 DAA
    .{ .bytes = 2, .cycles = 8 }, // 0x28 JR Z,r8 (12 if taken)
    .{ .bytes = 1, .cycles = 8 }, // 0x29 ADD HL,HL
    .{ .bytes = 1, .cycles = 8 }, // 0x2A LD A,(HL+)
    .{ .bytes = 1, .cycles = 8 }, // 0x2B DEC HL
    .{ .bytes = 1, .cycles = 4 }, // 0x2C INC L
    .{ .bytes = 1, .cycles = 4 }, // 0x2D DEC L
    .{ .bytes = 2, .cycles = 8 }, // 0x2E LD L,d8
    .{ .bytes = 1, .cycles = 4 }, // 0x2F CPL
    .{ .bytes = 2, .cycles = 8 }, // 0x30 JR NC,r8 (12 if taken)
    .{ .bytes = 3, .cycles = 12 }, // 0x31 LD SP,d16
    .{ .bytes = 1, .cycles = 8 }, // 0x32 LD (HL-),A
    .{ .bytes = 1, .cycles = 8 }, // 0x33 INC SP
    .{ .bytes = 1, .cycles = 12 }, // 0x34 INC (HL)
    .{ .bytes = 1, .cycles = 12 }, // 0x35 DEC (HL)
    .{ .bytes = 2, .cycles = 12 }, // 0x36 LD (HL),d8
    .{ .bytes = 1, .cycles = 4 }, // 0x37 SCF
    .{ .bytes = 2, .cycles = 8 }, // 0x38 JR C,r8 (12 if taken)
    .{ .bytes = 1, .cycles = 8 }, // 0x39 ADD HL,SP
    .{ .bytes = 1, .cycles = 8 }, // 0x3A LD A,(HL-)
    .{ .bytes = 1, .cycles = 8 }, // 0x3B DEC SP
    .{ .bytes = 1, .cycles = 4 }, // 0x3C INC A
    .{ .bytes = 1, .cycles = 4 }, // 0x3D DEC A
    .{ .bytes = 2, .cycles = 8 }, // 0x3E LD A,d8
    .{ .bytes = 1, .cycles = 4 }, // 0x3F CCF
    .{ .bytes = 1, .cycles = 4 }, // 0x40 LD B,B
    .{ .bytes = 1, .cycles = 4 }, // 0x41 LD B,C
    .{ .bytes = 1, .cycles = 4 }, // 0x42 LD B,D
    .{ .bytes = 1, .cycles = 4 }, // 0x43 LD B,E
    .{ .bytes = 1, .cycles = 4 }, // 0x44 LD B,H
    .{ .bytes = 1, .cycles = 4 }, // 0x45 LD B,L
    .{ .bytes = 1, .cycles = 8 }, // 0x46 LD B,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x47 LD B,A
    .{ .bytes = 1, .cycles = 4 }, // 0x48 LD C,B
    .{ .bytes = 1, .cycles = 4 }, // 0x49 LD C,C
    .{ .bytes = 1, .cycles = 4 }, // 0x4A LD C,D
    .{ .bytes = 1, .cycles = 4 }, // 0x4B LD C,E
    .{ .bytes = 1, .cycles = 4 }, // 0x4C LD C,H
    .{ .bytes = 1, .cycles = 4 }, // 0x4D LD C,L
    .{ .bytes = 1, .cycles = 8 }, // 0x4E LD C,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x4F LD C,A
    .{ .bytes = 1, .cycles = 4 }, // 0x50 LD D,B
    .{ .bytes = 1, .cycles = 4 }, // 0x51 LD D,C
    .{ .bytes = 1, .cycles = 4 }, // 0x52 LD D,D
    .{ .bytes = 1, .cycles = 4 }, // 0x53 LD D,E
    .{ .bytes = 1, .cycles = 4 }, // 0x54 LD D,H
    .{ .bytes = 1, .cycles = 4 }, // 0x55 LD D,L
    .{ .bytes = 1, .cycles = 8 }, // 0x56 LD D,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x57 LD D,A
    .{ .bytes = 1, .cycles = 4 }, // 0x58 LD E,B
    .{ .bytes = 1, .cycles = 4 }, // 0x59 LD E,C
    .{ .bytes = 1, .cycles = 4 }, // 0x5A LD E,D
    .{ .bytes = 1, .cycles = 4 }, // 0x5B LD E,E
    .{ .bytes = 1, .cycles = 4 }, // 0x5C LD E,H
    .{ .bytes = 1, .cycles = 4 }, // 0x5D LD E,L
    .{ .bytes = 1, .cycles = 8 }, // 0x5E LD E,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x5F LD E,A
    .{ .bytes = 1, .cycles = 4 }, // 0x60 LD H,B
    .{ .bytes = 1, .cycles = 4 }, // 0x61 LD H,C
    .{ .bytes = 1, .cycles = 4 }, // 0x62 LD H,D
    .{ .bytes = 1, .cycles = 4 }, // 0x63 LD H,E
    .{ .bytes = 1, .cycles = 4 }, // 0x64 LD H,H
    .{ .bytes = 1, .cycles = 4 }, // 0x65 LD H,L
    .{ .bytes = 1, .cycles = 8 }, // 0x66 LD H,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x67 LD H,A
    .{ .bytes = 1, .cycles = 4 }, // 0x68 LD L,B
    .{ .bytes = 1, .cycles = 4 }, // 0x69 LD L,C
    .{ .bytes = 1, .cycles = 4 }, // 0x6A LD L,D
    .{ .bytes = 1, .cycles = 4 }, // 0x6B LD L,E
    .{ .bytes = 1, .cycles = 4 }, // 0x6C LD L,H
    .{ .bytes = 1, .cycles = 4 }, // 0x6D LD L,L
    .{ .bytes = 1, .cycles = 8 }, // 0x6E LD L,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x6F LD L,A
    .{ .bytes = 1, .cycles = 8 }, // 0x70 LD (HL),B
    .{ .bytes = 1, .cycles = 8 }, // 0x71 LD (HL),C
    .{ .bytes = 1, .cycles = 8 }, // 0x72 LD (HL),D
    .{ .bytes = 1, .cycles = 8 }, // 0x73 LD (HL),E
    .{ .bytes = 1, .cycles = 8 }, // 0x74 LD (HL),H
    .{ .bytes = 1, .cycles = 8 }, // 0x75 LD (HL),L
    .{ .bytes = 1, .cycles = 4 }, // 0x76 HALT
    .{ .bytes = 1, .cycles = 8 }, // 0x77 LD (HL),A
    .{ .bytes = 1, .cycles = 4 }, // 0x78 LD A,B
    .{ .bytes = 1, .cycles = 4 }, // 0x79 LD A,C
    .{ .bytes = 1, .cycles = 4 }, // 0x7A LD A,D
    .{ .bytes = 1, .cycles = 4 }, // 0x7B LD A,E
    .{ .bytes = 1, .cycles = 4 }, // 0x7C LD A,H
    .{ .bytes = 1, .cycles = 4 }, // 0x7D LD A,L
    .{ .bytes = 1, .cycles = 8 }, // 0x7E LD A,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x7F LD A,A
    .{ .bytes = 1, .cycles = 4 }, // 0x80 ADD A,B
    .{ .bytes = 1, .cycles = 4 }, // 0x81 ADD A,C
    .{ .bytes = 1, .cycles = 4 }, // 0x82 ADD A,D
    .{ .bytes = 1, .cycles = 4 }, // 0x83 ADD A,E
    .{ .bytes = 1, .cycles = 4 }, // 0x84 ADD A,H
    .{ .bytes = 1, .cycles = 4 }, // 0x85 ADD A,L
    .{ .bytes = 1, .cycles = 8 }, // 0x86 ADD A,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x87 ADD A,A
    .{ .bytes = 1, .cycles = 4 }, // 0x88 ADC A,B
    .{ .bytes = 1, .cycles = 4 }, // 0x89 ADC A,C
    .{ .bytes = 1, .cycles = 4 }, // 0x8A ADC A,D
    .{ .bytes = 1, .cycles = 4 }, // 0x8B ADC A,E
    .{ .bytes = 1, .cycles = 4 }, // 0x8C ADC A,H
    .{ .bytes = 1, .cycles = 4 }, // 0x8D ADC A,L
    .{ .bytes = 1, .cycles = 8 }, // 0x8E ADC A,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x8F ADC A,A
    .{ .bytes = 1, .cycles = 4 }, // 0x90 SUB B
    .{ .bytes = 1, .cycles = 4 }, // 0x91 SUB C
    .{ .bytes = 1, .cycles = 4 }, // 0x92 SUB D
    .{ .bytes = 1, .cycles = 4 }, // 0x93 SUB E
    .{ .bytes = 1, .cycles = 4 }, // 0x94 SUB H
    .{ .bytes = 1, .cycles = 4 }, // 0x95 SUB L
    .{ .bytes = 1, .cycles = 8 }, // 0x96 SUB (HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x97 SUB A
    .{ .bytes = 1, .cycles = 4 }, // 0x98 SBC A,B
    .{ .bytes = 1, .cycles = 4 }, // 0x99 SBC A,C
    .{ .bytes = 1, .cycles = 4 }, // 0x9A SBC A,D
    .{ .bytes = 1, .cycles = 4 }, // 0x9B SBC A,E
    .{ .bytes = 1, .cycles = 4 }, // 0x9C SBC A,H
    .{ .bytes = 1, .cycles = 4 }, // 0x9D SBC A,L
    .{ .bytes = 1, .cycles = 8 }, // 0x9E SBC A,(HL)
    .{ .bytes = 1, .cycles = 4 }, // 0x9F SBC A,A
    .{ .bytes = 1, .cycles = 4 }, // 0xA0 AND B
    .{ .bytes = 1, .cycles = 4 }, // 0xA1 AND C
    .{ .bytes = 1, .cycles = 4 }, // 0xA2 AND D
    .{ .bytes = 1, .cycles = 4 }, // 0xA3 AND E
    .{ .bytes = 1, .cycles = 4 }, // 0xA4 AND H
    .{ .bytes = 1, .cycles = 4 }, // 0xA5 AND L
    .{ .bytes = 1, .cycles = 8 }, // 0xA6 AND (HL)
    .{ .bytes = 1, .cycles = 4 }, // 0xA7 AND A
    .{ .bytes = 1, .cycles = 4 }, // 0xA8 XOR B
    .{ .bytes = 1, .cycles = 4 }, // 0xA9 XOR C
    .{ .bytes = 1, .cycles = 4 }, // 0xAA XOR D
    .{ .bytes = 1, .cycles = 4 }, // 0xAB XOR E
    .{ .bytes = 1, .cycles = 4 }, // 0xAC XOR H
    .{ .bytes = 1, .cycles = 4 }, // 0xAD XOR L
    .{ .bytes = 1, .cycles = 8 }, // 0xAE XOR (HL)
    .{ .bytes = 1, .cycles = 4 }, // 0xAF XOR A
    .{ .bytes = 1, .cycles = 4 }, // 0xB0 OR B
    .{ .bytes = 1, .cycles = 4 }, // 0xB1 OR C
    .{ .bytes = 1, .cycles = 4 }, // 0xB2 OR D
    .{ .bytes = 1, .cycles = 4 }, // 0xB3 OR E
    .{ .bytes = 1, .cycles = 4 }, // 0xB4 OR H
    .{ .bytes = 1, .cycles = 4 }, // 0xB5 OR L
    .{ .bytes = 1, .cycles = 8 }, // 0xB6 OR (HL)
    .{ .bytes = 1, .cycles = 4 }, // 0xB7 OR A
    .{ .bytes = 1, .cycles = 4 }, // 0xB8 CP B
    .{ .bytes = 1, .cycles = 4 }, // 0xB9 CP C
    .{ .bytes = 1, .cycles = 4 }, // 0xBA CP D
    .{ .bytes = 1, .cycles = 4 }, // 0xBB CP E
    .{ .bytes = 1, .cycles = 4 }, // 0xBC CP H
    .{ .bytes = 1, .cycles = 4 }, // 0xBD CP L
    .{ .bytes = 1, .cycles = 8 }, // 0xBE CP (HL)
    .{ .bytes = 1, .cycles = 4 }, // 0xBF CP A
    .{ .bytes = 1, .cycles = 8 }, // 0xC0 RET NZ (20 if taken)
    .{ .bytes = 1, .cycles = 12 }, // 0xC1 POP BC
    .{ .bytes = 3, .cycles = 12 }, // 0xC2 JP NZ,a16 (16 if taken)
    .{ .bytes = 3, .cycles = 16 }, // 0xC3 JP a16
    .{ .bytes = 3, .cycles = 12 }, // 0xC4 CALL NZ,a16 (24 if taken)
    .{ .bytes = 1, .cycles = 16 }, // 0xC5 PUSH BC
    .{ .bytes = 2, .cycles = 8 }, // 0xC6 ADD A,d8
    .{ .bytes = 1, .cycles = 16 }, // 0xC7 RST 00H
    .{ .bytes = 1, .cycles = 8 }, // 0xC8 RET Z (20 if taken)
    .{ .bytes = 1, .cycles = 16 }, // 0xC9 RET
    .{ .bytes = 3, .cycles = 12 }, // 0xCA JP Z,a16 (16 if taken)
    .{ .bytes = 2, .cycles = 4 }, // 0xCB PREFIX CB
    .{ .bytes = 3, .cycles = 12 }, // 0xCC CALL Z,a16 (24 if taken)
    .{ .bytes = 3, .cycles = 24 }, // 0xCD CALL a16
    .{ .bytes = 2, .cycles = 8 }, // 0xCE ADC A,d8
    .{ .bytes = 1, .cycles = 16 }, // 0xCF RST 08H
    .{ .bytes = 1, .cycles = 8 }, // 0xD0 RET NC (20 if taken)
    .{ .bytes = 1, .cycles = 12 }, // 0xD1 POP DE
    .{ .bytes = 3, .cycles = 12 }, // 0xD2 JP NC,a16 (16 if taken)
    .{ .bytes = 1, .cycles = 4 }, // 0xD3 ILLEGAL
    .{ .bytes = 3, .cycles = 12 }, // 0xD4 CALL NC,a16 (24 if taken)
    .{ .bytes = 1, .cycles = 16 }, // 0xD5 PUSH DE
    .{ .bytes = 2, .cycles = 8 }, // 0xD6 SUB d8
    .{ .bytes = 1, .cycles = 16 }, // 0xD7 RST 10H
    .{ .bytes = 1, .cycles = 8 }, // 0xD8 RET C (20 if taken)
    .{ .bytes = 1, .cycles = 16 }, // 0xD9 RETI
    .{ .bytes = 3, .cycles = 12 }, // 0xDA JP C,a16 (16 if taken)
    .{ .bytes = 1, .cycles = 4 }, // 0xDB ILLEGAL
    .{ .bytes = 3, .cycles = 12 }, // 0xDC CALL C,a16 (24 if taken)
    .{ .bytes = 1, .cycles = 4 }, // 0xDD ILLEGAL
    .{ .bytes = 2, .cycles = 8 }, // 0xDE SBC A,d8
    .{ .bytes = 1, .cycles = 16 }, // 0xDF RST 18H
    .{ .bytes = 2, .cycles = 12 }, // 0xE0 LDH (a8),A
    .{ .bytes = 1, .cycles = 12 }, // 0xE1 POP HL
    .{ .bytes = 1, .cycles = 8 }, // 0xE2 LD (C),A
    .{ .bytes = 1, .cycles = 4 }, // 0xE3 ILLEGAL
    .{ .bytes = 1, .cycles = 4 }, // 0xE4 ILLEGAL
    .{ .bytes = 1, .cycles = 16 }, // 0xE5 PUSH HL
    .{ .bytes = 2, .cycles = 8 }, // 0xE6 AND d8
    .{ .bytes = 1, .cycles = 16 }, // 0xE7 RST 20H
    .{ .bytes = 2, .cycles = 16 }, // 0xE8 ADD SP,r8
    .{ .bytes = 1, .cycles = 4 }, // 0xE9 JP (HL)
    .{ .bytes = 3, .cycles = 16 }, // 0xEA LD (a16),A
    .{ .bytes = 1, .cycles = 4 }, // 0xEB ILLEGAL
    .{ .bytes = 1, .cycles = 4 }, // 0xEC ILLEGAL
    .{ .bytes = 1, .cycles = 4 }, // 0xED ILLEGAL
    .{ .bytes = 2, .cycles = 8 }, // 0xEE XOR d8
    .{ .bytes = 1, .cycles = 16 }, // 0xEF RST 28H
    .{ .bytes = 2, .cycles = 12 }, // 0xF0 LDH A,(a8)
    .{ .bytes = 1, .cycles = 12 }, // 0xF1 POP AF
    .{ .bytes = 1, .cycles = 8 }, // 0xF2 LD A,(C)
    .{ .bytes = 1, .cycles = 4 }, // 0xF3 DI
    .{ .bytes = 1, .cycles = 4 }, // 0xF4 ILLEGAL
    .{ .bytes = 1, .cycles = 16 }, // 0xF5 PUSH AF
    .{ .bytes = 2, .cycles = 8 }, // 0xF6 OR d8
    .{ .bytes = 1, .cycles = 16 }, // 0xF7 RST 30H
    .{ .bytes = 2, .cycles = 12 }, // 0xF8 LD HL,SP+r8
    .{ .bytes = 1, .cycles = 8 }, // 0xF9 LD SP,HL
    .{ .bytes = 3, .cycles = 16 }, // 0xFA LD A,(a16)
    .{ .bytes = 1, .cycles = 4 }, // 0xFB EI
    .{ .bytes = 1, .cycles = 4 }, // 0xFC ILLEGAL
    .{ .bytes = 1, .cycles = 4 }, // 0xFD ILLEGAL
    .{ .bytes = 2, .cycles = 8 }, // 0xFE CP d8
    .{ .bytes = 1, .cycles = 16 }, // 0xFF RST 38H
};
