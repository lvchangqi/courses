package com.qingtao.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.qingtao.pojo.User;
import com.qingtao.serviceI.UserServiceI;

public class MyRealm extends AuthorizingRealm{
	
	@Autowired
	private UserServiceI userService;

	/**
	 * 权限授予
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String username = principals.getPrimaryPrincipal().toString();
		User user = userService.selectOneUser(new User(username,null));
		SimpleAuthorizationInfo sai = new SimpleAuthorizationInfo();
		sai.addRole(user.getRole());
		return sai;
	}

	/**
	 * 验证用户
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String username = token.getPrincipal().toString();
		User user = userService.selectOneUser(new User(username,null));
		if(user!=null){
			AuthenticationInfo ai = new SimpleAuthenticationInfo(user.getUsername(),user.getPassword(),"andios");
			return ai;
		}else{
			return null;
		}
	}

}
