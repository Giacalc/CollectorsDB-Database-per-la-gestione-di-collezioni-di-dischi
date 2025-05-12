-- QUERY 1: Inserimento di una nuova collezione.
INSERT INTO collezione (nome, pubbPriv, ID_Collezionista) VALUES
('Collezione query', 'Privata', (SELECT ID FROM collezionista WHERE nickname='luca14'));


-- QUERY 2: Aggiunta di dischi a una collezione e di tracce a un disco.
INSERT INTO disco (titolo, annodiUscita, barcode, ID_Collezione) VALUES
('Disco query', 2023, 1987509384765, (SELECT ID FROM collezione WHERE nome='Collezione query')); 
INSERT INTO disco (titolo, annodiUscita, barcode, ID_Collezione) VALUES
('Disco query: Remastered', 2024, 1457596544767, (SELECT ID FROM collezione WHERE nome='Collezione query'));
 
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES
('Canzone Query', '00:03:14', (SELECT ID FROM disco WHERE titolo='Disco query'));
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES
('Canzone Query 2', '00:05:10', (SELECT ID FROM disco WHERE titolo='Disco query'));


-- QUERY 3: Modifica dello stato di pubblicazione di una collezione (da privata a pubblica e viceversa) e aggiunta di nuove condivisioni a una collezione.
UPDATE collezione SET pubbPriv='Pubblica' where nome='Collezione query';
UPDATE collezione SET pubbPriv='Privata' where nome='Collezione query';

INSERT INTO condivide (ID_Collezione, ID_Collezionista) VALUES
((SELECT ID FROM collezione WHERE nome='Collezione query'), 
(SELECT ID FROM collezionista WHERE nickname='carlos56'));
INSERT INTO condivide (ID_Collezione, ID_Collezionista) VALUES
((SELECT ID FROM collezione WHERE nome='Collezione query'),
(SELECT ID FROM collezionista WHERE nickname='marios22'));


-- QUERY 4: Rimozione di un disco da una collezione.
DELETE FROM disco 
WHERE titolo='OUT' AND annoDiUscita='2023'
AND ID_Collezione=((SELECT ID FROM collezione WHERE nome='Collezione query'));


-- QUERY 5: Rimozione di una collezione
DELETE FROM collezione WHERE nome='Collezione out' and ID_Collezionista=
(SELECT ID FROM collezionista WHERE nickname='marios22');


-- QUERY 6: Lista di tutti i dischi in una collezione
SELECT disco.titolo AS 'Nome Disco', disco.annoDiUscita AS 'Anno di Uscita',
GROUP_CONCAT(d_Genere.nomeGenere) AS 'Genere'
FROM disco
JOIN collezione ON (disco.ID_Collezione = collezione.ID)
JOIN collezionista ON (collezione.ID_Collezionista = collezionista.ID)
JOIN d_Genere ON (disco.ID = d_Genere.ID_disco)
WHERE collezione.nome = 'Musica in movimento' AND collezionista.nickname = 'carlos56'
GROUP BY disco.titolo, disco.annoDiUscita;


-- QUERY 7: Track list di un disco
SELECT traccia.titolo AS 'Titolo', traccia.durata AS 'Durata'
FROM traccia JOIN disco ON (traccia.ID_Disco=disco.ID)
WHERE disco.titolo='Dream' AND disco.annodiUscita=2022 AND disco.ID_Collezione=1


