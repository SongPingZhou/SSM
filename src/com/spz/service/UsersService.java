package com.spz.service;

import java.util.List;

import com.spz.entity.Users;

public interface UsersService {
	/**
	 * 多条件分页查询
	 * @param users
	 * @return
	 */
	String selectUsersByUsers(Users users);
	
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
	 * 登陆时使用查询员工
	 * @param users
	 * @return
	 */
	Users selectUserBylogin(Users users);
}
