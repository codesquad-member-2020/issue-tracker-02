package com.codesquad.issuetracker.issue.data;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IssueRepository extends JpaRepository<Issue, Long> {

  List<Issue> findAllByUserIdEquals(String userId);

  List<Issue> findAllByTitleContainingOrDescriptionContaining(String title, String description);
}
