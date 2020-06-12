package com.codesquad.issuetracker.label.web.model;


import lombok.Builder;
import lombok.Getter;

@Getter
public class LabelQuery {

  private final String title;
  private final String description;
  private final String color;

  @Builder
  private LabelQuery(String title, String description, String color) {
    this.title = title;
    this.description = description;
    this.color = color;
  }

  public static LabelQuery of(String title, String description, String color) {
    return LabelQuery.builder()
        .title(title)
        .description(description)
        .color(color)
        .build();
  }
}
