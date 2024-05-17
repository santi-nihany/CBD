
Program EJ3;

Const 
    FIN =   'ZZZ';

Type 
    fString =   file Of string;

Procedure convertirAtxt(Var arch: fstring; Var nueTxt: Text);

Var 
    dino:   string;
Begin
    Reset(arch);
    Rewrite(nueTxt);
    Writeln('Creando archivo de texto...');
    While (Not(eof(arch))) Do
        Begin
            Read(arch, dino);
            Write(nueTxt, dino);
        End;
    Writeln('Archivo de texto finalizado!');
    Close(arch);
    Close(nueTxt);
End;

Var 
    nomDinosaurio:   String;
    archivo:   fString;
    nueTxt:   Text;
Begin
    Assign(archivo, 'dinosaurios.dat');
    ReWrite(archivo);
    WriteLn('Ingrese el nombre del dinosaurio:' );
    ReadLn(nomDinosaurio);
    While (nomDinosaurio <> FIN ) Do
        Begin
            Write(archivo,nomDinosaurio);
            WriteLn('Ingrese el nombre del dinosaurio: ');
            ReadLn(nomDinosaurio);
        End;
    Close(archivo);
    Assign(nueTxt, 'dinosaurios.txt');
    convertirAtxt(archivo,nueTxt);
    ReadLn();
End.
