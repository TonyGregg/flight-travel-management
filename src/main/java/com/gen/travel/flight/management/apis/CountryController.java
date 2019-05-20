package com.gen.travel.flight.management.apis;

import com.gen.travel.flight.management.cache.model.Country;
import com.gen.travel.flight.management.cache.repo.CountryRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * Created by Antony Genil Gregory on 5/19/2019 12:51 PM
 * For project : flight-travel-management
 **/
@RestController
@RequestMapping("/api/v1/trav-mgmnt/country")
public class CountryController {

    @Autowired
    private CountryRepository countryRepository;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @GetMapping("/all")
    public Map<String,Country> getAll() {
        logger.info("Inside getAll method of travel managment cache");
        Map<String,Country> countryMap = countryRepository.findAll();
        if (countryMap!= null) {
            logger.info("No. of countries "+countryMap.size());
        } else {
            logger.info("Sorry, no country information is available !!");
        }
        return countryMap;


    }

    @PostMapping("/create")
    @ResponseStatus(HttpStatus.CREATED)
    public Country save(@RequestBody @Valid Country country) {
        logger.info("Saving country "+country);
        return countryRepository.save(country);
    }
    @PostMapping("/delete")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@RequestBody @Valid Country country) {

        logger.info("deleting country "+country);
        if (country.getName().length()>40) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Sorry country name too long");

        }

        countryRepository.removeCountry(country);

    }





}
