package com.codesquad.issuetracker.milestone.business;

import com.codesquad.issuetracker.exception.ErrorMessage;
import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.issue.data.relation.IssueMilestoneRelation;
import com.codesquad.issuetracker.issue.data.relation.IssueMilestoneRelationRepository;
import com.codesquad.issuetracker.milestone.data.Milestone;
import com.codesquad.issuetracker.milestone.data.MilestoneRepository;
import com.codesquad.issuetracker.milestone.web.model.MilestoneQuery;
import com.codesquad.issuetracker.milestone.web.model.MilestoneView;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import javax.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MilestoneService {

  private final MilestoneRepository milestoneRepository;
  private final IssueMilestoneRelationRepository issueMilestoneRelationRepository;

  private List<Issue> extractIssues(Milestone milestone) {
    return issueMilestoneRelationRepository.findAllByMilestoneId(milestone.getId()).stream()
        .map(IssueMilestoneRelation::getIssue)
        .collect(Collectors.toList());
  }

  public List<MilestoneView> getMilestones() {
    List<Milestone> milestones = milestoneRepository.findAll();
    return milestones.stream()
        .map(milestone -> MilestoneView.from(milestone, extractIssues(milestone)))
        .collect(Collectors.toList());
  }

  public MilestoneView getMilestone(Long labelId) {
    Milestone findMilestone = milestoneRepository.findById(labelId)
        .orElseThrow(() -> new NoSuchElementException(ErrorMessage.NOT_EXIST_MILESTONE));
    return MilestoneView.from(findMilestone, extractIssues(findMilestone));
  }

  @Transactional
  public MilestoneView create(MilestoneQuery query) {
    Milestone savedMilestone = milestoneRepository.save(Milestone.from(query));
    return MilestoneView.from(savedMilestone, extractIssues(savedMilestone));
  }

  @Transactional
  public void delete(Long milestoneId) {
    Milestone findMilestone = milestoneRepository.findById(milestoneId)
        .orElseThrow(() -> new NoSuchElementException(ErrorMessage.NOT_EXIST_MILESTONE));
    issueMilestoneRelationRepository.deleteAllByMilestoneId(findMilestone.getId());
    milestoneRepository.delete(findMilestone);
  }

  @Transactional
  public MilestoneView put(Long milestoneId, MilestoneQuery query) {
    Milestone findMilestone = milestoneRepository.findById(milestoneId)
        .orElseThrow(() -> new NoSuchElementException(ErrorMessage.NOT_EXIST_MILESTONE));
    Milestone updatedMilestone = milestoneRepository
        .save(Milestone.from(findMilestone.getId(), query));
    return MilestoneView.from(updatedMilestone, extractIssues(updatedMilestone));
  }
}
