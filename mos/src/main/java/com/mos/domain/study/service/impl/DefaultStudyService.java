package com.mos.domain.study.service.impl;

import com.mos.domain.member.dto.MemberStudyDto;
import java.util.List;
import com.mos.domain.study.dto.TagDto;
import com.mos.domain.study.repository.TagRepository;
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

  @Override
  public List<StudyDto> list() {
    return studyRepository.findAll();
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
  public List<StudyDto> searchByTypeAndKeyword(String type, String keyword) {
    if ("title".equals(type)) {
      return studyRepository.searchByTitle(keyword);
    } else if ("introduction".equals(type)) {
      return studyRepository.searchByIntroduction(keyword);
    } else if ("tag".equals(type)) {
      return studyRepository.searchByTag(keyword);
    } else {
      throw new IllegalArgumentException("유효하지 않은 검색 유형입니다.");
    }
  }

}
