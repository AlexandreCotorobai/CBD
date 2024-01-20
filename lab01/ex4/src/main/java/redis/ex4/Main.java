package redis.ex4;

import redis.clients.jedis.Jedis;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class Main {
    public static String NAMES_KEY = "names";
    public static void main(String[] args) {
        Jedis jedis = new Jedis();

        // scan names from names.txt
        jedis.del(NAMES_KEY);

        try (Scanner scanner = new Scanner(new File("names.txt"))) {

            while (scanner.hasNextLine()) {
                String name = scanner.nextLine();
                jedis.rpush(NAMES_KEY, name);
            }

            scanner.close();

            System.out.print("Search for ('Enter' for quit): ");
            Scanner input = new Scanner(System.in);
            String search = input.nextLine().toLowerCase();

            while (!search.equals("")) {
                System.out.println("Results: ");
                for (String name : jedis.lrange(NAMES_KEY, 0, -1)) {
                    if (name.toLowerCase().startsWith(search)) {
                        System.out.println(name);
                    }
                }
                System.out.print("Search for ('Enter' for quit): ");
                search = input.nextLine().toLowerCase();
            }
            
            
            input.close();
            
            jedis.close();

        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
    }
}