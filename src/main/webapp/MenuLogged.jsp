<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="sidebar-menu"
            style="display: flex; flex-direction: column; justify-content: space-between; height: calc(100vh - 100px); padding: 10px 0;">

            <div style="display: flex; flex-direction: column; gap: 4px;">
                <a class="menu sidebar-item active" href="Content"
                    style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:white;font-weight:700;background-color:#E46B39;transition:all 0.2s;">
                    <i class="fa fa-home" style="font-size:17px;width:20px;text-align:center;"></i>
                    <span class="sidebar-text">Home</span>
                </a>

                <a class="menu sidebar-item" href="Posts"
                    style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
                    onmouseover="this.style.backgroundColor='#FFF6ED';"
                    onmouseout="this.style.backgroundColor='transparent';">
                    <i class="fa fa-compass" style="font-size:17px;width:20px;text-align:center;"></i>
                    <span class="sidebar-text">Explore</span>
                </a>

                <a class="menu sidebar-item" href="Notifications"
                    style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
                    onmouseover="this.style.backgroundColor='#FFF6ED';"
                    onmouseout="this.style.backgroundColor='transparent';">
                    <i class="fa fa-bell" style="font-size:17px;width:20px;text-align:center;"></i>
                    <span class="sidebar-text">Notifications</span>
                </a>

                <a class="menu sidebar-item" href="Followed"
                    style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
                    onmouseover="this.style.backgroundColor='#FFF6ED';"
                    onmouseout="this.style.backgroundColor='transparent';">
                    <i class="fa fa-users" style="font-size:17px;width:20px;text-align:center;"></i>
                    <span class="sidebar-text">Following</span>
                </a>

                <a class="menu sidebar-item" href="Followers"
                    style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
                    onmouseover="this.style.backgroundColor='#FFF6ED';"
                    onmouseout="this.style.backgroundColor='transparent';">
                    <i class="fa fa-user-plus" style="font-size:17px;width:20px;text-align:center;"></i>
                    <span class="sidebar-text">Followers</span>
                </a>

                <a class="menu sidebar-item" href="Posts?filter=saved"
                    style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
                    onmouseover="this.style.backgroundColor='#FFF6ED';"
                    onmouseout="this.style.backgroundColor='transparent';">
                    <i class="fa fa-bookmark" style="font-size:17px;width:20px;text-align:center;"></i>
                    <span class="sidebar-text">Saved</span>
                </a>

                <a class="menu sidebar-item" href="Profile"
                    style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
                    onmouseover="this.style.backgroundColor='#FFF6ED';"
                    onmouseout="this.style.backgroundColor='transparent';">
                    <i class="fa fa-user" style="font-size:17px;width:20px;text-align:center;"></i>
                    <span class="sidebar-text">Profile</span>
                </a>

                <c:if test="${sessionScope.user.role == 'admin'}">
                    <a class="menu sidebar-item" href="AdminPanel"
                        style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
                        onmouseover="this.style.backgroundColor='#FFF6ED';"
                        onmouseout="this.style.backgroundColor='transparent';">
                        <i class="fa fa-shield" style="font-size:17px;width:20px;text-align:center;"></i>
                        <span class="sidebar-text">Admin</span>
                    </a>
                </c:if>

                <a class="menu sidebar-item" href="More"
                    style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-radius:16px;text-decoration:none;color:#46331F;font-weight:600;transition:all 0.2s;"
                    onmouseover="this.style.backgroundColor='#FFF6ED';"
                    onmouseout="this.style.backgroundColor='transparent';">
                    <i class="fa fa-ellipsis-h" style="font-size:17px;width:20px;text-align:center;"></i>
                    <span class="sidebar-text">More</span>
                </a>
            </div>

            <!-- User Badge -->
            <a class="menu" href="Profile"
                style="text-decoration:none;display:flex;align-items:center;gap:10px;padding:10px;border-radius:14px;background-color:#FFF6ED;transition:all 0.2s;">
                <c:choose>
                    <c:when test="${not empty sessionScope.user.picture}">
                        <img src="${sessionScope.user.picture}" class="w3-circle"
                            style="height:40px;width:40px;object-fit:cover;border:2px solid #E46B39;" alt="Avatar">
                    </c:when>
                    <c:otherwise>
                        <div
                            style="width:40px;height:40px;border-radius:50%;background:#F4A83F;border:2px solid #E46B39;display:flex;align-items:center;justify-content:center;">
                            <i class="fa fa-user" style="color:white;font-size:16px;"></i>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div style="display:flex;flex-direction:column;overflow:hidden;">
                    <span
                        style="font-weight:700;color:#46331F;font-size:13px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;">
                        ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                    </span>
                    <span
                        style="color:#CE9C6A;font-size:11px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;">
                        @${sessionScope.user.username}
                    </span>
                </div>
            </a>

        </div>

        <script>
            $(document).ready(function () {
                $('.sidebar-item').click(function () {
                    $('.sidebar-item').removeClass('active').css({ 'background-color': 'transparent', 'color': '#46331F' });
                    $(this).addClass('active').css({ 'background-color': '#E46B39', 'color': 'white' });
                });
            });
        </script>