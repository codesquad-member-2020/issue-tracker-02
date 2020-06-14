package com.codesquad.issuetracker;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

import com.codesquad.issuetracker.milestone.business.MileStoneService;
import com.codesquad.issuetracker.milestone.data.Milestone;
import com.codesquad.issuetracker.milestone.data.MileStoneRepository;
import com.codesquad.issuetracker.milestone.web.model.MileStoneQuery;
import com.codesquad.issuetracker.milestone.web.model.MileStoneView;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import javax.transaction.Transactional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@DisplayName("MileStone")
public class MilestoneTest {

  private MileStoneQuery sampleMileStoneQuery;

  @Nested
  @DisplayName("POJO")
  public class PojoTest {

    @BeforeEach
    private void beforeEach() {
      sampleMileStoneQuery = MileStoneQuery
          .of("1차 목표", "1차 목표 상세 설명\n스켈레톤 코드 구성", LocalDate.now().plusDays(7), new ArrayList<>());
    }

    @DisplayName("MileStoneQuery 로 MileStone 을 만듭니다")
    @Test
    public void makeMileStoneByMileStoneQuery() {
      // given

      // when
      Milestone mileStone = Milestone.from(sampleMileStoneQuery);

      // then
      assertThat(mileStone.getId()).isNull();
      assertThat(mileStone.getTitle()).isEqualTo(sampleMileStoneQuery.getTitle());
      assertThat(mileStone.getDescription()).isEqualTo(sampleMileStoneQuery.getDescription());
      assertThat(mileStone.getDueDate()).isEqualTo(sampleMileStoneQuery.getDueDate());
      assertThat(mileStone.getIssues()).hasSize(0);
    }
  }

  @Nested
  @DisplayName("Integration")
  @Transactional
  @SpringBootTest
  public class IntegrationTest {

    @Autowired
    private MileStoneService mileStoneService;

    @Autowired
    private MileStoneRepository mileStoneRepository;

    @BeforeEach
    private void beforeEach() {
      sampleMileStoneQuery = MileStoneQuery
          .of("1차 목표", "1차 목표 상세 설명\n스켈레톤 코드 구성", LocalDate.now().plusDays(7), new ArrayList<>());
    }

    @DisplayName("MileStone 을 추가합니다")
    @Transactional
    @Test
    public void create() {
      // given

      // when
      Milestone savedMilestone = mileStoneService.create(sampleMileStoneQuery);

      // then
      Optional<Milestone> findOptionalMileStone = mileStoneRepository
          .findById(savedMilestone.getId());
      assertThat(findOptionalMileStone.orElseThrow(NoSuchElementException::new).getId())
          .isEqualTo(savedMilestone.getId());
    }

    @DisplayName("MileStone 을 삭제합니다")
    @Transactional
    @Test
    public void delete() {
      // given
      Milestone savedMilestone = mileStoneService.create(sampleMileStoneQuery);
      Optional<Milestone> findOptionalMileStone = mileStoneRepository
          .findById(savedMilestone.getId());
      assertThat(findOptionalMileStone.orElseThrow(NoSuchElementException::new).getId())
          .isEqualTo(savedMilestone.getId());

      // when
      mileStoneService.delete(savedMilestone.getId());

      // then
      Optional<Milestone> deletedOptionalMileStone = mileStoneRepository
          .findById(savedMilestone.getId());
      assertThatExceptionOfType(NoSuchElementException.class).isThrownBy(() -> {
        deletedOptionalMileStone.orElseThrow(NoSuchElementException::new);
      });
    }

    @Nested
    @DisplayName("MileStone 을 가져옵니다")
    @Transactional
    @SpringBootTest
    public class GetTest {

      @DisplayName("모든")
      @Test
      public void getMileStones() {
        // given

        // when
        List<MileStoneView> findMileStoneViews = mileStoneService.getMileStones();

        // then
        assertThat(findMileStoneViews.size()).isEqualTo(3); // MileStone 의 초기 값은 3개 입니다
      }

      @DisplayName("특정")
      @Test
      public void getMileStone() {
        // given

        // when
        Milestone findMilestone = mileStoneService.getMileStone(1L);

        // then
        assertThat(findMilestone).isNotNull();
      }
    }
  }
}
