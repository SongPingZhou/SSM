package com.spz.dao;

import java.util.List;


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
	
	
	
}
