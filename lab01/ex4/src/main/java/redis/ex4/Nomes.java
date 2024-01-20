package redis.ex4;

import redis.clients.jedis.Jedis;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class Nomes {
    public static String NAMES_KEY = "names";
    public static void main(String[] args) {
        Jedis jedis = new Jedis();

        // scan names from names.txt
        jedis.del(NAMES_KEY);

        try (Scanner scanner = new Scanner(new File("nomes-pt-2021.csv"))) {

            while (scanner.hasNextLine()) {
                String name = scanner.nextLine();
                String[] nameSplit = name.split(";");
                jedis.zadd(NAMES_KEY, Double.parseDouble(nameSplit[1]), nameSplit[0]);
            }

            scanner.close();

            System.out.print("Search for ('Enter' for quit): ");
            Scanner input = new Scanner(System.in);
            String search = input.nextLine().toLowerCase();

            while (!search.equals("")) {
                System.out.println("Results: ");
                for (String name : jedis.zrevrangeByScore(NAMES_KEY, "+inf", "-inf")) {
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