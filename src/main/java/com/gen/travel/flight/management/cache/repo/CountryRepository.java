package com.gen.travel.flight.management.cache.repo;

import com.gen.travel.flight.management.cache.model.Country;

import java.util.List;
import java.util.Map;

/**
 * Created by Antony Genil Gregory on 5/18/2019 8:19 PM
 * For project : flight-travel-management
 **/
public interface CountryRepository {
    Map<String,Country> findAll();
    Country save(Country country);
    public void removeCountry(Country country);
}
