package com.codesquad.issuetracker.label.web.model;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class LabelQuery {

  private final String title;
  private final String description;
  private final String color;
}
