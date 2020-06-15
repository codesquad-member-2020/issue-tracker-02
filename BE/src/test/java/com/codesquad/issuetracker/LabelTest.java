package com.codesquad.issuetracker;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

import com.codesquad.issuetracker.label.business.LabelService;
import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.label.data.LabelRepository;
import com.codesquad.issuetracker.label.web.model.LabelQuery;
import com.codesquad.issuetracker.label.web.model.LabelView;
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

  @Nested
  @DisplayName("Integration")
  @SpringBootTest
  public class IntegrationTest {

    @Autowired
    private LabelService labelService;

    @Autowired
    private LabelRepository labelRepository;

    private LabelQuery sampleLabelQuery;

    @BeforeEach
    private void beforeEach() {
      sampleLabelQuery = LabelQuery.builder()
          .title("created label")
          .description("created label description")
          .color("5319e7")
          .build();
    }

    @DisplayName("Label 을 추가합니다")
    @Transactional
    @Test
    public void create() {
      // given

      // when
      LabelView savedLabel = labelService.create(sampleLabelQuery);

      // then
      Optional<Label> findOptionalLabel = labelRepository.findById(savedLabel.getId());
      assertThat(findOptionalLabel.orElseThrow(NoSuchElementException::new).getId())
          .isEqualTo(savedLabel.getId());
    }

    @DisplayName("Label 을 삭제합니다")
    @Transactional
    @Test
    public void delete() {
      // given
      Long sampleId = 2L;

      // when
      labelService.delete(sampleId);

      // then
      labelRepository.findAll();
      Optional<Label> deletedOptionalLabel = labelRepository.findById(sampleId);
      assertThatExceptionOfType(NoSuchElementException.class).isThrownBy(() -> {
        deletedOptionalLabel.orElseThrow(NoSuchElementException::new);
      });
    }

    @Nested
    @DisplayName("Label 을 가져옵니다")
    public class GetTest {

      @DisplayName("모든")
      @Test
      public void getLabels() {
        // given

        // when
        List<LabelView> labels = labelService.getLabels();

        // then
        assertThat(labels.size()).isEqualTo(6); // label 의 초기 값은 6개 입니다
      }

      @DisplayName("특정")
      @Test
      public void getLabel() {
        // given

        // when
        LabelView findLabel = labelService.getLabel(1L);

        // then
        assertThat(findLabel).isNotNull();
      }
    }
  }
}
