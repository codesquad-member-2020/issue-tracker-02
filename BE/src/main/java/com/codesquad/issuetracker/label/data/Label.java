package com.codesquad.issuetracker.label.data;

import com.codesquad.issuetracker.label.web.model.LabelQuery;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Entity
public class Label {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String title;
  private String description;
  private String color;

  @Builder
  private Label(Long id, String title, String description, String color) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.color = color;
  }

  public static Label of(LabelQuery labelQuery) {
    return Label.builder()
        .title(labelQuery.getTitle())
        .description(labelQuery.getDescription())
        .color(labelQuery.getColor())
        .build();
  }
}
