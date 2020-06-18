package com.codesquad.issuetracker.issue.data.relation;

import com.codesquad.issuetracker.issue.data.Issue;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IssueLabelRelationRepository extends JpaRepository<IssueLabelRelation, Long> {

  long countAllByLabelIdIs(Long labelId);

  long countAllByIssueIs(Issue issue);

  void deleteAllByLabelId(Long labelId);

  Optional<IssueLabelRelation> findByIssueAndLabelId(Issue issue, Long labelId);

  List<IssueLabelRelation> findAllByIssue(Issue issue);
}
