package cbd.lab44;

import org.neo4j.driver.*;
import org.neo4j.driver.Record;

public class Main {
    public static void main(String[] args) {

        try (Driver driver = GraphDatabase.driver("bolt://localhost:7687", AuthTokens.basic("neo4j", "12345678"));
                Session session = driver.session()) {
            String clearQuery = "MATCH (n) DETACH DELETE n";
            session.run(clearQuery);

            // Define the path to your CSV file
            String csvFilePath = "file:///Top-50-musicality-global.csv";

            // Cypher query to load CSV data
            String query = String.format(
                    "LOAD CSV WITH HEADERS FROM '%s' AS row " +
                            "WITH row LIMIT 1000 " +
                            "MERGE (artist:Artist {name: coalesce(row.`Artist Name`, 'Unknown')}) " +
                            "MERGE (track:Track {name: coalesce(row.`Track Name`, 'Unknown'), duration: toInteger(row.duration), danceability: toFloat(row.Danceability), popularity: toInteger(row.Popularity), liveness: toFloat(row.Liveness), loudness: toFloat(row.Loudness)}) "
                            +
                            "MERGE (album:Album {name: coalesce(row.`Album Name`, 'Unknown'), releaseDate: row.Date}) "
                            +
                            "MERGE (country:Country {name: coalesce(row.Country, 'Unknown')}) " +
                            "MERGE (artist)-[:PRODUCED]->(track) " +
                            "MERGE (artist)-[:PUBLISHED]->(album) " +
                            "MERGE (album)-[:CONTAINS]->(track) " +
                            "MERGE (track)-[:HAS_IDIOM]->(country)",
                    csvFilePath);
            // Execute the Cypher query
            session.run(query);

            query = "MATCH (t:Track)<-[:PRODUCED]-(a:Artist) RETURN t.name, a.name, t.popularity ORDER BY t.popularity DESC LIMIT 5";
            System.out.println("\n1. As 5 músicas mais populares:");
            Result result = session.run(query);
            printData(result);

            query = "MATCH (a:Artist)-[:PUBLISHED]->(:Album)-[:CONTAINS]->(t:Track) WITH a, COUNT(t) AS totalTracks " +
                    "RETURN a.name AS Name, totalTracks ORDER BY totalTracks DESC LIMIT 1;";
            System.out.println("\n2. O artista com mais músicas publicadas:");
            result = session.run(query);
            printData(result);

            query = "MATCH (a:Artist {name: 'Jung Kook'})-[:PUBLISHED]->(album:Album) " +
                    "RETURN album.name AS AlbumName, album.releaseDate AS ReleaseDate ORDER BY album.releaseDate DESC LIMIT 1;";
            System.out.println("\n3. O álbum mais recente do artista Jung Kook:");
            result = session.run(query);
            printData(result);

            query = "MATCH (t:Track) WHERE t.duration > 180000 " +
                    "RETURN t.duration, t.name LIMIT 5;";
            System.out.println("\n4. Musicas com duração superior a 3 min:");
            result = session.run(query);
            printData(result);

            query = "MATCH (a:Artist)-[:PRODUCED]->(t:Track)-[:HAS_IDIOM]->(c:Country {name: 'KOR'}) "
                    + "RETURN a.name, t.name LIMIT 20;";
            System.out.println("\n5. Músicas lançadas na coreia:");
            result = session.run(query);
            printData(result);

            query = "MATCH (a:Artist {name: 'Bad Bunny'})-[:PRODUCED]->(t:Track) " +
                    "RETURN AVG(t.danceability);";
            System.out.println("\n6. Média de danceabilidade das músicas do Bad Bunny:");
            result = session.run(query);
            printData(result);

            query = "MATCH (a:Artist)-[:PRODUCED]->(t:Track) WITH a, AVG(t.popularity) AS avgPopularity " +
                    "RETURN a.name AS ArtistName, avgPopularity ORDER BY avgPopularity DESC LIMIT 3;";
            System.out.println("\n7. Os 3 artistas com maior popularidade média:");
            result = session.run(query);
            printData(result);

            query = "MATCH (t:Track) WHERE t.duration < 120000 AND t.liveness > 0.5 " +
                    "RETURN t.name, t.duration, t.liveness;";
            System.out.println("\n8. Músicas com duração inferior a 2 min e com alta liveness:");
            result = session.run(query);
            printData(result);

            query = "MATCH (t:Track)-[:HAS_IDIOM]->(c:Country) WITH t, COLLECT(DISTINCT c.name) AS countriesList, COUNT(DISTINCT c) AS countriesCount "
                    +
                    "WHERE countriesCount > 10 RETURN t.name AS track, countriesCount, countriesList;";
            System.out.println("\n9. Músicas com mais de 10 idiomas diferentes:");
            result = session.run(query);
            printData(result);

            query = "MATCH grafo = (a:Artist)-[:PRODUCED]->(t:Track)<-[:CONTAINS]-(alb:Album) "+
            "WHERE a.name = 'Bad Bunny' RETURN grafo;";
            System.out.println("\n10. Apresenta o subgrafo de Bad Bunny (musicas e albuns):");
            result = session.run(query);
            printData(result);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void printData(Result result) {
        Record firstRecord = result.peek();
        if (firstRecord != null) {
            for (String key : firstRecord.keys()) {
                System.out.printf("%-20s", key);
            }
            System.out.println();
        }

        while (result.hasNext()) {
            Record record = result.next();
            for (Object value : record.values()) {
                System.out.printf("%-20s", value.toString());
            }
            System.out.println();
        }
    }
}