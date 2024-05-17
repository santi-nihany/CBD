Program ej2;

Type 
    tVehiculo =   Record
        codigoVehiculo: integer;
        patente: String;
        motor: String;
        cantidadPuertas: integer;
        precio: real;
        descripcion: String
    End;
    tArchivo = File Of tVehiculo;


Procedure agregar (Var arch: tArchivo; vehiculo: tVehiculo);
var 
    reg: tVehiculo;
    pos:integer;
begin
    Reset(arch);
    read(arch,reg);
    if(reg.descripcion = '0')then
        seek(arch, fileSize(arch))
    else begin
        val(reg.descripcion, pos); {convierte desc(str) a pos a reutilizar }
        seek(arch, pos); {pos a reutilizar}
        read(arch, reg); {leo reg en pos}
        seek(arch,0);
        write(arch, reg); {escribo reg como cabecera}
        seek(arch, pos); {posicion a reutilizar}
    end;

    write(arch, vehiculo); { reutilizo pos, agrego vehiculo}
    Close(arch);    
end;

Procedure eliminar (Var arch: tArchivo; codigoVehiculo: integer);
var 
    aux, cabe:   tVehiculo;
    posEliminado:   Int64;
    strPos:   string;
Begin
    Reset(arch);
    read(arch,aux);
    cabe := aux; {obtengo cabecera del archivo (registro en pos 0)}
    While (Not(eof(arch)) And (aux.codigoVehiculo <> codigoVehiculo) ) Do
        Begin
            Read(arch,aux);
        End;

    If (aux.codigoVehiculo = codigoVehiculo)Then
        Begin
            posEliminado := filePos(arch) - 1;
            seek(arch,posEliminado);
            write(arch,cabe);
            {reemplazo el registro eliminado por la cabecera del archivo}
            seek(arch,0);
            Str(posEliminado, strPos);
            aux.descripcion := strPos; {modifico la descripcion del registro eliminado con la posicion del proximo registro a eliminar}
            write(arch,aux); {aux como cabecera}
        End
    Else
        Begin {no se encuentra la el codigo de vehiculo}
            WriteLn;
            WriteLn('No existe el vehiculo.');
            Write('Oprima Enter para continuar...');
            ReadLn;
        End;


    Close(arch);

end;

Begin
    Writeln('holaaa !!!!!!!!!!!!');
End.