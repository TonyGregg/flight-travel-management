package com.gen.travel.flight.management.cache.repo;

import com.gen.travel.flight.management.cache.model.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Antony Genil Gregory on 5/19/2019 12:18 PM
 * For project : flight-travel-management
 **/
@Repository
public class CountryRepoDAO implements CountryRepository {

    private static final String KEY = "COUNTRY";

    private RedisTemplate<String, Country> redisTemplate;

    private HashOperations hashOperations;

    public CountryRepoDAO(RedisTemplate<String, Country> redisTemplate) {
        this.redisTemplate = redisTemplate;
        this.hashOperations = redisTemplate.opsForHash();
    }

    @Override
    public Map<String,Country> findAll() {

        Map<String,Country> countryMap = hashOperations.entries(KEY);
        return countryMap;

    }

    @Override
    public Country save(Country country) {
        hashOperations.put(KEY, country.getName(),country);
        return country;

    }

    public long getNumberOfCountries() {
        return redisTemplate.opsForList().size(KEY);
    }

    public void removeCountry(Country country) {
        hashOperations.delete(KEY,country.getName());
    }
}
