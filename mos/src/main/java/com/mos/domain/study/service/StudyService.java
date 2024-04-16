package com.mos.domain.study.service;

import java.util.List;
import com.mos.domain.study.dto.StudyDto;
import com.mos.domain.study.dto.TagDto;

public interface StudyService {

  List<StudyDto> list();

  void add(StudyDto studyDto);

  StudyDto getByStudyNo(int studyNo);

  void deleteStudy(int studyNo);

  int update(StudyDto studyDto);

  List<TagDto> getAllTags();
}