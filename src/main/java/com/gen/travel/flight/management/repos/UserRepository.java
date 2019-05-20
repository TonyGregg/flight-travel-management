package com.gen.travel.flight.management.repos;

import com.gen.travel.flight.management.domain.User;

import org.springframework.data.repository.CrudRepository;

/**
 * Created by Antony Genil Gregory on 5/20/2019 6:48 AM
 * For project : flight-travel-management
 **/
public interface UserRepository  extends CrudRepository<User, Long> {
    User findByEmail(String email);

}
