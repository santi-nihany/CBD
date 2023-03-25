
Program EJ3;

Const 
    FIN =   'ZZZ';

Var 
    nomDinosaurio:   String;
    archivo:   Text;
Begin
    Assign(archivo, 'dinosaurios.txt');
    ReWrite(archivo);
    WriteLn('Ingrese el nombre del dinosaurio:' );
    ReadLn(nomDinosaurio);
    While (nomDinosaurio <> FIN ) Do
        Begin
            Write(archivo,nomDinosaurio+ ' ');
            WriteLn('Ingrese el nombre del material: ');
            ReadLn(nomDinosaurio);
        End;
    Close(archivo);
End.
