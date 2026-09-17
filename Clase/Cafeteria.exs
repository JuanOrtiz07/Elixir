#Una cafetería del barrio quiere un programa que les indique a sus clientes si está abierta en este momento.
#El programa debe solicitar el día de la semana y la hora (un número entero entre 0 y 23), y responder según el siguiente horario de atención:

#   De lunes a viernes: de 7 a 20.
#   Sábados: de 8 a 22.
#   Domingos: de 9 a 14.


#La hora de cierre ya está por fuera del horario: de lunes a viernes, a las 20 la cafetería ya cerró y la última hora de atención es la de las 19.

#El programa debe retornar:

#   {:ok, :abierta} si la hora está dentro del horario de ese día.
#   {:ok, :por_cerrar} si está dentro del horario, pero es la última hora antes de cerrar.
#   {:error, :cerrada} si la hora está fuera del horario de ese día.
#   {:error, :dia_invalido} si el día ingresado no corresponde a ninguno de la semana.

#Resuelva el ejercicio escribiendo una cláusula de función distinta para cada horario, apoyándose únicamente en los guards,
#sin usar if ni cond dentro de ellas. Defina las horas de apertura y cierre con atributos de módulo, como se hizo en el Ejemplo 1.

#Pista: normalice el día con String.downcase/1 antes de compararlo, para que “Lunes” y “lunes” se traten igual.
#Recuerde además que un guard admite rangos y pertenencia a listas, de modo que when dia in ["lunes", "martes"] y
#when hora in @apertura..@cierre son expresiones válidas
defmodule Cafeteria do
  def main do
    dia = Util.leer("Ingrese el dia de la semana en el que asistirá a la cafeteria: ", :String)
    |>String.downcase()
    hora = Util.leer("Ingrese la hora a la que asistirá a la cafeteria: ", :Integer)
    resultado = validar_horario(dia, hora)
    |>generar_mensaje()
    |>Util.imprimir()
  end

  defp validar_horario(dia, hora) when dia in ["lunes", "martes", "miércoles", "jueves", "viernes"] and hora in 7..19, do: {:ok, :abierta}
  defp validar_horario(dia, hora) when dia in ["lunes", "martes", "miércoles", "jueves", "viernes"] and hora == 20, do: {:ok, :por_cerrar}
  defp validar_horario(dia, hora) when dia in ["lunes", "martes", "miércoles", "jueves", "viernes"] and hora in 0..6 or hora in 21..23, do: {:error, :cerrado}
  defp validar_horario(dia, hora) when dia == "sábado" and hora in 8..21, do: {:ok, :abierta}
  defp validar_horario(dia, hora) when dia == "sábado" and hora == 22, do: {:ok, :por_cerrar}
  defp validar_horario(dia, hora) when dia == "sábado" and hora in 0..7 or hora == 23, do: {:error, :cerrado}
  defp validar_horario(dia, hora) when dia == "domingo" and hora in 9..13, do: {:ok, :abierta}
  defp validar_horario(dia, hora) when dia == "domingo" and hora == 14, do: {:ok, :por_cerrar}
  defp validar_horario(dia, hora) when dia == "domingo" and hora in 0..8 or hora in 15..23, do: {:error, :cerrado}
  defp validar_horario(_dia, _hora), do: {:error, :dia_invalido}

  defp generar_mensaje({:ok, :abierta}), do: "La cafeteria se encontrará abierta a la hora que usted ingresó"
  defp generar_mensaje({:ok, :por_cerrar}), do: "La cafeteria se encontrará abierta a la hora que usted ingresó, pero está por cerrar"
  defp generar_mensaje({:error, :cerrado}), do: "La cafeteria se encontrará cerrada a la hora que usted ingresó"
  defp generar_mensaje({:error, :dia_invalido}), do: "El día ingresado no es válido"
end

Cafeteria.main()
