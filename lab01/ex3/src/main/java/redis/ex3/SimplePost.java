package redis.ex3;

import redis.clients.jedis.Jedis;

public class SimplePost {
	public static String USERS_KEY = "users"; // Key set for users' name

	public static void main(String[] args) {
		Jedis jedis = new Jedis();
		// some users
		String[] users = { "Ana", "Pedro", "Maria", "Luis" };

		jedis.del(USERS_KEY); // remove if exists to avoid wrong type
		System.out.println("Set of users:");

		for (String user : users)
			jedis.sadd(USERS_KEY, user);
			
    	jedis.smembers(USERS_KEY).forEach(System.out::println);
		
		//
		// USING A LIST
		//
		jedis.del(USERS_KEY); // remove if exists to avoid wrong type
		System.out.println("\nList of users:");
		for (String user : users)
			jedis.rpush(USERS_KEY, user);
		
		jedis.lrange(USERS_KEY, 0, -1).forEach(System.out::println);
		

		//
		// USER A HASHMAP
		//
		jedis.del(USERS_KEY); // remove if exists to avoid wrong type
		System.out.println("\nHashmap of users:");
		for (String user : users)
			jedis.hset(USERS_KEY, user, user + "@gmail.com");
		
		jedis.hgetAll(USERS_KEY).forEach((k,v) -> System.out.println(k + " " + v));

		jedis.close();
	}
}
