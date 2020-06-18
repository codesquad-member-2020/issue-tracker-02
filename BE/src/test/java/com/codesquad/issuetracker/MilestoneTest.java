package com.codesquad.issuetracker;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

import com.codesquad.issuetracker.exception.ErrorMessage;
import com.codesquad.issuetracker.issue.data.relation.IssueMilestoneRelationRepository;
import com.codesquad.issuetracker.milestone.business.MilestoneService;
import com.codesquad.issuetracker.milestone.data.Milestone;
import com.codesquad.issuetracker.milestone.data.MilestoneRepository;
import com.codesquad.issuetracker.milestone.web.model.MilestoneQuery;
import com.codesquad.issuetracker.milestone.web.model.MilestoneView;
import java.time.LocalDate;
import java.util.List;
import java.util.NoSuchElementException;
import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@DisplayName("Milestone")
public class MilestoneTest {

  @Nested
  @DisplayName("Integration")
  @SpringBootTest
  public class IntegrationTest {

    @Autowired
    private MilestoneService mileStoneService;

    @Autowired
    private MilestoneRepository milestoneRepository;

    @Autowired
    private IssueMilestoneRelationRepository issueMilestoneRelationRepository;

    @DisplayName("Milestone 을 추가합니다")
    @Transactional
    @Test
    public void create() {
      // given
      MilestoneQuery sampleMilestoneQuery = MilestoneQuery.builder()
          .title("1차 목표")
          .description("1차 목표 상세 설명\n스켈레톤 코드 구성")
          .dueDate(LocalDate.now().plusDays(7))
          .build();

      // when
      MilestoneView savedMilestone = mileStoneService.create(sampleMilestoneQuery);

      // then
      Milestone findMilestone = milestoneRepository.findById(savedMilestone.getId())
          .orElseThrow(NoSuchElementException::new);
      assertThat(findMilestone.getId()).isEqualTo(savedMilestone.getId());
    }

    @DisplayName("Milestone 을 삭제합니다")
    @Transactional
    @Test
    public void delete() {
      // given
      Long sampleId = 2L;

      // when
      mileStoneService.delete(sampleId);

      // then
      assertThat(milestoneRepository.findById(sampleId).isPresent()).isFalse();
      assertThat(issueMilestoneRelationRepository.countAllByMilestoneIdIs(sampleId)).isEqualTo(0);
    }

    @Nested
    @DisplayName("Milestone 을 가져옵니다")
    @SpringBootTest
    public class GetTest {

      @DisplayName("모든")
      @Test
      public void getMilestones() {
        // given

        // when
        List<MilestoneView> findMilestoneViews = mileStoneService.getMilestones();

        // then
        assertThat(findMilestoneViews.size()).isEqualTo(3); // Milestone 의 초기 값은 3개 입니다
      }

      @DisplayName("특정")
      @Test
      public void getMilestone() {
        // given

        // when
        MilestoneView findMilestone = mileStoneService.getMilestone(1L);

        // then
        assertThat(findMilestone).isNotNull();
        assertThat(findMilestone.getIssueCount()).isGreaterThanOrEqualTo(0);
        assertThat(findMilestone.getCloseIssueCount())
            .isGreaterThanOrEqualTo(0)
            .isLessThanOrEqualTo(findMilestone.getIssueCount());
      }
    }

    @Nested
    @DisplayName("Milestone 을 수정합니다")
    @SpringBootTest
    public class PutTest {

      private Long sampleId;

      @DisplayName("존재하지 않는")
      @Test
      public void notExist() {
        // given
        sampleId = 99L;

        // when
        assertThatExceptionOfType(NoSuchElementException.class).isThrownBy(() -> {
          mileStoneService.put(99L, null);
        }).withMessage(ErrorMessage.NOT_EXIST_MILESTONE);

        // then
      }

      @DisplayName("존재하는")
      @Test
      public void exist() {
        // given
        sampleId = 1L;
        MilestoneQuery sampleMilestoneQuery = MilestoneQuery.builder()
            .title("수정된 1차 목표")
            .description("수정된 1차 목표 상세 설명\n스켈레톤 코드 구성")
            .dueDate(LocalDate.now().plusDays(14))
            .build();

        // when
        mileStoneService.put(sampleId, sampleMilestoneQuery);

        // then
        Milestone findMilestone = milestoneRepository.findById(sampleId)
            .orElseThrow(EntityNotFoundException::new);
        assertThat(findMilestone.getId()).isEqualTo(sampleId);
        assertThat(findMilestone.getTitle()).isEqualTo(sampleMilestoneQuery.getTitle());
        assertThat(findMilestone.getDescription()).isEqualTo(sampleMilestoneQuery.getDescription());
        assertThat(findMilestone.getDueDate()).isEqualTo(sampleMilestoneQuery.getDueDate());
      }
    }
  }
}
