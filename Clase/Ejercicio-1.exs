defmodule RegistroPaquetes do
  def main do
    nombreUsuario = leer_cadena("Ingrese su nombre: ")
    nombreDestinatario = leer_cadena("Ingrese el nombre del destinatario: ")
    direccionDestinatario = leer_cadena("Ingrese la dirección del destinatario: ")
    generar_mensaje(nombreUsuario, nombreDestinatario, direccionDestinatario)
    |> imprimir()
  end

  defp generar_mensaje(nombreUsuario, nombreDestinatario, direccionDestinatario) do
    "El paquete a nombre de #{nombreUsuario} quedó registrado para ser entregado a #{nombreDestinatario} en la dirección #{direccionDestinatario}."
  end

  defp leer_cadena(texto) do
    IO.gets(texto)
    |> String.trim()
  end

  defp imprimir(mensaje) do
    IO.puts(mensaje)
  end
end
RegistroPaquetes.main() # Invoca la función principal para ejecutar el programa
