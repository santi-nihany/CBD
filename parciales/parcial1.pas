
Program parcial1;

Const 

Type 
    producto =   Record
        cod, stock:   integer;
        nombre, desc:   string;
    End;

    file_productos =   file Of producto;

Procedure leerProducto(arch_text: Text; Var prod: producto);
Begin
    If (Not(EOF(arch_text)))Then
        Begin
            readln(prod.cod);
            readLn(prod.stock);
            readln(prod.nombre);
            readLn(prod.desc);
        End;
End;

Procedure generarBin(arch_text: Text);

Var 
    arch_bin:   file_productos;
    prod:   producto;
Begin
    Assign(arch_bin, 'archBin.dat');
    ReWrite(arch_bin);

    prod.cod := 0; {enlace lista LIFO}
    Write(arch_bin,prod); {cabecera}

    leerProducto(arch_text, prod);
    While (Not(EOF(arch_text))) Do
        Begin
            Write(arch_bin, prod);
            leerProducto(arch_text,prod);
        End;
    Close(arch_bin);
End;

Procedure eliminar(Var arch_bin: file_productos; cod: integer);

Var 
    aux, cabe:   producto;

Begin
    seek(arch_bin,0);
    read(arch_bin, cabe); {obtengo cabecera}

End;

Var 
    arch_text :   Text;
    arch_bin:   file_productos;
Begin
    Assign(arch_text,'arch.txt');
    Reset(arch_text);


    generarBin(arch_text);

    Assign(arch_bin,'archBin.dat');
    Reset(arch_bin);
    Writeln('Ingrese un codigo de producto a eliminar: ');
    Readln(cod);
    While (cod <> FIN) Do
        Begin
            eliminar(arch_bin, cod);
            Writeln('Ingrese un codigo de producto a eliminar: ');
            Readln(cod);
        End;

    Close(arch_text);
    close(arch_bin);
End.
