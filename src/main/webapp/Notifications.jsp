<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="w3-white w3-round w3-card w3-section" style="overflow:hidden;">
    <div style="height:5px; background:linear-gradient(90deg, #E46B39, #F4A83F, #CE9C6A);"></div>

    <div style="padding: 24px;">
        <h2 style="margin:0 0 16px; color:#46331F; font-family:'Pacifico', cursive;">🔔 Notifications</h2>
        
        <hr style="border:none; border-top:1px solid #f0e8df; margin:16px 0;">

        <c:choose>
            <c:when test="${empty notifications}">
                <div style="text-align: center; padding: 40px 20px; color: #CE9C6A;">
                    <div style="font-size: 48px; margin-bottom: 12px;">📭</div>
                    <p style="margin: 0; font-size: 15px; font-weight: 600;">You are all caught up!</p>
                    <p style="margin: 4px 0 0; font-size: 13px; color: #CE9C6A;">When other foodies interact with your posts or follow you, it will show up here.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div style="display: flex; flex-direction: column; gap: 12px;">
                    <c:forEach var="n" items="${notifications}">
                        <div style="display: flex; align-items: flex-start; gap: 12px; padding: 14px; border-radius: 12px; background-color: ${n.read ? '#fafafa' : '#FFF6ED'}; border: 1.5px solid ${n.read ? '#f0e8df' : '#E46B39'}; transition: all 0.2s;">
                            
                            <div style="font-size: 20px; margin-top: 2px;">
                                <c:choose>
                                    <c:when test="${n.type == 'like'}">❤️</c:when>
                                    <c:when test="${n.type == 'comment'}">💬</c:when>
                                    <c:when test="${n.type == 'follow'}">🤝</c:when>
                                    <c:otherwise>📢</c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div style="flex: 1; min-width: 0;">
                                <p style="margin: 0; color: #46331F; font-size: 14px; font-weight: ${n.read ? 'normal' : '700'}; line-height: 1.4;">
                                    ${n.message}
                                </p>
                                <span style="font-size: 11px; color: #CE9C6A; display: block; margin-top: 4px;">
                                    ${n.createdAt}
                                </span>
                            </div>
                            
                            <c:if test="${not n.read}">
                                <div style="width: 8px; height: 8px; border-radius: 50%; background-color: #E46B39; align-self: center;"></div>
                            </c:if>

                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
