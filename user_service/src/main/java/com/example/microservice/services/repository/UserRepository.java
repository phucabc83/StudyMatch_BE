package com.example.microservice.services.repository;

import com.example.microservice.services.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.Repository;

public interface UserRepository extends JpaRepository<User, Long> {
}
