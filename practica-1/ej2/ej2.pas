
Program EJ2;

Var 
    nomArchivo:   String;
    num, max, min :   integer;
    archivo:   file Of integer;
Begin
    max := -1;
    min := 999;
    WriteLn('Ingrese el nombre del archivo: ');
    ReadLn(nomArchivo);

    Assign(archivo, nomArchivo);
    Reset(archivo);

    // leer hasta eof
    While Not (Eof(archivo)) Do
        Begin
            Read(archivo,num);
            // chequear max,min
            If (num > max ) Then max := num;
            If (num < min) Then min := min;
            //print
            WriteLn(num);
        End;
    WriteLn('Maxima cantidad de votantes: ',max);
    WriteLn('Minima cantidad de votantes: ',min);
    Close(archivo);
End.
