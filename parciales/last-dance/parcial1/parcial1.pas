{
    Una ferretería desea almacenar sus productos en un archivo de datos para la posterior
    actualización de stock con las compras y ventas de productos. Para ello cuenta con un
    archivo de texto donde tiene almacenada la siguiente información: código de producto,
    nombre, descripción y stock. Deberá realizar un procedimiento que tomando como entrada
    el archivo de texto, genere el correspondiente archivo binario de datos. Una vez creado el
    archivo de datos, se recibirán por pantalla códigos de productos obsoletos, los cuales
    deberán eliminarse del archivo de datos, utilizando una marca de borrado.
    Nota: Al crear el archivo de datos debe considerar que se desea realizar mantenimiento
    del espacio libre a partir de una lista encadenada de organización LIFO (Last In, First Out).
    El campo utilizado para marcar los elementos eliminados deberá ser diferente del campo
    utilizado para enlazar la lista. Indique qué campo utiliza en cada caso. Realice las
    declaraciones necesarias y los procedimientos para cargar el archivo binario a partir del
    archivo de texto y el procedimiento que permite eliminar los productos.

}
Program parcial1;
const
    FIN= 9999;
Type
    producto= record
        cod: integer;
        nombre: string;
        stock: integer;
        desc: string;
    end;

    fProducuctos = file of producto;

procedure leerProducto(var archTexto: Text; var reg: producto);
begin
    if(not(eof(archTexto)))then begin
        Readln(archTexto, reg.cod, reg.nombre);
        Readln(archTexto,reg.stock, reg.desc);
    end
    else
        reg.cod := FIN;
end;

procedure generarBinario(var archTexto: Text; var archBin: fProducuctos);
var
    reg: producto;
begin
    Rewrite(archBin);
    Reset(archTexto);

    reg.desc := '0';{elijo campo "desc" para NNR de lista enlazada}
    Write(archBin,reg);{escribo cabecera} 

    reg.cod := FIN;
    leerProducto(archTexto, reg);
    while(reg.cod <> FIN) do begin
        Write(archBin, reg);
        leerProducto(archTexto,reg);
    end;

    Close(archTexto);
    Close(archBin);
end;

procedure eliminarProducto(var archBin: fProducuctos; codP: integer);
var 
    reg,cabe: producto;
    posE: integer;
    strPosE: string;
begin
    reg.cod := FIN; {para inicializar nomas}
    seek(archBin,0); {me posiciono al inicio}
   
    read(archBin,cabe); {leo cabecera}

    while((not(eof(archBin))) and (reg.cod <> codP))do {recorro buscando el codigo a eliminar} 
        read(archBin,reg);

    if((reg.cod = codP) and (reg.stock <> -1)) then begin
        Writeln('Eliminando codigo...');
        posE:= filePos(archBin) - 1; {posicion a eliminar}
        reg.stock:= -1; {marca de borrado}
        Str(posE, strPosE); 
        reg.desc := strPosE; {NRR de la pos Eliminada}
        seek(archBin, 0);
        write(archBin,reg); {reemplazo cabecera}
        seek(archBin,posE); {me posiciono en posE }
        write(archBin,cabe); {escribo antigua cabecera en posE}
        Writeln('Codigo eliminado!')
    end
    else if(( reg.cod = codP) and (reg.stock = -1)) then 
        Writeln('Codigo ya se encuentra eliminado')
    else
        Writeln('Codigo no encontrado');
end;


procedure eliminarProductos( var archBin: fProducuctos);
var
    codP: integer;
begin
    Reset(archBin);
    Writeln('Ingrese el codigo de producto a eliminar (FINALIZA INGRESANDO 9999): ');
    Readln(codP);
    While (codP <> FIN) Do
    Begin
        eliminarProducto(archBin,codP);
        Writeln('Ingrese el codigo de producto a eliminar: ');
        Readln(codP);
    End;
    Close(archBin);

end;

var 
    archTexto: Text;
    archBin: fProducuctos;
Begin
    Assign(archTexto, 'productos.txt');
    Assign(archBin, 'productos.dat');

    generarBinario(archTexto,archBin);

    eliminarProductos(archBin);
End.