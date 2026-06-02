defmodule Mensaje do
  def main do
    "Bienvenido a la empresa ONCe Ltda"
    |> mostrar_mensaje()
  end

  defp mostrar_mensaje (mensaje) do
    mensaje
    |>IO.puts()
  end
end
Mensaje.main()
# En este código, se define un módulo llamado Mensaje con una función main que contiene unacadena de texto.
# La cadena se pasa a la función mostrar_mensaje utilizando el operador de tubería (|>).
# La función mostrar_mensaje toma el mensaje como argumento y lo pasa a IO.puts() para imprimirlo en la consola.
