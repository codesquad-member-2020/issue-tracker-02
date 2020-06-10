package com.codesquad.issuetracker.label.business;

import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.label.data.LabelRepository;
import com.codesquad.issuetracker.label.web.model.LabelQuery;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import javax.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class LabelService {

  private final LabelRepository labelRepository;

  public List<String> getLabels() {
    return labelRepository.findAll().stream().map(Label::getTitle).collect(Collectors.toList());
  }

  public Label getLabel(Long labelId) {
    return labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
  }

  @Transactional
  public Label create(LabelQuery query) {
    return labelRepository.save(Label.of(query));
  }

  @Transactional
  public void delete(Long labelId) {
    Label findLabel = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
    labelRepository.delete(findLabel);
  }
}
