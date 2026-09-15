#La alcaldía local quiere hacerle recomendaciones a la comunidad sobre las condiciones climáticas.
#Para ello, se necesita un programa que analice la temperatura actual y la humedad relativa, y genere un mensaje así:

#    Pedirle al usuario la temperatura actual (°C).
#    Pedirle la humedad relativa (%).
#    Según estas condiciones, muestre un mensaje con recomendaciones:
#        Si la temperatura es mayor o igual a 30°C y la humedad es alta (> 70%), indicar: "Clima muy caluroso y húmedo, cuidado con golpes de calor".
#        Si la temperatura es alta (≥ 30°C) pero la humedad es baja (≤ 40%), indicar: "Clima seco y caliente, mantente hidratado".
#        Si la temperatura está entre 15°C y 29°C, considerar que es "Clima agradable".
#        Si la temperatura es menor a 15°C, decir: "Hace frío, abrígate".
#        Si los datos no cumplen ninguna condición (ej: humedad fuera de 0–100), debe mostrar: "Valores inválidos".

#Haga un programa en Elixir que imprima las recomendaciones.

defmodule Alcaldia do
  def main do
    temperatura = "Ingrese la temperatura actual (°C): "
    |> Util.leer(:float)

    humedad = "Ingrese la humedad relativa %: "
    |> Util.leer(:float)
    valido = es_valido?(temperatura, humedad)
    if valido do
      generar_mensaje(temperatura, humedad)
      |> Util.imprimir_mensaje()
    else
      Util.imprimir_error("Valores inválidos")
    end

  end

  defp es_valido?(temperatura, humedad) do
    temperatura >= -273.15 and humedad >= 0 and humedad <= 100
  end

  defp generar_mensaje(temperatura, humedad) do
    cond do
      temperatura >= 30 and humedad > 70 ->
        "Clima muy caluroso y húmedo, cuidado con golpes de calor"
      temperatura >= 30 and humedad <= 40 ->    #Aqui falta un valor para humedad entre 40 y 70 para evitar errores
        "Clima seco y caliente, mantente hidratado"
      temperatura >= 15 and temperatura < 30 ->
        "Clima agradable"
      temperatura < 15 ->
        "Hace frío, abrígate"
    end
  end
end

Alcaldia.main()
