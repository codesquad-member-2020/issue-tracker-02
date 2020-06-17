package com.codesquad.issuetracker;

import static org.assertj.core.api.Assertions.assertThat;

import com.codesquad.issuetracker.issue.data.relation.IssueMilestoneRelationRepository;
import com.codesquad.issuetracker.milestone.business.MilestoneService;
import com.codesquad.issuetracker.milestone.data.Milestone;
import com.codesquad.issuetracker.milestone.data.MilestoneRepository;
import com.codesquad.issuetracker.milestone.web.model.MilestoneQuery;
import com.codesquad.issuetracker.milestone.web.model.MilestoneView;
import java.time.LocalDate;
import java.util.List;
import java.util.NoSuchElementException;
import javax.transaction.Transactional;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@DisplayName("MileStone")
public class MilestoneTest {

  @Nested
  @DisplayName("Integration")
  @SpringBootTest
  public class IntegrationTest {

    @Autowired
    private MilestoneService mileStoneService;

    @Autowired
    private MilestoneRepository mileStoneRepository;

    @Autowired
    private IssueMilestoneRelationRepository issueMilestoneRelationRepository;

    @DisplayName("MileStone 을 추가합니다")
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
      Milestone findMilestone = mileStoneRepository.findById(savedMilestone.getId())
          .orElseThrow(NoSuchElementException::new);
      assertThat(findMilestone.getId()).isEqualTo(savedMilestone.getId());
    }

    @DisplayName("MileStone 을 삭제합니다")
    @Transactional
    @Test
    public void delete() {
      // given
      Long sampleId = 2L;

      // when
      mileStoneService.delete(sampleId);

      // then
      assertThat(mileStoneRepository.findById(sampleId).isPresent()).isFalse();
      assertThat(issueMilestoneRelationRepository.countAllByMilestoneIdIs(sampleId)).isEqualTo(0);
    }

    @Nested
    @DisplayName("MileStone 을 가져옵니다")
    @SpringBootTest
    public class GetTest {

      @DisplayName("모든")
      @Test
      public void getMileStones() {
        // given

        // when
        List<MilestoneView> findMilestoneViews = mileStoneService.getMileStones();

        // then
        assertThat(findMilestoneViews.size()).isEqualTo(3); // MileStone 의 초기 값은 3개 입니다
      }

      @DisplayName("특정")
      @Test
      public void getMileStone() {
        // given

        // when
        MilestoneView findMilestone = mileStoneService.getMileStone(1L);

        // then
        assertThat(findMilestone).isNotNull();
//        assertThat(findMilestone.getIssueCount()).isGreaterThanOrEqualTo(0);
//        assertThat(findMilestone.getCloseIssueCount())
//            .isGreaterThanOrEqualTo(0)
//            .isLessThanOrEqualTo(findMilestone.getIssueCount());
      }
    }
  }
}
