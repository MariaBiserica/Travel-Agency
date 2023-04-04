--crearea bazei de date
IF NOT EXISTS(Select * From sys.databases WHERE Name='AgentieDeTurism')
Create database AgentieDeTurism; 
use AgentieDeTurism

--crearea tabelelor aferente bazei de date

IF NOT EXISTS(Select * From sys.tables WHERE Name='AgentiePrincipala')
Begin
Create table AgentiePrincipala(
   idAgentie INT Primary Key IDENTITY(1,1),
   numeAgentie varchar(30),
	adresaAgentie varchar(30),
	telefonAgentie varchar(30)
  )
END

IF NOT EXISTS(Select * From sys.tables WHERE Name='ContractFiliala')
Begin
Create table ContractFiliala(
   idContractFiliala INT Primary Key IDENTITY(1,1),
   dataContractarii date,
   tarifPerceputFirmaAngajata int
  )
END

IF NOT EXISTS(Select * From sys.tables WHERE Name='FilialaAgentie')
Begin
Create table FilialaAgentie(
   idFiliala INT Primary Key IDENTITY(1,1),
   numeFiliala varchar(30),
   adresaFiliala varchar(30),
   telefonFiliala varchar(30),
   idAgentie int foreign key REFERENCES AgentiePrincipala(idAgentie),
	idContractFiliala int foreign key REFERENCES ContractFiliala(idContractFiliala)
  )
END

IF NOT EXISTS(Select * From sys.tables WHERE Name='ContractAngajat')
Begin
Create table ContractAngajat(
   idContractAngajat INT Primary Key IDENTITY(1,1),
   dataAngajare date,
   salariuPornire int,
   functie varchar(30),
   )
END

IF NOT EXISTS(Select * From sys.tables WHERE Name='Angajat')
Begin
Create table Angajat(
   idAngajat INT Primary Key IDENTITY(1,1),
   numeAngajat varchar(30),
   prenumeAngajat varchar(30),
   salariuCurent int,
   adresaAngajat varchar(30),
   aniExperienta int,
   idFiliala int foreign key REFERENCES FilialaAgentie(idFiliala),
	idContractAngajat int foreign key REFERENCES ContractAngajat(idContractAngajat)
  )
END

IF NOT EXISTS(Select * From sys.tables WHERE Name='Client')
Begin
Create table Client(
   CNPClient varchar(30) Primary Key,
   codGrup int,
   numeClient varchar(30),
   prenumeClient varchar(30),
   dataNasterii date,
   telefonClient varchar(30)
  )
END

IF NOT EXISTS(Select * From sys.tables WHERE Name='DetaliiTransport')
Begin
Create table DetaliiTransport(
   idDetaliiTransport INT Primary Key IDENTITY(1,1),
   pretMinim int,
   pretMaxim int,
   nrOreMinim int,
   nrOreMaxim int
  )
END

 IF NOT EXISTS(Select * From sys.tables WHERE Name='Transport')
Begin
Create table Transport(
    idTransport INT Primary Key IDENTITY(1,1),
    numeFirmaTransport varchar(30),
    tipTransport varchar(30),
    pret int,
	idContractFiliala int foreign key REFERENCES ContractFiliala(idContractFiliala),
	idDetaliiTransport int foreign key REFERENCES DetaliiTransport(idDetaliiTransport)
  )
END

 IF NOT EXISTS(Select * From sys.tables WHERE Name='Destinatie')
Begin
Create table Destinatie(
   idDestinatie INT Primary Key IDENTITY(1,1),
   tara varchar(30),
   oras varchar(30)
  )
END

IF NOT EXISTS(Select * From sys.tables WHERE Name='Cazare')
Begin
Create table Cazare(
   idCazare INT Primary Key IDENTITY(1,1),
	numeLocatie varchar(30),
	adresa varchar(30),
	telefonCazare varchar(30),
	rating float, --rating de la 1 la 5 de ex: 3,67
	regimCazare varchar(30),
	internet varchar(30),
	balcon varchar(30),
	aerConditionat varchar(30),
	pret int,
	idContractFiliala int foreign key REFERENCES ContractFiliala(idContractFiliala),
	idDestinatie int foreign key REFERENCES Destinatie(idDestinatie)
  )
