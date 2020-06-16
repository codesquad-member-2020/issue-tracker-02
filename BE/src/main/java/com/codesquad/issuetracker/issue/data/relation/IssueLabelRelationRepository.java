package com.codesquad.issuetracker.issue.data.relation;

import com.codesquad.issuetracker.issue.data.Issue;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IssueLabelRelationRepository extends JpaRepository<IssueLabelRelation, Long> {

  long countAllByLabelIdIs(Long labelId);

  long countAllByIssueIs(Issue issue);

  void deleteAllByLabelId(Long labelId);
}
