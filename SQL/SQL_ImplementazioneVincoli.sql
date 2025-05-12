-- Condivisione collezione privata
DELIMITER $$
CREATE FUNCTION flagpubbPriv (ID_param CHAR(5)) RETURNS CHAR(8) DETERMINISTIC
BEGIN
RETURN (SELECT pubbPriv FROM collezione WHERE ID=ID_param);
 END$$

DELIMITER $$
CREATE TRIGGER condivide_privata BEFORE INSERT ON condivide FOR EACH ROW
BEGIN
	DECLARE ID_trigger CHAR(5);
	SET ID_trigger = NEW.ID_Collezione;
	IF flagpubbPriv(ID_trigger)='Privata' THEN
	 SIGNAL SQLSTATE '45000' SET message_text = 'Non puoi condividere una collezione privata!';
	END IF;
END$$


-- Condivisione con se stessi
DELIMITER $$
CREATE FUNCTION funzCollezionista (ID_param_1 CHAR(5), ID_param_2 CHAR(5)) RETURNS CHAR(5) DETERMINISTIC
BEGIN
RETURN (SELECT ID_Collezionista FROM collezione WHERE ID=ID_param_1 AND ID_Collezionista=ID_param_2);
 END$$

DELIMITER $$
CREATE TRIGGER condivide_stesso BEFORE INSERT ON condivide FOR EACH ROW FOLLOWS condivide_privata
BEGIN
	DECLARE ID_trigger_1 CHAR(5);
    DECLARE ID_trigger_2 CHAR(5);
	SET ID_trigger_1 = NEW.ID_Collezione;
    SET ID_trigger_2 = NEW.ID_Collezionista;
	IF NEW.ID_Collezionista=funzCollezionista(ID_trigger_1, ID_trigger_2) THEN
	 SIGNAL SQLSTATE '45000' SET message_text = 'Non puoi condividere una collezione con te stesso!';
	END IF;
END$$