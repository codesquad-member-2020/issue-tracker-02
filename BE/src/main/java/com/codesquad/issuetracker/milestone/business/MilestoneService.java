package com.codesquad.issuetracker.milestone.business;

import com.codesquad.issuetracker.exception.ErrorMessage;
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

  private final MilestoneRepository mileStoneRepository;
  private final IssueMilestoneRelationRepository issueMilestoneRelationRepository;

  public List<MilestoneView> getMileStones() {
    List<Milestone> milestones = mileStoneRepository.findAll();
    return milestones.stream()
        .map(MilestoneView::from)
        .collect(Collectors.toList());
  }

  public MilestoneView getMileStone(Long labelId) {
    Milestone findMilestone = mileStoneRepository.findById(labelId)
        .orElseThrow(() -> new NoSuchElementException(ErrorMessage.NOT_EXIST_MILESTONE));
    return MilestoneView.from(findMilestone);
  }

  @Transactional
  public MilestoneView create(MilestoneQuery query) {
    Milestone savedMilestone = mileStoneRepository.save(Milestone.from(query));
    return MilestoneView.from(savedMilestone);
  }

  @Transactional
  public void delete(Long milestoneId) {
    Milestone findMilestone = mileStoneRepository.findById(milestoneId)
        .orElseThrow(() -> new NoSuchElementException(ErrorMessage.NOT_EXIST_MILESTONE));
    issueMilestoneRelationRepository.deleteAllByMilestoneId(findMilestone.getId());
    mileStoneRepository.delete(findMilestone);
  }
}
