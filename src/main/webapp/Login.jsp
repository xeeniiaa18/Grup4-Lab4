<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="w3-white w3-round w3-card w3-section" style="overflow:hidden; max-width: 400px; margin: 0 auto;">
    <div style="height:5px; background:linear-gradient(90deg, #E46B39, #F4A83F, #CE9C6A);"></div>
    
    <div style="padding:28px 24px;">
        <h2 style="margin:0 0 8px; color:#46331F; font-family:'Pacifico', cursive; text-align: center;">Welcome back!</h2>
        <p style="color:#CE9C6A; font-size:14px; text-align: center; margin-bottom: 24px;">Log in to Forkful to share and browse</p>

        <form id="loginForm" action="Login" method="POST">
            <div style="margin-bottom: 14px;">
                <label for="name" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Username</label>
                <input type="text" class="w3-input w3-border w3-round" 
                    id="name" name="name" required minlength="5" maxlength="20" value="${user.name}"
                    placeholder="e.g. chef_emily" style="font-size: 13px;"
                    title="Username must be between 5 and 20 characters." />
            </div>
            <div style="margin-bottom: 20px;">
                <label for="password" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Password</label>
                <input type="password" class="w3-input w3-border w3-round" 
                    id="password" name="password" required
                    pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$"
                    value="${user.password}"
                    placeholder="••••••••" style="font-size: 13px;"
                    title="Minimum 8 characters, including uppercase, numbers, and a special character (@#$%^&*)." />
            </div>

            <button type="submit" style="background: linear-gradient(135deg, #E46B39, #d05325); color: white; border: none; border-radius: 10px; padding: 12px; font-size: 14px; font-weight: 600; cursor: pointer; width: 100%; box-shadow: 0 4px 12px rgba(228,107,57,0.3);">
                Log In
            </button>
        </form>
    </div>
</div>

<script>
	App.Errors = {
	  <c:forEach var="error" items="${errors}">
	    "${error.key}": "${error.value}",
	  </c:forEach>
	};
	App.initLoginValidation(App.Errors);	
</script>