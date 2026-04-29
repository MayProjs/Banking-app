package com.bank.admin.controller;

import com.bank.admin.service.AdminService;
import com.bank.transaction.entity.Transaction;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
@CrossOrigin("*")
public class AdminController {

    private final AdminService service;

    public AdminController(AdminService service) {
        this.service = service;
    }

    @GetMapping("/transactions")
    public List<Transaction> getAllTransactions() {
        return service.getAllTransactions();
    }
}