package com.codesquad.issuetracker.exception.reponse;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ExceptionResponse {

  String exceptionClass;
  String message;
}
