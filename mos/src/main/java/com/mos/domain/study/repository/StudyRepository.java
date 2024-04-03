package com.mos.domain.study.repository;

import com.mos.domain.study.dto.StudyDto;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StudyRepository {
  List<StudyDto> findAll();

}