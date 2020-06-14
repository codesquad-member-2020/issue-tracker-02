package com.codesquad.issuetracker.exception;

import com.codesquad.issuetracker.exception.reponse.ExceptionResponse;
import java.util.NoSuchElementException;
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

  @ExceptionHandler(NotAllowedException.class)
  @ResponseStatus(HttpStatus.CONFLICT)
  public ExceptionResponse handleNotAllowedException(NotAllowedException e) {
    return new ExceptionResponse(e.getClass().toString(), e.getMessage());
  }

  @ExceptionHandler(NoSuchElementException.class)
  @ResponseStatus(HttpStatus.CONFLICT)
  public ExceptionResponse handleNoSuchElementException(NoSuchElementException e) {
    return new ExceptionResponse(e.getClass().toString(), e.getMessage());
  }
}
