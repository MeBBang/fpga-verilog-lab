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

## 보드 핀 배치

| Signal | Pin | | Signal | Pin |
|---|---|---|---|---|
| DIP1 | Y1 | | LED1 | L4 |
| DIP2 | W3 | | LED2 | M4 |
| DIP3 | U2 | | LED3 | M2 |
| | | | LED4 | N7 |
| | | | LED5 | M7 |

## 주차별 목록

| 주차 | 주제 | 디렉터리 |
|---|---|---|
| 2 | Logic Gate & Adder | [`week02/`](week02/) |

## 디렉터리 구조

```
weekNN/
  src/      설계 소스 (.v)
  constrs/  핀·I/O 제약 (.xdc)
  sim/      테스트벤치 (tb_*.v)
```
