defmodule Paquetes do
  @tipo_clientes ["frecuente", "corporativo", "ocasional"]

  @bogotá 1
  @medellín 2
  @cartagena 3
  @san_andres 4

  @destino1 180.000
  @destino2 150.000
  @destino3 220.000
  @destino4 280.000

  @noches1 120.000
  @noches2 100.000
  @noches3 85.000

  def main do
    destino = Util.leer("Ingrese el numero del destino al que desea viajar: 1-Bogotá 2-Medellín 3-Cartagena 4-San Andrés ", :integer)
    |>validar_destino()
    noches = Util.leer("Ingrese la cantidad de noches que desea hospedarse (minimo 1 maximo 30): ", :integer)
    |>validar_noches()
    cliente = Util.leer("Ingrese el tipo de Cliente (frecuente, corporativo u ocasional): ", :string)
    |>String.downcase()
    |>validar_cliente()
    |>descuento_cliente()
    mes = Util.leer("Ingrese el mes en el que desea viajar (1-12): ", :integer)
    |>validar_mes()
    |>recargo_temporada()
    maleta = Util.leer("Desea llevar maleta de bodega con un valor de 45.000? (Si su destino es San Andrés es obligatorio): ", :string)
    |>String.downcase()
    |>origen_maleta(destino)
    seguro = Util.leer("Desea llevar seguro de viaje?: ", :string)
    |>String.downcase()
    |>validar_seguro(noches)
    tarifa_vuelo = tarifa_destino(destino)
    tarifa_noches = costo_noches(noches)
    costo_maleta = valor_maleta(maleta)
    descuento = descuento_seguro(seguro, noches)
    subtotal = subtotal_hotel(tarifa_noches, cliente, descuento)
    total = total_viaje(subtotal, tarifa_vuelo, costo_maleta, seguro, mes)
    generar_mensaje({tarifa_vuelo,tarifa_noches,maleta,costo_maleta,subtotal,descuento,cliente,seguro,total})
    |>Util.imprimir_mensaje()
  end

  defp validar_destino(destino) when destino in @bogotá..@san_andres, do: {:ok, destino}
  defp validar_destino(_destino), do: {:error, "Destino inválido"}

  defp validar_noches(noches) when noches < 1 or noches > 30, do: {:error, "Cantidad de noches inválida"}
  defp validar_noches(noches) when noches in 1..30, do: {:ok, noches}

  defp validar_cliente(cliente) when cliente in @tipo_clientes, do: {:ok, cliente}
  defp validar_cliente(_cliente), do: {:error, "Tipo de cliente inválido"}

  defp validar_mes(mes) when mes in 1..12, do: {:ok, mes}
  defp validar_mes(_mes), do: {:error, "Mes inválido"}

  defp origen_maleta(_maleta, destino) when destino == @san_andres, do: {:ok,:automatico}
  defp origen_maleta(maleta, _destino) when maleta in ["si"], do: {:ok,:solicitado}
  defp origen_maleta(maleta, _destino) when maleta in ["no"], do: {:ok,:no_aplica}
  defp origen_maleta(_maleta, _destino), do: {:error, "Opción de maleta inválida"}

  defp valor_maleta({:ok, :automatico}), do: {:ok, 45.000}
  defp valor_maleta({:ok, :solicitado}), do: {:ok, 45.000}
  defp valor_maleta({:ok, :no_aplica}), do: {:ok, 0.0}
  defp valor_maleta({:error, _}), do: {:error, "No se puede calcular el valor de la maleta debido a una opción inválida"}

  defp validar_seguro(seguro, noches) when seguro in ["si"] and noches > 2, do: {:ok, 12.000 *(1 - 0.05)}
  defp validar_seguro(seguro, _noches) when seguro in ["si"], do: {:ok, 12.000}
  defp validar_seguro(seguro, _noches) when seguro in ["no"], do: {:ok, 0.0}
  defp validar_seguro(_seguro, _noches), do: {:error, "Opción de seguro inválida"}

  defp descuento_seguro({:ok, _seguro}, {:ok, noches}) when noches > 2, do: {:ok, 0.05}
  defp descuento_seguro({:ok, _seguro}, {:ok, _noches}), do: {:ok, 0.0}
  defp descuento_seguro({:error, motivo}, _noches), do: {:error, motivo}

  defp tarifa_destino({:ok, @bogotá}), do: {:ok, @destino1}
  defp tarifa_destino({:ok, @medellín}), do: {:ok, @destino2}
  defp tarifa_destino({:ok, @cartagena}), do: {:ok, @destino3}
  defp tarifa_destino({:ok, @san_andres}), do: {:ok, @destino4}
  defp tarifa_destino({:error, _}), do: {:error, "No se puede calcular la tarifa debido a un destino inválido"}

  defp descuento_cliente({:ok, "frecuente"}), do: {:ok, 0.20}
  defp descuento_cliente({:ok, "corporativo"}), do: {:ok, 0.15}
  defp descuento_cliente({:ok, "ocasional"}), do: {:ok, 0.0}
  defp descuento_cliente({:error, _}), do: {:error, "No se puede calcular el descuento debido a un tipo de cliente inválido"}

  defp recargo_temporada({:ok, mes}) do
    cond do
      mes == 12 or mes == 1 -> {:ok, 0.25}
      mes in 6..7 -> {:ok, 0.10}
      true -> {:ok, 0.0}
    end
  end

  defp costo_noches(noches) when noches < 1 or noches > 30, do: {:error, "Cantidad de noches inválida"}
  defp costo_noches(noches) when noches in 1..2, do: {:ok, (noches * @noches1)}
  defp costo_noches(noches) when noches in 3..5, do: {:ok, (noches * @noches2)}
  defp costo_noches(noches) when noches in 6..30, do: {:ok, (noches * @noches3)}

  defp subtotal_hotel(tarifa_noches,cliente,descuento) do
    case {tarifa_noches, cliente, descuento} do
      {{:ok, tarifa_noches}, {:ok, cliente}, {:ok, descuento}} ->
        subtotal = (tarifa_noches * (1 - cliente)) * (1 - descuento)
        {:ok, subtotal}
      _ ->
        {:error, "No se puede calcular el subtotal del hotel debido a opciones inválidas"}
    end
  end

  defp total_viaje(subtotal, tarifa_vuelo, costo_maleta, seguro, mes) do
    case {subtotal, tarifa_vuelo, costo_maleta, seguro, mes} do
      {{:ok, subtotal}, {:ok, tarifa_vuelo}, {:ok, costo_maleta}, {:ok, seguro}, {:ok, mes}} ->
        total = (subtotal + tarifa_vuelo + costo_maleta + seguro) * (1 + mes)
        {:ok, total}
        _ ->
        {:error, "No se puede calcular el total del viaje debido a opciones inválidas"}
    end
  end

  defp generar_mensaje({tarifa_vuelo, tarifa_noches, maleta, costo_maleta, subtotal, descuento, cliente, seguro, total}) do
    case {tarifa_vuelo, tarifa_noches, maleta, costo_maleta, subtotal, descuento, cliente, seguro, total} do

      {{:ok, tarifa_vuelo}, {:ok, tarifa_noches}, {:ok, maleta},
      {:ok, costo_maleta}, {:ok, subtotal}, {:ok, descuento},
      {:ok, cliente}, {:ok, seguro}, {:ok, total}} ->

      tarifa_vuelo = :erlang.float_to_binary(tarifa_vuelo, decimals: 2)
      tarifa_noches = :erlang.float_to_binary(tarifa_noches, decimals: 2)
      costo_maleta = :erlang.float_to_binary(costo_maleta, decimals: 2)
      subtotal = :erlang.float_to_binary(subtotal, decimals: 2)
      descuento = :erlang.float_to_binary(descuento, decimals: 2)
      seguro = :erlang.float_to_binary(seguro, decimals: 2)
      total = :erlang.float_to_binary(total, decimals: 2)

      """
      Tarifa del vuelo: $#{tarifa_vuelo}
      Tarifa de las noches: $#{tarifa_noches}
      Maleta: #{maleta}
      Valor de la maleta: $#{costo_maleta}
      Subtotal del hotel: $#{subtotal}
      Descuento: #{descuento}
      Cliente: #{cliente}
      Seguro: $#{seguro}
      Total del viaje: $#{total}
      """

    {{:error, motivo}, _, _, _, _, _, _, _, _} ->
    "Error: #{motivo}"

    {_, {:error, motivo}, _, _, _, _, _, _, _} ->
    "Error: #{motivo}"

    {_, _, {:error, motivo}, _, _, _, _, _, _} ->
  "Error: #{motivo}"

    {_, _, _, {:error, motivo}, _, _, _, _, _} ->
  "Error: #{motivo}"

    {_, _, _, _, {:error, motivo}, _, _, _, _} ->
  "Error: #{motivo}"

    {_, _, _, _, _, {:error, motivo}, _, _, _} ->
  "Error: #{motivo}"

    {_, _, _, _, _, _, {:error, motivo}, _, _} ->
  "Error: #{motivo}"

    {_, _, _, _, _, _, _, {:error, motivo}, _} ->
  "Error: #{motivo}"

    {_, _, _, _, _, _, _, _, {:error, motivo}} ->
  "Error: #{motivo}"
  end
end
end

Paquetes.main()
