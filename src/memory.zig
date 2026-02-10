const cartridge = @import("cartridge.zig");

pub const Memory = struct {
    rom: cartridge.ROM,
    vram: Vram,
    wram: Wram,
    hram: Hram,
    pub fn init(rom: cartridge.ROM) Memory {
        return .{ .rom = rom, .vram = .{}, .wram = .{}, .hram = .{} };
    }
    pub fn readByte(self: *Memory, address: u16) u8 {
        return switch (address) {
            0x0000...0x7FFF => self.rom.bytes[address],
            0x8000...0x9FFF => self.vram.bytes[address - 0x8000],
            0xC000...0xDFFF => self.wram.bytes[address - 0xC000],
            0xFF80...0xFFFE => self.hram.bytes[address - 0xFF80],
            else => 0xFF,
        };
    }
    pub fn writeByte(self: *Memory, address: u16, value: u8) void {
        switch (address) {
            0x0000...0x7FFF => {},
            0x8000...0x9FFF => self.vram.bytes[address - 0x8000] = value,
            0xC000...0xDFFF => self.wram.bytes[address - 0xC000] = value,
            0xFF80...0xFFFE => self.hram.bytes[address - 0xFF80] = value,
            else => {},
        }
    }
};

const Hram = struct { bytes: [127]u8 = [_]u8{0} ** 127 };
const Wram = struct { bytes: [8192]u8 = [_]u8{0} ** 8192 };
const Vram = struct { bytes: [8192]u8 = [_]u8{0} ** 8192 };
