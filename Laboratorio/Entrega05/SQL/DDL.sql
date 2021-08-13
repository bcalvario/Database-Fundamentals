--Crear la tabla publica
create table publica(
razonSocial varchar(100),
nivel varchar(100),
calle varchar(100),
numero int,
municipio varchar(100),
estado varchar(100),
cp char(5),
telefonoContacto char(12)
);

--Agregar la restricción de la llave primaria
alter table publica add constraint pkpublica primary key(razonSocial);
alter table publica alter column nivel set not null;
alter table publica alter column calle set not null;
alter table publica alter column numero set not null;
alter table publica alter column municipio set not null;
alter table publica alter column estado set not null;
alter table publica alter column cp set not null;
alter table publica alter column telefonoContacto set not null;
alter table publica add constraint num check(numero >= 1);

-- Tabla Privada
create table privada(
razonSocial varchar(100),
telefonoContacto char(12),
nivel varchar(100),
calle varchar(100),
numero int,
municipio varchar(100),
estado varchar(100),
cp char(5)
);

alter table privada add constraint pkprivada primary key(razonSocial);
alter table privada alter column telefonoContacto set not null;
alter table privada alter column nivel set not null;
alter table privada alter column calle set not null;
alter table privada alter column numero set not null;
alter table privada alter column municipio set not null;
alter table privada alter column estado set not null;
alter table privada alter column cp set not null;
alter table privada add constraint num check(numero >= 1);

--Crear la tabla seguro
create table seguro(
idSeguro serial,
razonSocial varchar(100),
nombre varchar(100),
costo real,
cobertura varchar(100)
);

--Agregar la restricción de la llave primaria y la llave foranea
alter table seguro add constraint pkseguro primary key (idSeguro);
alter table seguro alter column nombre set not null;
alter table seguro alter column costo set not null;
alter table seguro alter column cobertura set not null;
alter table seguro add constraint costo1 check(costo >= 0);

--Crear la tabla aseguradora
create table aseguradora(
razonSocial varchar(100),
idAseguradora serial
);

--Agregar la restricción de la llave primaria compuesta
alter table aseguradora add constraint pkaseg primary key(razonSocial, idAseguradora);

-- Tabla Grupo
create table grupo(
idGrupo serial,
grado varchar(100),
cupoMax int
);

alter table grupo add constraint pkgrupo primary key(idGrupo);
alter table grupo alter column grado set not null;
alter table grupo alter column cupoMax set not null;
alter table grupo add constraint cupo check(cupoMax >= 0);

-- Tabla DocentePlaza
create table docentePlaza(
rfc varchar(13),
nombre varchar(100),
paterno varchar(100),
materno varchar(100),
fechaNacimiento date,
nombreArchivoFoto varchar(100),
celular varchar(12),
correo varchar(100),
esActivo boolean,
cedulaProfesional char(8),
numeroTrabajador serial,
sueldoMensual real
);

alter table docentePlaza add constraint pkdocentep primary key(rfc);
alter table docentePlaza alter column nombre set not null;
alter table docentePlaza alter column paterno set not null;
alter table docentePlaza alter column materno set not null;
alter table docentePlaza alter column fechaNacimiento set not null;
alter table docentePlaza alter column nombreArchivoFoto set not null;
alter table docentePlaza alter column celular set not null;
alter table docentePlaza alter column correo set not null;
alter table docentePlaza alter column esActivo set not null;
alter table docentePlaza alter column cedulaProfesional set not null;
alter table docentePlaza alter column numeroTrabajador set not null;
alter table docentePlaza alter column sueldoMensual set not null;
alter table docentePlaza add constraint sueld check(sueldoMensual >= 0);
alter table docentePlaza add constraint mail check(correo like '_%@_%._%');

-- Tabla DocenteHonorarios
create table docenteHonorarios(
rfc varchar(13),
nombre varchar(100),
paterno varchar(100),
materno varchar(100),
fechaNacimiento date,
nombreArchivoFoto varchar(100),
celular varchar(12),
correo varchar(100),
esActivo boolean,
cedulaProfesional char(8),
numeroTrabajador serial,
pagoContrato real
);

alter table docenteHonorarios add constraint pkdocenteh primary key(rfc);
alter table docenteHonorarios alter column nombre set not null;
alter table docenteHonorarios alter column paterno set not null;
alter table docenteHonorarios alter column materno set not null;
alter table docenteHonorarios alter column fechaNacimiento set not null;
alter table docenteHonorarios alter column nombreArchivoFoto set not null;
alter table docenteHonorarios alter column celular set not null;
alter table docenteHonorarios alter column correo set not null;
alter table docenteHonorarios alter column esActivo set not null;
alter table docenteHonorarios alter column cedulaProfesional set not null;
alter table docenteHonorarios alter column numeroTrabajador set not null;
alter table docenteHonorarios alter column pagoContrato set not null;
alter table docenteHonorarios add constraint pago check(pagoContrato >= 0);
alter table docenteHonorarios add constraint mail check(correo like '_%@_%._%');

-- Tabla Alumno
create table alumno(
curp char(18),
idGrupo serial,
nombreP varchar(100),
paternoP varchar(100),
maternoP varchar(100),
fechaNacimiento date,
nombreArchivoFoto varchar(100),
contactoEmergencia char(12),
promedio real
);

