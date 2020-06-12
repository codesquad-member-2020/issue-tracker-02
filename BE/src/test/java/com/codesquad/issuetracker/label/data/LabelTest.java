package com.codesquad.issuetracker.label.data;

import static org.assertj.core.api.Assertions.assertThat;

import com.codesquad.issuetracker.label.web.model.LabelQuery;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

@DisplayName("Label : POJO")
class LabelTest {

  @DisplayName("LabelQuery 객체로 Label 객체를 만듭니다")
  @Test
  void makeLabelByLabelQuery() {
    // given
    LabelQuery labelQuery = LabelQuery.of("created label", "created label description", "5319e7");

    // when
    Label label = Label.from(labelQuery);

    // then
    assertThat(label.getId()).isNull();
    assertThat(label.getTitle()).isEqualTo(labelQuery.getTitle());
    assertThat(label.getDescription()).isEqualTo(labelQuery.getDescription());
    assertThat(label.getColor()).isEqualTo(labelQuery.getColor());
  }
}
