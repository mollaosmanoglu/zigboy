// TODO: Test with minimal ROM ---> fix self.registers.pc, fix opcodes, add loops in main.
// TODO: Clean up code thus far add error handling, and move to phase 4.
const memory = @import("memory");

const Registers = struct {
    a: u8 = 0,
    b: u8 = 0,
    c: u8 = 0,
    d: u8 = 0,
    e: u8 = 0,
    f: u8 = 0,
    h: u8 = 0,
    l: u8 = 0,
    sp: u16 = 0,
    pc: u16 = 0,
};

pub const CPU = struct {
    registers: Registers,
    //init
    pub fn init() CPU {
        return .{ .registers = .{} };
    }
    //HELPERS
    fn combine8bits(high: u8, low: u8) u16 {
        return (@as(u16, high) << 8) | @as(u16, low);
    }
    fn deconstruct16bit(value: u16) .{ u8, u8 } {
        const high: u8 = @truncate(value >> 8);
        const low: u8 = @truncate(value);
        return .{ high, low };
    }
    // step function
    pub fn step(self: *CPU, mem: *memory.Memory) !void {
        const opcode = mem.readByte(self.registers.pc);
        switch (opcode) {
            0x00 => return, // core
            0x01 => { // core
                const low: u16 = @as(u16, mem.readByte(self.registers.pc + 1));
                const high: u16 = @as(u16, mem.readByte(self.registers.pc + 2));
                self.setBC((high << 8) | low);
            },
            0x02 => mem.writeByte(self.getBC(), self.registers.a), // core
            0x03 => self.setBC(self.getBC() + 1), // core
            0x04 => return,
            0x05 => return,
            0x06 => self.registers.b = mem.readByte(self.registers.pc + 1), // core
            0x07 => return,
            0x08 => return,
            0x09 => return,
            0x0A => return,
            0x0B => self.setBC(self.getBC() - 1), // core
            0x0C => return,
            0x0D => return,
            0x0E => self.registers.c = mem.readByte(self.registers.pc + 1), // core
            0x0F => return,
            0x10 => return,
            0x11 => return,
            0x12 => return,
            0x13 => return,
            0x14 => return,
            0x15 => return,
            0x16 => self.registers.d = mem.readByte(self.registers.pc + 1), // core
            0x17 => return,
            0x18 => {
                const offset: i8 = @bitCast(mem.readByte(self.registers.pc + 1));
                self.registers.pc = self.registers.pc + @as(u16, offset) + 2;
            }, // core
            0x19 => return,
            0x1A => return,
            0x1B => self.setDE(self.getDE() - 1), // core
            0x1C => return,
            0x1D => return,
            0x1E => self.registers.e = mem.readByte(self.registers.pc + 1), // core
            0x1F => return,
            0x20 => {
                if (self.getZFlag() == 0) {
                    const offset: i8 = @bitCast(mem.readByte(self.registers.pc + 1));
                    self.registers.pc = self.registers.pc + @as(u16, offset) + 2;
                } else {
                    self.registers.pc = self.registers.pc + 2;
                }
            }, // core
            0x21 => return,
            0x22 => {
                mem.writeByte(self.getHL(), self.registers.a);
                self.setHL(self.getHL() - 1);
            }, // core
            0x23 => self.setHL(self.getHL() + 1), // core
            0x24 => return,
            0x25 => return,
            0x26 => self.registers.h = mem.readByte(self.registers.pc + 1), // core
            0x27 => return,
            0x28 => {
                if (self.getZFlag() == 1) {
                    const offset: i8 = @bitCast(mem.readByte(self.registers.pc + 1));
                    self.registers.pc = self.registers.pc + @as(u16, offset) + 2;
                } else {
                    self.registers.pc = self.registers.pc + 2;
                }
            }, // core
            0x29 => return,
            0x2A => {
                mem.writeByte(self.getHL(), self.registers.a);
                self.setHL(self.getHL() - 1);
            }, // core
            0x2B => self.setHL(self.getHL() - 1), // core
            0x2C => return,
            0x2D => return,
            0x2E => self.registers.l = mem.readByte(self.registers.pc + 1),
            0x2F => return,
            0x30 => {
                if (self.getCFlag() == 0) {
                    const offset: i8 = @bitCast(mem.readByte(self.registers.pc + 1));
                    self.registers.pc = self.registers.pc + @as(u16, offset) + 2;
                } else {
                    self.registers.pc = self.registers.pc + 2;
                }
            }, // core
            0x31 => return,
            0x32 => {
                mem.writeByte(self.getHL(), self.registers.a);
                self.setHL(self.getHL() - 1);
            }, // core
            0x33 => return,
            0x34 => return,
            0x35 => return,
            0x36 => mem.writeByte(self.getHL(), mem.readByte(self.registers.pc + 1)), // core
            0x37 => return,
            0x38 => {
                if (self.getCFlag() == 0) {
                    const offset: i8 = @bitCast(mem.readByte(self.registers.pc + 1));
                    self.registers.pc = self.registers.pc + @as(u16, offset) + 2;
                } else {
                    self.registers.pc = self.registers.pc + 2;
                }
            }, // core
            0x39 => return,
            0x3A => {
                self.registers.a = mem.readByte(self.getHL());
                self.setHL(self.getHL() - 1);
            }, // core
            0x3B => return,
            0x3C => return,
            0x3D => return,
            0x3E => self.registers.a = mem.readByte(self.registers.pc + 1), // core
            0x3F => return,
            0x40 => return,
            0x41 => return,
            0x42 => return,
            0x43 => return,
            0x44 => return,
            0x45 => return,
            0x46 => return,
            0x47 => return,
            0x48 => return,
            0x49 => return,
            0x4A => return,
            0x4B => return,
            0x4C => return,
            0x4D => return,
            0x4E => return,
            0x4F => return,
            0x50 => return,
            0x51 => return,
            0x52 => return,
            0x53 => return,
            0x54 => return,
            0x55 => return,
            0x56 => return,
            0x57 => return,
            0x58 => return,
            0x59 => return,
            0x5A => return,
            0x5B => return,
            0x5C => return,
            0x5D => return,
            0x5E => return,
            0x5F => return,
            0x60 => return,
            0x61 => return,
            0x62 => return,
            0x63 => return,
            0x64 => return,
            0x65 => return,
            0x66 => return,
            0x67 => return,
            0x68 => return,
            0x69 => return,
            0x6A => return,
            0x6B => return,
            0x6C => return,
            0x6D => return,
            0x6E => return,
            0x6F => return,
            0x70 => return,
            0x71 => return,
            0x72 => return,
            0x73 => return,
            0x74 => return,
            0x75 => return,
            0x76 => return,
            0x77 => mem.writeByte(self.getHL(), self.registers.a), // core
            0x78 => return,
            0x79 => return,
            0x7A => return,
            0x7B => return,
            0x7C => return,
            0x7D => return,
            0x7E => self.registers.a = mem.readByte(self.getHL()), // core
            0x7F => return,
            0x80 => self.registers.a = self.registers.a + self.registers.b,
            0x81 => return,
            0x82 => return,
            0x83 => return,
            0x84 => return,
            0x85 => return,
            0x86 => return,
            0x87 => return,
            0x88 => return,
            0x89 => return,
            0x8A => return,
            0x8B => return,
            0x8C => return,
            0x8D => return,
            0x8E => return,
            0x8F => return,
            0x90 => return,
            0x91 => return,
            0x92 => return,
            0x93 => return,
            0x94 => return,
            0x95 => return,
            0x96 => return,
            0x97 => return,
            0x98 => return,
            0x99 => return,
            0x9A => return,
            0x9B => return,
            0x9C => return,
            0x9D => return,
            0x9E => return,
            0x9F => return,
            0xA0 => return,
            0xA1 => return,
            0xA2 => return,
            0xA3 => return,
            0xA4 => return,
            0xA5 => return,
            0xA6 => return,
            0xA7 => return,
            0xA8 => return,
            0xA9 => return,
            0xAA => return,
            0xAB => return,
            0xAC => return,
            0xAD => return,
            0xAE => return,
            0xAF => return,
            0xB0 => return,
            0xB1 => return,
            0xB2 => return,
            0xB3 => return,
            0xB4 => return,
            0xB5 => return,
            0xB6 => return,
            0xB7 => return,
            0xB8 => return,
            0xB9 => return,
            0xBA => return,
            0xBB => return,
            0xBC => return,
            0xBD => return,
            0xBE => return,
            0xBF => return,
            0xC0 => return,
            0xC1 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                const combined = combine8bits(high, low);
                self.setBC(combined);
                self.registers.sp = self.registers.sp + 2;
            }, // core
            0xC2 => return,
            0xC3 => { // core
                const low: u16 = @as(u16, mem.readByte(self.registers.pc + 1));
                const high: u16 = @as(u16, mem.readByte(self.registers.pc + 2));
                self.registers.pc = (high << 8) | low;
            },
            0xC4 => return,
            0xC5 => {
                const high, const low = deconstruct16bit(self.getBC());
                mem.writeByte(self.registers.sp - 1, high);
                mem.writeByte(self.registers.sp - 2, low);
                self.registers.sp = self.registers.sp - 2;
            }, // core
            0xC6 => return,
            0xC7 => return,
            0xC8 => return,
            0xC9 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                self.registers.sp = self.registers.sp + 2;
                const combined: u16 = combine8bits(high, low);
                self.registers.pc = combined;
            }, // core
            0xCA => return,
            0xCB => return,
            0xCC => return,
            0xCD => return,
            0xCE => return,
            0xCF => return,
            0xD0 => return,
            0xD1 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                const combined = combine8bits(high, low);
                self.setDE(combined);
                self.registers.sp = self.registers.sp + 2;
            }, // core
            0xD2 => return,
            0xD3 => return,
            0xD4 => return,
            0xD5 => {
                const high, const low = deconstruct16bit(self.getDE());
                mem.writeByte(self.registers.sp - 1, high);
                mem.writeByte(self.registers.sp - 2, low);
                self.registers.sp = self.registers.sp - 2;
            }, // core
            0xD6 => return,
            0xD7 => return,
            0xD8 => return,
            0xD9 => return,
            0xDA => return,
            0xDB => return,
            0xDC => return,
            0xDD => return,
            0xDE => return,
            0xDF => return,
            0xE0 => return,
            0xE1 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                const combined = combine8bits(high, low);
                self.setHL(combined);
                self.registers.sp = self.registers.sp + 2;
            }, // core
            0xE2 => return,
            0xE3 => return,
            0xE4 => return,
            0xE5 => {
                const high, const low = deconstruct16bit(self.getHL());
                mem.writeByte(self.registers.sp - 1, high);
                mem.writeByte(self.registers.sp - 2, low);
                self.registers.sp = self.registers.sp - 2;
            }, // core
            0xE6 => return,
            0xE7 => return,
            0xE8 => return,
            0xE9 => return,
            0xEA => return,
            0xEB => return,
            0xEC => return,
            0xED => return,
            0xEE => return,
            0xEF => return,
            0xF0 => return,
            0xF1 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                const combined = combine8bits(high, low);
                self.setAF(combined);
                self.registers.sp = self.registers.sp + 2;
            }, // core
            0xF2 => return,
            0xF3 => return,
            0xF4 => return,
            0xF5 => {
                const high, const low = deconstruct16bit(self.getAF());
                mem.writeByte(self.registers.sp - 1, high);
                mem.writeByte(self.registers.sp - 2, low);
                self.registers.sp = self.registers.sp - 2;
            }, // core
            0xF6 => return,
            0xF7 => return,
            0xF8 => return,
            0xF9 => return,
            0xFA => return,
            0xFB => return,
            0xFC => return,
            0xFD => return,
            0xFE => return,
            0xFF => return,
        }
    }
    // REGISTER PAIRS (private helpers)
    // getters
    fn getAF(self: CPU) u16 {
        return combine8bits(self.registers.a, self.registers.f);
    }
    fn getBC(self: CPU) u16 {
        return combine8bits(self.registers.b, self.registers.c);
    }
    fn getDE(self: CPU) u16 {
        return combine8bits(self.registers.d, self.registers.e);
    }
    fn getHL(self: CPU) u16 {
        return combine8bits(self.registers.h, self.registers.l);
    }
    // setters
    fn setAF(self: *CPU, value: u16) void {
        const high, const low = deconstruct16bit(value);
        self.registers.a = high;
        self.registers.f = low & 0xF0;
    }
    fn setBC(self: *CPU, value: u16) void {
        const high, const low = deconstruct16bit(value);
        self.registers.b = high;
        self.registers.c = low;
    }
    fn setDE(self: *CPU, value: u16) void {
        const high, const low = deconstruct16bit(value);
        self.registers.d = high;
        self.registers.e = low;
    }
    fn setHL(self: *CPU, value: u16) void {
        const high, const low = deconstruct16bit(value);
        self.registers.h = high;
        self.registers.l = low;
    }
    // FLAG REGISTERS (private helpers)
    // getters
    fn getZFlag(self: CPU) bool {
        const mask: u8 = 0x80;
        return (self.registers.f & mask) != 0;
    }
    fn getNFlag(self: CPU) bool {
        const mask: u8 = 0x40;
        return (self.registers.f & mask) != 0;
    }
    fn getHFlag(self: CPU) bool {
        const mask: u8 = 0x20;
        return (self.registers.f & mask) != 0;
    }
    fn getCFlag(self: CPU) bool {
        const mask: u8 = 0x10;
        return (self.registers.f & mask) != 0;
    }
    // setters
    fn setZFlag(self: *CPU, value: bool) void {
        self.registers.f = self.registers.f & ~@as(u8, 0x80);
        self.registers.f = self.registers.f | @as(u8, @intFromBool(value) << 7);
    }
    fn setNFlag(self: *CPU, value: bool) void {
        self.registers.f = self.registers.f & ~@as(u8, 0x40);
        self.registers.f = self.registers.f | @as(u8, @intFromBool(value) << 6);
    }
    fn setHFlag(self: *CPU, value: bool) void {
        self.registers.f = self.registers.f & ~@as(u8, 0x20);
        self.registers.f = self.registers.f | @as(u8, @intFromBool(value) << 5);
    }
    fn setCFlag(self: *CPU, value: bool) void {
        self.registers.f = self.registers.f & ~@as(u8, 0x10);
        self.registers.f = self.registers.f | @as(u8, @intFromBool(value) << 4);
    }
};
