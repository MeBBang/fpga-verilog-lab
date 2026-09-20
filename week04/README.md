# Week 04 — Sequential Logic Circuit

| 파일 | 내용 |
|---|---|
| `src/d_ff.v` | D 플립플롭 |
| `src/jk_ff.v` | JK 플립플롭 |
| `src/t_ff.v` | T 플립플롭 (원샷 트리거 미적용) |
| `src/t_ff_oneshot.v` | T 플립플롭 (원샷 트리거 적용) |
| `sim/tb_*.v` | 각 설계의 테스트벤치 |
| `constrs/d_ff.xdc` | 6.1 핀 제약 |
| `constrs/jk_ff.xdc` | 6.2 핀 제약 |
| `constrs/t_ff.xdc` | 6.3 핀 제약 |
| `constrs/t_ff_oneshot.xdc` | 6.4 핀 제약 — 클럭은 버튼 `SM_1` |
| `constrs/t_ff_oneshot_mainclk.xdc` | 6.5 핀 제약 — 클럭은 `Main_clock1` |
