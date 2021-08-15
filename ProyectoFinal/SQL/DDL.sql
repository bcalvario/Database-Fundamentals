-- Tabla Docente
create table docente(
idAcademico serial,
numTrabajador serial,
rfc varchar(13),
cedProfesional char(8),
esActivo boolean,
nombre varchar(100),
paterno varchar(100),
materno varchar(100),
fechaNacimiento date,
nombreArchivoFoto varchar(100),
correo varchar(100),
celular varchar(12),
tipoContrato varchar(100),
pagoContrato real,
sueldoMensual real
);

-- Agregar restricciones de docente
alter table docente add constraint pkacademico primary key(idAcademico);
alter table docente alter column numTrabajador set not null;
alter table docente alter column rfc set not null;
alter table docente alter column cedProfesional set not null;
alter table docente alter column esActivo set not null;
alter table docente alter column nombre set not null;
alter table docente alter column paterno set not null;
alter table docente alter column materno set not null;
alter table docente alter column fechaNacimiento set not null;
alter table docente alter column nombreArchivoFoto set not null;
alter table docente alter column correo set not null;
alter table docente alter column celular set not null;
alter table docente alter column tipoContrato set not null;
alter table docente alter column pagoContrato set not null;
alter table docente alter column sueldoMensual set not null;
alter table docente add constraint pContrato check(pagoContrato >= 0);
alter table docente add constraint sMensual check(sueldoMensual >= 0);
alter table docente add constraint mail check(correo like '_%@_%._%');

-- Crear tabla escuela
create table escuela(
razonSocial varchar(100),
tipo varchar(100),
nivel varchar(100),
estado varchar(100),
municipio varchar(100),
calle varchar(100),
numero int,
cp char(5),
telefonoContacto char(12)
);

-- Agregar restricciones de escuela
alter table escuela add constraint pkescuela primary key(razonSocial);
alter table escuela alter column tipo set not null;
alter table escuela alter column nivel set not null;
alter table escuela alter column estado set not null;
alter table escuela alter column municipio set not null;
alter table escuela alter column calle set not null;
alter table escuela alter column numero set not null;
alter table escuela alter column cp set not null;
alter table escuela alter column telefonoContacto set not null;
alter table escuela add constraint num check(numero >= 1);

-- Crear la tabla aseguradora
create table aseguradora(
razonSocialAseguradora varchar(100)
);

-- Agregar la restricción de la llave primaria compuesta
alter table aseguradora add constraint pkaseguradora primary key(razonSocialAseguradora);

-- Tabla Director
create table director(
idAcademico serial,
razonSocial varchar(100),
numTrabajador serial,
rfc char(13),
cedProfesional char(8),
esActivo boolean,
nombre varchar(100),
paterno varchar(100),
materno varchar(100),
fechaNacimiento date,
nombreArchivoFoto varchar(100),
correo varchar(100),
celular char(12),
sueldo real,
bono real,
fechaInicio date,
fechaFin date,
periodo varchar(100)
);

-- Agregar restricciones de director
alter table director add constraint pkdirector primary key(idAcademico);
alter table director add constraint fkdirector foreign key(razonSocial) references escuela(razonSocial)
on update cascade on delete cascade;
alter table director alter column numTrabajador set not null;
alter table director alter column rfc set not null;
alter table director alter column cedProfesional set not null;
alter table director alter column esActivo set not null;
alter table director alter column nombre set not null;
alter table director alter column paterno set not null;
alter table director alter column materno set not null;
alter table director alter column fechaNacimiento set not null;
alter table director alter column nombreArchivoFoto set not null;
alter table director alter column correo set not null;
alter table director alter column celular set not null;
alter table director alter column sueldo set not null;
alter table director alter column bono set not null;
alter table director alter column fechaInicio set not null;
alter table director alter column fechaFin set not null;
alter table director alter column periodo set not null;
alter table director add constraint mail check(correo like '_%@_%._%');
alter table director add constraint bonoAdd check(bono >= 0);
alter table director add constraint sueldoAdd check(sueldo >= 0);

-- Crear la tabla seguro
create table seguro(
idSeguro serial,
razonSocialAseguradora varchar(100),
razonSocial varchar(100),
nombre varchar(100),
costo real,
cobertura varchar(100)
);

-- Agregar la restricción de la llave primaria y la llave foranea
alter table seguro add constraint pkseguro primary key (idSeguro);
alter table seguro add constraint fk1seguro foreign key(razonSocialAseguradora) references aseguradora(razonSocialAseguradora)
on update cascade on delete cascade;
alter table seguro add constraint fk2seguro foreign key(razonSocial) references escuela(razonSocial)
on update cascade on delete cascade;
alter table seguro alter column nombre set not null;
alter table seguro alter column costo set not null;
alter table seguro alter column cobertura set not null;
alter table seguro add constraint costo1 check(costo >= 0);

