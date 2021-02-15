Marbel App

Arquitectura MVVM + Coordinators

MVMM es un patron para organizar el codigo de la vista, y su logica asociada. El ViewModel representa el modelo, haciendo las transformaciones necesarias sobre él, para poder renderizarlo.

Los Coordinators son un patrón para organizar el código de navegación de la app, descargando al Controller de esa responsabilidad, con una jerarquia nodos/coordinators, donde el AppCoordinator es la raíz, que se encarga de la UIWindow. Existirán tantos como flujos de navegacion salgan del AppCoordinator. Permiten que los ViewControllers no conozcan a otros ViewControllers, y sean más independientes. Ademas, un mismo Controller puede ser lanzado desde varios puntos de la app, sin que ese Controller sepa en qué contexto.

Cada coordinator creado tiene un:
	- Presenter: que es un UINavigationController.
	- DataManager: que es la clase que maneja el acceso a los datos. En este caso son accesos remotos, pero podrian ser locales, asi que implementa un data manager de accesos remotos que crea una sesion con el api.

No he utilizado librerias de terceros para el acceso al API o la presentación de imagenes como Alamofire o Kingfisher respectivamente, ya que con estas librerias, que he usado en muchos de mis trabajos, el trabajo es mas fácil, y he preferido mostrar cómo se realiza en nativo.

Se han implementado test para validar el desarrollo.
Se ha desarrollado un correcto control de errores.
Se ha añadido la descarga y el muestreo de los comics de un personaje en el detalle.