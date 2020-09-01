package com.codesquad.issuetracker.label.web.model;

import com.codesquad.issuetracker.label.data.Label;
import java.util.List;
import java.util.stream.Collectors;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class LabelView {

  private final Long id;
  private final String title;
  private final String description;
  private final String color;

  public static LabelView from(Label label) {
    return LabelView.builder()
        .id(label.getId())
        .title(label.getTitle())
        .description(label.getDescription())
        .color(label.getColor())
        .build();
  }

  public static List<LabelView> toList(List<Label> labels) {
    return labels.stream()
        .map(LabelView::from)
        .collect(Collectors.toList());
  }
}
