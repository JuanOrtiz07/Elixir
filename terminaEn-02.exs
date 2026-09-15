"Hola Mundo"
|> String.upcase()
|>String.ends_with?("UNDO")
|>IO.puts()
# En este código, se utiliza el operador de tubería (|>) para encadenar varias funciones.
# Primero, la cadena "Hola Mundo" se convierte a mayúsculas utilizando String.upcase().
# Luego, se verifica si la cadena resultante termina con "UNDO" utilizando String.ends_with?().
# Finalmente, el resultado de esa verificación se imprime en la consola con IO.puts().
# El resultado será true, ya que "HOLA MUNDO" termina con "UNDO".
