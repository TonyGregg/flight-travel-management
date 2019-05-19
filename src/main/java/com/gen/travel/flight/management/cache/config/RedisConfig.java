package com.gen.travel.flight.management.cache.config;

import com.gen.travel.flight.management.cache.model.Country;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;


import org.springframework.data.redis.connection.RedisConnectionFactory;


/**
 * Created by Antony Genil Gregory on 5/18/2019 6:15 PM
 * For project : flight-travel-management
 **/

@Configuration
@ComponentScan("com.gen.travel.flight.management.cache.config")
public class RedisConfig {
    @Bean
    public RedisConnectionFactory redisConnectionFactory() {
        LettuceConnectionFactory connectionFactory = new LettuceConnectionFactory();
        return connectionFactory;
    }
    @Bean
    public RedisTemplate<String, Country> redisTemplate() {
        RedisTemplate<String, Country> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(redisConnectionFactory());
        return redisTemplate;
    }


}
