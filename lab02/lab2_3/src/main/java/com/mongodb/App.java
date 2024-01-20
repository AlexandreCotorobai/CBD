package com.mongodb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.client.DistinctIterable;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class App {
    public static void main(String[] args) {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("cbd");
        MongoCollection<Document> restaurants = database.getCollection("restaurants");

        //
        // Alinea a)
        //
        System.out.println("\n\n--------- Alinea a) ---------");

        // Para evitar duplicar quando correr o programa mais do que uma vez
        restaurants.deleteMany(Filters.eq("nome", "A tasca do Zé"));

        // INSERT
        Document newRestaurant = new Document("nome", "A tasca do Zé")
                .append("gastronomia", "Portuguesa")
                .append("address", new Document("rua", "Rua da Alegria").append("zipcode", "123-4567")).append("localidade", "Aveiro");
        restaurants.insertOne(newRestaurant);

        // FIND
        System.out.println("\n--------- Após primeira inserção ---------");

        Document restaurantE = restaurants.find(new Document("nome", "A tasca do Zé")).first();
        System.out.println(restaurantE.toJson());

        // EDIT
        restaurantE.put("gastronomia", "Nova Cozinha");
        restaurants.replaceOne(Filters.eq("_id", restaurantE.get("_id")), restaurantE);

        System.out.println("\n--------- Após update ---------");
        Document restaurant2 = restaurants.find(new Document("nome", "A tasca do Zé")).first();
        System.out.println(restaurant2.toJson());

        //
        // Alinea b)
        //
        System.out.println("\n\n--------- Alinea b) ---------");

        System.out.println("\n\nSem indice");

        long start = System.nanoTime();
        FindIterable<Document> restaurantFind1 = restaurants.find(new Document("localidade", "Bronx"));
        System.out.println("Localidade Bronx: \t" + (System.nanoTime() - start) + " nanossegundos");

        start = System.nanoTime();
        FindIterable<Document> restaurantFind12 = restaurants.find(new Document("nome", "Domino'S Pizza"));
        System.out.println("Dominos: \t\t" + (System.nanoTime() - start) + " nanossegundos");

        start = System.nanoTime();
        FindIterable<Document> restaurantFind3 = restaurants.find(new Document("gastronomia", "American"));
        System.out.println("American Food: \t\t" + (System.nanoTime() - start) + " nanossegundos");

        System.out.println("\nCom indice: ");

        restaurants.createIndex(new Document("localidade", 1));
        restaurants.createIndex(new Document("gastronomia", 1));
        restaurants.createIndex(new Document("nome", "text"));

        start = System.nanoTime();
        FindIterable<Document> index_restaurantFind1 = restaurants.find(new Document("localidade", "Bronx"));
        System.out.println("Localidade Bronx: \t" + (System.nanoTime() - start) + " nanossegundos");

        start = System.nanoTime();
        FindIterable<Document> index_restaurantFind12 = restaurants.find(new Document("nome", "Domino'S Pizza"));
        System.out.println("Dominos: \t\t" + (System.nanoTime() - start) + " nanossegundos");

        start = System.nanoTime();
        FindIterable<Document> Index_restaurantFind3 = restaurants.find(new Document("gastronomia", "American"));
        System.out.println("American Food: \t\t" + (System.nanoTime() - start) + " nanossegundos");

        //
        // Alinea c)
        //
        System.out.println("\n\n--------- Alinea c) ---------");

        System.out.println("\n4. Indique o total de restaurantes localizados no Bronx.");
        System.out.println(restaurants.countDocuments(new Document("localidade", "Bronx")));

        System.out.println(
                "\n5. Apresente os primeiros 15 restaurantes localizados no Bronx, ordenados por ordem crescente de nome.");
        FindIterable<Document> restaurantFind5 = restaurants.find(new Document("localidade", "Bronx"))
                .sort(new Document("nome", 1)).limit(15);
        for (Document document : restaurantFind5) {
            System.out.println(document.getString("nome"));
        }

        System.out.println(
                "\n7. Encontre os restaurantes que obtiveram uma ou mais pontuações (score) entre [80 e 100].");
        FindIterable<Document> restaurantFind7 = restaurants.find(new Document("grades",
                new Document("$elemMatch", new Document("score", new Document("$gte", 80).append("$lte", 100)))));

        for (Document document : restaurantFind7) {
            System.out.println(document.getString("nome"));
        }

        System.out.println("\n8. Indique os restaurantes com latitude inferior a -95,7.");
        FindIterable<Document> restaurantFind8 = restaurants.find(new Document("address.coord.0",
                new Document("$lt", -95.7)));

        for (Document document : restaurantFind8) {
            System.out.println(document.getString("nome"));
        }

        System.out.println(
                "\n10. Liste o restaurant_id, o nome, a localidade e gastronomia dos restaurantes cujo nome começam por \"Wil\".");
        FindIterable<Document> restaurantFind9 = restaurants.find(Filters.regex("nome", "^Wil"))
                .projection(new Document("restaurant_id", 1).append("nome", 1).append("localidade", 1)
                        .append("gastronomia", 1));

        for (Document document : restaurantFind9) {
            System.out.println(document.toJson());
        }

        //
        // Alinea d)
        //

        System.out.println("\n\n--------- Alinea d) ---------");

        int count = countLocalidades(restaurants);
        System.out.println("\nNúmero de localidades distintas: " + count);

        Map<String, Integer> restaurantCounts = countRestByLocalidade(restaurants);
        System.out.println("\nNúmero de restaurantes por localidade: ");
        for (String locality : restaurantCounts.keySet()) {
            System.out.println(locality + " - " + restaurantCounts.get(locality));
        }

        List<String> restaurantsWithNameCloserTo = getRestWithNameCloserTo(restaurants, "Park");
        System.out.println("\nNome de restaurantes contendo 'Park no nome:");
        for (String restaurantName : restaurantsWithNameCloserTo) {
            System.out.println(restaurantName);
        }
    }

    public static int countLocalidades(MongoCollection<Document> collection) {
        DistinctIterable<String> distinctLocalities = collection.distinct("localidade", String.class);
        int count = 0;
        for (String locality : distinctLocalities) {
            count++;
        }
        return count;
    }

    public static Map<String, Integer> countRestByLocalidade(MongoCollection<Document> collection) {
        Map<String, Integer> restaurantCounts = new HashMap<>();
        FindIterable<Document> allRestaurants = collection.find();
        for (Document restaurant : allRestaurants) {
            String locality = restaurant.getString("localidade");
            restaurantCounts.put(locality, restaurantCounts.getOrDefault(locality, 0) + 1);
        }
        return restaurantCounts;
    }

    public static List<String> getRestWithNameCloserTo(MongoCollection<Document> collection, String name) {
        List<String> restaurants = new ArrayList<>();
        Bson regexFilter = Filters.regex("nome", ".*" + name + ".*", "i"); // Case-insensitive regex
        FindIterable<Document> matchingRestaurants = collection.find(regexFilter);
        for (Document restaurant : matchingRestaurants) {
            restaurants.add(restaurant.getString("nome"));
        }
        return restaurants;
    }

}
