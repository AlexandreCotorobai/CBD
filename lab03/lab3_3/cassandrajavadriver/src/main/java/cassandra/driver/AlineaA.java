package cassandra.driver;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.Row;

public class AlineaA {
    public static void main(String[] args) {
        Cluster cluster = Cluster.builder().addContactPoint("localhost").withPort(9042).build();
        Session session = cluster.connect("partilhavideos");
        System.out.println("Connected to cluster: " + cluster.getClusterName());

        String insertUserQuery = "INSERT INTO users (username, name, email, registration_timestamp) "
                + "VALUES ('JavaUser', 'Java User', 'java@example.com', toTimestamp(now()))";

        session.execute(insertUserQuery);
        System.out.println("User inserted");

        String updateUserQuery = "UPDATE users SET email = 'newjava@example.com' WHERE username = 'JavaUser'";
        session.execute(updateUserQuery);
        System.out.println("User email updated");

        String searchUserQuery = "SELECT * FROM users WHERE username = 'JavaUser'";
        ResultSet resultSet = session.execute(searchUserQuery);
        Row row = resultSet.one();

        if (row != null) {
            System.out.println("User found: " +
                    "Username: " + row.getString("username") +
                    ", Name: " + row.getString("name") +
                    ", Email: " + row.getString("email") +
                    ", Registration Timestamp: " + row.getTimestamp("registration_timestamp"));
        } else {
            System.out.println("User not found");
        }

        insertUserQuery = "INSERT INTO users (username, name, email, registration_timestamp) "
                + "VALUES ('Javauser2', 'Java User Two', 'javauser2@example.com', toTimestamp(now()))";

        session.execute(insertUserQuery);
        System.out.println("User inserted");

        searchUserQuery = "SELECT * FROM users";
        resultSet = session.execute(searchUserQuery);

        System.out.println("Users:");
        for (Row r : resultSet) {
            System.out.println("Username: " + r.getString("username") +
                    ", Name: " + r.getString("name") +
                    ", Email: " + r.getString("email") +
                    ", Registration Timestamp: " + r.getTimestamp("registration_timestamp"));
        }

        session.close();
        cluster.close();
        System.out.println("Connection closed.");
    }
}