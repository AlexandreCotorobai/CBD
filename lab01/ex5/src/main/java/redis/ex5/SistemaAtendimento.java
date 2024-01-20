package redis.ex5;

import redis.clients.jedis.Jedis;

public class SistemaAtendimento {
    private static int limit = 30;
    private static int timeslot = 3600;

    private Jedis jedis;

    public SistemaAtendimento() {
        jedis = new Jedis();
    }

    public void registarProduto(String user, String produto) {
        long current_time = System.currentTimeMillis() / 1000;

        jedis.zremrangeByScore(user, 0, current_time - timeslot);

        if (jedis.zcard(user) >= limit) {
            System.err.println("Limite de produtos atingido para o utilizador " + user + "!");
        } else {
            jedis.zadd(user, current_time, produto); 
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

    public void close() {
        jedis.close();
    }

}
