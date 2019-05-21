package com.gen.travel.flight.management.services;

import com.gen.travel.flight.management.domain.User;
import com.gen.travel.flight.management.repos.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

/**
 * Created by Antony Genil Gregory on 5/20/2019 7:00 AM
 * For project : flight-travel-management
 **/

@Service
public class UserDetailServiceImpl implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        User applicationUser = userRepository.findByEmail(email);
        if (applicationUser == null) {
            throw new UsernameNotFoundException(email);
        }

        UserDetails userDetails = new org.springframework.security.core.userdetails.
                User(email,applicationUser.getPassword(), Collections.emptyList());


        return userDetails;
    }
}
