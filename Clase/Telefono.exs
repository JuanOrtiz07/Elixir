#Un cliente está indeciso entre dos planes de telefonía móvil y quiere saber cuál le sale más barato.
#Cada plan cobra un cargo fijo mensual más un valor por cada giga que consuma.

#El programa debe solicitar el cargo fijo y el valor por giga de cada plan, junto con los gigas que el cliente consume al mes,
#calcular lo que pagaría en cada uno y mostrar un único mensaje:

#    Si el plan 1 sale más barato: "Le conviene el plan 1, ahorra $X al mes".
#    Si el plan 2 sale más barato: "Le conviene el plan 2, ahorra $X al mes".
#    Si los dos cuestan igual: "Los dos planes cuestan lo mismo, $X al mes".

#Tenga en cuenta lo siguiente:

#  La función que compara los dos costos no debe generar el mensaje, sino retornar un átomo (:plan_1, :plan_2 o :empate). Así la decisión queda separada
#  del texto que se muestra.

#   Escriba una cláusula de generar_mensaje por cada uno de esos tres átomos, aprovechando que los patrones también coinciden contra valores concretos.
#   El ahorro es la diferencia entre los dos costos, sin importar cuál sea mayor, así que abs/1 le resuelve el cálculo con una sola operación.
#   Use el módulo Util para leer los datos y para imprimir el mensaje.
#   Con valores reales de un plan los costos son números grandes y aparecerán en notación científica. Aplique lo visto en las versiones opcionales
#   de los ejemplos para mostrarlos con dos decimales.

defmodule Telefonia do
    def main do
        gigas_consumidos = Util.leer("Ingrese la cantidad de gigas consumidos al mes: ", :float)
        cargo_fijo_1 = Util.leer("Ingrese el cargo fijo del plan 1: ", :float)
        valor_giga_1 = Util.leer("Ingrese el valor por giga del plan 1: ", :float)
        cargo_fijo_2 = Util.leer("Ingrese el cargo fijo del plan 2: ", :float)
        valor_giga_2 = Util.leer("Ingrese el valor por giga del plan 2: ", :float)
        costo_1 = calcular_costo(cargo_fijo_1, valor_giga_1, gigas_consumidos)
        costo_2 = calcular_costo(cargo_fijo_2, valor_giga_2, gigas_consumidos)
        decision = comparar_costos(costo_1, costo_2)
        ahorro = sacar_ahorro(costo_1, costo_2)
        mensaje = generar_mensaje(decision, ahorro)
        Util.imprimir_mensaje(mensaje)

    end

    defp calcular_costo(cargo_fijo, valor_giga, gigas_consumidas) do
        cargo_fijo + (gigas_consumidas * valor_giga)
    end

    defp comparar_costos(costo_1, costo_2) do
        cond do
            costo_1 < costo_2 -> :plan_1
            costo_1 > costo_2 -> :plan_2
            true -> :empate
        end
    end

    defp sacar_ahorro(costo_1, costo_2) do
        abs(costo_1 - costo_2)
    end

    defp generar_mensaje(decision, ahorro) do
        case decision do
            :plan_1 -> "Le conviene el plan 1, ahorra $#{Float.round(ahorro, 2)} al mes"
            :plan_2 -> "Le conviene el plan 2, ahorra $#{Float.round(ahorro, 2)} al mes"
            :empate -> "Los dos planes cuestan lo mismo, $#{Float.round(ahorro, 2)} al mes"
        end
    end

end

Telefonia.main()
