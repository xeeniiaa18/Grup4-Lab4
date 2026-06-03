<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="w3-white w3-round w3-card w3-section" style="overflow:hidden; max-width: 500px; margin: 0 auto;">
    <div style="height:5px; background:linear-gradient(90deg, #E46B39, #F4A83F, #CE9C6A);"></div>
    
    <div style="padding:28px 24px;">
        <h2 style="margin:0 0 8px; color:#46331F; font-family:'Pacifico', cursive; text-align: center;">Join Forkful</h2>
        <p style="color:#CE9C6A; font-size:14px; text-align: center; margin-bottom: 24px;">Share your passion for cooking and reviews</p>

        <form id="registerForm" action="Register" method="POST" enctype="multipart/form-data">
            
            <div style="margin-bottom: 14px;">
                <label for="name" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Username</label>
                <input class="w3-input w3-border w3-round" type="text" id="name" name="name" required minlength="5" maxlength="20"
                    value="${user.name}" placeholder="e.g. chef_emily" style="font-size: 13px;" />
            </div>

            <div style="display: flex; gap: 10px; margin-bottom: 14px;">
                <div style="flex: 1;">
                    <label for="firstName" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">First Name</label>
                    <input class="w3-input w3-border w3-round" type="text" id="firstName" name="firstName" required
                        value="${user.firstName}" placeholder="Emily" style="font-size: 13px;" />
                </div>
                <div style="flex: 1;">
                    <label for="lastName" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Last Name</label>
                    <input class="w3-input w3-border w3-round" type="text" id="lastName" name="lastName" required
                        value="${user.lastName}" placeholder="Smith" style="font-size: 13px;" />
                </div>
            </div>

            <div style="margin-bottom: 14px;">
                <label for="email" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Email</label>
                <input class="w3-input w3-border w3-round" type="email" id="email" name="email" required
                    value="${user.email}" placeholder="emily@example.com" style="font-size: 13px;" />
            </div>

            <div style="margin-bottom: 14px;">
                <label for="dateOfBirth" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Date of Birth</label>
                <input class="w3-input w3-border w3-round" type="date" id="dateOfBirth" name="dateOfBirth" required
                    value="${user.dateOfBirth}" style="font-size: 13px;" />
            </div>

            <div style="margin-bottom: 14px;">
                <label for="password" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Password</label>
                <input class="w3-input w3-border w3-round" type="password" id="password" name="password" required
                    pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$" value="${user.password}"
                    placeholder="••••••••" style="font-size: 13px;"
                    title="Minimum 8 characters, including uppercase, numbers, and a special character (@#$%^&*)." />
            </div>

            <div style="margin-bottom: 14px;">
                <label for="confirmPassword" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Repeat password</label>
                <input class="w3-input w3-border w3-round" type="password" id="confirmPassword"
                    name="confirmPassword" required value="${user.password}"
                    placeholder="••••••••" style="font-size: 13px;"
                    title="Passwords must match" />
            </div>

            <div style="margin-bottom: 20px;">
                <label for="picture" style="font-size: 13px; font-weight: 600; color: #46331F; display: block; margin-bottom: 4px;">Profile Picture</label>
                <input class="w3-input w3-border w3-round" type="file" id="picture" name="picture" accept="image/*" style="font-size: 13px;" />
            </div>

            <button type="submit" style="background: linear-gradient(135deg, #E46B39, #d05325); color: white; border: none; border-radius: 10px; padding: 12px; font-size: 14px; font-weight: 600; cursor: pointer; width: 100%; box-shadow: 0 4px 12px rgba(228,107,57,0.3);">
                Create Account
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
	App.initRegisterValidation(App.Errors);
</script>
