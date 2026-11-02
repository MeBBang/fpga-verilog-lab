# Week 09 — Text LCD Cursor Control

| 파일 | 내용 |
|---|---|
| `src/lcd_cursor.v` | 예비 A · 결과 A — 숫자 버튼으로 문자 입력, `*` · `#` 로 커서 이동 |
| `src/lcd_cursor_line.v` | 결과 B — DIP SW2 로 커서 줄 전환 |
| `src/lcd_cursor_wrap.v` | 결과 C — 줄 전환 + 0FH · 4FH 에서 오른쪽 이동 시 줄 처음으로 |
| `src/oneshot_universal.v` | 버튼 원샷 트리거 |
| `sim/tb_lcd_cursor.v` | 예비 A 테스트벤치 |
| `constrs/lcd_cursor.xdc` | 결과 A 핀 제약 |
| `constrs/lcd_cursor_line.xdc` | 결과 B · C 핀 제약 |
