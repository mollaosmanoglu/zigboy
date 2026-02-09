const std = @import("std");
const cpu = @import("cpu");
const memory = @import("memory");
const cartridge = @import("cartridge");
const ppu = @import("ppu");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const file_path: []const u8 = "roms/test.gb";
    const game_data = try std.fs.cwd().readFileAlloc(allocator, file_path, 32 * 1024);
    var gb_rom: cartridge.ROM = cartridge.ROM.init();
    try gb_rom.loadData(game_data);
    var gb_cpu: cpu.CPU = cpu.CPU.init();
    var gb_memory: memory.Memory = memory.Memory.init(gb_rom);

    defer allocator.free(game_data);
    // Prints to stderr, ignoring potential errors.
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}
