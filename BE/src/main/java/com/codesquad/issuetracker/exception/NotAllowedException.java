package com.codesquad.issuetracker.exception;

public class NotAllowedException extends RuntimeException {

  public NotAllowedException(String errorMsg) {
    super(errorMsg);
  }
}
