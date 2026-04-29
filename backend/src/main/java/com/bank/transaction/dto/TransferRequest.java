package com.bank.transaction.dto;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Positive;

public class TransferRequest
{
    @NotNull(message = "FromAccount ID is required")
    private Long fromAccount;

    @NotNull(message = " To Account ID is required")
    private Long toAccount;

    @NotNull(message = "Amount is required")
    @Positive(message = "Amount must be greater than 0")
    private Double amount;
    // private String txnType;
    @NotBlank(message = "Channel is required")
    private String channel;

    public Long getFromAccount() {
        return fromAccount;
    }

    public void setFromAccount(Long fromAccount) {
        this.fromAccount = fromAccount;
    }

    public Long getToAccount() {
        return toAccount;
    }

    public void setToAccount(Long toAccount) {
        this.toAccount = toAccount;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    // public String getTxnType() {
    //     return txnType;
    // }

    // public void setTxnType(String txnType) {
    //     this.txnType = txnType;
    // }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }
}
