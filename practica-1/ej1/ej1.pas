
Program EJ1;

Const 
    FIN =   'cemento';

Var 
    nomArchivo:   String;
    nomMaterial:   String;
    archivo:   Text;
Begin
    WriteLn('Ingrese el nombre del archivo: ');
    ReadLn(nomArchivo);
    Assign(archivo, nomArchivo);
    ReWrite(archivo);
    WriteLn('Ingrese el nombre del material:' );
    ReadLn(nomMaterial);
    While (nomMaterial <> FIN ) Do
        Begin
            Write(archivo,nomMaterial+ ' ');
            WriteLn('Ingrese el nombre del material: ');
            ReadLn(nomMaterial);
        End;
    Write(archivo,nomMaterial);
    Close(archivo);
End.
