package com.gen.travel.flight.management.api;

import com.gen.travel.flight.management.domain.User;
import com.gen.travel.flight.management.repos.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * Created by Antony Genil Gregory on 5/20/2019 7:25 AM
 * For project : flight-travel-management
 **/
@RestController
@RequestMapping("/api/v1/trav-mgmnt/users")
public class UserController {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;


    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @PostMapping("/sign-up")
    @ResponseStatus(HttpStatus.CREATED)
    public User signUp(@RequestBody User user) {
        logger.info("User received "+user);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return user;
    }

    @RequestMapping("/find/{email}")
    public User findUser(@PathVariable("email") String email) {
        logger.debug("email passed "+email);
        return userRepository.findByEmail(email);
    }
}
