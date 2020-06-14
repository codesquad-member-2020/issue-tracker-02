package com.codesquad.issuetracker.label.data;

import com.codesquad.issuetracker.label.web.model.LabelQuery;
import java.util.Objects;
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
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Entity
public class Label {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String title;
  private String description;
  private String color;

  public static Label of(Long id) {
    return Label.builder()
        .id(id)
        .build();
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
