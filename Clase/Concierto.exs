
#Eres parte del comité organizador de un concierto. Tienes un total de 325 entradas para repartir entre diferentes colegios.
#Cada colegio recibirá 20 entradas completas, y lo que sobre se guardará para rifarlas entre el público en general.

#Haga un programa en Elixir que calcule:

#   ¿Cuántos colegios podrán recibir entradas completas?
#    ¿Cuántas entradas sobrarán para la rifa?

#Haga una función que retorne una tupla con los resultados, e imprima los resultados en la función principal.
#También permita que el usuario ingrese la cantidad total de entradas y la cantidad de entradas por colegio.
defmodule Concierto do
  def main do
    total_entradas = "Ingrese la cantidad total de entradas: "
    |> Util.leer(:integer)
    entradas_por_colegio = "ingrese la cantidad de entradas por colegio: "
    |> Util.leer(:integer)
    colegios = calcular_colegios(total_entradas, entradas_por_colegio)
    sobrantes = calcular_sobrantes(total_entradas, entradas_por_colegio)
    generar_mensaje(sobrantes, colegios)
    |> Util.imprimir_mensaje()
  end

  defp calcular_colegios(total_entradas, entradas_por_colegio) do
    div(total_entradas, entradas_por_colegio)
  end

  defp calcular_sobrantes(total_entradas, entradas_por_colegio) do
    rem(total_entradas, entradas_por_colegio)
  end

  defp generar_mensaje(sobrantes, colegios) do
    "Se podrán repartir entradas completas a #{colegios} colegios y sobrarán #{sobrantes} entradas para la rifa."
  end
end



Concierto.main()
