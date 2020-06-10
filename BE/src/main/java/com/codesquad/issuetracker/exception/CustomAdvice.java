package com.codesquad.issuetracker.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class CustomAdvice {

  @ExceptionHandler(Exception.class)
  @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
  public ExceptionResponse handleException(Exception e) {
    return new ExceptionResponse(e.getClass().toString(), e.getMessage());

  }

  @Getter
  private class ExceptionResponse {

    String exceptionClass;
    String message;

    public ExceptionResponse(String exceptionClass, String message) {
      this.exceptionClass = exceptionClass;
      this.message = message;
    }
  }
}
