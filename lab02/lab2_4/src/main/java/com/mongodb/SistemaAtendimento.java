package com.mongodb;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class SistemaAtendimento {
    private static int limit = 30;
    private static int timeslot = 3600;
    MongoCollection<Document> users;

    public SistemaAtendimento(MongoDatabase database) {
        users = database.getCollection("users");

    }

    public void registarProduto(String user, String produto) {
        long current_time = System.currentTimeMillis() / 1000;
        long max_time = current_time + timeslot;

        Document filter = new Document("user", user)
                .append("produtos.timestamp", new Document("$gt", current_time));

        long count = users.countDocuments(filter);

        Document removeFilter = new Document("user", user)
                .append("produtos.timestamp", new Document("$lte", current_time));

        users.deleteMany(removeFilter);

        if (count >= limit) {
            System.err.println("Limite de produtos atingido para o utilizador " + user + "!");
        } else {
            Document product = new Document("produto", produto).append("timestamp", max_time);

            Document pedido = new Document("user", user).append("produtos", List.of(product));
            users.insertOne(pedido);
            System.out.println("Produto " + produto + " registado para o utilizador " + user);
        }
    }

    public static void setLimit(int limite) {
        System.out.println("Limite alterado para " + limite + " produtos.");
        limit = limite;
    }

    public static void setTimeslot(int timeslote) {
        System.out.println("Timeslot alterado para " + timeslote + " segundos.");
        timeslot = timeslote;
    }

    public static int getLimit() {
        return limit;
    }

    public static int getTimeslot() {
        return timeslot;
    }

}
