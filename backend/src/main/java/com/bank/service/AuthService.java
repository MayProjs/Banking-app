package com.bank.service;

import com.bank.dto.LoginRequest;
import com.bank.entity.User;
import com.bank.exception.CustomException;
import com.bank.repository.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class AuthService {

    private final UserRepository userRepo;

    public AuthService(UserRepository userRepo) {
        this.userRepo = userRepo;
    }

    public ResponseEntity<?> login(LoginRequest req) {

        if (req.getEmail() == null || req.getPassword() == null) {
            throw new CustomException("VALIDATION_ERROR", "Email and password are required");
        }

        User user = userRepo.findByEmail(req.getEmail());

        System.out.println("INPUT EMAIL: " + req.getEmail());
        System.out.println("USER FROM DB: " + user);

        if (user == null || !user.getPassword().equals(req.getPassword())) {
            throw new CustomException("INVALID_CREDENTIALS", "Invalid email or password");
        }

        Map<String, Object> response = new HashMap<>();
        response.put("userId", user.getUserId());
        response.put("email", user.getEmail());
        response.put("role", user.getRole());

        return ResponseEntity.ok(response);
    }
}