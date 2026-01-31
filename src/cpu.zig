// TODO: Move all functions from Rust to Zig until phase 3

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
    //HELPERS
    fn combine8bits(register_1: u8, register_2: u8) u16 {
        const high: u16 = @as(u16, register_1) << 8;
        const low: u16 = @as(u16, register_2);
        return high | low;
    }
    fn deconstruct16bit(value: u16) .{ u8, u8 } {
        const high: u8 = @truncate(value >> 8);
        const low: u8 = @truncate(value);
        return .{ high, low };
    }
    //REGISTER PAIRS
    //getters
    pub fn getAF(self: CPU) u16 {
        return combine8bits(self.registers.a, self.registers.f);
    }
    pub fn getBC(self: CPU) u16 {
        return combine8bits(self.registers.b, self.registers.c);
    }
    pub fn getDE(self: CPU) u16 {
        return combine8bits(self.registers.d, self.registers.e);
    }
    pub fn getHL(self: CPU) u16 {
        return combine8bits(self.registers.h, self.registers.l);
    }
    //setters
    pub fn setAF(self: *CPU, value: u16) void {
        const high, const low = deconstruct16bit(value);
        self.registers.a = high;
        self.registers.f = low & 0xF0;
    }
    pub fn setBC(self: *CPU, value: u16) void {
        const high, const low = deconstruct16bit(value);
        self.registers.b = high;
        self.registers.c = low;
    }
    pub fn setDE(self: *CPU, value: u16) void {
        const high, const low = deconstruct16bit(value);
        self.registers.d = high;
        self.registers.e = low;
    }
    pub fn setHL(self: *CPU, value: u16) void {
        const high, const low = deconstruct16bit(value);
        self.registers.h = high;
        self.registers.l = low;
    }
    //FLAG REGISTERS
    //getters
    pub fn getZFlag(self: CPU) bool {
        const mask: u8 = 0x80;
        return (self.registers.f & mask) != 0;
    }
    pub fn getNFlag(self: CPU) bool {
        const mask: u8 = 0x40;
        return (self.registers.f & mask) != 0;
    }
    pub fn getHFlag(self: CPU) bool {
        const mask: u8 = 0x20;
        return (self.registers.f & mask) != 0;
    }
    pub fn getCFlag(self: CPU) bool {
        const mask: u8 = 0x10;
        return (self.registers.f & mask) != 0;
    }
    //setters
    pub fn setZFlag(self: *CPU, value: bool) void {
        self.registers.f = self.registers.f & ~@as(u8, 0x80);
        self.registers.f = self.registers.f | @as(u8, @intFromBool(value) << 7);
    }
    pub fn setNFlag(self: *CPU, value: bool) void {
        self.registers.f = self.registers.f & ~@as(u8, 0x40);
        self.registers.f = self.registers.f | @as(u8, @intFromBool(value) << 6);
    }
    pub fn setHFlag(self: *CPU, value: bool) void {
        self.registers.f = self.registers.f & ~@as(u8, 0x20);
        self.registers.f = self.registers.f | @as(u8, @intFromBool(value) << 5);
    }
    pub fn setCFlag(self: *CPU, value: bool) void {
        self.registers.f = self.registers.f & ~@as(u8, 0x10);
        self.registers.f = self.registers.f | @as(u8, @intFromBool(value) << 4);
    }
};
