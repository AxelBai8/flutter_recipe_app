# recetas_app

Una aplicación móvil construida con Flutter que permite a los usuarios explorar, buscar y ver los detalles de una gran variedad de recetas de cocina.

## Caracteristicas

Listado Infinito: Pantalla principal con infinite scroll para explorar recetas.
Vista de Detalle: Pantalla de detalle para cada receta con su imagen, lista de ingredientes e instrucciones.

### Enfoque

El proyecto sigue los principios de Clean Architecture para separar las responsabilidades del código en tres capas principales:

Domain: La capa central que contiene la lógica de negocio pura (entidades, casos de uso, y los contratos de los repositorios). No tiene dependencias de Flutter ni de ninguna fuente de datos.

Data: Responsable de obtener los datos, ya sea de una API remota o de una base de datos local. Implementa los contratos del repositorio definidos en la capa de Dominio.

Presentation: La capa de UI, que contiene los widgets de Flutter y la lógica de estado. Se utiliza el patrón BLoC (Business Logic Component) para separar la lógica de la interfaz de usuario, creando un flujo de datos unidireccional y predecible (Event -> BLoC -> State).

La Inyección de Dependencias se maneja con el paquete get_it para desacoplar las clases y facilitar las pruebas.

#### Getting Started

Sigue estos pasos para ejecutar el proyecto en tu máquina local.

Prerrequisitos
Tener el SDK de Flutter instalado.

Un editor de código como Visual Studio Code o Android Studio.

---X Pasos de Instalación X---

Clona el repositorio:

git clone https://github.com/tu-usuario/recetas_app.git
cd recetas_app

Instala las dependencias:
Ejecuta el siguiente comando en la terminal desde la raíz del proyecto.

flutter pub get

Ejecuta la aplicación (para desarrollo web):
Para evitar problemas de CORS al hacer peticiones a la API desde el navegador, es necesario ejecutar la app con una bandera que deshabilita la seguridad web. (No he podido resolver ese detalle)

Desde la terminal:

flutter run -d chrome --web-browser-flag "--disable-web-security"

##### Consideraciones y Mejoras futuras

--Limitaciones
CORS en Web: La API TheMealDB no tiene cabeceras CORS configuradas, lo que impide las llamadas directas desde un navegador. La solución para producción sería implementar un proxy inverso que actúe como intermediario entre el frontend y la API.

--Mejoras Futuras
Favoritos: Implementar la funcionalidad para que los usuarios puedan guardar sus recetas favoritas, utilizando almacenamiento local con Hive.

--Autenticación: Permitir a los usuarios crear cuentas para sincronizar sus recetas favoritas entre dispositivos.
