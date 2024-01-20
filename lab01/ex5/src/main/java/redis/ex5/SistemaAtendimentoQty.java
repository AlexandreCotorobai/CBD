package redis.ex5;

import redis.clients.jedis.Jedis;

import java.util.*;

public class SistemaAtendimentoQty {
    private static int limit = 30;
    private static int timeslot = 3600;

    private Jedis jedis;

    public SistemaAtendimentoQty() {
        jedis = new Jedis();
        jedis.del("qty");
    }

    public void registarProduto(String user, String produto, int qty) {
        long current_time = System.currentTimeMillis() / 1000;
        int sum = 0;

        List<String> removed_products = jedis.zrangeByScore(user, 0, current_time - timeslot);

        jedis.zremrangeByScore(user, 0, current_time - timeslot);

        for (String removed_product : removed_products) {
            jedis.hdel("qty", user + ":" + removed_product);
        }

        // System.out.println("Produtos removidos: " + removed_products);
        // System.out.println("Hset: " + jedis.hgetAll("qty"));

        Map<String, String> quantidades = jedis.hgetAll("qty");

        for (String key : quantidades.keySet()) {
            if (key.startsWith(user + ":"))
                sum += Integer.parseInt(quantidades.get(key));
        }

        // System.out.println("O utilizador " + user + " tem " + sum + " produtos
        // registados.");

        if (sum + qty > limit) {
            System.err.println("Limite de produtos atingido para o utilizador " + user + "!" + " ( tentou add " + qty
                    + " mas já tem " + sum + " )");
        } else {
            jedis.zadd(user, current_time, produto);

            if (jedis.hexists("qty", user + ":" + produto)) {
                int updated_qty = qty + Integer.parseInt(jedis.hget("qty", user + ":" + produto));
                jedis.hset("qty", user + ":" + produto, String.valueOf(updated_qty));
            } else {
                jedis.hset("qty", user + ":" + produto, String.valueOf(qty));
            }

            System.out.println("Produto " + produto + " registado para o utilizador " + user + " | +" + qty
                    + " unidades (" + (sum + qty) + " no total)");
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

    public void delete(String user) {
        Set<String> keys = jedis.keys("p" + user + "*");

        for (String key : keys) {
            jedis.del(key);
        }

        jedis.del(user);
    }

    public void close() {
        jedis.close();
    }

    public String getAllProducts(String user) {
        List<String> products = jedis.zrange(user, 0, -1);
        Map<String, String> quantidades = jedis.hgetAll("qty");

        String result = "";

        for (String product : products) {
            result += product + " (" + quantidades.get(user + ":" + product) + " unidades)\n";
        }

        return result;
    }

}
