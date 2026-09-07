# Week 02 — Logic Gate & Adder

## 파일 구성

| 파일 | 내용 |
|---|---|
| `src/logic_gate.v` | 2 input → 5 output (AND / OR / XOR / NOR / NAND) |
| `src/half_adder.v` | 논리식으로 구현한 Half Adder |
| `src/half_adder_case.v` | case문으로 구현한 Half Adder |
| `src/HA.v` | Full Adder의 sub-module |
| `src/full_adder.v` | `HA`를 `u1`, `u2`로 인스턴스화한 Full Adder |
| `constrs/logic_gate.xdc` | `logic_gate` 핀 제약 |
| `constrs/full_adder.xdc` | `full_adder` 핀 제약 |
| `sim/tb_logic_gate.v` | input `2'b00` ~ `2'b11` |
| `sim/tb_full_adder.v` | input `3'b000` ~ `3'b111` |

## 신호 매핑

**`logic_gate`**

| Port | 게이트 | 연결 | Pin |
|---|---|---|---|
| `a` | — | DIP1 | Y1 |
| `b` | — | DIP2 | W3 |
| `y_and` | AND | LED1 | L4 |
| `y_or` | OR | LED2 | M4 |
| `y_xor` | XOR | LED3 | M2 |
| `y_nor` | NOR | LED4 | N7 |
| `y_nand` | NAND | LED5 | M7 |

**`full_adder`**

| Port | 연결 | Pin |
|---|---|---|
| `a` | DIP1 | Y1 |
| `b` | DIP2 | W3 |
| `cin` | DIP3 | U2 |
| `cout` | LED1 | L4 |
| `sum` | LED2 | M4 |

## 합성 · 구현 결과

Vivado 2022.1, `xc7s75fgga484-1`. Implementation 열은 `Slice` / `Slice LUTs` 기준.

| 설계 | Synthesis cell usage | Slice | Slice LUTs |
|---|---|---|---|
| `logic_gate` | LUT2 ×5, IBUF ×2, OBUF ×5 | 2 | 3 |
| `half_adder` | LUT2 ×2, IBUF ×2, OBUF ×2 | 1 | 1 |
| `half_adder_case` | LUT2 ×2, IBUF ×2, OBUF ×2 | 1 | 1 |
| `full_adder` | LUT3 ×2, IBUF ×3, OBUF ×2 | 1 | 1 |
