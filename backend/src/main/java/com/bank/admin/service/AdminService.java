package com.bank.admin.service;

import com.bank.transaction.entity.Transaction;
import com.bank.transaction.repository.TransactionRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    private final TransactionRepository txnRepo;

    public AdminService(TransactionRepository txnRepo) {
        this.txnRepo = txnRepo;
    }

    public List<Transaction> getAllTransactions() {
        return txnRepo.findAllByOrderByTransactionIdDesc();
    }
}