package com.bank.common.exception;

import com.bank.common.exception.dto.ErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

@ControllerAdvice
public class GlobalExceptionHandler {

    //1. Handle Custom Exceptions
    @ExceptionHandler(CustomException.class)
    public ResponseEntity<ErrorResponse> handleCustom(CustomException ex) {

        ErrorResponse error = new ErrorResponse(
                ex.getErrorCode(),
                ex.getMessage()
        );

        return ResponseEntity.badRequest().body(error);
    }

    //2. Handle Validation Errors (@Valid)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(MethodArgumentNotValidException ex) {

        String message = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .findFirst()
                .map(err -> err.getDefaultMessage())
                .orElse("Validation error");

        ErrorResponse error = new ErrorResponse(
                "VALIDATION_ERROR",
                message
        );

        return ResponseEntity.badRequest().body(error);
    }

    //3. Handle Illegal Arguments (manual validation)
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleIllegal(IllegalArgumentException ex) {

        ErrorResponse error = new ErrorResponse(
                "BAD_REQUEST",
                ex.getMessage()
        );

        return ResponseEntity.badRequest().body(error);
    }

    //4. Handle All Other Exceptions
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGeneric(Exception ex) {

        ErrorResponse error = new ErrorResponse(
                "INTERNAL_ERROR",
                ex.getMessage() != null ? ex.getMessage() : "Something went wrong"
        );

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
    }
}