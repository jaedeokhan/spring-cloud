package org.example.controller;

import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class UserController {

    private final Environment env;
    private final Greeting greeting;

    public UserController(Environment env, Greeting greeting) {
        this.env = env;
        this.greeting = greeting;
    }

    @GetMapping("/health_check")
    public String healthCheck() {
        return env.getProperty("greeting.message");
    }

    @GetMapping("/welcome")
    public String welcome() {
        return greeting.getMessage();
    }
}
