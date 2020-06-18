package com.codesquad.issuetracker;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.exception.ErrorMessage;
import com.codesquad.issuetracker.exception.NotAllowedException;
import com.codesquad.issuetracker.issue.business.IssueService;
import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.issue.data.IssueRepository;
import com.codesquad.issuetracker.issue.data.relation.IssueLabelRelationRepository;
import com.codesquad.issuetracker.issue.data.relation.IssueMilestoneRelationRepository;
import com.codesquad.issuetracker.issue.web.model.IssueQuery;
import com.codesquad.issuetracker.issue.web.model.IssueView;
import com.codesquad.issuetracker.issue.web.model.PutIssueQuery;
import com.google.common.primitives.Longs;
import java.util.LinkedHashSet;
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

@DisplayName("Issue")
public class IssueTest {

  private Long sampleId;
  private User sampleUser;
  private IssueQuery sampleIssueQuery;

  @Nested
  @DisplayName("Integration")
  @SpringBootTest
  public class IntegrationTest {

    @Autowired
    private IssueService issueService;

    @Autowired
    private IssueLabelRelationRepository issueLabelRelationRepository;

    @Autowired
    private IssueMilestoneRelationRepository issueMilestoneRelationRepository;

    @Nested
    @DisplayName("Issue 를 가져옵니다")
    public class GetTest {

      @DisplayName("모든 ")
      @Test
      public void getIssues() {
        // given

        // when
        List<IssueView> findIssues = issueService.getIssues();

        // then
        assertThat(findIssues.size()).isEqualTo(16); // Issue 의 초기 값은 16개 입니다
      }

      @DisplayName("특정 ")
      @Test
      void getIssue() {
        // given

        // when
        IssueView findIssue = issueService.getIssue(1L);

        // then
        assertThat(findIssue).isNotNull();
      }
    }

    @Nested
    @DisplayName("IssueQuery 로 Issue 를 추가합니다")
    @Transactional
    @SpringBootTest
    public class CreateTest {

      @Autowired
      private IssueRepository issueRepository;

      @BeforeEach
      private void beforeEach() {
        sampleUser = User.builder()
            .nodeId("MDQ6VXNlcjU1NzIyMTg2")
            .userId("Hyune-c")
            .avatarUrl("https://avatars1.githubusercontent.com/u/55722186?v=4")
            .build();
      }

      @Nested
      @DisplayName("Label 과")
      @Transactional
      @SpringBootTest
      public class WithLabelTest {

        @DisplayName("Milestone 없이")
        @Test
        public void withOutMilestone() {
          // given
          LinkedHashSet<Long> idOfLabels = new LinkedHashSet<>(Longs.asList(4, 5, 1));
          sampleIssueQuery = IssueQuery.builder()
              .title("Hyune-c 1")
              .description("Hyune-c contents1\\nHyune-c contents1\\nHyune-c contents1")
              .idOfLabels(idOfLabels)
              .build();

          // when
          IssueView savedIssue = issueService.create(sampleUser, sampleIssueQuery);

          // then
          Optional<Issue> findOptionalIssue = issueRepository.findById(savedIssue.getId());
          Issue findIssue = findOptionalIssue.orElseThrow(NoSuchElementException::new);

          assertThat(findIssue.getId())
              .isEqualTo(savedIssue.getId());
          assertThat(issueLabelRelationRepository.countAllByIssueIs(findIssue))
              .isEqualTo(idOfLabels.size());
        }
      }

      @Nested
      @DisplayName("존재하지 않는 Label 과")
      @Transactional
      @SpringBootTest
      public class WithNotExistLabelTest {

        @DisplayName("Milestone 없이")
        @Test
        public void withOutMilestone() {
          // given
          LinkedHashSet<Long> idOfLabels = new LinkedHashSet<>(Longs.asList(4, 15, 1));
          sampleIssueQuery = IssueQuery.builder()
              .title("Hyune-c 1")
              .description("Hyune-c contents1\\nHyune-c contents1\\nHyune-c contents1")
              .idOfLabels(idOfLabels)
              .build();

          // when
          assertThatExceptionOfType(NoSuchElementException.class)
              .isThrownBy(() -> issueService.create(sampleUser, sampleIssueQuery))
              .withMessage(ErrorMessage.NOT_EXIST_LABEL);

          // then
        }
      }

      @Nested
      @DisplayName("Label 없이")
      @Transactional
      @SpringBootTest
      public class WithOutLabelTest {

        @DisplayName("Milestone 없이")
        @Test
        public void withOutMilestone() {
          // given
          sampleIssueQuery = IssueQuery.builder()
              .title("Hyune-c 1")
              .description("Hyune-c contents1\\nHyune-c contents1\\nHyune-c contents1")
              .build();

          // when
          IssueView savedIssue = issueService.create(sampleUser, sampleIssueQuery);

          // then
          Issue validateIssue = issueRepository.findById(savedIssue.getId())
              .orElseThrow(NoSuchElementException::new);

          assertThat(validateIssue.getId())
              .isEqualTo(savedIssue.getId());
          assertThat(validateIssue.getIssueLabelRelations().size())
              .isEqualTo(0);
        }

