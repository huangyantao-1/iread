package com.iread.font.service;

import java.util.List;

import java.util.Map;

import com.iread.beans.domain.AIIAboutMe;
import com.iread.beans.domain.MyBookDo;
import com.iread.beans.domain.Order;
import com.iread.beans.domain.UserInfomations;

/**
 *项目名称: iread
 *类名称: UserService
 *类描述: 用户的操作功能
 * @author 方秋都
 *
 */
public interface UserService {

	public Map<String, Object> getMyBooks(int userId,int page);//获取书架信息
	public Map<String, Object> getMyCarts(int userId,int page);//获取购物车信息
	public boolean addBookToMyCart(int bookId,int userId);//添加图书到购物车
	public void moveBookFromMyCart(int uid,int bid);//id购物车cart表主键
	public List<Order> getMyOrders(int userId);//获取订单信息
	public Map<String, Object> getnews(int userId);//获取系统消息
	public AIIAboutMe getMyInfos(int userId);//获取个人信息
	public void setMyInfos(UserInfomations info);//设置个人信息
	public void changeMyInfos(UserInfomations info);//更改个人信息
	public boolean changePass(int userId, String newPass);//更改密码
	public void addMyBook(MyBookDo book);//添加图书到书架
	public void deleteMyBook(int id); //删除书架上的图书（mybooks 主键）
	public int getMybookId(int uId,int bId);//根据用户ID和图书ID找书架对应的主键
	public void buyBook(int bid,int uid);//购买
}