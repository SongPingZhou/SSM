package com.spz.controller;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Users;
import com.spz.service.UsersService;
import com.spz.util.Result;

@Controller
public class LoginController {
	
	@Autowired UsersService usersService;
	
	@RequestMapping(value="login",method=RequestMethod.POST)
	@ResponseBody
	public String login(Users users,HttpServletRequest request,HttpSession session,Integer yzm,HttpServletResponse resp) {
		Users users2 = usersService.selectUserBylogin(users);
		String k = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		/*System.out.println(k+"����֤��");
		System.out.println(yzm+"ǰ��֤��");*/
		if(yzm==null) {
			//ǰ��������֤��������
			if(users2 != null) {
				request.getSession().setAttribute("u_id", users2.getU_id());
				//���û�����ӵ�cookie
				insertCookie(resp,users2.getU_name(),users2.getU_pwd());
			}
		}else {
			//�ж���֤���Ƿ���ȷ����ȷ������֤�������ȷ���ѯ
			/*Object a=Integer.parseInt(k)!=yzm ? Result.toClient(false, "��֤�����") : (users2 == null ? null : request.getSession().setAttribute("u_id", users2.getU_id()));*/
			if(Integer.parseInt(k)==yzm) {
				//��֤����ȷ��ѯ
				if(users2 != null) {
					request.getSession().setAttribute("u_id", users2.getU_id());
					//���û�����ӵ�cookie
					insertCookie(resp,users2.getU_name(),users2.getU_pwd());
				}
			}else {
				//��֤���ȥ����
				return Result.toClient(false, "��֤�����");
			}
		}
		//����õ��ĵ�¼�û��Ƿ�����״̬==1�������ʾ
		//String count=users2.getU_isLockout()==1 ? "�û������� ������ϵ����Ա�������½ " : "�������";
		if(users2 !=null) {
			if(users2.getU_isLockout()==1) {
				return Result.toClient(false, "�û��ѱ�����");
			}
		}else {
			return Result.toClient(false, "�û�������");
		}
		return Result.toClient(users2 !=null ? true : false, users2 !=null ? users2 : "�������");
	}
	@RequestMapping(value="locking",method=RequestMethod.POST)
	@ResponseBody
	public Integer locking(Users users) {
		//��¼ʧ�ܶ�������û�
		return usersService.updateUsers(users);
	}
	public void insertCookie(HttpServletResponse resp,String val1,String val2) {
		Cookie name=new Cookie("u_name", val1);
		//���ù���ʱ�䣨����Ϊ��λ��
		name.setMaxAge(60*60);
		//������ӵ���·����
		name.setPath("/");
		//���Cookie
		resp.addCookie(name);
		
		Cookie pwds=new Cookie("u_pwd", val2);
		//���ù���ʱ�䣨����Ϊ��λ��
		pwds.setMaxAge(60*60);
		//������ӵ���·����
		pwds.setPath("/");
		//���Cookie
		resp.addCookie(pwds);
	}
	
}
