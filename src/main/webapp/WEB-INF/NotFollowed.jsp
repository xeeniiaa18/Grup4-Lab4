<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:if test="${not empty currentUser}">
<div class="suggestions-card" style="position:sticky;bottom:20px;background-color:#ffffff;border-radius:16px;border:1.5px solid #CE9C6A;padding:20px;box-shadow:0 4px 12px rgba(70,51,31,0.08);margin-top:auto;margin-bottom:20px;">

    <h3 style="margin:0 0 16px;font-size:15px;font-weight:700;color:#46331F;display:flex;align-items:center;gap:8px;">
        <i class="fa fa-user-plus" style="color:#E46B39;"></i> Suggested for you
    </h3>

    <c:choose>
        <c:when test="${empty users}">
            <p style="color:#7A5533;font-size:13px;margin:0;text-align:center;">
                <i class="fa fa-check-circle"></i> No new suggestions today!
            </p>
        </c:when>
        <c:otherwise>
            <div style="display:flex;flex-direction:column;gap:14px;">
                <c:forEach var="u" items="${users}">
                    <div id="${u.id}" style="display:flex;align-items:center;justify-content:space-between;gap:10px;">

                        <div style="display:flex;align-items:center;gap:10px;min-width:0;">
                            <c:choose>
                                <c:when test="${not empty u.picture}">
                                    <img src="${fn:escapeXml(u.picture)}" class="w3-circle"
                                         style="height:36px;width:36px;object-fit:cover;border:1.5px solid #CE9C6A;" alt="Avatar">
                                </c:when>
                                <c:otherwise>
                                    <div style="width:36px;height:36px;border-radius:50%;background:#FFF6ED;border:1.5px solid #CE9C6A;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                        <i class="fa fa-user" style="color:#7A5533;font-size:14px;"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div style="display:flex;flex-direction:column;min-width:0;">
                                <span style="font-size:13px;font-weight:700;color:#46331F;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;">
                                    <c:if test="${not empty u.title}"><c:out value="${u.title}"/> </c:if><c:out value="${u.firstName}"/> <c:out value="${u.lastName}"/>
                                    <c:if test="${u.verified}">
                                        <i class="fa fa-check-circle" style="color:#3D7A5A;font-size:11px;" title="Verified"></i>
                                    </c:if>
                                </span>
                                <span style="font-size:11px;color:#7A5533;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;">
                                    @<c:out value="${u.username}"/>
                                </span>
                            </div>
                        </div>

                        <button type="button" class="followUser"
                                aria-label="Follow ${fn:escapeXml(u.firstName)} ${fn:escapeXml(u.lastName)}"
                                style="background-color:#E46B39;color:white;border:none;border-radius:12px;padding:6px 14px;font-size:12px;font-weight:700;cursor:pointer;transition:all 0.2s;white-space:nowrap;"
                                onmouseover="this.style.backgroundColor='#d05325';"
                                onmouseout="this.style.backgroundColor='#E46B39';">
                            <i class="fa fa-plus"></i> Follow
                        </button>

                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>
</c:if>
