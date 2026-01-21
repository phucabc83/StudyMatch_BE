package com.example.microservice.services.controller;

import com.example.microservice.services.entity.User;
import com.example.microservice.services.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    final UserRepository repository;


    public UserController(UserRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public ResponseEntity<List<User>> getAllUsers(){
        List<User> users = repository.findAll();

        if(users.isEmpty()) return ResponseEntity.noContent().build();

        System.out.println(users.toString());

        return ResponseEntity.ok(users);

    }


    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id){
        Optional<User> user = repository.findById(id);

        return user.map(item -> ResponseEntity.ok(item)).
                orElse(ResponseEntity.notFound().build());

    }

}
