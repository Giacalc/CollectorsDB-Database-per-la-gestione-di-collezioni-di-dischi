-- collezionista
INSERT INTO collezionista(nickname, email) VALUES ('marios22', 'mario.rossi@univaq.it');
INSERT INTO collezionista(nickname, email) VALUES ('carlos56', 'carlo.giallini@univaq.it');
INSERT INTO collezionista(nickname, email) VALUES ('luca14', 'luca.franchi@univaq.it');

-- collezione
INSERT INTO collezione (nome, pubbPriv, ID_Collezionista) VALUES ('CollPubb', 'Pubblica', 1);
INSERT INTO collezione (nome, pubbPriv, ID_Collezionista) VALUES ('CollPriv', 'Privata', 2);
INSERT INTO collezione (nome, pubbPriv, ID_Collezionista) VALUES ('Compilation 2003', 'Pubblica', 3);
INSERT INTO collezione (nome, pubbPriv, ID_Collezionista) VALUES ('Compilation 2005', 'Pubblica', 1);
INSERT INTO collezione (nome, pubbPriv, ID_Collezionista) VALUES ('Musica in movimento', 'Privata', 2);
INSERT INTO collezione (nome, pubbPriv, ID_Collezionista) VALUES ('Allenamento', 'Privata', 2);
INSERT INTO collezione (nome, pubbPriv, ID_Collezionista) VALUES ('Collezione out', 'Pubblica', 1);

-- disco
INSERT INTO disco (titolo, annoDiUscita, barcode, ID_Collezione) VALUES ('Dream', 2022, 1987509384765, 1);
INSERT INTO disco (titolo, annoDiUscita, barcode, ID_Collezione) VALUES ('Rose', 2024, 4895840934905, 1);
INSERT INTO disco (titolo, annoDiUscita, barcode, ID_Collezione) VALUES ('Bling', 1990, 2467547547682, 6);
INSERT INTO disco (titolo, annoDiUscita, barcode, ID_Collezione) VALUES ('Broken Glass', 1986, 3748374983048, 5);
INSERT INTO disco (titolo, annoDiUscita, barcode, ID_Collezione) VALUES ('Rockstar', 2018, 1114526663257, 5);
INSERT INTO disco (titolo, annoDiUscita, barcode, ID_Collezione) VALUES ('OUT', 1918, 0125527568259, 7);

-- copia disco
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Nuovo', 'CD', 1);
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Nuovo', 'CD', 2);
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Nuovo', 'CD', 3);
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Nuovo', 'CD', 4);
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Nuovo', 'CD', 5);
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Nuovo', 'CD', 6);
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Nuovo', 'CD', 7);
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Usato', 'Vinile', 2);
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Nuovo', 'Cassetta', 5);
INSERT INTO copiaDisco (statoConservazione, formato, ID_Disco) VALUES ('Nuovo', 'CD', (SELECT ID FROM disco WHERE titolo='OUT'));

-- immagine 

INSERT INTO immagine (URL, tipologia, ID_Disco) VALUES ('/Users/rab5/Immagini/1-Copertina.jpg', 'Copertina', 1);
INSERT INTO immagine (URL, tipologia, ID_Disco) VALUES ('/Users/rab5/Immagini/1-retro.jpg', 'Retro', 1);

-- etichetta
INSERT INTO etichetta (nome) VALUES ('Sony Music');
INSERT INTO etichetta (nome) VALUES ('Universal Music Group');
INSERT INTO etichetta (nome) VALUES ('Bertelsmann Music Group ');
INSERT INTO etichetta (nome) VALUES ('Warner Music Group');

-- traccia
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Intro', '00:00:59', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Primo', '00:02:59', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Secondo', '00:03:19', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Terzo', '00:03:09', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Quarto', '00:03:23', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Interludio', '00:01:35', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Quinto', '00:03:32', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Sesto', '00:03:06', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Settimo', '00:02:47', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Ottavo', '00:03:49', 1);
INSERT INTO traccia (titolo, durata, ID_Disco) VALUES ('Traccia out', '00:03:14', (SELECT ID FROM disco WHERE titolo='OUT'));

