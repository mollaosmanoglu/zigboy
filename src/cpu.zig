// TODO: Move all functions from Rust to Zig until phase 3

pub const CPU = struct {
    registers: Registers,
    fn combine8bits(register_1: u8, register_2: u8) u16 {
        const high: u16 = @as(u16, register_1) << 8;
        const low: u16 = @as(u16, register_2);
        return high | low;
    }
    //getters
    pub fn get_AF(self: CPU) u16 {
        return combine8bits(self.registers.a, self.registers.f);
    }
    pub fn get_BC(self: CPU) u16 {
        return combine8bits(self.registers.b, self.registers.c);
    }
    pub fn get_DE(self: CPU) u16 {
        return combine8bits(self.registers.d, self.registers.e);
    }
    pub fn get_HL(self: CPU) u16 {
        return combine8bits(self.registers.h, self.registers.l);
    }
    //setters
    pub fn set_AF(self: *CPU, value: u16) void {
        return;
    }
    pub fn set_BC(self: *CPU, value: u16) void {
        return;
    }
    pub fn set_DE(self: *CPU, value: u16) void {
        return;
    }
    pub fn set_HL(self: *CPU, value: u16) void {
        return;
    }
};

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