END

 IF NOT EXISTS(Select * From sys.tables WHERE Name='Preturi')
Begin
Create table Preturi(
    pret int,
	perioada date,
	idTransport int foreign key REFERENCES Transport(idTransport),
	idCazare int foreign key REFERENCES Cazare(idCazare)
  )
END

alter table Preturi
add tipTransport varchar(20)

alter table Preturi
drop column perioada

alter table Preturi
add perioadaStart date
alter table Preturi
add perioadaEnd date

select * from Preturi

IF NOT EXISTS(Select * From sys.tables WHERE Name='Oferta')
Begin
Create table Oferta(
   idOferta INT Primary Key IDENTITY(1,1),
	tarif int,
	dataPLecarii date,
	dataSosirii date,
	tipExcursie varchar(30),
	discount varchar(30),
	asigurareMedicala varchar(30),
	idCazare int foreign key REFERENCES Cazare(idCazare),
	idTransport int foreign key REFERENCES Transport(idTransport)
  )
END

IF NOT EXISTS(Select * From sys.tables WHERE Name='ContractClient')
Begin
Create table ContractClient(
   idContract INT Primary Key IDENTITY(1,1),
	dataContractariiClient date,
	avansAcordat int,
	scadentaPlatiiIntegrale date,
    CNPClient varchar(30) foreign key REFERENCES Client(CNPClient),
	idAngajat int foreign key REFERENCES Angajat(idAngajat),
	idOferta int foreign key REFERENCES Oferta(idOferta)
  )
END

--inserarea inregistrarilor in tabele
insert into AgentiePrincipala
values  ('WorldTour','Str. A.I.Cuza 21','0368548258'),
		('TravelTogether','Str. Morii 45','0754145215'),
		('SunnyHolidays','Str. Nicopole 6','0742154263'),
		('ExploreNow' , 'Str. Dinicu Golescu 7', '0745652145'),
		('VoyagerTourism','Str. Libertatii 41','0238145221')
select * from AgentiePrincipala

insert into ContractFiliala
values  ('2023-01-10',6500),
		('2022-12-07',4850),
		('2022-12-17',7000),
		('2022-10-25',2500),
		('2022-05-13',8900)
select * from ContractFiliala

insert into FilialaAgentie
values ('WorldTour-Brasov','Str. Piatra Mare 19','07541254896',1,1),
	   ('TravelTogheter-Bucuresti','Str. Matei Basarab 27', '0741897858',2,2),
	   ('SunnyHolidays-Timisoara','Str. Independentei 8', '0732451266',3,3),
	   ('ExploreNow-Braila','Strada de Mijloc 5','0746548258',4,4),
	   ('VoyagerTourism-Cluj','Str. Dealul Clujului 68','0765214323',5,5)
select * from FilialaAgentie
select * from ContractAngajat

insert into ContractAngajat
values  ('2017-12-06',6000,'Manager'),
		('2020-07-25',4000,'Consilier Turism'),
		('2021-04-23',4000,'Agent Turism'),
		('2022-11-14',3000,'Receptioner'),
		('2019-06-17',4500,'Ghid turistic')

insert into ContractAngajat
values  ('2018-12-06',6000,'Manager')

--adresa angajati = doar oras pt a putea face interogari
insert into Angajat
values  ('Pop','Anca',6000,'BV',6,2,1),
		('Ionescu','Aurelian',3500,'B',2,3,2),
		('Manole','Valeria',4000,'TM',10,4,3),
		('Vasile','Irina',3000,'BR',5,5,4),
		('Constantin','Vlad',4500,'CJ',10,3,5),
		('Iriminescu','David',6000,'CJ',8,1,6)
select * from Angajat

insert into Client
values  ('2940618038763',17,'Andrei','Andreea','1994-06-18','0784526354'),
		('2940709284561',17,'Biserica','Maria','1994-07-09','0774154225'),
		('5020221139587',21,'Chindea','Cosmin','2002-02-21','0723564582'),
		('2990514018441',5,'Rentea','Diana','1999-05-14','0724149864'),
		('5041205088154',16,'Branaci','Serban','2004-12-05','0736548987')
