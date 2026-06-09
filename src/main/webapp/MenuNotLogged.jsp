<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="sidebar-menu" style="display:flex;flex-direction:column;justify-content:space-between;height:calc(100vh - 100px);padding:10px 0;">

    <div style="display:flex;flex-direction:column;gap:4px;">
        <a class="menu sidebar-item active" href="Content"
           style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:white;font-weight:700;background-color:#E46B39;transition:all 0.2s;">
            <i class="fa fa-home" style="font-size:17px;width:20px;text-align:center;"></i>
            <span class="sidebar-text">Home</span>
        </a>

        <a class="menu sidebar-item" href="Posts"
           style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
           onmouseover="this.style.backgroundColor='#FFF6ED';" onmouseout="this.style.backgroundColor='transparent';">
            <i class="fa fa-compass" style="font-size:17px;width:20px;text-align:center;"></i>
            <span class="sidebar-text">Explore</span>
        </a>

        <a class="menu sidebar-item" href="Login"
           style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
           onmouseover="this.style.backgroundColor='#FFF6ED';" onmouseout="this.style.backgroundColor='transparent';">
            <i class="fa fa-sign-in" style="font-size:17px;width:20px;text-align:center;"></i>
            <span class="sidebar-text">Log In</span>
        </a>

        <a class="menu sidebar-item" href="Register"
           style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
           onmouseover="this.style.backgroundColor='#FFF6ED';" onmouseout="this.style.backgroundColor='transparent';">
            <i class="fa fa-user-plus" style="font-size:17px;width:20px;text-align:center;"></i>
            <span class="sidebar-text">Register</span>
        </a>
    </div>

    <!-- Guest Badge -->
    <div style="display:flex;align-items:center;gap:10px;padding:10px;border-radius:14px;background-color:#FFF6ED;">
        <div style="width:40px;height:40px;border-radius:50%;background:#CE9C6A;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
            <i class="fa fa-user-o" style="color:white;font-size:16px;"></i>
        </div>
        <div style="display:flex;flex-direction:column;">
            <span style="font-weight:700;color:#46331F;font-size:13px;">Guest User</span>
            <span style="color:#CE9C6A;font-size:11px;">Browsing mode</span>
        </div>
    </div>

</div>

<script>
$(document).ready(function() {
    $('.sidebar-item').click(function() {
        $('.sidebar-item').removeClass('active').css({'background-color': 'transparent', 'color': '#46331F'});
        $(this).addClass('active').css({'background-color': '#E46B39', 'color': 'white'});
    });
});
</script>
