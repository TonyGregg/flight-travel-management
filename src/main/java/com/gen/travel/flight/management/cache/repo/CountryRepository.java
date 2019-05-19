package com.gen.travel.flight.management.cache.repo;

import com.gen.travel.flight.management.cache.model.Country;

import java.util.List;

/**
 * Created by Antony Genil Gregory on 5/18/2019 8:19 PM
 * For project : flight-travel-management
 **/
public interface CountryRepository {
    List<Country> findAll();
    void save(Country country);
}
