package com.codesquad.issuetracker;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

import com.codesquad.issuetracker.label.business.LabelService;
import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.label.data.LabelRepository;
import com.codesquad.issuetracker.label.web.model.LabelQuery;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import javax.transaction.Transactional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@DisplayName("Label")
public class LabelTest {

  private Label sampleLabel;
  private LabelQuery sampleLabelQuery;

  @Nested
  @DisplayName("POJO")
  public class PojoTest {

    @DisplayName("LabelQuery 로 Label 을 만듭니다")
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

  @Nested
  @DisplayName("Integration")
  @SpringBootTest
  public class IntegrationTest {

    @Autowired
    private LabelService labelService;

    @Autowired
    private LabelRepository labelRepository;

    @BeforeEach
    private void beforeEach() {
      sampleLabelQuery = LabelQuery.of("created label", "created label description", "5319e7");
      sampleLabel = Label.from(sampleLabelQuery);
    }

    @DisplayName("모든 Label 을 가져옵니다")
    @Test
    void getLabels() {
      // given

      // when
      List<Label> labels = labelService.getLabels();

      // then
      assertThat(labels.size()).isEqualTo(6); // label 의 초기 값은 6개 입니다
    }

    @DisplayName("Label 을 추가합니다")
    @Transactional
    @Test
    void create() {
      // given

      // when
      Label savedLabel = labelService.create(sampleLabelQuery);

      // then
      Optional<Label> findOptionalLabel = labelRepository.findById(savedLabel.getId());
      assertThat(findOptionalLabel.orElseThrow(NoSuchElementException::new).getId())
          .isEqualTo(savedLabel.getId());
    }

    @DisplayName("특정 Label 을 가져옵니다")
    @Test
    void getLabel() {
      // given
      Label savedLabel = labelRepository.save(sampleLabel);

      // when
      Label findLabel = labelService.getLabel(savedLabel.getId());

      // then
      assertThat(findLabel).isEqualTo(savedLabel);
    }

    @DisplayName("Label 을 삭제합니다")
    @Transactional
    @Test
    void delete() {
      // given
      Label savedLabel = labelRepository.save(sampleLabel);
      Optional<Label> findOptionalLabel = labelRepository.findById(savedLabel.getId());
      assertThat(findOptionalLabel.orElseThrow(NoSuchElementException::new).getId())
          .isEqualTo(savedLabel.getId());

      // when
      labelService.delete(savedLabel.getId());

      // then
      Optional<Label> deletedOptionalLabel = labelRepository.findById(savedLabel.getId());
      assertThatExceptionOfType(NoSuchElementException.class).isThrownBy(() -> {
        deletedOptionalLabel.orElseThrow(NoSuchElementException::new);
      });
    }
  }
}
