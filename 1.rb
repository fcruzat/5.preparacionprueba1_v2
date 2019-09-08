# Preparación Prueba - Ruby
# Contexto
# La tienda de tecnología PC Factoring tiene el siguiente registro de inventario de sus productos en
# diferentes tienda del país.
# Notebook, 40, 10, 5, 15
# Desktop, 36, 42, 19, 0
# Router, 12, 55, 17, 26
# Impresora, 8, 18, 0, 13
# Copia el registro de inventario y pégalo en un archivo "inventario.csv"
# Para leer el archivo debes utilizar el siguiente método:
# def read_products(file_name)
#     file = File.open(file_name, 'r')
#     products = file.readlines.map(&:chomp).map { |lines| lines.split(', ') }
#     file.close
#     products
# end
# Este método recibe como argumento el nombre del archivo y luego retorna un arreglo con su
# contenido.

# Requerimientos
# Crea un menú de 7 opciones:

# Opción 1: Si el usuario ingresa a esta opción, podrá visualizar cada producto junto con el stock
# existente en cada tienda.
# Opción 2: Si el usuario ingresa a esta opción, podrá visualizar cada producto junto con su stock
# total (suma de los stock de cada tienda).
# Opción 3: Si el usuario ingresa a esta opción, podrá ver el ítem que tiene la mayor cantidad de
# stock total.
# Opción 4: Si el usuario ingresa a esta opción, podrá ver el ítem que tiene la menor cantidad de
# stock total.
# Opción 5: Si el usuario ingresa a esta opción, podrá ver los nombres de los productos que
# presentan stock cero en alguna tienda.
# Opción 6: Si el usuario ingresa a esta opción, debe poder escribir el nombre de un producto. El
# sistema debe responder si el producto existe en el inventario.
# Por ejemplo, el usuario ingresará "Notebooks" y el programa responderá "Sí".
# Opción 7: Si el usuario ingresa a esta opción, el programa termina.

# Consideraciones
# Luego del ingreso a una opción, el programa debe volver a mostrar el menú principal y solicitar
# el ingreso de una nueva opción.
# Se debe validar que la opción ingresada sea válida. Si se ingresa una opción no válida, el
# sistema debe imprimir el menú y volver a solicitar el ingreso de una opción.



def read_products(file_name)
    file = File.open(file_name, 'r')
    products = file.readlines.map(&:chomp).map { |lines| lines.split(', ') }
    file.close
    return products
end

def products_list
    products = read_products('inventario.csv')
    products.each do |elems|
        puts "\nEl producto #{elems[0]} tiene:"
        elems.each_with_index do |elem, index|
            puts "En la tienda #{index} = #{elem}" if index != 0
        end
    end
end

def stock_total
    products = read_products('inventario.csv')
    products.each do |elems|
        puts "\nEl stock total del producto #{elems[0]} es:"
        sum = 0
        elems.each do |x|
            sum += x.to_i
        end
        puts sum
    end
end

def max_stock
    products = read_products('inventario.csv')
    hash = {}
    products.each do |elems|
        sum = 0
        elems.each do |value|
            sum += value.to_i
        end
        hash[elems[0]] = sum
    end
    max_val = hash.invert.max
    puts "El producto con más stock es #{max_val[1]} con #{max_val[0]} unidades disponibles."
end

def min_stock
    products = read_products('inventario.csv')
    hash = {}
    products.each do |elems|
        sum = 0
        elems.each do |value|
            sum += value.to_i
        end
        hash[elems[0]] = sum
    end
    min_val = hash.invert.min
    puts "El producto con menos stock es #{min_val[1]} con #{min_val[0]} unidades disponibles."
end

def products_no_stock
    products = read_products('inventario.csv')
    products.each do |elems|
        elems.each_with_index do |elem, index|
            if elem.to_i == 0
                puts "El producto #{elems[0]}, está agotado en la tienda #{index}." if index != 0
            end
        end
    end
end

def existent_product
    products = read_products('inventario.csv')
    puts "Ingrese el nombre del producto y le responderemos si está presente en el inventario o no"
    ask = gets.chomp.capitalize
    arr = []
    products.each do |x|
        arr << x[0]
    end

    if arr.include?(ask)
        puts "Si. El producto #{ask}, existe en PC Factoring!." 
    else
        puts "No existe el producto #{ask} en PC Factoring :( intente con otro."
    end
end

# MENU
puts "\nBienvenido a PC Factoring!!"
menu_num = 0
while menu_num != 7
    puts "\nMenú:
    1. Ver los productos junto a su Stock en cada tienda.
    2. Ver los productos junto a su Stock total existente.
    3. El producto con mayor cantidad de Stock.
    4. El producto con menor cantidad de Stock.
    5. Conocer los productos que están agotados en alguna tienda.
    6. Consultar si algún producto existe en el inventario.
    7. Salir
    
    Ingresa el número de la opción que quieres escoger: _"
    menu_num = (gets.chomp).to_i
    if menu_num == 1
        products_list
    elsif menu_num == 2
        stock_total
    elsif menu_num == 3
        max_stock
    elsif menu_num == 4
        min_stock
    elsif menu_num == 5
        products_no_stock
    elsif menu_num == 6
        existent_product
    elsif menu_num == 7
        puts "Adiós!!"
    else
        puts "Número incorrecto, intente nuevamente"
    end
end