select * from Client

--a fost schimbata structura tabelului
insert into DetaliiTransport
values  (350,500,4,6),
		(5000,5500,10,12),
		(1250,1500,6,8),
		(2750,3000,10,11),
		(700,750,7,9)
alter table DetaliiTransport
drop column pretMinim
select * from DetaliiTransport

alter table DetaliiTransport
drop column pretMaxim
select * from DetaliiTransport

--trebuie pretul calculat
insert into Transport (numeFirmaTransport,tipTransport,idContractFiliala,idDetaliiTransport)
values  ('CDI Transport','autocar',4,1),
		('Matrix Transport','autocar',2,5),
		('Lufthansa','avion',5,2),
		('Qatar Airlines','avion',3,4),
		('flyDubai','avion',1,3)
select * from Transport

insert into Destinatie
values  ('Emiratele Arabe Unite','Abu Dabi'),
		('Japonia','Tokyo'),
		('Thailanda','Bangkok'),
		('Italia','Roma'),
		('Franta','Paris')
select * from Destinatie
select * from ContractFiliala

insert into Cazare (numeLocatie,adresa,telefonCazare,rating,regimCazare,internet,balcon,aerConditionat,idContractFiliala, idDestinatie)
values  ('Emirates Palace','West Corniche Road','+97126909000',4.3,'All inclusive','da','da','nu',5,1),
		('Aman Tokyo','The Otemachi Tower','+81352243333',4,'All inclusive','da','nu','da',3,2),
		('Capella Bangkok','300 2 Charoen Krung Rd','+6620983888',3.6,'Demi Pensiune','da','nu','da',1,3),
		('Hotel Hassler Roma','Piazza della Trinita dei Monti','+3906699340',4.8,'Demi Pensiune','da','da','da',2,4),
		('Ritz Paris','15 Pl. Vendôme, 75001','+33143163030',4.8,'All inclusive','da','da','nu',4,5)
select * from Cazare
select * from Destinatie
select * from Transport

insert into Preturi(pret,idTransport,tipTransport) --desi e cu rosu, coloana apare in tabel, e posibil sa fie asa de la alter table?
values  (2000,1,'autocar'),--transport id=1 - autocar
		(3500,2,'autocar')--transport id=2 - autocar
select * from Preturi

insert into Preturi(pret,idTransport,tipTransport) 
values  (4000,3,'avion'),--transport id=3 - avion
		(5600,4,'avion'),--transport id=4 - avion
		(6750,5,'avion')--transport id=4 - avion
select * from Preturi

insert into Preturi(idCazare,perioadaStart,perioadaEnd,pret) -- coloane adaugate cu alter table
values  (1,'2022-12-01','2023-02-28',3500), -- decembrie->februarie
		(1,'2023-03-01','2023-04-30',5500), -- mar-apr
		(1,'2023-05-01','2023-06-30',4500),-- mai-iun
		(1,'2023-07-01','2023-08-30',6700),-- iul-aug
		(1,'2023-09-01','2023-11-30',7500)-- sept-nov

insert into Preturi(idCazare,perioadaStart,perioadaEnd,pret) 
values  (2,'2022-12-01','2023-02-28',4500), -- decembrie->februarie
		(2,'2023-03-01','2023-04-30',2500), -- mar-apr
		(2,'2023-05-01','2023-06-30',6500),-- mai-iun
		(2,'2023-07-01','2023-08-30',8000),-- iul-aug
		(2,'2023-09-01','2023-11-30',3500)-- sept-nov

insert into Preturi(idCazare,perioadaStart,perioadaEnd,pret) 
values  (3,'2022-12-01','2023-02-28',2500), -- decembrie->februarie
		(3,'2023-03-01','2023-04-30',3500), -- mar-apr
		(3,'2023-05-01','2023-06-30',4500),-- mai-iun
		(3,'2023-07-01','2023-08-30',9000),-- iul-aug
		(3,'2023-09-01','2023-11-30',6000)-- sept-nov

