# Game Boy Emulator Project - Context for Claude

## Developer Background
- **Primary Language**: Python
- **Zig Experience**: Switched from Rust to Zig for a more minimalist approach
- **Learning Style**: Hands-on, learning by doing
- **Needs**: Back-and-forth guidance, hints and tips rather than complete solutions
- **Game Boy Knowledge**: Already understand how the Game Boy works from previous Rust implementation

## Project Goal
Build a Game Boy emulator from scratch to:
1. Learn Zig deeply through practical application
2. Apply existing Game Boy hardware knowledge in a minimalist language
3. Eventually port to WebAssembly
4. Host the emulator on the web

## Available Resources
1. **Game Boy Manual** - Hardware specifications and behavior
2. **Zig Documentation** - Language reference
3. **Game Boy Building Guides** - To be used sparingly, only when stuck

## Development Philosophy
- Code by hand, understand every line
- No premature optimizations
- Focus on correctness and learning over performance
- Iterative development with testing at each phase
- Embrace Zig's minimalism and explicit nature

## Project Phases

### Phase 1: CPU + Registers (CURRENT - RESTARTING IN ZIG)
- Implement Sharp LR35902 CPU structure
- 8-bit registers: A, B, C, D, E, F, H, L
- 16-bit registers: SP, PC
- Register pairs: AF, BC, DE, HL
- Flag register operations (Z, N, H, C)

### Phase 2: Memory Management (PLANNED)
- Memory map implementation
- ROM loading
- Memory banking

### Phase 3: Instruction Set (PLANNED)
- Opcode implementation
- Instruction decoding
- Fetch-decode-execute cycle

### Phase 4: GPU/PPU (PLANNED)
- Tile rendering
- Background/sprites
- LCD controller

### Phase 5: Input/Audio (PLANNED)
- Joypad input
- Basic audio processing

### Phase 6: Testing & Compatibility (PLANNED)
- Test ROMs
- Game compatibility
- Debugging tools

### Phase 7: WebAssembly Port (FUTURE)
- Port to wasm
- Web frontend
- Browser compatibility
- Deployment

## How Claude Should Help
- **NEVER provide code implementations, UNLESS its a copy or tedious copy of code (do not change any other code)** - only hints, guidance, and explanations
- **Keep explanations concise** - brief and to the point
- Provide hints and guidance, not full implementations
- Explain Zig concepts as they become relevant
- Point out common pitfalls (especially allocators, comptime, and error handling)
- Suggest testing strategies
- Answer architecture questions
- Help debug when stuck
- Relate concepts to Python when helpful

## Current Status
- Working directory: `/Users/Faruk/Desktop/zig/gameboy`
- Phase: 1 (CPU + Registers) - Restarting in Zig
- Completed: Understanding of Game Boy architecture from previous Rust implementation
- Next Steps: Implement CPU registers and flag operations in Zig
