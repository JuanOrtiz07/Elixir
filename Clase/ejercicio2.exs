defmodule Salario do
  def main do
    nombreEmpleado = leer_cadena("Ingrese el nombre del empleado: ")
    horasTrabajadas = leer_numero("Ingrese el número de horas trabajadas: ")
    valorHora = leer_numero("Ingrese el valor por hora: ")
    calcular_salario(horasTrabajadas, valorHora)
    |> generar_mensaje(nombreEmpleado)
    |> imprimir()
  end

  defp leer_cadena(texto) do
    IO.gets(texto)
    |> String.trim()
  end

  defp leer_numero(texto) do
    IO.gets(texto)
    |> String.trim()
    |> String.to_float()
  end

  defp calcular_salario(horasTrabajadas, valorHoras) do
    horasTrabajadas * valorHoras
  end

  defp generar_mensaje(salario, nombreEmpleado) do
    "El salario del empleado #{nombreEmpleado} es de: #{salario}."
  end

  defp imprimir(mensaje) do
    IO.puts(mensaje)
  end

end

Salario.main()
