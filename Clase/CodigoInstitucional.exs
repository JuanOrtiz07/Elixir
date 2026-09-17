#Se necesita un programa en Elixir que solicite al usuario un código institucional y determine si es válido según las siguientes reglas:

#    Debe tener exactamente 10 caracteres.
#    Debe contener la cadena “UQ-“ al inicio.
#    Debe terminar en “2026”.

#Si cumple todas las condiciones, mostrar: {:ok, "Codigo válido"}. De lo contrario, mostrar: {:error, "Código inválido: <razón del error>"}, indicando todas las razones por las cuales el código no es válido.

#Pista: se puede usar las funciones String.starts_with?/2, String.ends_with?/2 y String.length/1 para validar el código.
defmodule CodigoInstitucional do
  def main do
    codigo = Util.leer("Ingrese el codigo institucional: ", :String)
    resultado = validar_codigo(codigo)
    generar_mensaje(resultado)
    |> Util.imprimir_mensaje()
  end

  defp validar_codigo(codigo) do
    with {:ok, codigo} <- validar_longitud(codigo)
          {:ok, codigo} <- validar_inicio(codigo)
          {:ok, codigo} <- validar_fin(codigo) do
            {:ok, "Codigo válido"}
          end
  end

  defp validar_longitud(codigo) do
    if String.length(codigo) == 10 do
      {:ok, codigo}
    else
      {:error, "El código debe tener exactamente 10 caracteres"}
    end
  end

  defp validar_inicio(codigo) do
    if String.starts_with?(codigo, "UQ-") do
      {:ok, codigo}
    else
      {:error, "El código debe comenzar con 'UQ-'"}
    end
  end

  defp validar_final (codigo) do
    if  String.ends_with?(codigo,"2026") do
      {:ok, codigo}
    else
      {:error, "El código debe terminar en '2026'"}
    end
  end

  defp generar_mensaje({:ok, mensaje}), do: mensaje
  defp generar_mensaje({:error, motivo}), do: "Codigo inválido: #{motivo}"

end

CodigoInstitucional.main()
