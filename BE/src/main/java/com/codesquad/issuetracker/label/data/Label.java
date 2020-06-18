package com.codesquad.issuetracker.label.data;

import com.codesquad.issuetracker.label.web.model.LabelQuery;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor
@Entity
public class Label {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String title;
  private String description;
  private String color;

  public static Label from(LabelQuery labelQuery) {
    return Label.builder()
        .title(labelQuery.getTitle())
        .description(labelQuery.getDescription())
        .color(labelQuery.getColor())
        .build();
  }

  public static Label from(Long labelId, LabelQuery labelQuery) {
    return Label.builder()
        .id(labelId)
        .title(labelQuery.getTitle())
        .description(labelQuery.getDescription())
        .color(labelQuery.getColor())
        .build();
  }
}
