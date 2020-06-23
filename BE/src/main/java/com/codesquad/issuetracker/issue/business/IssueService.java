package com.codesquad.issuetracker.issue.business;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.exception.ErrorMessage;
import com.codesquad.issuetracker.exception.NotAllowedException;
import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.issue.data.IssueRepository;
import com.codesquad.issuetracker.issue.data.relation.IssueLabelRelation;
import com.codesquad.issuetracker.issue.data.relation.IssueLabelRelationRepository;
import com.codesquad.issuetracker.issue.data.relation.IssueMilestoneRelation;
import com.codesquad.issuetracker.issue.data.relation.IssueMilestoneRelationRepository;
import com.codesquad.issuetracker.issue.web.model.IssueQuery;
import com.codesquad.issuetracker.issue.web.model.IssueView;
import com.codesquad.issuetracker.issue.web.model.PatchIssueQuery;
import com.codesquad.issuetracker.issue.web.model.PutIssueQuery;
import com.codesquad.issuetracker.issue.web.model.SearchIssueQuery;
import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.label.data.LabelRepository;
import com.codesquad.issuetracker.milestone.data.Milestone;
import com.codesquad.issuetracker.milestone.data.MilestoneRepository;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;
import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class IssueService {

  private final IssueRepository issueRepository;
  private final LabelRepository labelRepository;
  private final MilestoneRepository milestoneRepository;

  private final IssueLabelRelationRepository issueLabelRelationRepository;
  private final IssueMilestoneRelationRepository issueMilestoneRelationRepository;

  private LinkedHashSet<Label> extractLabels(Issue issue) {
    return new LinkedHashSet<>(labelRepository.findAllById(issue.getIdOfLabels()));
  }

  private LinkedHashSet<Milestone> extractMilestones(Issue issue) {
    return new LinkedHashSet<>(milestoneRepository.findAllById(issue.getIdOfMilestones()));
  }

  private Boolean isValidLabelIds(Set<Long> idOfLabels) {
    return idOfLabels.size() == labelRepository.findAllById(idOfLabels).size();
  }

  private Boolean isValidMilestoneIds(Set<Long> idOfMilestones) {
    return idOfMilestones.size() == milestoneRepository.findAllById(idOfMilestones).size();
  }

  public List<IssueView> getIssues(SearchIssueQuery searchIssueQuery) {
    List<Issue> findIssues;
    if (Objects.nonNull(searchIssueQuery.getKeyword())) {
      findIssues = issueRepository
          .findAllByTitleContainingOrDescriptionContaining(searchIssueQuery.getKeyword(),
              searchIssueQuery.getKeyword());
    } else if (Objects.nonNull(searchIssueQuery.getClose())
        && Objects.nonNull(searchIssueQuery.getUserId())) {
      findIssues = issueRepository
          .findAllByCloseAndUserId(searchIssueQuery.getClose(), searchIssueQuery.getUserId());
    } else if (Objects.nonNull(searchIssueQuery.getClose())) {
      findIssues = issueRepository.findAllByClose(searchIssueQuery.getClose());
    } else if (Objects.nonNull(searchIssueQuery.getUserId())) {
      findIssues = issueRepository.findAllByUserId(searchIssueQuery.getUserId());
    } else {
      findIssues = issueRepository.findAll();
    }

    return findIssues.stream()
        .map(issue -> IssueView.from(issue, extractLabels(issue), extractMilestones(issue)))
        .collect(Collectors.toList());
  }

  public IssueView getIssue(Long issueId) {
    Issue findIssue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
    return IssueView.from(findIssue, extractLabels(findIssue), extractMilestones(findIssue),
        findIssue.getReplies());
  }

  @Transactional
  public IssueView create(User user, IssueQuery query) {
    Set<Long> idOfLabels = query.getIdOfLabels();
    Set<Long> idOfMilestones = query.getIdOfMilestones();

    if (!isValidLabelIds(idOfLabels)) {
      throw new NoSuchElementException(ErrorMessage.NOT_EXIST_LABEL);
    }

    if (!isValidMilestoneIds(idOfMilestones)) {
      throw new NoSuchElementException(ErrorMessage.NOT_EXIST_MILESTONE);
    }

    Issue issue = Issue.from(user, query);
    issueRepository.save(issue);
    idOfLabels.forEach(
        labelId -> issueLabelRelationRepository.save(IssueLabelRelation.of(issue, labelId)));
    idOfMilestones.forEach(milestoneId -> issueMilestoneRelationRepository
        .save(IssueMilestoneRelation.of(issue, milestoneId)));

    return IssueView.from(issue, extractLabels(issue), extractMilestones(issue));
  }

  @Transactional
  public void delete(Long issueId, User user) {
    Issue findIssue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);

    if (!findIssue.isSameUser(user)) {
      throw new NotAllowedException(ErrorMessage.ANOTHER_USER_ISSUE);
    }

    issueRepository.delete(findIssue);
  }

  @Transactional
  public IssueView put(Long issueId, User user, PutIssueQuery query) {
    Issue issue = issueRepository.findById(issueId).orElseThrow(EntityNotFoundException::new);

    if (!issue.isSameUser(user)) {
      throw new NotAllowedException(ErrorMessage.ANOTHER_USER_ISSUE);
    }

    issue.update(query);

    return IssueView.from(issue, extractLabels(issue), extractMilestones(issue));
  }

  @Transactional
  public void patch(Long issueId, PatchIssueQuery query) {
    Issue issue = issueRepository.findById(issueId).orElseThrow(EntityNotFoundException::new);

    issue.updateStatus(query.getClose());

    if (Objects.nonNull(query.getAttachLabel())) {
      issueLabelRelationRepository.save(IssueLabelRelation.of(issue, query.getAttachLabel()));
    }

    if (Objects.nonNull(query.getDetachLabel())) {
      IssueLabelRelation deletedRelation = issueLabelRelationRepository
          .findByIssueAndLabelId(issue, query.getDetachLabel())
          .orElseThrow(EntityNotFoundException::new);
      issueLabelRelationRepository.delete(deletedRelation);
    }

    if (Objects.nonNull(query.getAttachMilestone())) {
      issueMilestoneRelationRepository
          .save(IssueMilestoneRelation.of(issue, query.getAttachMilestone()));
    }

    if (Objects.nonNull(query.getDetachMilestone())) {
      IssueMilestoneRelation deletedRelation = issueMilestoneRelationRepository
          .findByIssueAndMilestoneId(issue, query.getDetachMilestone())
          .orElseThrow(EntityNotFoundException::new);
      issueMilestoneRelationRepository.delete(deletedRelation);
    }
  }
}
