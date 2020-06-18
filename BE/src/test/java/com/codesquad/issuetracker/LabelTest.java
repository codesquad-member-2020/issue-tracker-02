package com.codesquad.issuetracker;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

import com.codesquad.issuetracker.exception.ErrorMessage;
import com.codesquad.issuetracker.issue.data.relation.IssueLabelRelationRepository;
import com.codesquad.issuetracker.label.business.LabelService;
import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.label.data.LabelRepository;
import com.codesquad.issuetracker.label.web.model.LabelQuery;
import com.codesquad.issuetracker.label.web.model.LabelView;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import javax.persistence.EntityNotFoundException;
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

    @Autowired
    private IssueLabelRelationRepository issueLabelRelationRepository;

    private LabelQuery sampleLabelQuery;

    @BeforeEach
    private void beforeEach() {
      sampleLabelQuery = LabelQuery.builder()
          .title("sample label")
          .description("sample description")
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
      assertThat(labelRepository.findById(sampleId).isPresent()).isFalse();
      assertThat(issueLabelRelationRepository.countAllByLabelIdIs(sampleId)).isEqualTo(0);
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

    @Nested
    @DisplayName("Label 을 수정합니다")
    @SpringBootTest
    public class PutTest {

      private Long sampleId;

      @DisplayName("존재하지 않는")
      @Test
      public void notExist() {
        // given
        sampleId = 99L;

        // when
        assertThatExceptionOfType(EntityNotFoundException.class).isThrownBy(() -> {
          labelService.put(99L, null);
        }).withMessage(ErrorMessage.NOT_EXIST_LABEL);

        // then
      }

      @DisplayName("존재하는")
      @Test
      public void exist() {
        // given
        sampleId = 1L;
        sampleLabelQuery = LabelQuery.builder()
            .title("sample label")
            .description("sample description")
            .color("5319e7")
            .build();

        // when
        labelService.put(sampleId, sampleLabelQuery);

        // then
        Label findLabel = labelRepository.findById(sampleId)
            .orElseThrow(EntityNotFoundException::new);
        assertThat(findLabel.getId()).isEqualTo(sampleId);
        assertThat(findLabel.getTitle()).isEqualTo(sampleLabelQuery.getTitle());
        assertThat(findLabel.getDescription()).isEqualTo(sampleLabelQuery.getDescription());
        assertThat(findLabel.getColor()).isEqualTo(sampleLabelQuery.getColor());
      }
    }
  }
}
