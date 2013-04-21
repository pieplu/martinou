; Sous-programme qui lit un tableau d'entier
; -> utilise des vraies variables locales
; Jean Privat (c) 2011
;
; Programme principal. Invoque simplement la fonction.
         LDA     tab,i       
         LDX     tabLen,i    
         CALL    lireTab     
         STOP                
tab:     .BLOCK  56      ; un tableau d'entiers #1d50a 
debord:  .BLOCK  1
tabLen:  .EQUATE 56      ; taille de tab en octets 
;
; readTab: lit un tableau d'entiers (de l'input)
; IN: A=tableau d'entiers (mots signés #2d)
;     X=taille du tableau en octets
; En cas de probleme de lecture, le programme s'arrete
lireTab: SUBSP   6,i         ; reserve var locales #taille #addrt #addrfin
         STA     addrt,s     ; sauvegarde le parametre A
         STX     taille,s    ; sauvegarde le parametre X
         ADDX    addrt,s     
         STX     addrfin,s   ; addrfin = addrt + taille
         LDX     addrt,s     ; for (X=addrt; X<addrfin; X+=2) {
lire:    CPX     addrfin,s   
         BRGE    rTfin       ;fin de la saisie, le tableau est rempli  TROUVER un truc pour v/rifi/ au<il ne reste rien
         CHARI   0,x    ;;

         
         
         LDA     count,d     ;charge le compteur
         ADDA    1,i         ;increment
         STA     count,d     ;sauve
         
         CPA     7,i         ;verifie pour la pos du tiret
         BREQ    checkTir
         CPA     10,i        ;verifie pour la pos max possible de la virgule
         BREQ    checkVir
        
         
         



         LDA     0,i
         LDBYTEA 0,x    ;
         CPA     '9',i
         BRGT    erreur
         CPA     '0',i
         BRLT    erreur

         CPA     10,i        ; Lire un caractère.
         BREQ    finSaisi      ;
         
         ADDX    1,i         ;incr/menete pour placer le prochain carac
         BR      lire
finSaisi:             
;
;





         DECI    0,x         ;   *addrt = readInt();
         ADDX    2,i         
         BR      readLoop    ; } // fin for
rTfin:   LDX     taille,s    ; restaure X
         RET6                ; libere #taille #addrt #addrfin
;
addrfin: .EQUATE 0           ; l'adresse de fin du tableau #2h
addrt:   .EQUATE 2           ; l'adresse du tableau #2h
taille:  .EQUATE 4           ; la taille du tableau en octets #2d
;
;
         .END       