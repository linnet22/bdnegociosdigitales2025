# Mongodb Crud

## Crear una base de datos 

**Solo se crea si contiene por lo menos una conección**
```json
use basededatos
```
## Crear una colección 

``use db1
db.createCollection('Empleado')``

## Mostrar collecciones
`show collections`

## Inserccion de un documento 
db.Empleado.insertOne(
    {
    nombre:'Soyla',
    apellido: 'Vaca',
    edad:32,
    ciudad: 'San Miguel de las Piedras'
    }
)

## Insercion de un documento mas complejo con array 
```json
db.Empleado.insertOne ({
  nombre: 'Ivan',
  apellido:'Baltazar',
  apellido2:'Rodriguez',
  aficiones: ['Cerveza', 'Canabis', 'Crico', 'Mentir']
})
```
**Eliminar una colleccion**
```json
db.collection.drop()
```
```json
__Ejemplo__
db.empleado.drop()
```
## Insecion de documentoos mas complejos con documento anidados, arrays y ID
```json
db.alumnos.insertOne(
{
    nombre: 'Jose Luis',
    apellido1: 'Herrera',
    apellido2: 'Gallardo',
    edad:41,
    estudios:[
        'Ingenieria en Sistemas Computacionales',
        'Maestria en Administración de Tecnologias de Información'
    ],
    Experiencia: {
        lenguaje: 'SQL',
        sgb: 'SqlServer',
        anios_experiencia: 20
    }
}
)
```
```json
db.alumnos.inser({
    _id:3,
    nombre:'Sergio',
    apellido:'Ramos',
    equipo: 'Monterrey',
    aficiones:['Dinero', 'Hombres', 'Fiesta'],
    talentos:{
        furbol:true,
        bañarse: false
    }
})
```
## Insertar Multiples Documentos
```json
db.alumnos.insertMany(
[
    {
        _id:12,
        nombre:'Osgualdo',
        apellido:'Venado',
        edad: 20,
        descipción: 'Es un quejumbroso'
    },
    {
        nombre: 'Maritza',
        apellido: 'Rechiken',
        edad: 20,
        habilidades:[
            'Ser Vibora', 'Ilusionar', 'Caguamear'],
            direccion:{
                calle: 'Del infierno',
                numero: 666
            },
            esposos:[
                {
                    nombre: 'Joshua',
                    edad: 20,
                    pension: -34,
                    hijos: ['Ivan el Cricoso', 'Jose']
                },
                {
                    nombre: 'Leo',
                    edad:15,
                    pension: 70,
                    complaciente: true
                }
            ]
    }
]
)
```
# Busquedas, Condiciones Simples de gualdad.Método find()
1. Seleccionar todos los documentos de la coleccion libros 
```json
db.libros.find({})

```
2. Seleccionar todos los documentos que sean de la editorial Biblio
```json
db.libros.find({editorial:'Biblio'})

```
3. Mostrar todos los documentos que el precio sea 25
```json
db.libros.find({precio:25})

```
4. Seleccionar todos los documentos donde el titulo sea json para todos 
```json
db.libros.find({titulo:'JSON para todos'})
```
## Operadores de comparación 