insert into Preturi(idCazare,perioadaStart,perioadaEnd,pret)
values  (4,'2022-12-01','2023-02-28',2500), -- decembrie->februarie
		(4,'2023-03-01','2023-04-30',3000), -- mar-apr
		(4,'2023-05-01','2023-06-30',4500),-- mai-iun
		(4,'2023-07-01','2023-08-30',6000),-- iul-aug
		(4,'2023-09-01','2023-11-30',3000)-- sept-nov

insert into Preturi(idCazare,perioadaStart,perioadaEnd,pret)
values  (5,'2022-12-01','2023-02-28',3500), -- decembrie->februarie
		(5,'2023-03-01','2023-04-30',3000), -- mar-apr
		(5,'2023-05-01','2023-06-30',2500),-- mai-iun
		(5,'2023-07-01','2023-08-30',4200),-- iul-aug
		(5,'2023-09-01','2023-11-30',3670)-- sept-nov
select * from Preturi
alter table Transport
drop column pret
--trebuie adaugate asigurari
insert into Oferta(dataPLecarii,dataSosirii, tipExcursie,idCazare,idTransport)--fara discount
values  ('2023-01-12','2023-02-12','Croaziera',1,3),--emirates, avion
		('2023-01-27','2023-02-05','Croaziera',4,1)--roma, autocar
select * from Oferta

insert into Oferta(dataPLecarii,dataSosirii, tipExcursie,discount,idCazare,idTransport)
values	('2022-12-06','2022-12-25','Sejur','discountCopil',2,4),
		('2022-08-06','2022-09-29','Croaziera','discountPensionar',3,5), 
		('2022-11-10','2022-11-20','Sejur','discountCopil',5,2)

alter table Oferta
add tarifCuDiscount int

select * from Angajat
select * from Client
select * from Preturi
select * from Oferta
select * from Cazare
select * from Transport
select * from ContractAngajat

insert into ContractClient(dataContractariiClient,scadentaPlatiiIntegrale,CNPClient,idAngajat,idOferta)
values  ('2022-12-25','2023-01-10','2940618038763',21,2),
		('2022-12-14','2023-01-04','2940709284561',23,3),
		('2022-11-21','2022-12-02','2990514018441',22,4),
		('2022-07-27','2022-08-01','5020221139587',26,5),
		('2022-10-27','2022-11-05','5041205088154',25,6)

select * from ContractClient
select * from Client

insert into Client
values  ('1452489584685',17,'Popa','Marius','2019-08-19','0745489615'),
		('1549857245326',5,'Ionescu','Dorel','1945-11-23','0784526589')

 --constrangere pentru tipul de trasnport
Alter table Transport
Add Constraint Tip_Transport
Check (tipTransport in ('autocar','avion'));

insert into Transport(numeFirmaTransport,tipTransport,idContractFiliala,idDetaliiTransport)
values  ('MaxiBoat','barca',4,1)
select * from Transport

alter table Cazare
drop column pret

--calcularea tarifului pentru oferte fara discount-uri
insert into Oferta(dataPLecarii,dataSosirii, tipExcursie,discount,idCazare,idTransport)
values	('2022-12-08','2022-12-27','Croaziera','discountCopil',2,4)


--afiseaza oferta cu tariful maxim
--pt acelasi tip de destinatie avem mai multe oferte cu tarife diferite
select * from Oferta
select max(o.tarif) as pretMaximOferta, d.tara as tara, d.oras as oras
 from Oferta o
 inner join Cazare c on c.idCazare=o.idCazare
 inner join  Destinatie d on d.idDestinatie=c.idDestinatie
group by d.tara,d.oras

--oferta cu tariful minim(dintre toate)
--functie pentru determinarea celei mai ieftine oferte

 declare @tarifMinim int = (select min(tarif) from Oferta)

 select * from Oferta

 select @tarifMinim as pretMinimOferta
 select o.tarif,d.tara as tara, d.oras as oras
 from Oferta o
 inner join Cazare c on c.idCazare=o.idCazare
 inner join  Destinatie d on d.idDestinatie=c.idDestinatie
 group by d.tara,d.oras,o.tarif
 having tarif=@tarifMinim

 --cea mai ieftina oferta dintr-o tara anume
 --ofertele dintr 0 tara anume si suma de cazare sa fie mai mica decat, sau sa fie intr un interval de preturi

