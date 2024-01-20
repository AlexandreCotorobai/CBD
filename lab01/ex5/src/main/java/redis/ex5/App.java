package redis.ex5;

import redis.clients.jedis.Jedis;
import java.util.Scanner;

/**
 * Hello world!
 *
 */

public class App {

    public static void main(String[] args) {

        Jedis jedis = new Jedis();
        jedis.flushAll();
        jedis.close();

        // scann the input
        Scanner scanner = new Scanner(System.in);
        System.out.print("Qual a alinea? (a ou b): ");
        String input = scanner.nextLine();
        long start;
        switch (input) {
            case "a":
                SistemaAtendimento sistema = new SistemaAtendimento();

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

                sistema.close();

                break;
            case "b":

                SistemaAtendimentoQty sistemaQty = new SistemaAtendimentoQty();

                SistemaAtendimentoQty.setLimit(5);
                SistemaAtendimentoQty.setTimeslot(4);

                String user1Qty = "Joao";

                for (int i = 1; i <= 3; i++) {
                    start = System.nanoTime();

                    sistemaQty.registarProduto(user1Qty, "Produto" + i, i);
                    System.out.println("Tempo de execucao: " + (System.nanoTime() - start) / 1000000 + "ms");
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
                System.out.println("Tempo de execucao ao ler todos os produtos: " + (System.nanoTime() - start) / 1000000 + "ms");
                
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
                System.out.println("Tempo de execucao ao ler todos os produtos: " + (System.nanoTime() - start) / 1000000 + "ms");

                sistemaQty.close();

                break;
            default:
                break;

        }

        scanner.close();
    }

}
