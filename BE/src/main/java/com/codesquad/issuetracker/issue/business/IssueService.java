package com.codesquad.issuetracker.issue.business;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.exception.ErrorMessage;
import com.codesquad.issuetracker.exception.NotAllowedException;
import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.issue.data.IssueRepository;
import com.codesquad.issuetracker.issue.web.model.IssueQuery;
import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.label.data.LabelRepository;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import javax.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class IssueService {

  private final IssueRepository issueRepository;
  private final LabelRepository labelRepository;

  public List<Issue> getIssues() {
    return issueRepository.findAll();
  }

  public Issue getIssue(Long issueId) {
    return issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
  }

  @Transactional
  public Issue create(User user, IssueQuery query) {
    LinkedHashSet<Label> labels = query.getIdOfLabels().stream()
        .map(id -> labelRepository.findById(id)
            .orElseThrow(() -> new NoSuchElementException(ErrorMessage.NOT_EXIST_LABEL)))
        .collect(Collectors.toCollection(LinkedHashSet::new));

    return issueRepository.save(Issue.from(user, query, labels));
  }

  @Transactional
  public void delete(User user, Long issueId) {
    Issue findIssue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);

    if (!findIssue.isSameUser(user)) {
      throw new NotAllowedException(ErrorMessage.ANOTHER_USER_ISSUE);
    }

    issueRepository.delete(findIssue);
  }
}
