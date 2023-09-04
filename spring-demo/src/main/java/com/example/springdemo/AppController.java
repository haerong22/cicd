package com.example.springdemo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;

@RestController
public class AppController {

    @Value("${spring.profiles.active:default}")
    private String[] profiles;

    @GetMapping("/health-check")
    public String healthCheck() {
        return Arrays.toString(profiles);
    }
}