-- QUERY 8: Ricerca di dischi in base a nomi di autori/compositori/interpreti 
-- e/o titoli. Si potrà decidere di includere nella ricerca le collezioni di un
-- certo collezionista e/o quelle condivise con lo stesso collezionista e/o 
-- quelle pubbliche.
DELIMITER $$
CREATE PROCEDURE query8 (personal BOOLEAN, condivise BOOLEAN, pubbliche BOOLEAN)
BEGIN
	CREATE TEMPORARY TABLE query8_Start AS
	(
		SELECT DISTINCT disco.* FROM collezione 
		JOIN collezionista ON (collezione.ID_Collezionista=collezionista.ID)
		JOIN condivide ON (collezione.ID=condivide.ID_Collezione)
		JOIN disco on (collezione.ID=disco.ID_Collezione) 
		JOIN d_Compone ON (disco.ID=d_Compone.ID_Disco) 
		JOIN autore ON (d_Compone.ID_Autore=autore.ID)
		WHERE (autore.pseudonimo='John Brave' AND (d_Compone.ruolo='Autore' OR d_Compone.ruolo='Compositore'
		OR d_Compone.ruolo='Interprete')) OR disco.titolo='Compilation 2003'
    );
	CREATE TEMPORARY TABLE query8_Personal AS
	(	
		SELECT DISTINCT disco.* FROM collezione 
		JOIN collezionista ON (collezione.ID_Collezionista=collezionista.ID)
		JOIN condivide ON (collezione.ID=condivide.ID_Collezione)
		JOIN disco on (collezione.ID=disco.ID_Collezione) 
		JOIN d_Compone ON (disco.ID=d_Compone.ID_Disco) 
		JOIN autore ON (d_Compone.ID_Autore=autore.ID)
		WHERE collezionista.nickname='marios22'
	);
    CREATE TEMPORARY TABLE query8_Condivise AS
	(
		SELECT disco.* FROM collezione 
		JOIN collezionista ON (collezione.ID_Collezionista=collezionista.ID)
		JOIN condivide ON (collezione.ID=condivide.ID_Collezione)
		JOIN disco on (collezione.ID=disco.ID_Collezione) 
		JOIN d_Compone ON (disco.ID=d_Compone.ID_Disco) 
		JOIN autore ON (d_Compone.ID_Autore=autore.ID)
		WHERE condivide.ID_Collezionista=(SELECT ID FROM collezionista WHERE nickname='marios22')
	);
	CREATE TEMPORARY TABLE query8_Pubbliche AS
	(
		SELECT disco.* FROM collezione 
		JOIN collezionista ON (collezione.ID_Collezionista=collezionista.ID)
		JOIN condivide ON (collezione.ID=condivide.ID_Collezione)
		JOIN disco on (collezione.ID=disco.ID_Collezione) 
		JOIN d_Compone ON (disco.ID=d_Compone.ID_Disco) 
		JOIN autore ON (d_Compone.ID_Autore=autore.ID)
		WHERE pubbPriv='Pubblica'
	);

IF (personal AND condivise AND pubbliche) THEN
	SELECT * FROM query8_Start
    UNION
	SELECT * FROM query8_Personal
    UNION
    SELECT * FROM query8_Condivise
    UNION
    SELECT * FROM query8_Pubbliche;
ELSEIF (personal AND condivise) THEN
	SELECT * FROM query8_Start
    UNION
	SELECT * FROM query8_Personal
    UNION
    SELECT * FROM query8_Condivise;
ELSEIF (personal AND pubbliche) THEN
	SELECT * FROM query8_Start
    UNION
	SELECT * FROM query8_Personal
    UNION
    SELECT * FROM query8_Pubbliche;
ELSEIF (condivise AND pubbliche) THEN
	SELECT * FROM query8_Start
    UNION
	SELECT * FROM query8_Condivise
    UNION
    SELECT * FROM query8_Pubbliche;
ELSEIF (personal) THEN
	SELECT * FROM query8_Start
    UNION
	SELECT * FROM query8_Personal;
ELSEIF (condivise) THEN
	SELECT * FROM query8_Start
    UNION
	SELECT * FROM query8_Condivise;
ELSEIF (pubbliche) THEN
	SELECT * FROM query8_Start
    UNION
	SELECT * FROM query8_Pubbliche;
ELSEIF NOT(personal AND condivise AND pubbliche) THEN
	SELECT * FROM query8_Start;
 END IF;
 
DROP TABLE query8_Start;
DROP TABLE query8_Personal;
DROP TABLE query8_Condivise;
DROP TABLE query8_Pubbliche;
 
END$$

CALL query8(1,1,1)


