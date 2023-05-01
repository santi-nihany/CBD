Program altasBajas;

Type 
    tRaza =   String[50];
    tArchRaza =   File Of tRaza;
Procedure Procesar(Var a: tArchRaza );
Var 
    // o: Byte; {opción}
    // cl: Byte; {contador de lineas}
    r: tRaza; {raza y raza a buscar}
    sLibre: tRaza; {string con próximo registro libre}
    nLibre, cod: LongInt; {numero del próximo registro libre, y código de error al transformar datos }

Begin
    Reset(a);
    Read(a, sLibre); {lee la cabecera}
    Val(sLibre, nLibre,cod); {convierte de string a number}
    If (nLibre= -1) Then
        Seek(a, FileSize(a))
    Else
        Begin
            Seek(a, nLibre);
            Read(a, sLibre); {lee la posición a reutilizar}
            Seek(a, 0);
            Write(a, sLibre); {Actualiza la cabecera}
            Seek(a, nLibre);
        End;
    WriteLn('Raza Vacuna: ');
    ReadLn(r); {Lee la raza de teclado}
    Write(a, r); {Guarda la raza}
    Close(a)
End;

Procedure eliminar(var a: tArchRaza);
var
    // o: Byte; {opción}
    // cl: Byte; {contador de lineas}
    r, rb: tRaza; {raza y raza a eliminar}
    sLibre: tRaza; {string con próximo registro libre}
    nLibre: LongInt; {numero del próximo registro libre, y código de error al transformar datos }
Begin
    Reset(a);
    Write('Nombre de la raza a dar de baja: ');
    ReadLn(rb); {Raza eliminar}
    Read(a, sLibre); {lee la cabecera}
    r:= 'zzz';
    While (Not((r=rb) Or EoF(a))) do begin
        Read(a, r); {busca}
        If (r=rb) Then Begin {se encuentra la raza}
            nLibre:=FilePos(a)-1;
            Seek(a, nLibre); Write(a, sLibre); {Grabamos el contenido de la cabecera}
            Str(nLibre, sLibre); {Convierte de number a string}
            Seek(a, 0); Write(a, sLibre); {Se actualiza la cabecera}
        End
        Else Begin {no se encuentra la raza}
            WriteLn; WriteLn('No existe la raza.');
            Write('Oprima Entrar para continuar...');ReadLn;
        End;
    End;
    Close(a);
End;

begin
  WriteLn('hola');
end.