package com.bank.controller;

import com.bank.dto.DepositRequest;
import com.bank.dto.TransferRequest;
import com.bank.dto.WithdrawRequest;
import com.bank.service.TransactionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/transactions")
//@CrossOrigin("*") // allow React
public class TransactionController {

    private final TransactionService service;

    public TransactionController(TransactionService service) {
        this.service = service;
    }

    @PostMapping("/transfer")
    public ResponseEntity<?> transfer(@Valid @RequestBody TransferRequest req) {
        try {
            Long txnId = service.transferMoney(
                    req.getFromAccount(),
                    req.getToAccount(),
                    req.getAmount(),
                    // req.getTxnType(),
                    req.getChannel()
            );

            return ResponseEntity.ok("Transaction successful. ID: " + txnId);

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
// putting validations on the /deposits... at controller level
    @PostMapping("/deposit")
    public ResponseEntity<?> deposit(@RequestBody DepositRequest req) {
        try {

            if (req.getAccountId() == null) {
                return ResponseEntity.badRequest().body("Account ID is required");
            }

            if (req.getAmount() == null) {
                return ResponseEntity.badRequest().body("Amount is required");
            }

            if (req.getAmount() <= 0) {
                return ResponseEntity.badRequest().body("Amount must be greater than 0");
            }

            if (req.getChannel() == null || req.getChannel().isBlank()) {
                return ResponseEntity.badRequest().body("Channel is required");
            }

            Long txnId = service.depositMoney(
                    req.getAccountId(),
                    req.getAmount(),
                    req.getChannel()
            );

            return ResponseEntity.ok("Deposit successful. ID: " + txnId);

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/withdraw")
    public ResponseEntity<?> withdraw(@Valid @RequestBody WithdrawRequest req) {
        try {

            Long txnId = service.withdrawMoney(
                    req.getAccountId(),
                    req.getAmount(),
                    req.getChannel()
            );

            return ResponseEntity.ok("Withdraw successful. ID: " + txnId);

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}


