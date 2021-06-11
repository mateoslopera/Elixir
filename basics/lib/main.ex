defmodule Main do
    def main() do
        concurrency()
    end

    #Concurrencia -> Permite correr varios bloques de codigo a la vez
    #Para esto se usa una funcion llamada spawn
    def concurrency() do
        spawn(fn() -> loop(50, 1) end)
        spawn(fn() -> loop(100, 50) end)

        #Enviando mensajes a los procesos 
        send(self(), {:french, "Bob"})

        receive do
            {:german, name} -> IO.puts "Guten Tag #{name}"
            {:french, name} -> IO.puts "Bonjour #{name}"
            {:english, name} -> IO.puts "Hello #{name}"
        #Si no responde le ponemos un temporizador de 500ms
        after
            500 -> IO.puts "Time Up"
        end



    end

    #---------------------------------------------------

    #Manejo de excepciones
    def manejo_error() do
        err = try do
            5 / 0
        rescue
            ArithmeticError -> "Can't divide by Zero."
        end
        IO.puts err
    end

    #---------------------------------------------------

    #List comprehension
    def list_comprehension() do
        #Multiplicar todos los valores de la lista x2
        dbl_list = for n <- [1, 2, 3], do: n * 2
        IO.inspect dbl_list
        #Saber cuales son los pares
        even_list = for n <- [1, 2, 3, 4, 5, 6], rem(n, 2) == 0, do: n
        IO.inspect even_list
    end

    #---------------------------------------------------

    #Haciendo uso de Enum
    def enum_practice() do
        Enum.each([1, 2, 3], fn(n) -> IO.puts n end)
        #Modificando los valores de la lista
        dbl_list = Enum.map([1, 2, 3], fn(n) -> n * 2 end)
        IO.inspect dbl_list
        #Sumar los valores y almacenarlos en la variable sum
        sum_vals = Enum.reduce([1, 2, 3], fn(n, sum) -> n + sum end)
        IO.puts "Suma: #{sum_vals}"
        #Obtener valores unicos solamente
        IO.inspect Enum.uniq([1, 2, 2, 3, 1, 4, 3])
    end

    #---------------------------------------------------
    
    #Vamos a usar Recursio para hacer Loops
    def recursion() do 
        IO.puts "Sum: #{sum([1,2,3])}"
        loop(5, 1)
    end

    #Si la fucion no tiene ningun valor
    def sum([]), do: 0

    #Si recibe parametros
    def sum([h | t]), do: h + sum(t)

    #Esta es otra forma de hacer un loop
    def loop(0, _), do: nil
    
    def loop(max, min) do
        if max < min do
            loop(0, min)
        else
            IO.puts "Num: #{max}"
            loop(max - 1, min)
        end
    end

    #---------------------------------------------------

    #Anonymous Function
    def anon do
        get_sum = fn(x, y) -> x + y end
        IO.puts "5 + 5 = #{get_sum.(5, 5)}"

        #Forma corta de hacer la funcion de arriba
        get_less = &(&1 - &2)
        IO.puts "7 - 6 = #{get_less.(7, 6)}"

        #Definir varias funciones en una funcion anonima
        add_sum = fn 
            {x, y} -> IO.puts "#{x} + #{y} = #{x+y}"
            {x, y, z} -> IO.puts "#{x} + #{y} + #{z} = #{x+y+z}"
        end
        add_sum.({1, 2}) 
        add_sum.({1, 2, 3})

        #Funcion con parametros definidos por defecto.
        IO.puts do_it()
        IO.puts do_it(5, 7)
    end

    # \\ Parametros por defecto.
    def do_it(x \\ 1, y \\ 2) do
        x+y
    end

    #Pattern Matching
    def pat_match do
        #Ignorar campos
        [_, [_, a]] = [20, [30, 40]]
        IO.puts "Number #{a}"
    end

    #Maps
    def maps do
        capitals = %{"Alabama" => "Montgomery", 
            "Alaska" => "Juneau", "Arizona" => "Phoenix"}

        IO.puts "Capital of Alaska #{capitals["Alaska"]}"

        #Atoms as a key
        capitals_2 = %{alabama: "Montgomery", 
            alaska: "Juneau", arizona: "Phoenix"}

        IO.puts "Capital of Arizona #{capitals_2.arizona}"
    end

    #Listas
    def listas() do
        list_1 = [1, 2, 3]
        list_2 = [4, 5, 6]
        list_3 = [1, 4 , 6]
        #Juntar varias listas
        list_4 = list_1 ++ list_2 ++ list_3
        #Extraer elementos de las listas
        list_5 = list_3 -- list_1
        IO.inspect list_5
        IO.puts 6 in list_2
        [head | tail] = list_4 
        IO.puts "Head: #{head}"
        IO.write "Tail: "
        IO.inspect tail

        #Recorrer el array
        words = ["Hola", "Mundo", "Hello", "World"]
        Enum.each words, fn word -> 
            IO.puts "#{word} is Fun"
        end

        #Funcion -> Recursion
        display_list(words)
    end

    def display_list([word | words]) do
        IO.puts word
        display_list(words)
    end

    #Para que una funcion no haga nada se pone lo siguiente:
    def display_list([]), do: nil

    #Tuplas
    def tupla() do
        my_stats = {175, 6.25, :Mateo}
        IO.puts "Tuple: #{is_tuple(my_stats)}"
        #Pattern Matching
        {age, height, name} = {23, 6.25, "Mateo"}
        IO.puts "Name: #{name} -> Age: #{age}"
        IO.puts "Size: #{tuple_size(my_stats)}"
    end

    #Operador Ternario
    def ternary_op(num) do
        IO.puts "Ternary : #{if num > 18, do: "You can Vote", else: "Can't Vote"}"
    end

    #Switch -> Case
    def case(num) do
        case num do
            1 -> IO.puts("Hi, I'm One")
            2 -> IO.puts("Hi, I'm Two")
            3 -> IO.puts("Hi, I'm Three")
            #Default
            _ -> IO.puts("Oops, not matching.")
        end
    end

    #Condicionales
    def conditionals(age) do
        if age >= 18 do
            IO.puts "Can Vote"
        else
            IO.puts "Can´t Vote"
        end

        #Unless
        unless age === 18 do
            IO.puts "You're not 18"
        else
            IO.puts "You are 18"
        end

        #Cond -> Solo producira un output en su primer match
        cond do
            age >= 18 -> IO.puts "You can Vote"
            age >= 16 -> IO.puts "You can Drive"
            age >= 14 -> IO.puts "You can wait"
            true -> IO.puts "Default"
        end
    end

    def vote_drive(age) do
        IO.puts "Vote & Drive: #{(age >= 16) and (age >= 18)}"
        IO.puts "Vote or Drive: #{(age >= 16) or (age >= 18)}"
    end

    def do_stuff() do
        my_str = "My Sentence"
        IO.puts "Length: #{String.length(my_str)}"
        longer_str = "#{my_str} is Longer"
        IO.puts longer_str
        IO.puts "Equal: #{"Egg" === "egg"}"

        #Contiene "My"
        IO.puts "My ?: #{String.contains?(my_str, "My")}"

        #Separar y poner en un array
        IO.inspect String.split(longer_str, " ")
    end

    def data_stuff do
        my_int = 123
        my_float = 3.14159
        IO.puts "Integer #{is_integer(my_int)}"
        IO.puts "Float #{is_float(my_float)}"
        #El nombre del atomo es el mismo del valor
        IO.puts "Atom #{is_atom(:New_York)}"
    end

    #IO.gets pide informacion al usuario por consola.
    #Trim quita el espacio de abajo.
    def saludo() do
        name = IO.gets('Whats is your name?') 
        IO.puts "Hello #{name}"
    end
end