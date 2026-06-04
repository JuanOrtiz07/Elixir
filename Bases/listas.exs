iex> list = [3.14, "Hola", :pie]
#agregar elemento al inicio de la lista (mas rapido que agregar al final)
iex> ["Juan" | list]
#agregar elemento al final de la lista (menos eficiente que agregar al inicio)
iex> list ++ ["Ortiz"]

#CONCATENACION DE LISTAS
iex> list1 = [1, 2, 3]
iex> list2 = [4, 5, 6]
iex> list1 ++ list2

#Sustraccion de listas
iex> ["foo", :bar, 42] -- [42, "bar"] #Resultado => ["foo", :bar ]
iex> [1,2,2,2,2,3] -- [2] #Resultado => [1,3] se eliminan todas las ocurrencias de 2
iex> [2] -- [2.0] #Resultado => [2] no se eliminan las ocurrencias de 2 porque 2 y 2.0 son diferentes
iex> [2] -- [2] #Resultado => [] se eliminan todas las ocurrencias de 2

# Cuando usamos listas es común trabajar con la cabeza y la cola. La cabeza es el primer elemento de la lista,
# mientras que la cola es una lista que contiene a los elementos restantes. Elixir ofrece dos funciones útiles,
# hd y tl, para trabajar con estas partes. hd es la abreviatura de “head” (cabeza en inglés), y tl es la abreviatura de “tail” (cola):
iex> [3.14, :pie, "Hola"]
|> hd() #Resultado => 3.14
iex> [3.14, :pie, "Hola"]
|> tl() #Resultado => [:pie, "Hola"]

iex>[head | tail] = [3.14, :pie, "Apple"]
iex>[3.14, :pie, "Apple"]
iex>head #3.14
iex>tail #[:pie, "Apple"]
