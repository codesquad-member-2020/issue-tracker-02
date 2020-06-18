package com.codesquad.issuetracker.label.business;

import com.codesquad.issuetracker.exception.ErrorMessage;
import com.codesquad.issuetracker.issue.data.relation.IssueLabelRelationRepository;
import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.label.data.LabelRepository;
import com.codesquad.issuetracker.label.web.model.LabelQuery;
import com.codesquad.issuetracker.label.web.model.LabelView;
import java.util.List;
import java.util.NoSuchElementException;
import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class LabelService {

  private final LabelRepository labelRepository;
  private final IssueLabelRelationRepository issueLabelRelationRepository;

  public List<LabelView> getLabels() {
    List<Label> findLabels = labelRepository.findAll();
    return LabelView.toList(findLabels);
  }

  public LabelView getLabel(Long labelId) {
    Label findLabel = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
    return LabelView.from(findLabel);
  }

  @Transactional
  public LabelView create(LabelQuery query) {
    Label savedLabel = labelRepository.save(Label.from(query));
    return LabelView.from(savedLabel);
  }

  @Transactional
  public void delete(Long labelId) {
    Label findLabel = labelRepository.findById(labelId)
        .orElseThrow(() -> new NoSuchElementException(ErrorMessage.NOT_EXIST_LABEL));
    issueLabelRelationRepository.deleteAllByLabelId(findLabel.getId());
    labelRepository.delete(findLabel);
  }

  @Transactional
  public LabelView put(Long labelId, LabelQuery query) {
    Label label = labelRepository.findById(labelId)
        .orElseThrow(() -> new EntityNotFoundException(ErrorMessage.NOT_EXIST_LABEL));
    label.update(query);

    return LabelView.from(label);
  }
}
