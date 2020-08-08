/*---- BASE DE CONOCIMIENTOS ----*/

/*- PROPIEDADES -*/
nombre(beatriz).
nombre(claudia).
nombre(alicia).

apellido(garcia).
apellido(lopez).
apellido(mendez).

profesion(secretaria).
profesion(actriz).
profesion(maestra).

/*---- JUEGO DE LÓGICA ----*/
mensaje :- nl,write('Ejemplo "Juego Lógico" cargado.'),nl,
 write('Se lanza con ?- iniciar.'),
 nl,nl.

/*---- RUTINAS GENERALES ----*/
/* escribir(Lista1,Lista2,...) <- escribe las soluciones correlacionadas
de las listas: Lista1, Lista2 ... */

escribir([],[],[]).
escribir([Obj1|Resto1],[Obj2|Resto2],[Obj3|Resto3]) :-
 write(Obj1), write(' - '),write(Obj2),
 write(' - '), write(Obj3),nl,
 escribir(Resto1,Resto2,Resto3).

/* pausa <- detiene la ejecución del programa hasta que se pulse una tecla */
pausa :- write('Pulsa <return> para buscar otra solucion'),
 skip(10),nl.

/*---- RUTINAS DE MANEJO DE LISTAS ----*/
/* nopertenece(Elem,Lista)) <- el elemento Elem no pertenece a la lista Lista */
nopertenece(_,[]).
nopertenece(E,[X|L]) :- E\=X,
 nopertenece(E,L).

/* nel(Lista,N) <- el número de elementos de la lista Lista es N */
nel([],0).
nel([_|L],N) :- nel(L,M),
 N is M+1.

/*relaciones entre las propiedades*/

%Relacion nombre,profesion
relacion_nombre_profesion(claudia,actriz).
relacion_nombre_profesion(Nombre,Profesion):- nombre(Nombre),Nombre\=claudia,profesion(Profesion),Profesion\=actriz.

%Relacion nombre,apellido
relacion_nombre_apellido(beatriz,Apellido):- apellido(Apellido), Apellido\=garcia.
relacion_nombre_apellido(Nombre,Apellido):- nombre(Nombre), Nombre\=beatriz, apellido(Apellido).

%Relacion apellido,profesion
relacion_apellido_profesion(lopez,secretaria).
relacion_apellido_profesion(Apellido,maestra):- apellido(Apellido), Apellido\=mendez, Apellido\=lopez.
relacion_apellido_profesion(Apellido,Profesion):- apellido(Apellido),  profesion(Profesion), Profesion\=secretaria, Profesion\=maestra.

/*---- PROGRAMA PRINCIPAL ----*/
/* iniciar <- llamada inicial del programa */
iniciar:- !,ini(3,[],[],[]).

/* Correlacionar las propiedades de nombre, apellido y profesion propiedades */
ini(M,ListaNombre,ListaApellido,ListaProfesion) :- nel(ListaNombre,M),escribir(ListaNombre,ListaApellido,ListaProfesion),nl.
ini(M,ListaNombre,ListaApellido,ListaProfesion) :- relacion_nombre_profesion(Nombre,Profesion),
 nopertenece(Nombre,ListaNombre),
nopertenece(Profesion,ListaProfesion),
relacion_nombre_apellido(Nombre,Apellido),
nopertenece(Apellido,ListaApellido),
relacion_apellido_profesion(Apellido,Profesion),
ini(M,[Nombre|ListaNombre],[Apellido|ListaApellido],[Profesion|ListaProfesion]).

:- mensaje.