-- QUERY 9: Verifica della visibilità di una collezione da parte di un collezionista.
SELECT DISTINCT collezione.nome FROM collezione 
JOIN collezionista ON (collezione.ID_Collezionista=collezionista.ID)
JOIN condivide ON (collezionista.ID=condivide.ID_Collezionista)
WHERE collezione.nome='Collezione query' AND 
( 
	collezione.ID_Collezionista=(SELECT ID FROM collezionista WHERE nickname='marios22') OR
	condivide.ID_Collezionista=(SELECT ID FROM collezionista WHERE nickname='marios22') OR
	collezione.pubbPriv='Pubblica'
);


-- QUERY 10: Numero dei brani (tracce di dischi) distinti di un certo autore (compositore, musicista) presenti nelle collezioni pubbliche.
SELECT COUNT(DISTINCT traccia.titolo) AS 'Numero brani'
FROM traccia JOIN disco ON (traccia.ID_Disco=disco.ID) 
JOIN collezione ON (disco.ID_Collezione=collezione.ID)
JOIN t_Compone ON (traccia.ID=t_Compone.ID_Traccia) JOIN autore ON (t_Compone.ID_Autore=autore.ID) 
WHERE autore.pseudonimo='Mac Hollister' AND (t_compone.ruolo='Musicista' OR t_compone.ruolo='Compositore')
AND collezione.pubbPriv='Pubblica'


-- QUERY 11: Minuti totali di musica riferibili a un certo autore (compositore, musicista)
-- memorizzati nelle collezioni pubbliche.
SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(traccia.durata))) AS 'Minuti totali'
FROM traccia JOIN disco ON (traccia.ID_Disco=disco.ID) 
JOIN collezione ON (disco.ID_Collezione=collezione.ID)
JOIN t_Compone ON (traccia.ID=t_Compone.ID_Traccia) JOIN autore ON (t_Compone.ID_Autore=autore.ID) 
WHERE autore.pseudonimo='Mac Hollister' AND (t_compone.ruolo='Musicista' OR t_compone.ruolo='Compositore')
AND collezione.pubbPriv='Pubblica'


-- QUERY 12: Statistiche (una query per ciascun valore): numero di collezioni di ciascun 
-- collezionista, numero di dischi per genere nel sistema 
SELECT collezionista.nickname, COUNT(collezione.ID_Collezionista) AS numCollezioni
FROM collezionista JOIN collezione ON (collezionista.ID=collezione.ID_Collezionista)
GROUP BY collezionista.nickname

SELECT d_Genere.nomeGenere, COUNT(d_Genere.ID_Disco) AS numDischi
FROM d_Genere
GROUP BY d_Genere.nomeGenere


-- QUERY 13: Opzionalmente, dati un numero di barcode, un titolo e il nome di un autore,
-- individuare tutti i dischi presenti nelle collezioni che sono più coerenti 
-- con questi dati (funzionalità utile, ad esempio, per individuare un disco già 
-- presente nel sistema prima di inserirne un doppione). L'idea è che il barcode
--  è univoco, quindi i dischi con lo stesso barcode sono senz'altro molto coerenti
-- , dopodichè è possibile cercare dischi con titolo simile e/o con l'autore dato,
-- assegnando maggior punteggio di somiglianza a quelli che hanno più corrispondenze.
DELIMITER $$
CREATE PROCEDURE query13(barcode_param VARCHAR(13), titolo_param VARCHAR(50), pseudonimo_param VARCHAR(50))
BEGIN
SELECT disco.* FROM disco 
JOIN d_Compone ON (disco.ID=d_compone.ID_Disco)
JOIN autore ON (d_Compone.ID_Autore=Autore.ID)
WHERE disco.barcode LIKE CONCAT('%',barcode_param,'%') OR 
disco.titolo LIKE CONCAT('%',titolo_param,'%') OR 
autore.pseudonimo LIKE CONCAT('%',pseudonimo_param,'%');
END$$

CALL query13(1053648952346,'Rocks','Laurent')