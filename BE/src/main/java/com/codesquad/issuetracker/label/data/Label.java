package com.codesquad.issuetracker.label.data;

import com.codesquad.issuetracker.label.web.model.LabelQuery;
import java.util.Objects;
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

  public static Label from(LabelQuery labelQuery) {
    return Label.builder()
        .title(labelQuery.getTitle())
        .description(labelQuery.getDescription())
        .color(labelQuery.getColor())
        .build();
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof Label)) {
      return false;
    }
    Label label = (Label) o;
    return Objects.equals(getId(), label.getId()) &&
        Objects.equals(getTitle(), label.getTitle()) &&
        Objects.equals(getDescription(), label.getDescription()) &&
        Objects.equals(getColor(), label.getColor());
  }

  @Override
  public int hashCode() {
    return Objects.hash(getId(), getTitle(), getDescription(), getColor());
  }
}
