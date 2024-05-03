package com.mos.domain.study.service.impl;

import com.mos.domain.member.dto.MemberStudyDto;
import java.util.List;
import com.mos.domain.study.dto.TagDto;
import com.mos.domain.study.repository.TagRepository;
import java.util.stream.Collectors;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.mos.domain.study.dto.StudyDto;
import com.mos.domain.study.repository.StudyRepository;
import com.mos.domain.study.service.StudyService;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DefaultStudyService implements StudyService {

  private final StudyRepository studyRepository;
  private final TagRepository tagRepository;

  @Transactional
  @Override
  public void add(StudyDto studyDto) {
    studyRepository.add(studyDto);
    for (TagDto tagDto : studyDto.getTagList()) {
      tagDto.setStudyNo(studyDto.getStudyNo());
    }
    tagRepository.addAll(studyDto.getTagList());
  }

  @Override
  public StudyDto getByStudyNo(int studyNo) {
    return studyRepository.getByStudyNo(studyNo);
  }

  @Override
  public void deleteStudy(int studyNo) {
    studyRepository.delete(studyNo);
  }

  @Override
  public int update(StudyDto studyDto) {
    return studyRepository.update(studyDto);
  }

  // 조회수 카운트
  @Transactional
  @Override
  public StudyDto updateHitCount(int studyNo) {
    studyRepository.updateHitCount(studyNo);
    return studyRepository.getByStudyNo(studyNo);
  }

  @Override
  public Page<StudyDto> list(Pageable pageable) {
    List<StudyDto> studyList = studyRepository.findAll(pageable);
    long totalCount = studyRepository.countAll(); // 전체 데이터 개수 구하기
    return new PageImpl<>(studyList, pageable, totalCount);
  }



  @Override
  public List<TagDto> getAllTags() {
    return tagRepository.findAll();
  }

  @Transactional
  @Override
  public boolean applyStudy(MemberStudyDto memberStudyDto) {
      studyRepository.applyStudy(memberStudyDto);
      return true;
  }

  @Override
  public List<StudyDto> listAll() {
    return studyRepository.listAll();
  }

  @Override
  public List<StudyDto> searchByTypeAndKeyword(String type, String keyword) {

    List<StudyDto> searchResult;
    if ("title".equals(type)) {
      searchResult = studyRepository.searchByTitle(keyword);
    } else if ("introduction".equals(type)) {
      searchResult = studyRepository.searchByIntroduction(keyword);
    } else if ("tag".equals(type)) {
      searchResult = studyRepository.searchByTag(keyword);
    } else {
      throw new IllegalArgumentException("유효하지 않은 검색 유형입니다.");
    }
    return searchResult;
  }

  @Override
  public void updateLikeCount(int studyNo, int likeCount) {
    studyRepository.updateLikeCount(studyNo, likeCount);
  }
}
