# Mongodb Crud

## Crear una base de datos 

**Solo se crea si contiene por lo menos una conección**
```json
use basededatos
```
## Crear una colección 

``use bd1
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

