CREATE TRIGGER Trg_CalulareTarifOferta
   ON  Oferta
   AFTER INSERT
AS 
BEGIN
	DECLARE @idOferta int = (SELECT idOferta from inserted)
	DECLARE @dataPlecarii date = (SELECT dataPlecarii from inserted)
	DECLARE @dataSosirii date = (SELECT dataSosirii from inserted)
	DECLARE @pret int = (SELECT pret from Preturi p
						inner join Oferta o on o.idCazare=p.idCazare
						WHERE @dataPlecarii>=p.perioadaStart and @dataSosirii<=p.perioadaEnd)
						
	UPDATE OFERTA 
		SET tarif=@pret
		where idOferta=@idOferta
END
GO
