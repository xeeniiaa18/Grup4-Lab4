<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="w3-white w3-round w3-card w3-section" style="overflow:hidden;">
            <div style="height:5px; background:linear-gradient(90deg, #E46B39, #F4A83F, #CE9C6A);"></div>
            <div style="padding: 24px;">
                <h2 style="margin:0 0 16px; color:#46331F; font-family:'Pacifico', cursive;">
                    <i class="fa fa-user-plus" style="color:#E46B39;"></i> Followers
                </h2>
                <hr style="border:none; border-top:1px solid #f0e8df; margin:16px 0;">
                <c:choose>
                    <c:when test="${empty users}">
                        <div style="text-align: center; padding: 40px 20px; color: #CE9C6A;">
                            <i class="fa fa-users" style="font-size:48px; margin-bottom:12px; display:block;"></i>
                            <p style="margin: 0; font-size: 15px; font-weight: 600;">Nobody is following you yet.</p>
                            <p style="margin: 4px 0 0; font-size: 13px;">Share your posts and let people discover you!
                            </p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="display: flex; flex-direction: column; gap: 12px;">
                            <c:forEach var="u" items="${users}">
                                <div id="${u.id}"
                                    style="display:flex;align-items:center;justify-content:space-between;gap:12px;padding:14px;border-radius:12px;background:#fff;border:1.5px solid #CE9C6A;">
                                    <div style="display:flex;align-items:center;gap:12px;min-width:0;">
                                        <c:choose>
                                            <c:when test="${not empty u.picture}">
                                                <img src="${u.picture}" class="w3-circle"
                                                    style="height:44px;width:44px;object-fit:cover;border:2px solid #E46B39;"
                                                    alt="Avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <div
                                                    style="width:44px;height:44px;border-radius:50%;background:#FFF6ED;border:2px solid #E46B39;display:flex;align-items:center;justify-content:center;">
                                                    <i class="fa fa-user" style="color:#E46B39;font-size:18px;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div style="display:flex;flex-direction:column;min-width:0;">
                                            <a class="menu" href="ViewProfile?uid=${u.id}"
                                                style="font-weight:700;color:#46331F;font-size:14px;text-decoration:none;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;">
                                                <c:if test="${not empty u.title}">${u.title} </c:if>${u.firstName}
                                                ${u.lastName}
                                                <c:if test="${u.verified}">
                                                    <i class="fa fa-check-circle"
                                                        style="color:#3D7A5A;font-size:11px;"></i>
                                                </c:if>
                                            </a>
                                            <span style="color:#CE9C6A;font-size:12px;">@${u.username}</span>
                                        </div>
                                    </div>
                                    <c:choose>
                                        <c:when test="${followingIds.contains(u.id)}">
                                            <button type="button" class="unfollowUser"
                                                style="background:transparent;color:#CE9C6A;border:1.5px solid #CE9C6A;border-radius:12px;padding:6px 14px;font-size:12px;font-weight:700;cursor:pointer;"
                                                onmouseover="this.style.backgroundColor='#FFF6ED';"
                                                onmouseout="this.style.backgroundColor='transparent';">
                                                Following
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="followUser"
                                                style="background:transparent;color:#E46B39;border:1.5px solid #E46B39;border-radius:12px;padding:6px 14px;font-size:12px;font-weight:700;cursor:pointer;"
                                                onmouseover="this.style.backgroundColor='#FFF6ED';"
                                                onmouseout="this.style.backgroundColor='transparent';">
                                                Follow back
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>