package com.codesquad.issuetracker.issue.data.relation;

import com.codesquad.issuetracker.issue.data.Issue;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IssueMilestoneRelationRepository extends
    JpaRepository<IssueMilestoneRelation, Long> {

  long countAllByMilestoneIdIs(Long milestoneId);

  long countAllByIssueIs(Issue issue);

  void deleteAllByMilestoneId(Long milestoneId);
}
