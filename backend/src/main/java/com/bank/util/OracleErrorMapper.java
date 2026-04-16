package com.bank.util;

import com.bank.exception.CustomException;
import java.sql.SQLException;

public class OracleErrorMapper {

    public static void handle(SQLException e) {

        String msg = e.getMessage();

        if (msg.contains("ORA-20001")) {
            throw new CustomException("SAME_ACCOUNT", "Cannot transfer to same account");
        }
        else if (msg.contains("ORA-20002")) {
            throw new CustomException("ACCOUNT_INACTIVE", "Account is not active");
        }
        else if (msg.contains("ORA-20003")) {
            throw new CustomException("INSUFFICIENT_BALANCE", "Insufficient balance");
        }
        else if (msg.contains("ORA-20004")) {
            throw new CustomException("ACCOUNT_NOT_FOUND", "Account not found");
        }
        else if (msg.contains("ORA-20005")) {
            throw new CustomException("SENDER_ACCOUNT_NOT_FOUND", "Sender account not found");
        }
        else if (msg.contains("ORA-20006")) {
            throw new CustomException("RECEIVER_ACCOUNT_NOT_FOUND", "Receiver account not found");
        }
        else if (msg.contains("ORA-20007")) {
            throw new CustomException("INVALID_CHANNEL", "Invalid transaction channel");
        }
        else if (msg.contains("ORA-20008")) {
            throw new CustomException("INVALID_TYPE", "Invalid transaction type");
        }

        throw new CustomException("UNKNOWN_ERROR", msg);
    }
}