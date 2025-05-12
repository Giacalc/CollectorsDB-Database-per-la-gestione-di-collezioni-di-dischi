<!DOCTYPE html>
    <html lang="it">
        <head>
            <title>Interfaccia grafica Collectors</title>
            <link rel="stylesheet" href="style.css"/>
        </head>
    <body>
            <h1 class="w3-center">Seleziona una query da eseguire</h1>
            <form class="w3-panel w3-container w3-center" method="post">
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 1"class="button" value="Query 1" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 2" class="button" value="Query 2" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 3" class="button" value="Query 3" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 4" class="button" value="Query 4" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 5" class="button" value="Query 5" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 6" class="button" value="Query 6" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 7" class="button" value="Query 7" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 8" class="button" value="Query 8" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 9" class="button" value="Query 9" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 10" class="button" value="Query 10" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 11" class="button" value="Query 11" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 12" class="button" value="Query 12" />
                <input class="w3-button w3-border w3-padding" type="submit" name="Query 13" class="button" value="Query 13" />
            </form>
            <?php
                $mysqliobj = new mysqli("localhost:3306", "root", "password", "Collectors");
                $res = "";       
                if(array_key_exists('Query 1', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        INSERT INTO collezione (nome, pubbPriv, ID_Collezionista) VALUES
                        ('Collezione query', 'Privata', (SELECT ID FROM collezionista WHERE nickname='luca14'))
                        ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 2', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        INSERT INTO disco (titolo, annodiUscita, barcode, ID_Collezione) VALUES
                        ('Disco query', 2023, 1987509384765, (SELECT ID FROM collezione WHERE nome='Collezione query'))
                        ");
                    $stmt->execute();
                    $res = $stmt->get_result();

                    $stmt = $mysqliobj->prepare("
                        INSERT INTO disco (titolo, annodiUscita, barcode, ID_Collezione) VALUES
                        ('Disco query: Remastered', 2024, 1457596544767, (SELECT ID FROM collezione WHERE nome='Collezione query'));
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result(); 
                       
                    $stmt = $mysqliobj->prepare("
                        INSERT INTO traccia (titolo, durata, ID_Disco) VALUES
                        ('Canzone Query', '00:03:14', (SELECT ID FROM disco WHERE titolo='Disco query'))
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result(); 
                    
                    $stmt = $mysqliobj->prepare("
                        INSERT INTO traccia (titolo, durata, ID_Disco) VALUES
                        ('Canzone Query 2', '00:05:10', (SELECT ID FROM disco WHERE titolo='Disco query'));
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 3', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        UPDATE collezione SET pubbPriv='Pubblica' where nome='Collezione query'
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();

                    $stmt = $mysqliobj->prepare("
                        UPDATE collezione SET pubbPriv='Privata' where nome='Collezione query';
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();    
                    
                    $stmt = $mysqliobj->prepare("
                        INSERT INTO condivide (ID_Collezione, ID_Collezionista) VALUES
                        ((SELECT ID FROM collezione WHERE nome='Collezione query'), (SELECT ID FROM collezionista WHERE nickname='carlos56'))
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();  

                    $stmt = $mysqliobj->prepare("    
                        INSERT INTO condivide (ID_Collezione, ID_Collezionista) VALUES
                        ((SELECT ID FROM collezione WHERE nome='Collezione query'), (SELECT ID FROM collezionista WHERE nickname='marios22'))
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 4', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        DELETE FROM disco 
                        WHERE titolo='OUT' AND annoDiUscita='2023'
                        AND ID_Collezione=((SELECT ID FROM collezione WHERE nome='Collezione query'))
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 5', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        DELETE FROM collezione WHERE nome='Collezione out' and ID_Collezionista=
                        (SELECT ID FROM collezionista WHERE nickname='marios22')
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 6', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        SELECT disco.titolo AS 'Nome Disco', disco.annoDiUscita AS 'Anno di Uscita',
                        GROUP_CONCAT(d_Genere.nomeGenere) AS 'Genere'
                        FROM disco
                        JOIN collezione ON (disco.ID_Collezione = collezione.ID)
                        JOIN collezionista ON (collezione.ID_Collezionista = collezionista.ID)
                        JOIN d_Genere ON (disco.ID = d_Genere.ID_disco)
                        WHERE collezione.nome = 'Musica in movimento' AND collezionista.nickname = 'carlos56'
                        GROUP BY disco.titolo, disco.annoDiUscita    
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 7', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        SELECT traccia.titolo AS 'Titolo', traccia.durata AS 'Durata'
                        FROM traccia JOIN disco ON (traccia.ID_Disco=disco.ID)
                        WHERE disco.titolo='Dream' AND disco.annodiUscita=2022 AND disco.ID_Collezione=1           
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();

                    $stmt = $mysqliobj->prepare("
                        SELECT * FROM disco JOIN collezione ON (disco.ID_Collezione=collezione.ID)
                        WHERE disco.titolo='Dream'
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 8', $_POST)) {
                    $stmt = $mysqliobj->prepare("CALL query8(1,1,1)");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 9', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        SELECT DISTINCT collezione.nome FROM collezione JOIN collezionista ON (collezione.ID_Collezionista=collezionista.ID)
                        JOIN condivide ON (collezionista.ID=condivide.ID_Collezionista)
                        WHERE collezione.nome='Collezione query' AND 
                        (collezione.ID_Collezionista=(SELECT ID FROM collezionista WHERE nickname='marios22') OR
                        condivide.ID_Collezionista=(SELECT ID FROM collezionista WHERE nickname='marios22') OR
                        collezione.pubbPriv='Pubblica')
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 10', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        SELECT COUNT(DISTINCT traccia.titolo) AS 'Numero brani'
                        FROM traccia JOIN disco ON (traccia.ID_Disco=disco.ID) 
                        JOIN collezione ON (disco.ID_Collezione=collezione.ID)
                        JOIN t_Compone ON (traccia.ID=t_Compone.ID_Traccia) 
                        JOIN autore ON (t_Compone.ID_Autore=autore.ID) 
                        WHERE autore.pseudonimo='Mac Hollister' AND (t_compone.ruolo='Musicista' OR t_compone.ruolo='Compositore')
                        AND collezione.pubbPriv='Pubblica'
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 11', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(traccia.durata))) AS 'Minuti totali'
                        FROM traccia JOIN disco ON (traccia.ID_Disco=disco.ID) 
                        JOIN collezione ON (disco.ID_Collezione=collezione.ID)
                        JOIN t_Compone ON (traccia.ID=t_Compone.ID_Traccia) 
                        JOIN autore ON (t_Compone.ID_Autore=autore.ID) 
                        WHERE autore.pseudonimo='Mac Hollister' AND (t_compone.ruolo='Musicista' OR t_compone.ruolo='Compositore')
                        AND collezione.pubbPriv='Pubblica'            
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 12', $_POST)) {
                    $stmt = $mysqliobj->prepare("
                        SELECT collezionista.nickname, COUNT(collezione.ID_Collezionista) AS numCollezioni
                        FROM collezionista JOIN collezione ON (collezionista.ID=collezione.ID_Collezionista)
                        GROUP BY collezionista.nickname
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();

                    $stmt = $mysqliobj->prepare("  
                        SELECT d_Genere.nomeGenere, COUNT(d_Genere.ID_Disco) AS numDischi
                        FROM d_Genere
                        GROUP BY d_Genere.nomeGenere
                    ");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                else if(array_key_exists('Query 13', $_POST)) {
                    $stmt = $mysqliobj->prepare("CALL query13(1053648952346,'Rocks','Laurent')");
                    $stmt->execute();
                    $res = $stmt->get_result();
                }
                echo $res;
                $mysqliobj->close();
            ?>
    </body>
</html>

