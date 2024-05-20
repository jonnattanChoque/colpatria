# Instalación y ejecución del proyecto

```
1. git clone https://github.com/tu-usuario/tu-repositorio.git
2. cd tu-repositorio
3. pod install
4. open YourProjectName.xcworkspace
5. Selecciona tu esquema de proyecto en Xcode.
6. Conecta un dispositivo o selecciona un simulador.
7. Haz clic en el botón de ejecutar (Run) o presiona Cmd + R.
```

# Arquitectura VIPER en iOS

## Introducción

VIPER es un patrón de arquitectura de software utilizado para desarrollar aplicaciones iOS modulares y escalables. VIPER significa Vista (View), Interactor, Presentador (Presenter), Entidad (Entity) y Enrutador (Router). Cada componente tiene una responsabilidad bien definida, promoviendo la separación de preocupaciones y mejorando el mantenimiento del código.

## Componentes de VIPER

### Vista (View)

- Muestra lo que el Presentador le indica y retransmite las entradas del usuario al Presentador.

### Interactor

- Contiene la interacción con el consumo de apis y lógica de negocio.

### Presentador (Presenter)

- Contiene la lógica de la vista para preparar el contenido para mostrarlo con los datos obtenidos del Interactor y/o utils.

### Entidad (Entity)

- Contiene objetos modelo básicos utilizados por el Interactor, Presenter y Vista.

### Enrutador (Router)

- Maneja la navegación para describir qué pantallas se muestran o a dónde debe volver.

## Diagrama de VIPER

```plaintext
                        +-----------------------------------+
         -------------- |            Vista                  |
         |              | (UIViewController)                |
         |              +--+-----------------------------+--+
         |                   |
         v                   v
+--------+--------+     +--------+--------+
|    Entidad      | <---|    Presentador   |---------------
|                 |     |                  |              |
+--------+--------+     +--------+--------+               |
        ^                       |                         |
        |                       v                         v
        |            +--------+--------+      +-------------+-------------+
        |---------- |     Interactor  |      |        Router             |
                    |                 |      |                           |
                    +--------+--------+      +-------------+-------------+

```
