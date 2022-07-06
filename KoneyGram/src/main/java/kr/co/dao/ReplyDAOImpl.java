package kr.co.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	
	@Inject SqlSession sql;
	
	// 댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return sql.selectList("replyMapper.readReply", bno);
	}
	
	// 댓글 작성
	@Override
	public void writeReply(ReplyVO vo) throws Exception {
		sql.insert("replyMapper.writeReply", vo);
	}
	
	// 댓글 수정
	@Override
	public void updateReply(ReplyVO vo) throws Exception {
		sql.update("replyMapper.updateReply", vo);
	}
	
	// 댓글 삭제
	@Override
	public void deleteReply(ReplyVO vo) throws Exception {
		sql.delete("replyMapper.deleteReply", vo);
	}
	
	// 선택된 댓글 조회
	@Override
	public ReplyVO selectReply(int rno) throws Exception {
		return sql.selectOne("replyMapper.selectReply", rno);
	}

}
