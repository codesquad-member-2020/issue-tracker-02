package com.codesquad.issuetracker.issue.business;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.issue.data.IssueRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class IssueService {

  private final IssueRepository issueRepository;

  public List<Issue> getIssues(User user) {
    return issueRepository.findAllByUserIdEquals(user.getUserId());
  }
}
