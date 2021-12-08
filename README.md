# TMDb

1. Las capas de la aplicación (por ejemplo capa de persistencia, vistas, red, negocio, etc) y
qué clases pertenecen a cual.
2. La responsabilidad de cada clase creada.

Frameworks & drivers:
- JsonDecodeManager: clase concreta para deserializador JSON a objetos, implementa interface DecodeManager.
- SQLiteStoreManagerMovie: clase concreta para acceso a sqlite, implementa interface StoreManagerMovie.
- URLBuilder: Clase estatica para construir las url de las API.
- TMDbConstants: Clase con constantes para las url de las API.
- URLSessionNetworkManager: clase concreta para comunicaion con http, implementa interface NetworkManager.

Interface Adapters:
- MoviesReducer: Encargado de crea un nuevo State, segun que Action reciba.
- MoviesView, MovieCellView, MovieCardView, MovieDetailView, YoutubeWebView: GUI
- MoviesState: almacena el modelo. implementa interface MoviesStateModel
- MoviesStatePresenter: Presenta los datos a la View. implement al interface MoviesStateUseCaseOutput

Use Cases:
- MoviesStateUseCase:  Despacha los casos de usos. implementa interface MoviesStateUseCaseInput
- MoviesMiddleware: Orquesta la ejecucion de una Action

Entities:
- MoviesAction: Enum de acciones
- MovieCategory, MovieResult, MovieResponse, VideoMovieResponse: Modelos


1. En qué consiste el principio de responsabilidad única? Cuál es su propósito?
Consiste en definir una responsabilidad unica por modulo/class/struct/func(unidad de software) sobre una parte de la funcionalidad del sofware
- Contener la propagacion de cambios
- Organizar/Dividir las resposabilidades.

2. Qué características tiene, según su opinión, un “buen” código o código limpio
- cumplir principios SOLID.
- implementar design patterns.
- cumplir las reglas de Clean Architecture.
- agregar simulaciones(objetos mocks)
- ejecutar unit test/ ui test, alineadas a los objetivos de la logica de negocio.
