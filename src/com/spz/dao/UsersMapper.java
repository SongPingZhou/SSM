package com.spz.dao;

import java.util.List;

import com.spz.entity.Modules;
import com.spz.entity.Users;

public interface UsersMapper {
	
	/**
	 * 多条件分页查询
	 * @param users
	 * @return
	 */
	List<Users> selectUsersByUsers(Users users);
	
	/**
	 *  多条件分页查询总条数
	 * @param users
	 * @return
	 */
	Integer selectUsersByUsersCount(Users users);
	
	/**
	 * 添加员工
	 * @param users
	 * @return
	 */
	Integer insertUsers(Users users);
	
	/**
	 * 修改员工
	 * @param users
	 * @return
	 */
	Integer updateUsers(Users users);	
	
	/**
	 * 删除员工
	 * @param u_id
	 * @return
	 */
	Integer deleteUsers(Integer u_id);
	
	
	/**
	 * 登陆时查询使用
	 * @param users
	 * @return
	 */
	Users selectUserBylogin(Users users);
	
	
	/**
	 * 查询登录用户的模块 
	 * @param u_id
	 * @return
	 */
	List<Modules> selectUserModuls(Integer u_id);
	
	/**
	 * 查id下所有的子模块
	 * @return
	 */
	List<Modules> selectModulsByid(Integer m_id,Integer u_id);
	
	/**
	 *  查询已打卡咨询师成交的学生总个数，和已录入的未成交的个数，以及成功率
	 * @return Users对象里面维护了count打卡咨询师的全部学生个数，counts打卡咨询师的还未成交的学生个数，counts/count=bfb 咨询师的成功率
	 */
	List<Users> selectUsersByFenLiang(Users users);
	
	/**
	 * 通过id去查看该咨询师是否被开启自动分配
	 * @param u_id
	 * @return
	 */
	Users selectUsersByKaiQi(Integer u_id);
	
	/**
	 * 查看网络咨询师的分量情况
	 * @return
	 */
	List<Users> selectUsersByflcz(Users users);
	
	/**
	 * 查看网络咨询师的分量情况条数
	 * @return
	 */
	Integer selectUsersByflczCount(Users users);
	
	/**
	 * 修改用户表中为网络咨询师的用户的状态作为是否自动分量
	 * @param u_state
	 * @return
	 */
	Integer updateUsersByu_state(Integer u_state);
	
	/**
	 * 对别的员工添加经理的角色的时候做判断经理是否被人引用
	 * @return
	 */
	Users selectUsersJingLi();
	
	/**
	 * 查询最新添加的员工
	 * @return
	 */
	Users selecuMaxUserId();
	
	//孙所蕾
	/**
	 * 查询所有员工
	 * @return
	 */
	List<Users> selectUsers();
}
