# fpga-verilog-lab

서울시립대학교 전자전기컴퓨터공학부
전자전기컴퓨터설계실험II (40097-07) · 2026학년도 2학기

## 개발 환경

| 항목 | 값 |
|---|---|
| 툴 | Xilinx Vivado 2022.1 |
| FPGA | `xc7s75fgga484-1` (Spartan-7) |
| I/O 표준 | LVCMOS33 |
| 시뮬레이터 | Vivado Simulator (xsim) |
| 보드 | HBE-ComboII-DLD-51 |
| DIP 스위치 | ON 쪽으로 올린 상태가 1 |

## 보드 핀 배치

| Signal | Pin | | Signal | Pin | | Signal | Pin |
|---|---|---|---|---|---|---|---|
| DIP1 | Y1 | | LED1 | L4 | | SM_1 | K4 |
| DIP2 | W3 | | LED2 | M4 | | SM_2 | N8 |
| DIP3 | U2 | | LED3 | M2 | | | |
| DIP4 | T1 | | LED4 | N7 | | | |
| DIP5 | W4 | | LED5 | M7 | | | |
| DIP6 | W1 | | LED6 | M3 | | | |
| DIP7 | V4 | | LED7 | M1 | | | |
| DIP8 | U4 | | LED8 | N5 | | | |

## 주차별 목록

| 주차 | 주제 | 디렉터리 |
|---|---|---|
| 2 | Logic Gate & Adder | [`week02/`](week02/) |
| 3 | Combinational Circuit | [`week03/`](week03/) |

## 디렉터리 구조

```
weekNN/
  src/      설계 소스 (.v)
  constrs/  핀·I/O 제약 (.xdc)
  sim/      테스트벤치 (tb_*.v)
```
