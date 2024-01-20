package cassandra.driver;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.Row;

public class AlineaB {
    public static void main(String[] args) {
        Cluster cluster = Cluster.builder().addContactPoint("localhost").withPort(9042).build();
        Session session = cluster.connect("partilhavideos");
        System.out.println("Connected to cluster: " + cluster.getClusterName());

        String query1 = "SELECT * FROM events WHERE video_id = 1 AND user_id = 1 LIMIT 5";
        ResultSet resultSet1 = session.execute(query1);
        printResultSet("d) 4", resultSet1);

        String query2 = "SELECT video_id, SUM(rating) / CAST(COUNT(*) AS DOUBLE) AS average_rating, COUNT(*) AS total_votes FROM video_ratings WHERE video_id = 2";
        ResultSet resultSet2 = session.execute(query2);
        printResultSet("a) 10", resultSet2);

        String query3 = "SELECT * FROM video_followers WHERE video_id = 1";
        ResultSet resultSet3 = session.execute(query3);
        printResultSet("d) 7", resultSet3);

        String query4 = "SELECT video_id, COUNT(*) AS num_events FROM events GROUP BY video_id, user_id LIMIT 5";
        ResultSet resultSet4 = session.execute(query4);
        printResultSet("d) 12", resultSet4);

        session.close();
        cluster.close();
        System.out.println("Connection closed.");
    }

    private static void printResultSet(String queryName, ResultSet resultSet) {
        System.out.println("\n" + queryName + ":");
        for (Row row : resultSet) {
            System.out.println(row.toString());
        }
    }
}