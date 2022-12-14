package com.study.mapper.board;

import com.study.domain.board.BoardDto;

import java.util.List;

public interface BoardMapper {
    int insert(BoardDto board);

    List<BoardDto> list();

    default BoardDto select(int id) {
        return select(id, null);
    }

    BoardDto select(int id, String username);

    int update(BoardDto board);

    int delete(int id);

    List<BoardDto> list(int offset, int records, String type, String keyword);

    int countAll(String type, String keyword);

    int insertFile(int id, String fileName);

    int deleteFileByBoardId(int id);

    int deleteFileByBoardIdAndFileName(int id, String fileName);

    int getLikeByBoardIdAndMemberId(String boardId, String memberId);

    int deleteLike(String boardId, String memberId);

    int insertLike(String boardId, String memberId);

    int countLikeByBoardId(String boardId);

    int deleteLikeByBoardId(int id);

    int deleteLikeByMemberId(String id);

    List<BoardDto> listByMemberId(String id);

}
