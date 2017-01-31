section .data
pixelx             dd 1
pixely             dd 1
destposition       dd 0
rgba               times 4 db 0

section .text
global rotateUD
rotateUD:
push                ebp
mov                 ebp, esp


%define             input [EBP + 8]
%define             output [EBP + 12]
%define             width [EBP + 16]
%define             height [EBP + 20]
mov                 edi, output
mov                 esi, input
mov                 eax, width
imul                eax, height
lea                 eax, [eax*4]
mov                 ecx, eax                ; Ustawiamy licznik (width*height*4)
add                 esi, ecx
sub                 esi, 4

for:
# Obrót o 90 stopni w lewo wyszukuje piksel źródłowy na pozycji (x,y)  x: <1;nowa_wysokość> y: <1;nowa_szerokość>
# Wyrażone jest to wzorem P(x,y) = Szerokość*y - x + 1  gdzie Wysokość i Szerokość są to wymiary źródła

# push               eax                       ;Zwalniamy sobie rejestry do wykonania obliczeń
# push               ebx
# push               ecx
# push               esi
# push
# mov                eax, [pixelx]
# mov                ebx, [pixely]
# mov                ecx, [destposition]
# mov
; mov                ebx, dword [height]

 mov                dl, byte [esi]          ; Ładuję do dl pierwszy pixel
 mov                byte [rgba], dl         ; składuję pierwszy pixel

 mov                dl, byte [esi+1]        ; Ładuję do dl drugi pixel
 mov                byte [rgba + 1], dl     ; Składuję drugi pixel

 mov                dl, byte [esi + 2]      ; Ładuję do dl trzeci pixel
 mov                byte [rgba + 2], dl     ; Składuję trzeci pixel

 mov                byte [rgba + 3], 0xFF    ; Skłdauję 0 jako alfę

 mov                al, byte [rgba]         ; Ładuję pierwszy pixel do al
 mov                byte [edi], al          ; Zapisuję do obrazka docelowego

 mov                al, byte [rgba + 1]     ; Ładuję drugi pixel do al
 mov                byte [edi + 1], al          ; Zapisuję do obrazka docelowego

 mov                al, byte [rgba + 2]     ; Ładuję trzeci pixel do al
 mov                byte [edi + 2], al          ; Zapisuję do obrazka docelowego

 mov                al, byte [rgba + 3]     ; Ładuję alfę do al
 mov                byte [edi + 3], al          ; Zapisuję do obrazka docelowego

 sub                esi, 4
 add                edi, 4
 sub                ecx, 3
 loop               for
end:

# Przywracamy esp
mov                 esp, ebp
pop                 ebp
ret
