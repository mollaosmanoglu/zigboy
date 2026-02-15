//TODO: move to phase 4

const std = @import("std");
const memory = @import("memory.zig");
const cartridge = @import("cartridge.zig");
const opcode_info = @import("helpers/opcode.zig");

const CpuError = error{OpcodeNotFound};

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
    fn combine8Bits(high: u8, low: u8) u16 {
        return (@as(u16, high) << 8) | @as(u16, low);
    }
    fn deconstruct16Bit(value: u16) struct { u8, u8 } {
        const high: u8 = @truncate(value >> 8);
        const low: u8 = @truncate(value);
        return .{ high, low };
    }
    fn relativeJump(pc: u16, mem: *memory.Memory, n: i16) u16 {
        const pcI16: i16 = @bitCast(pc);
        const offset: i8 = @bitCast(mem.readByte(pc + 1));
        const result: i16 = pcI16 + @as(i16, offset) + n;
        return @intCast(result);
    }
    // step function
    pub fn step(self: *CPU, mem: *memory.Memory) void {
        const opcode = mem.readByte(self.registers.pc); //fetch
        const info = opcode_info.OPCODES[opcode]; //decode

        var pcChanged: bool = false;

        switch (opcode) { //execute
            0x00 => {}, // core
            0x01 => { // core
                const low: u16 = @as(u16, mem.readByte(self.registers.pc + 1));
                const high: u16 = @as(u16, mem.readByte(self.registers.pc + 2));
                self.setBc((high << 8) | low);
            },
            0x02 => mem.writeByte(self.getBc(), self.registers.a), // core
            0x03 => self.setBc(self.getBc() + 1), // core
            0x04 => {},
            0x05 => {},
            0x06 => self.registers.b = mem.readByte(self.registers.pc + 1), // core
            0x07 => {},
            0x08 => {},
            0x09 => {},
            0x0A => {},
            0x0B => self.setBc(self.getBc() - 1), // core
            0x0C => {},
            0x0D => {},
            0x0E => self.registers.c = mem.readByte(self.registers.pc + 1), // core
            0x0F => {},
            0x10 => {},
            0x11 => {},
            0x12 => {},
            0x13 => {},
            0x14 => {},
            0x15 => {},
            0x16 => self.registers.d = mem.readByte(self.registers.pc + 1), // core
            0x17 => {},
            0x18 => {
                self.registers.pc = relativeJump(self.registers.pc, mem, 2);
                pcChanged = true;
            }, // core
            0x19 => {},
            0x1A => {},
            0x1B => self.setDe(self.getDe() - 1), // core
            0x1C => {},
            0x1D => {},
            0x1E => self.registers.e = mem.readByte(self.registers.pc + 1), // core
            0x1F => {},
            0x20 => {
                if (self.getZFlag() == false) {
                    self.registers.pc = relativeJump(self.registers.pc, mem, 2);
                } else {
                    self.registers.pc = self.registers.pc + 2;
                }
                pcChanged = true;
            }, // core
            0x21 => {},
            0x22 => {
                mem.writeByte(self.getHl(), self.registers.a);
                self.setHl(self.getHl() - 1);
            }, // core
            0x23 => self.setHl(self.getHl() + 1), // core
            0x24 => {},
            0x25 => {},
            0x26 => self.registers.h = mem.readByte(self.registers.pc + 1), // core
            0x27 => {},
            0x28 => {
                if (self.getZFlag() == true) {
                    self.registers.pc = relativeJump(self.registers.pc, mem, 2);
                } else {
                    self.registers.pc = self.registers.pc + 2;
                }
                pcChanged = true;
            }, // core
            0x29 => {},
            0x2A => {
                mem.writeByte(self.getHl(), self.registers.a);
                self.setHl(self.getHl() - 1);
            }, // core
            0x2B => self.setHl(self.getHl() - 1), // core
            0x2C => {},
            0x2D => {},
            0x2E => self.registers.l = mem.readByte(self.registers.pc + 1),
            0x2F => {},
            0x30 => {
                if (self.getCFlag() == false) {
                    self.registers.pc = relativeJump(self.registers.pc, mem, 2);
                } else {
                    self.registers.pc = self.registers.pc + 2;
                }
                pcChanged = true;
            }, // core
            0x31 => {},
            0x32 => {
                mem.writeByte(self.getHl(), self.registers.a);
                self.setHl(self.getHl() - 1);
            }, // core
            0x33 => {},
            0x34 => {},
            0x35 => {},
            0x36 => mem.writeByte(self.getHl(), mem.readByte(self.registers.pc + 1)), // core
            0x37 => {},
            0x38 => {
                if (self.getCFlag() == true) {
                    self.registers.pc = relativeJump(self.registers.pc, mem, 2);
                }
                pcChanged = true;
            }, // core
            0x39 => {},
            0x3A => {
                self.registers.a = mem.readByte(self.getHl());
                self.setHl(self.getHl() - 1);
            }, // core
            0x3B => {},
            0x3C => {},
            0x3D => {},
            0x3E => self.registers.a = mem.readByte(self.registers.pc + 1), // core
            0x3F => {},
            0x40 => {},
            0x41 => {},
            0x42 => {},
            0x43 => {},
            0x44 => {},
            0x45 => {},
            0x46 => {},
            0x47 => {},
            0x48 => {},
            0x49 => {},
            0x4A => {},
            0x4B => {},
            0x4C => {},
            0x4D => {},
            0x4E => {},
            0x4F => {},
            0x50 => {},
            0x51 => {},
            0x52 => {},
            0x53 => {},
            0x54 => {},
            0x55 => {},
            0x56 => {},
            0x57 => {},
            0x58 => {},
            0x59 => {},
            0x5A => {},
            0x5B => {},
            0x5C => {},
            0x5D => {},
            0x5E => {},
            0x5F => {},
            0x60 => {},
            0x61 => {},
            0x62 => {},
            0x63 => {},
            0x64 => {},
            0x65 => {},
            0x66 => {},
            0x67 => {},
            0x68 => {},
            0x69 => {},
            0x6A => {},
            0x6B => {},
            0x6C => {},
            0x6D => {},
            0x6E => {},
            0x6F => {},
            0x70 => {},
            0x71 => {},
            0x72 => {},
            0x73 => {},
            0x74 => {},
            0x75 => {},
            0x76 => {},
            0x77 => mem.writeByte(self.getHl(), self.registers.a), // core
            0x78 => {},
            0x79 => {},
            0x7A => {},
            0x7B => {},
            0x7C => {},
            0x7D => {},
            0x7E => self.registers.a = mem.readByte(self.getHl()), // core
            0x7F => {},
            0x80 => self.registers.a = self.registers.a + self.registers.b,
            0x81 => {},
            0x82 => {},
            0x83 => {},
            0x84 => {},
            0x85 => {},
            0x86 => {},
            0x87 => {},
            0x88 => {},
            0x89 => {},
            0x8A => {},
            0x8B => {},
            0x8C => {},
            0x8D => {},
            0x8E => {},
            0x8F => {},
            0x90 => {},
            0x91 => {},
            0x92 => {},
            0x93 => {},
            0x94 => {},
            0x95 => {},
            0x96 => {},
            0x97 => {},
            0x98 => {},
            0x99 => {},
            0x9A => {},
            0x9B => {},
            0x9C => {},
            0x9D => {},
            0x9E => {},
            0x9F => {},
            0xA0 => {},
            0xA1 => {},
            0xA2 => {},
            0xA3 => {},
            0xA4 => {},
            0xA5 => {},
            0xA6 => {},
            0xA7 => {},
            0xA8 => {},
            0xA9 => {},
            0xAA => {},
            0xAB => {},
            0xAC => {},
            0xAD => {},
            0xAE => {},
            0xAF => {},
            0xB0 => {},
            0xB1 => {},
            0xB2 => {},
            0xB3 => {},
            0xB4 => {},
            0xB5 => {},
            0xB6 => {},
            0xB7 => {},
            0xB8 => {},
            0xB9 => {},
            0xBA => {},
            0xBB => {},
            0xBC => {},
            0xBD => {},
            0xBE => {},
            0xBF => {},
            0xC0 => {},
            0xC1 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                const combined = combine8Bits(high, low);
                self.setBc(combined);
                self.registers.sp = self.registers.sp + 2;
            }, // core
            0xC2 => {},
            0xC3 => { // core
                const low: u16 = @as(u16, mem.readByte(self.registers.pc + 1));
                const high: u16 = @as(u16, mem.readByte(self.registers.pc + 2));
                self.registers.pc = (high << 8) | low;
                pcChanged = true;
            },
            0xC4 => {},
            0xC5 => {
                const high, const low = deconstruct16Bit(self.getBc());
                mem.writeByte(self.registers.sp - 1, high);
                mem.writeByte(self.registers.sp - 2, low);
                self.registers.sp = self.registers.sp - 2;
            }, // core
            0xC6 => {},
            0xC7 => {},
            0xC8 => {},
            0xC9 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                self.registers.sp = self.registers.sp + 2;
                const combined: u16 = combine8Bits(high, low);
                self.registers.pc = combined;
                pcChanged = true;
            }, // core
            0xCA => {},
            0xCB => {},
            0xCC => {},
            0xCD => {},
            0xCE => {},
            0xCF => {},
            0xD0 => {},
            0xD1 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                const combined = combine8Bits(high, low);
                self.setDe(combined);
                self.registers.sp = self.registers.sp + 2;
            }, // core
            0xD2 => {},
            0xD3 => {},
            0xD4 => {},
            0xD5 => {
                const high, const low = deconstruct16Bit(self.getDe());
                mem.writeByte(self.registers.sp - 1, high);
                mem.writeByte(self.registers.sp - 2, low);
                self.registers.sp = self.registers.sp - 2;
            }, // core
            0xD6 => {},
            0xD7 => {},
            0xD8 => {},
            0xD9 => {},
            0xDA => {},
            0xDB => {},
            0xDC => {},
            0xDD => {},
            0xDE => {},
            0xDF => {},
            0xE0 => {},
            0xE1 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                const combined = combine8Bits(high, low);
                self.setHl(combined);
                self.registers.sp = self.registers.sp + 2;
            }, // core
            0xE2 => {},
            0xE3 => {},
            0xE4 => {},
            0xE5 => {
                const high, const low = deconstruct16Bit(self.getHl());
                mem.writeByte(self.registers.sp - 1, high);
                mem.writeByte(self.registers.sp - 2, low);
                self.registers.sp = self.registers.sp - 2;
            }, // core
            0xE6 => {},
            0xE7 => {},
            0xE8 => {},
            0xE9 => {},
            0xEA => {},
            0xEB => {},
            0xEC => {},
            0xED => {},
            0xEE => {},
            0xEF => {},
            0xF0 => {},
            0xF1 => {
                const low: u8 = mem.readByte(self.registers.sp);
                const high: u8 = mem.readByte(self.registers.sp + 1);
                const combined = combine8Bits(high, low);
                self.setAf(combined);
                self.registers.sp = self.registers.sp + 2;
            }, // core
            0xF2 => {},
            0xF3 => {},
            0xF4 => {},
            0xF5 => {
                const high, const low = deconstruct16Bit(self.getAf());
                mem.writeByte(self.registers.sp - 1, high);
                mem.writeByte(self.registers.sp - 2, low);
                self.registers.sp = self.registers.sp - 2;
            }, // core
            0xF6 => {},
            0xF7 => {},
            0xF8 => {},
            0xF9 => {},
            0xFA => {},
            0xFB => {},
            0xFC => {},
            0xFD => {},
            0xFE => {},
            0xFF => {},
        }
        if (!pcChanged) {
            self.registers.pc = self.registers.pc + info.bytes;
        }

        return;
    }
    // REGISTER PAIRS (private helpers)
    // getters
    fn getAf(self: CPU) u16 {
        return combine8Bits(self.registers.a, self.registers.f);
    }
    fn getBc(self: CPU) u16 {
        return combine8Bits(self.registers.b, self.registers.c);
    }
    fn getDe(self: CPU) u16 {
        return combine8Bits(self.registers.d, self.registers.e);
    }
    fn getHl(self: CPU) u16 {
        return combine8Bits(self.registers.h, self.registers.l);
    }
    // setters
    fn setAf(self: *CPU, value: u16) void {
        const high, const low = deconstruct16Bit(value);
        self.registers.a = high;
        self.registers.f = low & 0xF0;
    }
    fn setBc(self: *CPU, value: u16) void {
        const high, const low = deconstruct16Bit(value);
        self.registers.b = high;
        self.registers.c = low;
    }
    fn setDe(self: *CPU, value: u16) void {
        const high, const low = deconstruct16Bit(value);
        self.registers.d = high;
        self.registers.e = low;
    }
    fn setHl(self: *CPU, value: u16) void {
        const high, const low = deconstruct16Bit(value);
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

test "rom" {
    const game: []const u8 = &[_]u8{
        0x00, // NOP
        0x18, // JR r8
        0xFE, // offset -2 (jump back to JR at PC=1)
    };

    var gbRom: cartridge.ROM = cartridge.ROM.init();
    try gbRom.loadData(game);
    var gbMemory: memory.Memory = memory.Memory.init(gbRom);
    var gbCpu: CPU = CPU.init();

    // Run a few steps
    for (0..4) |_| {
        gbCpu.step(&gbMemory);
        std.debug.print("pc is {d}\n", .{gbCpu.registers.pc});
    }
    const expectEqual = std.testing.expectEqual;

    try expectEqual(@as(u16, 1), gbCpu.registers.pc);
}
