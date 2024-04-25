package com.mos.domain.wiki.service.impl;

import com.mos.domain.wiki.dto.JstreeWikiDto;
import com.mos.domain.wiki.dto.WikiDto;
import com.mos.domain.wiki.repository.WikiRepository;
import com.mos.domain.wiki.service.WikiService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DefaultWikiService implements WikiService {

  private final WikiRepository wikiRepository;

  //개별 스터디에 따라 위키들을 정렬하는 메서드임!
  @Override
  public List<WikiDto> listByStudyNo(int studyNo) {
    return wikiRepository.listByStudyNo(studyNo);
  }

  @Override
  public List<WikiDto> listByWikiNo() {
    return wikiRepository.listByWikiNo();
  }

  @Override
  public WikiDto getByWikiNo(int wikiNo) {
    return wikiRepository.getByWikiNo(wikiNo);
  }

  @Override
  public int updateWiki(WikiDto wikiDto) {
    return wikiRepository.updateWiki(wikiDto);
  }

  @Override
  public void deleteWiki(int wikiNo) {
    wikiRepository.deleteWiki(wikiNo);
  }

  @Override
  public void add(WikiDto wikiDto) {
    wikiRepository.add(wikiDto);
  }

  @Override
  public int getFirstWikiNo(int studyNo) {
    return wikiRepository.getFirstWiki(studyNo);
  }

  @Override
  public List<JstreeWikiDto> getWikiTitleTree(int studyNo) {
    return wikiRepository.findByStudyNo(studyNo);
  }
}
