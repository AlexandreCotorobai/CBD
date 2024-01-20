package redis.ex6;

import redis.clients.jedis.Jedis;

public class Main {
    public static void main(String[] args) {
        Jedis jedis = new Jedis();
        jedis.flushAll();

        User user1 = new User("Alice");
        User user2 = new User("Bob");

        user1.registerUser();
        user2.registerUser();

        user1.followUser(user2);

        System.out.println(user2.getName() + "'s followers: " + jedis.lrange(user2.getName() + ":followers", 0, -1));

        user2.postMsg("Hello, Twitter!");

        user1.unfollowUser(user2);

        user2.postMsg("Unfollowed!");

        System.out.println(user2.getName() + "'s followers: " + jedis.lrange(user2.getName() + ":followers", 0, -1));

        System.out.println(user2.getName() + "'s msgs: " + user2.getMsgs());
        jedis.close();

    }
}