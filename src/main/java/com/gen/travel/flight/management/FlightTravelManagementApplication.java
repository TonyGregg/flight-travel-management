package com.gen.travel.flight.management;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
public class FlightTravelManagementApplication {

	public static void main(String[] args) {
		SpringApplication.run(FlightTravelManagementApplication.class, args);
	}

}
