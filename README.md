# TC3041 Proyecto  Final Primavera 2019

# Guardabosques
---

##### Integrantes:
1. Juan José Santos Chávez
2. Rafael Díaz Medina


---
## 1. Aspectos generales

### 1.1 Estructura del repositorio

```
- /                                     #Raiz de todo el proyecto
	- README.md			# Archivo con los datos del proyecto
	- Guardabosques			# Carpeta raíz del proyecto de Xcode
		- Model			# Modelos de Reporte y Datasets
		- View			# Storyboard y Vistas en Swift
		- Controller		# Controladores de las vistas en Swift
		- Fonts			# Fonts externas
		- Assets		# Imágenes que va a utilizar la app
		- Pods			# Librerías externas para Swift
```

## 2. Descripción del proyecto

Crear una aplicación móvil que funcione como red social para todos los guarda bosques de México.
Con el fin de compartir información sobre lo que hay en su reserva, bosque o estado en el que están, la información se compartira en tiempo real por lo que para cualquier amenaza o buena noticia los guarda bosques no perderán tiempo a menos de que no tengan acceso a una red de internet.
En está aplicación se podran hacer post de 4 cosas en específico que son flora, fauna, alertas y clima (temperatura, humedad y presion).
Se incluiran las especies en peligro de extinción de flora y fauna para facilitar el acceso a ellas.


## 3. Solución

Para solucionar el problema se investigo a las especies de flora y fauna en peligro de extinción en México, también se hizo una lista de las reservas y areas protegidas de México.
Sepenso en dos diferentes bases de datos para almacenar la información de la aplicación móvil así como en que se iba a desarrollar, la mejor manera para poder registrar a todos los guarda bosques es por medio de su correo electronico.
La manera en la que se compartira la información será en momento real gracias a una conexión a internet
### 3.1 Modelos de *bases de datos* utilizados

Se escogieron dos  bases de datos que son Firebase y SQLite

*Firebase
Es una plataforma de desarrollo móvil en la nube de Google que proporciona un API para guardar y sincronizar datos en la nube en tiempo real, al mismo tiempo funciona como orquestador por lo que decidimos no ocupar Kubernetes ya que este está mejor optimizado para el desarrollo móvil.
Otras carácteristicas de Firebase son que es:

Analítica: Provee una solución gratuita para tener todo tipo de medidas (hasta 500 tipos de eventos), para gestionarlo todo desde un único panel.

Desarrollo: Permite construir mejores apps, permitiendo delegar determinadas operaciones en Firebase, para poder ahorrar tiempo, evitar bugs y obtener un aceptable nivel de calidad. Entre sus características destacan el almacenamiento, testeo, configuración remota, mensajería en la nube o autenticación, entre otras.

Crecimiento: Permite gestionar los usuarios de las aplicaciones, pudiendo además captar nuevos. Para ello dispondremos de funcionalidades como las de invitaciones, indexación o notificaciones.

*SQLite
Es una base de datos relacional compatible con ACID (Atomicidad, Consistencia, Aislamiento y Durabilidad).
Esta contenida en una relativamente pequeña biblioteca escrita en C.

Nos permite ejecutar comandos SQL en la base datos por lo que es fácil hacer consultas parametrizadas.
Otra de sus características es que el conjunto de la base de datos (definiciones, tablas, índices, y los propios datos), son guardados como un solo fichero estándar en la máquina host. Este diseño simple se logra bloqueando todo el fichero de base de datos al principio de cada transacción.

### 3.2 Modelo de Datos Firebase
### User
* UID
* Email
* Password
* Created
* Signedin

### Guardabosques
* Flora
* Fauna
* Alerts
* Weather

### Report
* Date
* Location
* MessageBody
* Title
* Username
 
 ### 3.3 Modelo de Datos SQLite
### Users
* Id
* Email
* Name
* Job
* Location

 ### 3.4 DataSet
Para nuestro conjunto de datos se realizo una investigación para encontrar el nombre de las Reservas, Fauna en peligro de Extinción y Flora también en peligro de extinción. Todo solo en territorio Mexicano ya que es lo que nos importa resolver con nuestra app.

### 3.5 Arquitectura de la solución
![](images/GuardabosquesArq.001.jpeg)

## 3.5.1 Diagrama de las pantallas
![](images/diagramaPantallas.png)

### 3.6 Firebase
### Framework
* Firebase

### API
* Firebase provee un API para guardar y sincronizar datos en tiempo real.

### Backend
* Es la base de datos y como se comunica con la app atraves de la librería Firebase Swift

### Lenguaje de Programación
* Swift 4 para iOS 12

### Librerias Externas 3.6.1
* Libreria de Firebase para iOS
* Libreria de SQlite

### 3.7 Frontend
* Las pantallas del diagrama fueron diseñadas en Xcode con Swift y el Storyboard Builder


## 3.8 Pasos a seguir para utilizar el proyecto
1. Clonar Repositorio
2. Navegar a la carpeta Guardabosques
3. Abir con Xcode el archivo Guardabosques.xcworkspace
4. NOTA: No confundir con el otro archivo con extension .xcodeproj
5. Con el proyecto abierto en Xcode, agregar un nuevo Bundle Identifier y un Development Team
6. Correr el Proyecto en el Simulador de Xcode con el dispositivo predilecto
## 3.9 Referencias

* https://swift.org/documentation/
* https://www.sqlite.org/docs.html
* http://firebase.google.com/
* https://ecoosfera.com/2014/08/estas-son-las-reservas-naturales-de-mexico-como-protegerlas/
* http://www.unionjalisco.mx/articulo/2018/03/16/medio-ambiente/especies-en-peligro-de-extincion-en-mexico 
* https://www.forummexico.mx/top-5/%C3%A1reas-naturales-protegidas-en-m%C3%A9xico/
* https://ecoosfera.com/2016/10/10-especies-mexicanas-en-peligro-de-extincion/
