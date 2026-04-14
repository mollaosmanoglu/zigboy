<p align="center">
  <img src="docs/logo.png" alt="zigboy logo" width="200"/>
</p>

# zigboy

![Zig](https://img.shields.io/badge/Zig-0.13-F7A41D)
![License](https://img.shields.io/badge/license-MIT-blue)
![Status](https://img.shields.io/badge/status-WIP-yellow)

Game Boy emulator built from scratch in Zig. CPU, PPU, memory, and cartridge subsystems.

<p align="center">
  <img src="docs/demo.gif" alt="Running Pokemon" width="600"/>
</p>

## Build

```bash
zig build run
```

Requires Zig 0.13+.

## Features

- CPU emulation (Sharp LR35902 instruction set)
- Memory management (VRAM, WRAM, HRAM, I/O registers)
- Cartridge loading (ROM banks)
- PPU (pixel processing, scanlines)
- Sound (audio channels)
- Input (joypad)
- WebAssembly compilation target

## Architecture

```
┌─────────────────────────────────────┐
│  CPU (Sharp LR35902)                │
│  • 8-bit registers (A,F,B,C,D,E,H,L)│
│  • 16-bit SP, PC                    │
│  • 512 opcodes + CB prefix          │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Memory (64KB address space)        │
│  • 0x0000-0x7FFF: ROM (cartridge)   │
│  • 0x8000-0x9FFF: VRAM (tiles)      │
│  • 0xC000-0xDFFF: WRAM              │
│  • 0xFF80-0xFFFE: HRAM              │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  PPU (Picture Processing Unit)      │
│  • 160x144 LCD                      │
│  • Tile-based rendering             │
│  • 4 shades of gray                 │
└─────────────────────────────────────┘
```

## References

- [Pan Docs](https://gbdev.io/pandocs/) — The Game Boy technical reference
- [GBEDG](https://hacktix.github.io/GBEDG/) — Opcode behavior
- [Blargg's test ROMs](https://github.com/retrio/gb-test-roms) — CPU validation

## Usage

Load a Game Boy ROM and run:

```bash
zig build run -- path/to/rom.gb
```

Compiles to WebAssembly for browser deployment.

## License

MIT
