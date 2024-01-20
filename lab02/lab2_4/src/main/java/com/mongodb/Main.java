package com.mongodb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.client.DistinctIterable;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class Main {
    public static void main(String[] args) {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("sistema_atendimento");
        // MongoCollection<Document> users = database.getCollection("users");

        // clear database
        database.drop();

        Scanner scanner = new Scanner(System.in);
        System.out.print("Qual a alinea? (a ou b): ");
        String input = scanner.nextLine();
        long start;

        switch (input) {
            case "a":
                SistemaAtendimento sistema = new SistemaAtendimento(database);

                SistemaAtendimento.setLimit(5);
                SistemaAtendimento.setTimeslot(7);

                String user1 = "Joao";
                String user2 = "Maria";

                for (int i = 0; i < 8; i++) {
                    sistema.registarProduto(user1, "Produto" + i);
                    // sleep for 1 second
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }

                for (int i = 0; i < 10; i++) {
                    sistema.registarProduto(user2, "Produto" + i);
                    // sleep for 1 second
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }

                for (int i = 0; i < 3; i++) {
                    sistema.registarProduto(user1, "Produto" + i);
                    // sleep for 1 second
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }

                break;
            case "b":

                SistemaAtendimentoQty sistemaQty = new SistemaAtendimentoQty(database);

                SistemaAtendimentoQty.setLimit(5);
                SistemaAtendimentoQty.setTimeslot(4);

                String user1Qty = "Joao";

                for (int i = 1; i <= 3; i++) {
                    start = System.nanoTime();

                    sistemaQty.registarProduto(user1Qty, "Produto" + i, i);

                    System.out.println(
                            "Tempo de execucao ao registar produto: " + (System.nanoTime() - start) / 1000000 + "ms");
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }

                // sistemaQty.registarProduto(user1Qty, "Produto1", 1);
                // sistemaQty.registarProduto(user1Qty, "Produto2", 2);
                // sistemaQty.registarProduto(user1Qty, "Produto3", 3);

                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }

                sistemaQty.registarProduto(user1Qty, "ProdutoX", 3);

                // testing stuff
                try {
                    Thread.sleep(10000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }

                sistemaQty.registarProduto(user1Qty, "ProdutoY", 3);

                start = System.nanoTime();
                System.out.println(sistemaQty.getAllProducts(user1Qty));
                System.out.println(
                        "Tempo de execucao ao ler todos os produtos: " + (System.nanoTime() - start) / 1000000 + "ms");

                try {
                    Thread.sleep(3000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                sistemaQty.registarProduto(user1Qty, "ProdutoY", 2);

                System.out.println(sistemaQty.getAllProducts(user1Qty));

                try {
                    Thread.sleep(3000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }

                start = System.nanoTime();
                System.out.println(sistemaQty.getAllProducts(user1Qty));
                System.out.println(
                        "Tempo de execucao ao ler todos os produtos: " + (System.nanoTime() - start) / 1000000 + "ms");

                break;
            default:
                break;

        }

        scanner.close();
    }
}