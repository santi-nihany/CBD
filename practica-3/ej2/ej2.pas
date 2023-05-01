Program ej2;

Type 
    tVehiculo = Record
        codigoVehiculo: integer;
        patente: String;
        motor: String;
        cantidadPuertas: integer;
        precio: real;
        descripcion: String; {0: no existen registros borrados; N: proximo registro a reutilizar}
    End;

    tArchivo = File Of tVehiculo;


{
    agregar(): Abre el archivo y agrega un vehículo para alquiler. 
    El vehículo se recibe como parámetro y debe utilizar la política 
    de lista invertida para recuperación de espacio.
}
Procedure agregar (Var arch: tArchivo; vehiculo: tVehiculo);
var
    aux, reg_libre: tVehiculo;
    n_libre, cod: LongInt; 
begin
    Reset(arch);
    read(arch,aux);
    if(aux.descripcion = '0')then 
        Seek(arch, FileSize(arch))      
    else begin
        Val(aux.descripcion,n_libre,cod);
        Seek(arch, n_libre);
        Read(arch,reg_libre);
        Seek(arch,0);
        Write(arch,reg_libre);
        Seek(arch,n_libre);
    end;

    Write(arch, vehiculo);

    Close(arch);
end;


{
    eliminar():Abre el archivo y elimina el vehículo que 
    posea el código recibido como parámetro manteniendo 
    la política de lista invertida
}
procedure eliminar(var arch: tArchivo; codigoVehiculo: integer);
var
    aux, cabe: tVehiculo;
    posEliminado: Int64;
    strPos: string;
begin
    Reset(arch);
    read(arch,aux);
    cabe := aux; {obtengo cabecera del archivo (registro en pos 0)}
    while(not(eof(arch)) and (aux.codigoVehiculo <> codigoVehiculo) ) do begin
        Read(arch,aux);
    end;

    if(aux.codigoVehiculo = codigoVehiculo)then
    begin
        posEliminado := filePos(arch) - 1;
        seek(arch,posEliminado);
        write(arch,cabe); {reemplazo el registro eliminado por la cabecera del archivo}
        seek(arch,0);
        Str(posEliminado, strPos);
        aux.descripcion := strPos; {modifico la descripcion del registro eliminado con la posicion del proximo registro a eliminar} 
        write(arch,aux); {aux como cabecera}
    end   
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
    WriteLn('Hola');
End.