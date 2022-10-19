# prueba_tecnica_3a

### ¿Cuál de las siguientes definiciones describe mejor lo que es un algoritmo?
Una serie de instrucciones organizadas secuencialmente para obtener un resultado definido y predecible según condiciones de
inicio

### ¿Qué significa la complejidad de un algoritmo?
La cantidad de operaciones y/o posiciones en memoria que un algoritmo necesita para ejecutarse, expresada como un orden
de magnitud del tamaño de las variables de entrada


### ¿Cuáles de las siguientes son estructuras de datos comúnmente utilizadas?
Árboles, Grafos, Arreglos, Conjuntos y Listas


## Una vez implementado el algoritmo responda las siguientes preguntas:
### ¿Cuál es la estructura de datos principal que utilizó para resolver el problema?
Arrays y ciclos principalmente for.
### Si quisiéramos modificar el algoritmo para que reconozca las diagonales como parte de una misma isla, ¿en dónde deberíamos
modificar el código?

en la parte del código en donde definimos las direcciones de revisión de cada elemento respecto a sus adyacentes, en este caso sería:

 final rowNbr = [-1, 0, 0, 1];
 final colNbr = [0, -1, 1, 0];

quedaría:

 final rowNbr = [-1, 0, 0, 1,-1, -1, 1, 1];
 final colNbr = [0, -1, 1, 0,-1, 1, -1, 1];