[Operadores de Comparación](https://www.mongodb.com/docs/manual/reference/operator/query/)
![Operadores de comparación](./data/img/operadores-Relacionales.png)

1. Mostrar todos los documentos donde el precio sea mayor a 25 
db.libros.find({precio:{$gt:25}})
2. Mostrar los documentos donde el precio sea 25
db.libros.find({precio:$eq:25})
db.libros.find({precio:{$eq:25}})
3. Mostrar los documentos cuya cantidad sea menor a 5 
db.libros.find({cantidad:{$lt:25}})
4. Mostrar los documentos que pertenecena la editorial biblio o planeta 
 db.libros. find( { editorial: { $in: ['Biblio', 'Planeta']  }})
5. Mostrar todos los documentos de libros que cuesten 20 o 25
db.libros. find ({precio: {$in:[20,25]}})
6. Recuperar todos los documentos que no cuesten 20 o 25
db.libros. find ({precio: {$nin:[20,25]}})

## Instrucción findOne
7. Recuperar solo una fila (Devuelve el primer elemento que cumpla la condicion )
db.libros. findOne ({precio: {$in:[20,25]}})

## Operadores Lógicos
[Operadores Lógicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

### Operador AND
- Dos posibles operaciones
1. La simple, mediante condiciones separadas por comas 
- db.libros.find({condicion1,condicion2, ....}) -> con esto asume que es una AND
{ $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }
- db.libros.find({$and: [{condiciion1}, {condicion2}]})

1. Mostrar todos aquellos libros que cuesten mas de 25 y cuya cantidad sea inferior a 15 
db.libros.find({precio: {$gt:25},cantidad:{$lt:15}})

db.libros.find({$and:[{precio:{$gt:25}},{cantidad:{$lt:15}}] })

### Operador or ($or)
- Mostrar todos aquellos libros que cuesten mas de 25 o cuya cantidad se inferior  a 15
```json
 db.libros.find(
 {
    $or:[

        {
            precio:{$gt:25}
        },
        {
            cantidad:{$lt:15}
        }
    ]
 }
 )

```
### Ejemplo ocn AND y OR Combinados

- Mostrar los libros de la editorial Biblio com precio mayor a 40 o libros de la editorial Planeta con precio mayor a 30 
'''json
db.libros.find({
    $and: [
        { $or: [{ editorial: 'Biblio' }, { precio: { $gt: 30 } }] },
        { $or: [{ editorial: 'Planeta' }, { precio: { $gt: 20 } }] }
    ]
})
'''
### Proyección (ver ciertas columnas)
**Sintaxis**

db.coleccion.find(filtro, columnas)
1. Seleccionar todos los libros, soloo mostrando el titulo 

db.libros.find({},{titulo: 1})
db.libros.find({},{titulo: 1, _id:0})

db.getCollection('libros').find(
  { editorial: 'Planeta' },
  { _id: 0, titulo: 1, editorial: 1, precio: 1 }
);

## Operador exists (Permite saber si un campo se encuentra o no en un documento)

[Operador exists](https://www.mongodb.com/docs/manual/reference/operator/query/exists/)
{ field: { $exists: <boolean> } }

db.libros.find({editorial:{$exists:true}})

db.libros.insertOne(
    {
        _id:10,
        titulo: 'Mongo en Negocios Digitales',
        editorial:'Terra',
        precio: 125
    }
)
-Buscar todos los documentos que no tengan cantidad 
db.libros.find({
    cantidad:{$exists:false}
})

## Operador type (Permie solicitar a mongo si un campo corresponde a un tipo)
[Operador type](https://www.mongodb.com/docs/manual/reference/operator/query/type/)

db.libros.find(
    {
        precio:{$type:1}
    }
)

db.libros.find(
    [
    {
        precio:{$type:16}
    }
    ]
)

- Mostrar todos los documentos donde el precio sea de tipo doble o entero o cualquier otro tipo de dato 

db.libros.find(
    {
        precio:{$type: 'int'}
    }
)

db.libros.insertMany(
    [
    {
        _id:12,
        titulo: 'IA',
        editorial: 'Terra',
        precio: 125,
        cantidad: 20
    },
    {
        _id:13,
        titulo: 'Pithon para todos',
        editorial: 2001,
        precio: 200,
        cantidad: 30

    }
    ]
)

- Selecciosnar todos los documentos de libros donde los valodes de la editorial sean strings

db.libros.find({editorial: {$type: 'string'}})
db.libros.find( {editorial: {$type: 2}})
db.libros.find({editorial: {$type: 16}})

# Modificando documentos 
## Comandos importantes 
1. UpdateOne -> Modifica un solo documento 
2. UpdateMany -> Modificar multiples documentos 
3. ReplaceOne -> Sustituir el contenido completo de un documento 
'''json
db.collection.updateOne(
    {filto},
    {operador:}
)
'''
[Operadores Update](https://www.mongodb.com/docs/manual/reference/operator/update/)
 
**Operador $set**
1. Modificar un documento 
```json
db.libros.updateOne({titulo: 'Python para todos'},{$set:{titulo:'Java para todos'}})
```
-- Modificar el documento con _id:10, estableciendo el precio en 100 y la cantidad en 50
db.libros.updateOne(
    {_id:10},{$set:{precio:100, cantidad:50}})

-- Utilizando el updateMany modificar todos los libros donde el precio sea Mayor  a 100 cambiarlo por 150 

db.libros.updateMany({precio:{$gt:100}},{$set:{precio:150}})

## Operadores $inc y $null (Incrementar y multiplicar)

-- Incrementar todos los precios de los libros en 5 
'''json
db.libros.updateMany({editorial: 'Terra'},{$inc:{precio:5}})
'''
-- Multiplicar todos los libros donde la cantidad sea mayor a 20 multiplicar la  cantidad por 2


db.libros.updateMany({cantidad:{$gt:20}},{$mul:{cantidad:2}})
db1> db.libros.find({_id:{$in:[1,7,10,13]}})

-- Actualizar todos los libros multiplicando por 2 la cantidad y el precio de todos aquellos libros donde el precio sea mayor a 20

db.libros.updateMany({precio:{$gt:20}},{$mul:{cantidad:2, precio:2}})

## Reemplazar documentos (replaceOne)

-- Actualizar todo el documento del id 2 por el titulo De la tierra a la luna, autor julio verne, editorial Terra, precio 100

db.libros.replaceOne(
    {_id:2},
    { 
    titulo: 'De la tierra ala luna',
    autor: 'Julio Verne',
    editorial: 'Terra',
    precio: 100
    }
)

## Borrar documentos 
1. deleteOne-> Elimina 1 solo documento 
2. delete/Many -> Elimina multiples documentos 

-- Eliminar el documento con el id 2 

db.libros.deleteOne({_id:2})

-- Eliminar todos los libros  donde la cantidad es mayor a 150

db.libros.deleteMany({cantidad:{$gt:150}})

## Expresiones Regulares
-- Seleccionar todos los libros que contengan en el titulo una t minuscula

db.libros.find({titulo:/t/})

-- Seleccionar todos los libros que en el titulo contenga la palabra json 
db.libros.find({titulo:/json/})

--seleccionar todos los libros que el titulo termine con tos 
db.libros.find({titulo:/tos$/})

--  Seleccionar todos los libros que en el titulo comiencen conn j
db.libros.find({titulo:/^j/})
## Operador $regex
[Operador Regex](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)
## Metodo sort (Ordenar Documentos)


-- Seleccionar los libros que contengan la palabra "Para"

db.libros.find(
    {
        titulo:{
            $regex: 'para'
        }
    }
)
-- seleccionar los titulos que contengan Json

db.libros.find(
    {
        titulo:{
             /JSON/
        }
    }
)

--Distinguir entre mayusculas y minusculas 
db.libros.find(
    {
        titulo:{
             $regex:  /JSON/'i'
        }
    }
)

db.libros.find(
    {
        titulo:{
             $regex:/json/,$options,'i'
        }
    }
)

db.libros.find(
    {
        titulo:{
             $regex:/^j/,$options,'i'}
    }
)


-- seleccionar todos los documentos de libros donde el titulo termine con es  y no distinga entre mayusculas y minusculas 

db.libros.find(
    {
        titulo: {
            $regex: /es$/,$options:'i'
        }
    }
)

## Metodo sort ( Ordenar documentos)
-- Ordenar los libros de manera ascendente por el precio 

db.libros.find(
    {},{
        _id:0,
        titulo:1,
        precio:1
    }
).sort({precio:1})
-- Ordenar los libros de forma descendente 
db.libros.find(
    {},{
        _id:0,
        titulo:1,
        precio:1
    }
).sort({precio:-1})

-- Ordenar los libros de manera ascendente por la editorial y de manera descendente por el precio mostrando el titulo el precio y la editorial

db.libros.find(
    {},
    {
        _id:0,
        precio:1,
        editorial:1
    }
).sort(
    {
        editorial:1,
        precio:-1
    }
)

## Metodos skip,limit,size
db.libros.find(
    {
        titulo:{
             $regex:/^j/,$options,'i'
    }
    }
).size()
-- Buscar los libros mostrando los 2 primeros 
db.libros.find({}).limit(2)
db.libros.find({}).skip(2)
# Borrar colecciones y base de datos 
db.libros.drop()
 db.dropDatabase()