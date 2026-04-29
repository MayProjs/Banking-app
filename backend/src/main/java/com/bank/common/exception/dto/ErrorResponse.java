package com.bank.common.exception.dto;

public class ErrorResponse {

    private String errorCode;
    private String message;

    public ErrorResponse(String errorCode, String message) {
        this.errorCode = errorCode;
        this.message = message;
    }

//    getters
    public String getErrorCode() { return errorCode; }
    public String getMessage() { return message; }
}