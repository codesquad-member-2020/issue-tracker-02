package com.codesquad.issuetracker.issue.business;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.issue.data.IssueRepository;
import com.codesquad.issuetracker.issue.web.model.IssueQuery;
import java.util.List;
import java.util.NoSuchElementException;
import javax.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class IssueService {

  private final IssueRepository issueRepository;

  public List<Issue> getIssues(User user) {
    return issueRepository.findAllByUserIdEquals(user.getUserId());
  }

  public Issue getIssue(User user, Long issueId) {
    Issue findIssue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);

    if (!findIssue.isSameUser(user)) {
      throw new RuntimeException("다른 유저의 Issue 입니다");
    }

    return findIssue;
  }

  @Transactional
  public Issue create(User user, IssueQuery query) {
    return issueRepository.save(Issue.of(user, query));
  }

  @Transactional
  public void delete(User user, Long issueId) {
    Issue findIssue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);

    if (!findIssue.isSameUser(user)) {
      throw new RuntimeException("다른 유저의 Issue 입니다");
    }

    issueRepository.delete(findIssue);
  }
}
