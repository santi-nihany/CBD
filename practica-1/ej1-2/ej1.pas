
Program ej1;

Const 
    FIN =   'cemento';

Type 
    archM =   file Of String;

Var 
    archMateriales:   archM;
    nombreArch, material:   String;
Begin
    Writeln('Ingrese el nombre del archivo: ');
    Readln(nombreArch);
    Assign(archMateriales, nombreArch +'.dat');
    Rewrite(archMateriales);
    Writeln('Ingrese el nombre del material: ');
    Readln(material);
    While (material <> FIN) Do
        Begin
            Write(archMateriales, material);
            Writeln('Ingrese el nombre del material: ');
            Readln(material);
        End;
    Close(archMateriales);
End.
