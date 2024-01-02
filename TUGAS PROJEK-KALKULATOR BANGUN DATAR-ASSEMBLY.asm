.MODEL SMALL
.STACK 100h
.DATA  

JMP MULAI:
msg_start       DB 0Dh, 0Ah, '===SELAMAT DATANG DI KALKULATOR BANGUN DATAR===', 0Dh, 0Ah, '$'
msg_pilih       DB 0Dh, 0Ah, 'Pilih bangun datar yang akan dihitung:', 0Dh, 0Ah, '1. Persegi', 0Dh, 0Ah, '2. Persegi Panjang', 0Dh, 0Ah, '3. Segitiga', 0Dh, 0Ah, '4. Jajar Genjang', 0Dh, 0Ah, '5. Trapesium', 0Dh, 0Ah, '6. Keluar', 0Dh, 0Ah, '$'
msg_sisi        DB 0Dh, 0Ah, 'Masukkan panjang sisi (1-9): $'
msg_panjang     DB 0Dh, 0Ah, 'Masukkan panjang (1-9): $'
msg_lebar       DB 0Dh, 0Ah, 'Masukkan lebar (1-9): $'
msg_alas        DB 0Dh, 0Ah, 'Masukkan panjang alas (1-9): $'
msg_tinggi      DB 0Dh, 0Ah, 'Masukkan tinggi (1-9): $'
msg_sisia       DB 0Dh, 0Ah, 'Masukkan sisi A (1-9): $'
msg_sisib       DB 0Dh, 0Ah, 'Masukkan sisi B (1-9): $'
msg_hasil       DB 0Dh, 0Ah, 'Hasil perhitungan luas: $', 0Dh, 0Ah, '$'
msg_invalid     DB 0Dh, 0Ah, 'Masukan nomor yang valid!', 0Dh, 0Ah, '$'
msg_keluar      DB 0Dh, 0Ah, 'TERIMA KASIH TELAH MENGGUNAKAN KALKULATOR INI :)', 0Dh, 0Ah, '$' 
hasil           DB 10 DUP('$')

.CODE
MULAI:
main PROC
    MOV AX, DATA
    MOV DS, AX
    LEA DX, msg_start
    MOV AH, 09h
    INT 21h
    
MENU:
    LEA DX, msg_pilih
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    CMP AL, '1'
    JE PERSEGI
    CMP AL, '2'
    JE PERSEGI_PANJANG
    CMP AL, '3'
    JE SEGITIGA
    CMP AL, '4'
    JE JAJAR_GENJANG
    CMP AL, '5'
    JE TRAPESIUM
    CMP AL, '6'
    JE KELUAR
    JMP INVALID

PERSEGI:
    LEA DX, msg_sisi
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    MOV BL, AL
    MUL BL
    JMP TULIS_ANGKA

PERSEGI_PANJANG:
    LEA DX, msg_panjang
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    MOV BL, AL
    LEA DX, msg_lebar
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    MUL BL
    JMP TULIS_ANGKA

SEGITIGA:
    LEA DX, msg_alas
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    MOV BL, AL
    LEA DX, msg_tinggi
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    IMUL BL
    SAR AX, 1  
    JMP TULIS_ANGKA

JAJAR_GENJANG:
    LEA DX, msg_alas
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    MOV BL, AL  
    LEA DX, msg_tinggi
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    MOV BH, AL  
    IMUL BH 
    JMP TULIS_ANGKA

TRAPESIUM:
    LEA DX, msg_sisia
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    MOV BL, AL
    LEA DX, msg_sisib
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    ADD BL, AL   
    LEA DX, msg_tinggi
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    IMUL BL
    SAR AX, 1    
    JMP TULIS_ANGKA

KELUAR:  
    LEA DX, msg_keluar
    MOV AH, 09h
    INT 21h
    MOV AH, 4Ch
    INT 21h

INVALID:
    LEA DX, msg_invalid
    MOV AH, 09h
    INT 21h
    JMP MENU

TULIS_ANGKA:
    CALL CETAK
    LEA DX, msg_hasil
    MOV AH, 09h
    INT 21h
    LEA DX, hasil
    MOV AH, 09h
    INT 21h
    JMP MENU

CETAK PROC 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV CX, 10
    MOV BX, 0
    LEA DI, hasil
CONVERT_LOOP:
    XOR DX, DX
    DIV CX
    PUSH DX
    INC BX
    TEST AX, AX
    JZ CETAK_LOOP
    JMP CONVERT_LOOP
CETAK_LOOP:
    POP DX
    ADD DL, '0'
    MOV [DI], DL
    INC DI
    DEC BX
    JNZ CETAK_LOOP
    MOV [DI], '$'
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CETAK ENDP

END main