# Game Boy Emulator Project - Context for AI

## Developer Background
- **Primary Language**: Python
- **Zig Experience**: Learning Zig through building this emulator
- **Learning Style**: Hands-on, learning by doing
- **Needs**: Back-and-forth guidance, hints and tips rather than complete solutions
- **Game Boy Knowledge**: Understands Game Boy hardware architecture and behavior

## Project Goal
Build a Game Boy emulator from scratch to:
1. Learn Zig deeply through practical application
2. Apply existing Game Boy hardware knowledge in a minimalist language
3. Eventually port to WebAssembly
4. Host the emulator on the web
5. Run Pokemon in the browser

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

### Phase 1: CPU + Registers ✓ (COMPLETED)
- Implement Sharp LR35902 CPU structure
- 8-bit registers: A, B, C, D, E, F, H, L
- 16-bit registers: SP, PC
- Register pairs: AF, BC, DE, HL
- Flag register operations (Z, N, H, C)

### Phase 2: Memory Management ✓ (COMPLETED)
- Memory map implementation
- ROM loading
- Memory banking (deferred - ROM-only games for now)

### Phase 3: Instruction Set 🔧 (CURRENT)
- Opcode implementation
- Instruction decoding
- Fetch-decode-execute cycle
- Test with minimal ROM in main.zig (verify execution before Phase 4)

### Phase 4: GPU/PPU (PLANNED)
- 4.1: Define PPU registers (LCDC/STAT) as packed structs
- 4.2: Implement PPU mode state machine (Mode 2/3/0/1) with `step(cycles)`
- 4.3: Implement tile/sprite renderer that reads VRAM and writes to a framebuffer

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
- **Guide, don't implement** - provide hints and explanations, not full solutions
- **Keep it concise** - brief, focused responses
- **Check Zig docs first** - verify syntax and best practices using MCP docs
- **Teach by doing** - explain concepts as they become relevant
- **Point out pitfalls** - especially allocators, comptime, and error handling
- **Relate to Python** - when helpful for understanding

## Development History

### Phase 1: CPU + Registers
- **Status**: Completed
- **PR**: #1 - Needs Review
- **Changes**: 
  - Implemented CPU struct with all 8-bit and 16-bit registers
  - Added register pair getters/setters (AF, BC, DE, HL)
  - Implemented flag register operations (Z, N, H, C)
  - Updated function names to Zig camelCase conventions

### Phase 2: Memory Management
- **Status**: Completed
- **PR**: #2 - Needs Review
- **Changes**:
  - Implemented ROM struct with 32KB capacity and loadData function
  - Added Memory struct with readByte/writeByte operations
  - Created memory regions: VRAM (8KB), WRAM (8KB), HRAM (127 bytes)
  - Implemented address routing with proper offset calculations
  - Added error handling for ROM size validation
  - Deferred memory banking (MBC) for future implementation

## Current Status
- Working directory: `/Users/Faruk/Desktop/zig/gameboy`
- Current Phase: **Phase 3 (Instruction Set)**
- Active Branch: `phase-3-instruction-set`
- Next Steps: Implement opcode definitions, instruction decoding, and fetch-decode-execute cycle
