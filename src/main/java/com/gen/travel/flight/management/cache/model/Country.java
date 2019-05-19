package com.gen.travel.flight.management.cache.model;

import java.io.Serializable;

/**
 * Created by Antony Genil Gregory on 5/18/2019 8:36 PM
 * For project : flight-travel-management
 **/
public class Country implements Serializable {
    String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    String code;

    public Country(String name, String code) {
        this.name = name;
        this.code = code;
    }

    @Override
    public int hashCode() {
        int hasNo = 7;
        hasNo = 13 * hasNo + (name == null? 0: name.hashCode());
        return hasNo;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) return false;

        final Country country = (Country)obj;
        if (this == country) return true;
        return (this.name.equals(country.name));
    }

    @Override
    public String toString() {
        return "Country{" +
                "name='" + name + '\'' +
                ", code='" + code + '\'' +
                '}';
    }
}
