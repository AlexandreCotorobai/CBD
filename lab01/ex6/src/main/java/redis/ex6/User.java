package redis.ex6;

import redis.clients.jedis.Jedis;

public class User {
    private String name;
    private Jedis jedis;

    public User(String name) {
        this.name = name;
        jedis = new Jedis();

    }

    public void registerUser() {

        jedis.sadd("users", this.name);

    }

    public void followUser(User user) {

        jedis.rpush(this.name + ":following", user.getName());
        jedis.rpush(user.getName() + ":followers", this.name);
        // System.out.println(user.getName() + " followed by " + this.name);
        // System.out.println(jedis.lrange(this.name + ":followers", 0, -1));

    }

    public void unfollowUser(User user) {

        jedis.lrem(this.name + ":following", 0, user.getName());
        jedis.lrem(user.getName() + ":followers", 0, this.name);

    }

    public void postMsg(String msg) {
        jedis.rpush(this.name + ":msgs", msg);
        System.out.println(this.name + " posted '" + msg + "'");


        for (String follower : jedis.lrange(this.name + ":followers", 0, -1)) {
            System.out.println(follower + " received '" + msg + "' from " + this.name);
        }
    }

    public String getMsgs() {
        String msgs = "";
        for (String msg : jedis.lrange(this.name + ":msgs", 0, -1)) {
            msgs += msg + "\n";
        }
        return msgs;
    }



    public String getName() {
        return this.name;
    }

}
