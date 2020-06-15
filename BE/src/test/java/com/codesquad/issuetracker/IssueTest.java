package com.codesquad.issuetracker;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.exception.ErrorMessage;
import com.codesquad.issuetracker.exception.NotAllowedException;
import com.codesquad.issuetracker.issue.business.IssueService;
import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.issue.data.IssueRepository;
import com.codesquad.issuetracker.issue.web.model.IssueQuery;
import com.codesquad.issuetracker.issue.web.model.IssueView;
import com.google.common.primitives.Longs;
import java.util.LinkedHashSet;
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

@DisplayName("Issue")
public class IssueTest {

  @Nested
  @DisplayName("Integration")
  @SpringBootTest
  public class IntegrationTest {

    @Autowired
    private IssueService issueService;

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
    @DisplayName("Issue 를 추가합니다")
    @Transactional
    @SpringBootTest
    public class CreateTest {

      @Autowired
      private IssueRepository issueRepository;

      private User sampleUser;
      private IssueQuery sampleIssueQuery;

      @BeforeEach
      private void beforeEach() {
        sampleUser = User.builder()
            .nodeId("MDQ6VXNlcjU1NzIyMTg2")
            .userId("Hyune-c")
            .avatarUrl("https://avatars1.githubusercontent.com/u/55722186?v=4")
            .build();
      }

      @DisplayName("Label 이 없는 IssueQuery 로")
      @Test
      public void createWithNoLabel() {
        // given
        sampleIssueQuery = IssueQuery.builder()
            .title("Hyune-c 1")
            .description("Hyune-c contents1\\nHyune-c contents1\\nHyune-c contents1")
            .build();

        // when
        IssueView savedIssue = issueService.create(sampleUser, sampleIssueQuery);

        // then
        Optional<Issue> findOptionalIssue = issueRepository.findById(savedIssue.getId());
        Issue findIssue = findOptionalIssue.orElseThrow(NoSuchElementException::new);

        assertThat(findIssue.getId())
            .isEqualTo(savedIssue.getId());
      }

      @DisplayName("존재하는 Label id 를 가지고 있는 IssueQuery 로")
      @Test
      public void createWithLabel() {
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
        assertThat(findIssue.getIssueLabelRelations().size())
            .isEqualTo(idOfLabels.size());
      }

      @DisplayName("존재하지 않는 Label id 를 가지고 있는 IssueQuery 로")
      @Test
      public void createWithWrongLabel() {
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
    @DisplayName("Issue 를 삭제합니다")
    @Transactional
    @SpringBootTest
    public class DeleteTest {

      @Autowired
      private IssueRepository issueRepository;

      private User sampleUser;

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

        // when
        issueService.delete(sampleUser, 9L);

        // then
        Optional<Issue> deletedOptionalIssue = issueRepository.findById(9L);

        assertThatExceptionOfType(NoSuchElementException.class).isThrownBy(() -> {
          deletedOptionalIssue.orElseThrow(NoSuchElementException::new);
        });
      }

      @DisplayName("다른 User 의")
      @Test
      void deleteOtherIssue() {
        // given

        // when
        assertThatExceptionOfType(NotAllowedException.class).isThrownBy(() -> {
          issueService.delete(sampleUser, 1L);
        }).withMessage(ErrorMessage.ANOTHER_USER_ISSUE);

        // then
      }
    }
  }
}
