package kr.co.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.UsersVO;

@Repository
public class UsersDAOImpl implements UsersDAO{

	@Inject SqlSession sql;
	
	@Override
	public void register(UsersVO vo) throws Exception {
		sql.insert("userMapper.register", vo);
	}

	@Override
	public UsersVO login(UsersVO vo) throws Exception {
		return sql.selectOne("userMapper.login", vo);
	}

	@Override
	public void userUpdate(UsersVO vo) throws Exception {
		sql.update("userMapper.userUpdate", vo);
	}

	@Override
	public void userDelete(UsersVO vo) throws Exception {
		sql.delete("userMapper.userDelete", vo);
	}

	@Override
	public int passChk(UsersVO vo) throws Exception {
		int result = sql.selectOne("userMapper.passChk", vo);
		return result;
	}

	@Override
	public int idChk(UsersVO vo) throws Exception {
		int result = sql.selectOne("userMapper.idChk", vo);
		return result;
	}
	
	
	
	
	
	
}