        @DisplayName("Milestone 있이")
        @Test
        public void WithMileStone() {
          // given
          LinkedHashSet<Long> idOfMilestone = new LinkedHashSet<>(Longs.asList(2, 1));
          sampleIssueQuery = IssueQuery.builder()
              .title("Hyune-c 1")
              .description("Hyune-c contents1\\nHyune-c contents1\\nHyune-c contents1")
              .idOfMilestones(idOfMilestone)
              .build();

          // when
          IssueView savedIssue = issueService.create(sampleUser, sampleIssueQuery);

          // then
          Issue validateIssue = issueRepository.findById(savedIssue.getId())
              .orElseThrow(NoSuchElementException::new);

          assertThat(validateIssue.getId())
              .isEqualTo(savedIssue.getId());
          assertThat(issueMilestoneRelationRepository.countAllByIssueIs(validateIssue))
              .isEqualTo(idOfMilestone.size());
        }

        @DisplayName("존재하지 않는 Milestone 으로")
        @Test
        public void WithNotExistMilestone() {
          // given
          LinkedHashSet<Long> idOfMilestone = new LinkedHashSet<>(Longs.asList(99, 105));
          sampleIssueQuery = IssueQuery.builder()
              .title("Hyune-c 1")
              .description("Hyune-c contents1\\nHyune-c contents1\\nHyune-c contents1")
              .idOfMilestones(idOfMilestone)
              .build();

          // when
          assertThatExceptionOfType(NoSuchElementException.class)
              .isThrownBy(() -> issueService.create(sampleUser, sampleIssueQuery))
              .withMessage(ErrorMessage.NOT_EXIST_MILESTONE);

          // then
        }
      }
    }

    @Nested
    @DisplayName("Issue 를 삭제합니다")
    @Transactional
    @SpringBootTest
    public class DeleteTest {

      @Autowired
      private IssueRepository issueRepository;

      @BeforeEach
      private void beforeEach() {
        sampleUser = User.builder()
            .nodeId("MDQ6VXNlcjU1NzIyMTg2")
            .userId("Hyune-c")
            .avatarUrl("https://avatars1.githubusercontent.com/u/55722186?v=4").build();
      }

      @DisplayName("맞는 User 의")
      @Test
      void deleteOwnIssue() {
        // given
        sampleId = 9L;

        // when
        issueService.delete(sampleId, sampleUser);

        // then
        assertThat(issueRepository.findById(sampleId).isPresent()).isFalse();
        assertThat(issueLabelRelationRepository.countAllByLabelIdIs(sampleId)).isEqualTo(0);
      }

      @DisplayName("다른 User 의")
      @Test
      void deleteOtherIssue() {
        // given
        sampleId = 1L;

        // when
        assertThatExceptionOfType(NotAllowedException.class).isThrownBy(() -> {
          issueService.delete(sampleId, sampleUser);
        }).withMessage(ErrorMessage.ANOTHER_USER_ISSUE);

        // then
      }
    }

    @Nested
    @DisplayName("Issue 를 수정합니다")
    @Transactional
    @SpringBootTest
    public class PutTest {

      @Autowired
      private IssueRepository issueRepository;

      private PutIssueQuery samplePutIssueQuery;

      @BeforeEach
      private void beforeEach() {
        sampleUser = User.builder()
            .nodeId("MDQ6VXNlcjU1NzIyMTg2")
            .userId("Hyune-c")
            .avatarUrl("https://avatars1.githubusercontent.com/u/55722186?v=4").build();

        samplePutIssueQuery = PutIssueQuery.builder()
            .title("수정된 Hyune-c 1")
            .description("수정된 Hyune-c contents1\\nHyune-c contents1\\nHyune-c contents1")
            .build();
      }

      @DisplayName("존재하지 않는")
      @Test
      public void notExist() {
        // given
        sampleId = 99L;

        // when
        assertThatExceptionOfType(EntityNotFoundException.class).isThrownBy(() -> {
          issueService.put(sampleId, sampleUser, samplePutIssueQuery);
        });

        // then
      }

      @DisplayName("존재하는")
      public class ExistTest {

        @DisplayName("다른 User 의")
        @Test
        void notOwn() {
          // given
          sampleId = 1L;

          // when
          assertThatExceptionOfType(NotAllowedException.class).isThrownBy(() -> {
            issueService.put(sampleId, sampleUser, samplePutIssueQuery);
          }).withMessage(ErrorMessage.ANOTHER_USER_ISSUE);

          // then
        }

        @DisplayName("맞는 User 의")
        @Test
        void own() {
          // given
          sampleId = 9L;

          // when
          issueService.put(sampleId, sampleUser, samplePutIssueQuery);

          // then
          Issue findIssue = issueRepository.findById(sampleId)
              .orElseThrow(EntityNotFoundException::new);
          assertThat(findIssue.getId()).isEqualTo(sampleId);
          assertThat(findIssue.getTitle()).isEqualTo(samplePutIssueQuery.getTitle());
          assertThat(findIssue.getDescription()).isEqualTo(samplePutIssueQuery.getDescription());
        }
      }
    }
  }
}