alter table alumno add constraint pkalumno primary key(curp);
alter table alumno add constraint fkalumno foreign key(idGrupo) references grupo(idGrupo)
on update cascade on delete cascade;
alter table alumno alter column nombreP set not null;
alter table alumno alter column paternoP set not null;
alter table alumno alter column maternoP set not null;
alter table alumno alter column fechaNacimiento set not null;
alter table alumno alter column nombreArchivoFoto set not null;
alter table alumno alter column contactoEmergencia set not null;
alter table alumno alter column promedio set not null;
alter table alumno add constraint prom check(promedio >= 0);

-- Tabla Boleta
create table boleta(
idBoleta serial,
curp char(18),
rfc varchar(13),
materia varchar (100),
grupo int,
anho char(4)
);

alter table boleta add constraint pkboleta primary key(idBoleta);
alter table boleta add constraint fkboleta foreign key(curp) references alumno(curp)
on update cascade on delete cascade;
alter table boleta add constraint fkboleta2 foreign key(rfc) references docentePlaza(rfc)
on update cascade on delete cascade;
alter table boleta add constraint fkboleta3 foreign key(rfc) references docenteHonorarios(rfc)
on update cascade on delete cascade;
alter table boleta alter column materia set not null;
alter table boleta alter column grupo set not null;
alter table boleta alter column anho set not null;
alter table boleta add constraint grup check(grupo >= 0);

-- Tabla Estudiar
create table estudiar(
razonSocial varchar(100),
curp char(18)
);

alter table estudiar add constraint fkestudiar foreign key(razonSocial) references publica(razonSocial)
on update cascade on delete cascade;
alter table estudiar add constraint fkestudiar2 foreign key(razonSocial) references privada(razonSocial)
on update cascade on delete cascade;
alter table estudiar add constraint fkestudiar3 foreign key(curp) references alumno(curp)
on update cascade on delete cascade;

-- Tabla Pagar
create table pagar(
razonSocial varchar(100),
curp char(18),
corriente boolean
);

alter table pagar add constraint fkpagar foreign key(razonSocial) references privada(razonSocial)
on update cascade on delete cascade;
alter table pagar add constraint fkpagar2 foreign key(curp) references alumno(curp)
on update cascade on delete cascade;
alter table pagar alter column corriente set not null;


-- Tabla Titular
create table titular(
rfc varchar(13),
idGrupo serial
);

alter table titular add constraint fktitular foreign key(rfc) references docentePlaza(rfc)
on update cascade on delete cascade;
alter table titular add constraint fktitular2 foreign key(rfc) references docenteHonorarios(rfc)
on update cascade on delete cascade;
alter table titular add constraint fktitular3 foreign key(idGrupo) references grupo(idGrupo)
on update cascade on delete cascade;

-- Tabla Laborar
create table laborar(
razonSocial varchar(100),
rfc varchar(13)
);

alter table laborar add constraint fklaborar foreign key(razonSocial) references publica(razonSocial)
on update cascade on delete cascade;
alter table laborar add constraint fklaborar2 foreign key(razonSocial) references privada(razonSocial)
on update cascade on delete cascade;
alter table laborar add constraint fklaborar3 foreign key(rfc) references docentePlaza(rfc)
on update cascade on delete cascade;
alter table laborar add constraint fklaborar4 foreign key(rfc) references docenteHonorarios(rfc)
on update cascade on delete cascade;

-- Tabla Director
create table director(
rfc char(13),
razonSocial varchar(100),
nombre varchar(100),
paterno varchar(100),
materno varchar(100),
fechaNacimiento date,
nombreArchivoFoto varchar(100),
numTrabajador serial,
cedProfesional char(8),
correo varchar(100),
celular char(12),
esActivo boolean,
bonoAdicional real,
periodoParticipacion varchar(100)
);

alter table director add constraint pkdirector primary key(rfc);
alter table director add constraint fkdirector foreign key(razonSocial) references publica(razonSocial)
on update cascade on delete cascade;
alter table director add constraint fkdirector2 foreign key(razonSocial) references privada(razonSocial)
on update cascade on delete cascade;
alter table director alter column nombre set not null;
alter table director alter column paterno set not null;
alter table director alter column materno set not null;
alter table director alter column fechaNacimiento set not null;
alter table director alter column nombreArchivoFoto set not null;
alter table director alter column numTrabajador set not null;
alter table director alter column cedProfesional set not null;
alter table director alter column correo set not null;
alter table director alter column celular set not null;
alter table director alter column esActivo set not null;
alter table director alter column periodoParticipacion set not null;
alter table director add constraint bono check(bonoAdicional >= 0);
alter table director add constraint mail check(correo like '_%@_%._%');


--Crear la tabla proveer
create table proveer(
razonSocial varchar(100),
idAseguradora serial,
idSeguro serial
);

--Agregar las restricciones de las llaves foraneas
alter table proveer
add constraint fkproveer2 foreign key(razonSocial, idAseguradora) references aseguradora(razonSocial, idAseguradora),
add constraint fkproveer3 foreign key(idSeguro) references seguro(idSeguro)
on update cascade on delete cascade;