-- autore 
INSERT INTO autore (pseudonimo, nome, cognome, dataDiNascita, gruppoSingolo) VALUES ('Alex Mauro', 'Alessandro', 'Monchi', '1978-05-05', 'Singolo');
INSERT INTO autore (pseudonimo, nome, cognome, dataDiNascita, gruppoSingolo) VALUES ('John Brave', 'Giovanni', 'Terzo', '1968-03-22', 'Singolo');
INSERT INTO autore (pseudonimo, dataDiNascita, gruppoSingolo) VALUES ('Poveri e Ricchi', '1913-02-14', 'Gruppo');
INSERT INTO autore (pseudonimo, nome, cognome, datadiNascita, gruppoSingolo) VALUES ('Mac Hollister', 'Marco' ,'Fiore', '1999-01-01', 'Singolo');

-- genere
INSERT INTO genere (nome) VALUES ('Pop');
INSERT INTO genere (nome) VALUES ('Rock');
INSERT INTO genere (nome) VALUES ('Musica classica');
INSERT INTO genere (nome) VALUES ('Rap');
INSERT INTO genere (nome) VALUES ('Trap');

-- condivide
INSERT INTO condivide (ID_Collezione, ID_Collezionista) VALUES (1, 2);
INSERT INTO condivide (ID_Collezione, ID_Collezionista) VALUES (1, 3);

-- d_Compone
INSERT INTO d_Compone (ruolo, ID_Disco, ID_Autore) VALUES('Autore', 1, 1);
INSERT INTO d_Compone (ruolo, ID_Disco, ID_Autore) VALUES('Compositore', 1, 2);
INSERT INTO d_Compone (ruolo, ID_Disco, ID_Autore) VALUES('Compositore', 5, 2);

-- t_Compone
INSERT INTO t_Compone (ruolo, ID_Traccia, ID_Autore) VALUES('Autore', 4, 2);
INSERT INTO t_Compone (ruolo, ID_Traccia, ID_Autore) VALUES('Autore', 4, 3);
INSERT INTO t_compone (ruolo, ID_Traccia, ID_Autore) VALUES
('Compositore', 1, 4),
('Compositore', 2, 4),
('Compositore', 3, 4),
('Compositore', 4, 4),
('Compositore', 5, 4),
('Compositore', 6, 4),
('Compositore', 7, 4),
('Compositore', 8, 4), 
('Compositore', 9, 4),
('Compositore', 10, 4);
INSERT INTO t_compone (ruolo, ID_Traccia, ID_Autore) VALUES ('Compositore', 15, 4);

-- d_Genere
INSERT INTO d_Genere (ID_Disco, nomeGenere) VALUES (1,'Pop');
INSERT INTO d_Genere (ID_Disco, nomeGenere) VALUES (2,'Rock');
INSERT INTO d_Genere (ID_Disco, nomeGenere) VALUES (3,'Rock');
INSERT INTO d_Genere (ID_Disco, nomeGenere) VALUES (4,'Musica classica');
INSERT INTO d_Genere (ID_Disco, nomeGenere) VALUES (5,'Trap');

INSERT INTO d_Genere (ID_Disco, nomeGenere) VALUES (5,'Rap');
INSERT INTO d_Genere (ID_Disco, nomeGenere) VALUES (1,'Rock');
-- a_Genere
INSERT INTO a_Genere (ID_autore, nomeGenere) VALUES (3,'Musica classica');
INSERT INTO a_Genere (ID_autore, nomeGenere) VALUES (2,'Trap');
INSERT INTO a_Genere (ID_autore, nomeGenere) VALUES (4,'Pop');
INSERT INTO a_Genere (ID_autore, nomeGenere) VALUES (4,'Trap');

-- produce
INSERT INTO produce (nomeEtichetta, ID_Disco) VALUES ('Sony Music',1); 
INSERT INTO produce (nomeEtichetta, ID_Disco) VALUES ('Universal Music Group',2); 
INSERT INTO produce (nomeEtichetta, ID_Disco) VALUES ('Bertelsmann Music Group ',2); 
INSERT INTO produce (nomeEtichetta, ID_Disco) VALUES ('Warner Music Group',2); 
INSERT INTO produce (nomeEtichetta, ID_Disco) VALUES ('Sony Music',3); 

