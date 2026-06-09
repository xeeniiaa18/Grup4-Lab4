<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="header-container" style="display:flex;align-items:center;justify-content:space-between;padding:12px 24px;background-color:#FFF6ED;border-bottom:1px solid #CE9C6A;box-shadow:0 2px 8px rgba(70,51,31,0.05);">

    <!-- Logo -->
    <a href="Content" class="menu" style="text-decoration:none;display:flex;flex-direction:column;align-items:flex-start;">
        <span style="font-family:'Pacifico',cursive;font-size:26px;color:#E46B39;line-height:1.1;">Forkful</span>
        <span style="font-size:9px;font-weight:700;color:#CE9C6A;letter-spacing:0.5px;text-transform:uppercase;margin-top:-2px;">Share the flavor</span>
    </a>

    <!-- Search Bar -->
    <div style="flex:0 1 400px;margin:0 20px;position:relative;">
        <i class="fa fa-search" style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#CE9C6A;font-size:14px;"></i>
        <input type="text" placeholder="Search recipes, reviews, users..."
               style="width:100%;padding:10px 14px 10px 38px;border:1.5px solid #CE9C6A;border-radius:20px;background-color:#ffffff;font-size:13px;color:#46331F;outline:none;transition:all 0.2s;"
               onfocus="this.style.borderColor='#E46B39';this.style.boxShadow='0 0 0 3px rgba(228,107,57,0.15)';"
               onblur="this.style.borderColor='#CE9C6A';this.style.boxShadow='none';" />
    </div>

    <!-- Actions -->
    <div style="display:flex;align-items:center;gap:12px;">
        <c:choose>
            <c:when test="${not empty user}">
                <a href="Logout" id="btnLogout"
                   style="text-decoration:none;display:flex;align-items:center;gap:6px;padding:8px 16px;border:1.5px solid #E46B39;border-radius:12px;color:#E46B39;font-weight:700;font-size:13px;background-color:transparent;transition:all 0.2s;cursor:pointer;"
                   onmouseover="this.style.backgroundColor='#FFF6ED';" onmouseout="this.style.backgroundColor='transparent';">
                    <i class="fa fa-sign-out"></i> Logout
                </a>
            </c:when>
            <c:otherwise>
                <a class="menu" href="Login"
                   style="text-decoration:none;display:flex;align-items:center;gap:6px;padding:8px 16px;font-weight:700;font-size:13px;color:#46331F;transition:all 0.2s;">
                    <i class="fa fa-sign-in"></i> Log In
                </a>
                <a class="menu" href="Register"
                   style="text-decoration:none;display:flex;align-items:center;gap:6px;padding:8px 16px;border-radius:12px;background-color:#E46B39;color:white;font-weight:700;font-size:13px;box-shadow:0 4px 10px rgba(228,107,57,0.2);transition:all 0.2s;">
                    <i class="fa fa-user-plus"></i> Register
                </a>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<script>
$('#btnLogout').off('click').on('click', function(e) {
    e.preventDefault();
    $.post('Logout', function() {
        App.reloadChrome();
        $('#content').load('Content');
    });
});
</script>
