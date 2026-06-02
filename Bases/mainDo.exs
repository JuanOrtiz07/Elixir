defmodule Mensaje do
  def main do
    "Bienvenido a la empresa ONCE ltda"
    |>IO.puts()
    # En este código, se utiliza el operador de tubería (|>)
    #para encadenar la cadena "Bienvenido a la empresa ONCE Ltda" con la función IO.puts().\
    # El resultado de la cadena se pasa como argumento a IO.puts(), que imprime el mensaje en la consola.
  end
end
Mensaje.main()
