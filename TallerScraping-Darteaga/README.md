# Lenguajes de Programación
## Taller Ruby - Scraping

**Indicaciones:**
* Para desarrollar de forma correcta el taller es necesario que haya revisado las gemas:
  * nokogiri: https://github.com/sparklemotion/nokogiri/wiki/Cheat-sheet
  * open-uri: https://ruby-doc.org/stdlib-2.6.3/libdoc/open-uri/rdoc/OpenURI.html
  * csv: https://ruby-doc.org/stdlib-2.6.3/libdoc/csv/rdoc/CSV.html
* Una vez finalizado el taller enviar (Submit).
* La última versión debe ser enviada antes de las 12h35 pm de hoy.


**Desarrollo:**

1. Crear en main.rb el scraper e imprimir cada valor extraído de cada película encontrada en Cuevana: nombre, género, año, duración, rating, link, reparto, productor, etc. Use el siguiente enlace: https://ww1.cuevana3.me/peliculas-mas-valoradas

2. Crear una clase Pelicula que define los atributos: nombre, género, año, duración,rating,link. Agregue a esta clase  el método guardar que recibe todos los campos extraídos y permite registrar en movies.csv los 6 valores separados por coma. No olvide colocar la primera vez un encabezado con todos los campos. Adicionalmente defina sus getters y setters. Si algún valor no fue encontrado por defecto su valor será nil.

3. Crear la clase Actor que define el atributo nombre y el método guardar que permite agregar un nuevo actor al archivo actor.csv en diferente línea. En el archivo csv no pueden existir actores repetidos cree un método para validar de ser necesario.

4. Crear la clase Director, realiza lo mismo que Actor con la única diferencia de usar el archivo director.csv

5. Modificar el main.rb, use todas las clases creadas y registre los datos en cada archivo csv.


#Tarea

6. Presente un ranking con las 10 películas con mejor rating (valoración)

7. Presente un top con las 10 películas de mayor duración

8. Ordene todas las películas según orden alfabético e imprima los títulos.

9. Cree una nueva Clase denominada Géneros que es capaz de extraer las películas según este género. Utilice los links de género que ya da la plataforma Cuevana. Almacene los resultados en un archivo nombregenero.csv (use el formato de la clase Película, reutilice métodos en caso de ser posible)

10. Imprima el top 3 de cada género extraído según su rating.