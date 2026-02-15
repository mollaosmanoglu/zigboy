const std = @import("std");
const cpu = @import("cpu.zig");
const memory = @import("memory.zig");
const cartridge = @import("cartridge.zig");
const ppu = @import("ppu.zig");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const file_path: []const u8 = "roms/test.gb";
    const game_data = try std.fs.cwd().readFileAlloc(allocator, file_path, 32 * 1024);
    var gb_rom: cartridge.ROM = cartridge.ROM.init();
    try gb_rom.loadData(game_data);

    var gb_memory: memory.Memory = memory.Memory.init(gb_rom);
    var gb_cpu: cpu.CPU = cpu.CPU.init();
    while (true) {
        std.debug.print("PRE: PC=0x{X:0>4} OP=0x{X:0>2}\n", .{ gb_cpu.registers.pc, gb_memory.readByte(gb_cpu.registers.pc) });
        gb_cpu.step(&gb_memory);
        std.debug.print("PST: PC=0x{X:0>4}\n", .{ gb_cpu.registers.pc });
    }

    defer allocator.free(game_data);
    // Prints to stderr, ignoring potential errors.
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}
