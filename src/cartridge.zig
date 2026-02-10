pub const RomError = error{TooLarge};

pub const ROM = struct {
    bytes: [32768]u8 = [_]u8{0} ** 32768,
    pub fn init() ROM {
        return .{};
    }
    pub fn loadData(self: *ROM, instructions: []const u8) RomError!void {
        if (instructions.len > 32768) {
            return error.TooLarge;
        }
        @memcpy(self.bytes[0..instructions.len], instructions);
    }
};
