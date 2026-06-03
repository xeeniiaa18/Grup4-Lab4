<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="suggestions-card" style="background-color: #ffffff; border-radius: 16px; border: 1.5px solid #CE9C6A; padding: 20px; box-shadow: 0 4px 12px rgba(70,51,31,0.05); margin-top: 10px;">
    
    <h3 style="margin: 0 0 16px; font-size: 15px; font-weight: 700; color: #46331F; font-family: 'Nunito', sans-serif;">Suggested for you</h3>

    <c:choose>
        <c:when test="${empty users}">
            <p style="color: #CE9C6A; font-size: 13px; margin: 0; text-align: center;">No new suggestions today! 🍳</p>
        </c:when>
        <c:otherwise>
            <div style="display: flex; flex-direction: column; gap: 14px;">
                <c:forEach var="u" items="${users}">
                    <div id="${u.id}" style="display: flex; align-items: center; justify-content: space-between; gap: 10px;">
                        
                        <!-- Avatar & Info -->
                        <div style="display: flex; align-items: center; gap: 10px; min-width: 0;">
                            <c:choose>
                                <c:when test="${not empty u.picture}">
                                    <img src="${u.picture}" class="w3-circle" style="height: 36px; width: 36px; object-fit: cover; border: 1.5px solid #CE9C6A;" alt="Avatar">
                                </c:when>
                                <c:otherwise>
                                    <div style="width: 36px; height: 36px; border-radius: 50%; background-color: #FFF6ED; border: 1.5px solid #CE9C6A; display: flex; align-items: center; justify-content: center; font-size: 16px;">
                                        🧑‍🍳
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div style="display: flex; flex-direction: column; min-width: 0;">
                                <span style="font-size: 13px; font-weight: 700; color: #46331F; white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                    <c:if test="${not empty u.title}">${u.title} </c:if>
                                    ${u.firstName} ${u.lastName}
                                    <c:if test="${u.verified}"><span style="font-size: 11px;" title="Verified">✅</span></c:if>
                                </span>
                                <span style="font-size: 11px; color: #CE9C6A; white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                    @${u.username}
                                </span>
                            </div>
                        </div>

                        <!-- Follow Button -->
                        <button type="button" class="followUser" 
                                style="background-color: #E46B39; color: white; border: none; border-radius: 12px; padding: 6px 14px; font-size: 12px; font-weight: 700; cursor: pointer; transition: all 0.2s; box-shadow: 0 2px 6px rgba(228,107,57,0.15);"
                                onmouseover="this.style.backgroundColor='#d05325';" 
                                onmouseout="this.style.backgroundColor='#E46B39';">
                            Follow
                        </button>

                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>