-- Tabla Grupo
create table grupo(
idGrupo serial,
razonSocial varchar(100),
idAcademico serial,
grado varchar(100),
cupo int
);

-- Agregar la restricción de la llave primaria y la llave foranea
alter table grupo add constraint pkgrupo primary key(idGrupo);
alter table grupo add constraint fk1grupo foreign key(razonSocial) references escuela(razonSocial)
on update cascade on delete cascade;
alter table grupo add constraint fk2grupo foreign key(idAcademico) references docente(idAcademico)
on update cascade on delete cascade;
alter table grupo alter column grado set not null;
alter table grupo alter column cupo set not null;
alter table grupo add constraint cupoMax check(cupo >= 0 AND cupo <= 100);


-- Tabla Alumno
create table alumno(
idAlumno serial,
razonSocial varchar(100),
idGrupo serial,
curp char(18),
nombre varchar(100),
paterno varchar(100),
materno varchar(100),
fechaNacimiento date,
nombreArchivoFoto varchar(100),
promedio real,
contactoEmergencia char(12),
corriente boolean,
cuota real,
fecha date
);

-- Agregar la restricción de la llave primaria y la llave foranea
alter table alumno add constraint pkalumno primary key(idAlumno);
alter table alumno add constraint fk1alumno foreign key(razonSocial) references escuela(razonSocial)
on update cascade on delete cascade;
alter table alumno add constraint fk2alumno foreign key(idGrupo) references grupo(idGrupo)
on update cascade on delete cascade;
alter table alumno alter column curp set not null;
alter table alumno alter column nombre set not null;
alter table alumno alter column paterno set not null;
alter table alumno alter column materno set not null;
alter table alumno alter column fechaNacimiento set not null;
alter table alumno alter column nombreArchivoFoto set not null;
alter table alumno alter column promedio set not null;
alter table alumno alter column contactoEmergencia set not null;
alter table alumno alter column cuota set not null;
alter table alumno add constraint prom check(promedio >= 0 AND promedio <= 10);
alter table alumno add constraint cuot check(cuota >= 0);

-- Tabla Boleta
create table boleta(
idBoleta serial,
idAlumno serial,
idAcademico serial,
materia varchar (100),
grupo int,
anho char(4),
calificacion real
);

-- Agregar la restricción de la llave primaria y la llave foranea
alter table boleta add constraint pkboleta primary key(idBoleta);
alter table boleta add constraint fk1boleta foreign key(idAlumno) references alumno(idAlumno)
on update cascade on delete cascade;
alter table boleta add constraint fk2boleta foreign key(idAcademico) references docente(idAcademico)
on update cascade on delete cascade;
alter table boleta alter column materia set not null;
alter table boleta alter column grupo set not null;
alter table boleta alter column anho set not null;
alter table boleta alter column calificacion set not null;
alter table boleta add constraint grup check(grupo >= 0);
alter table boleta add constraint calif check(calificacion >= 0 AND calificacion <= 10);

-- Tabla Titular
create table titular(
idAcademico serial,
idGrupo serial
);

-- Agregar la restricción de la llave primaria y la llave foranea
alter table titular add constraint fk1titular foreign key(idAcademico) references docente(idAcademico)
on update cascade on delete cascade;
alter table titular add constraint fk2titular foreign key(idGrupo) references grupo(idGrupo)
on update cascade on delete cascade;

-- Tabla Laborar
create table laborar(
razonSocial varchar(100),
idAcademico serial
);

-- Agregar la restricción de la llave primaria y la llave foranea
alter table laborar add constraint fk1laborar foreign key(razonSocial) references escuela(razonSocial)
on update cascade on delete cascade;
alter table laborar add constraint fk2laborar foreign key(idAcademico) references docente(idAcademico)
on update cascade on delete cascade;

--Crear tabla pagoMensual
create table pagoMensual(
idAlumno serial,
razonSocial varchar(100),
pagoMensual real
);

--Agregar restricciones de pagoMensual
alter table pagoMensual add constraint fk1pagoMensual foreign key(idAlumno) references alumno(idAlumno)
on update cascade on delete cascade;
alter table pagoMensual add constraint fk2pagoMensual foreign key(razonSocial) references escuela(razonSocial)
on update cascade on delete cascade;
alter table pagoMensual alter column pagoMensual set not null;
alter table pagoMensual add constraint pagoM check(pagoMensual >= 0);