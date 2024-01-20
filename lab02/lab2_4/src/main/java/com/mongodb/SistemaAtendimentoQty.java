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

public class SistemaAtendimentoQty {
    private static int limit = 30;
    private static int timeslot = 3600;
    MongoCollection<Document> users;

    public SistemaAtendimentoQty(MongoDatabase database) {
        users = database.getCollection("users");
    }

    public void registarProduto(String user, String produto, int qty) {
        long current_time = System.currentTimeMillis() / 1000;
        long max_time = current_time + timeslot;
        long count = 0;

        Document filter = new Document("user", user)
                .append("produtos.timestamp", new Document("$gt", current_time));

        Iterable<Document> docs = users.find(filter);
        for (Document doc : docs) {
            List<Document> produtos = (List<Document>) doc.get("produtos");
            for (Document prod : produtos) {
                if (prod.getString("produto").equals(produto)) {
                    count += prod.getInteger("qty");
                }
            }
        }

        // long count = users.countDocuments(filter);

        // Document removeFilter = new Document("user", user)
        // .append("produtos.timestamp", new Document("$lte", current_time));

        // users.deleteMany(removeFilter);
        removeExpiredProducts(user);

        if (count + qty > limit) {
            System.err.println("Limite de produtos atingido para o utilizador " + user + "!" + " ( tentou add " + qty
                    + " mas já tem " + count + " )");
        } else {
            Document product = new Document("produto", produto).append("timestamp", max_time).append("qty", qty);

            Document pedido = new Document("user", user).append("produtos", List.of(product));
            users.insertOne(pedido);
            System.out.println("Produto " + produto + " registado para o utilizador " + user + " | +" + qty
                    + " unidades (" + (count + qty) + " no total)");
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

    public void removeExpiredProducts(String user) {
        long current_time = System.currentTimeMillis() / 1000;
        Document removeFilter = new Document("user", user)
                .append("produtos.timestamp", new Document("$lte", current_time));

        users.deleteMany(removeFilter);
    }

    public String getAllProducts(String user) {
        removeExpiredProducts(user);
        Document filter = new Document("user", user);
        Iterable<Document> docs = users.find(filter);
        String result = "";
        for (Document doc : docs) {
            List<Document> produtos = (List<Document>) doc.get("produtos");
            for (Document prod : produtos) {
                result += prod.getString("produto") + " Qty:" + prod.getInteger("qty") + " Time to expire (s): "
                        + (prod.getLong("timestamp") - (System.currentTimeMillis() / 1000)) + "\n";
            }
        }
        return result;
    }
}
