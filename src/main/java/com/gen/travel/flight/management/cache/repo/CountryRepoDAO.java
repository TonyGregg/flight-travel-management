package com.gen.travel.flight.management.cache.repo;

import com.gen.travel.flight.management.cache.model.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Antony Genil Gregory on 5/19/2019 12:18 PM
 * For project : flight-travel-management
 **/
@Repository
public class CountryRepoDAO implements CountryRepository {

    private static final String KEY = "COUNTRYKEY";

    @Autowired
    private RedisTemplate<String, Country> redisTemplate;

    @Override
    public List<Country> findAll() {
        return null;
    }

    @Override
    public Country save(Country country) {
        redisTemplate.opsForList().leftPush(KEY,country);
        return country;

    }

    public long getNumberOfCountries() {
        return redisTemplate.opsForList().size(KEY);
    }

    public void removeCountry(Country country) {
        redisTemplate.opsForList().remove(KEY,1,country);
    }
}
