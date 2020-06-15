package com.codesquad.issuetracker.milestone.business;

import com.codesquad.issuetracker.exception.ErrorMessage;
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

  public List<MilestoneView> getMileStones() {
    return mileStoneRepository.findAll().stream()
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
  public void delete(Long labelId) {
    Milestone findMilestone = mileStoneRepository.findById(labelId)
        .orElseThrow(() -> new NoSuchElementException(ErrorMessage.NOT_EXIST_MILESTONE));

    Milestone deletedMilestone = Milestone.extractMainInform(findMilestone);
    mileStoneRepository.save(deletedMilestone);
    mileStoneRepository.delete(deletedMilestone);
    System.out.println();
  }
}
