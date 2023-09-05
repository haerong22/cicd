package org.example.api;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {

    @Value("${spring.profiles.active:default}")
    private String profiles;

    @Value("${server.port:0}")
    private int port;

    @GetMapping("/health-check")
    public String healthCheck() {
        return "API service available! with " + profiles + ", " + port;
    }
}
