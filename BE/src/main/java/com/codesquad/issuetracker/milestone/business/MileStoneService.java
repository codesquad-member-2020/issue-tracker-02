package com.codesquad.issuetracker.milestone.business;

import com.codesquad.issuetracker.milestone.data.MileStone;
import com.codesquad.issuetracker.milestone.data.MileStoneRepository;
import com.codesquad.issuetracker.milestone.web.model.MileStoneQuery;
import com.codesquad.issuetracker.milestone.web.model.MileStoneView;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import javax.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MileStoneService {

  private final MileStoneRepository mileStoneRepository;

  public List<MileStoneView> getMileStones() {
    return mileStoneRepository.findAll().stream()
        .map(MileStoneView::from)
        .collect(Collectors.toList());
  }

  public MileStone getMileStone(Long labelId) {
    return mileStoneRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
  }

  @Transactional
  public MileStone create(MileStoneQuery query) {
    return mileStoneRepository.save(MileStone.from(query));
  }

  @Transactional
  public void delete(Long labelId) {
    MileStone findMileStone = mileStoneRepository.findById(labelId)
        .orElseThrow(NoSuchElementException::new);
    mileStoneRepository.delete(findMileStone);
  }
}
