<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <c:choose>
            <c:when test="${empty profileUser}">
                <p style="color:#CE9C6A;text-align:center;padding:40px;">User not found.</p>
            </c:when>
            <c:otherwise>
                <div style="max-width:600px; margin:0 auto; padding:24px 0;">

                    <div class="w3-card w3-white w3-round-large" style="padding:28px;">

                        <!-- Avatar + info -->
                        <div style="display:flex;align-items:center;gap:18px;margin-bottom:20px;">
                            <c:choose>
                                <c:when test="${not empty profileUser.picture}">
                                    <img src="${profileUser.picture}" class="w3-circle"
                                        style="height:80px;width:80px;object-fit:cover;border:3px solid #E46B39;"
                                        alt="Avatar">
                                </c:when>
                                <c:otherwise>
                                    <div
                                        style="width:80px;height:80px;border-radius:50%;background:#F4A83F;border:3px solid #E46B39;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                        <i class="fa fa-user" style="color:white;font-size:32px;"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div>
                                <div style="font-family:'Pacifico',cursive;font-size:20px;color:#46331F;">
                                    <c:if test="${not empty profileUser.title}">${profileUser.title} </c:if>
                                    ${profileUser.firstName} ${profileUser.lastName}
                                    <c:if test="${profileUser.verified}">
                                        <i class="fa fa-check-circle" style="color:#3D7A5A;font-size:14px;"></i>
                                    </c:if>
                                </div>
                                <div style="color:#CE9C6A;font-size:13px;">@${profileUser.username}</div>
                                <c:if test="${not empty profileUser.bio}">
                                    <div style="color:#46331F;font-size:13px;margin-top:6px;">${profileUser.bio}</div>
                                </c:if>
                            </div>
                        </div>
                        <hr style="border:none;border-top:1px solid #f0e8df;margin:20px 0;">

                        <div style="display:flex;flex-direction:column;gap:10px;font-size:13px;color:#46331F;">

                            <c:if test="${not empty profileUser.phone}">
                                <div>
                                    <span style="font-weight:700;"><i class="fa fa-phone"></i> Phone: </span>
                                    ${profileUser.phone}
                                </div>
                            </c:if>

                            <c:if test="${not empty profileUser.dateOfBirth}">
                                <div>
                                    <span style="font-weight:700;"><i class="fa fa-birthday-cake"></i> Date of birth:
                                    </span>
                                    ${profileUser.dateOfBirth}
                                </div>
                            </c:if>

                            <c:if test="${not empty profileUser.gender}">
                                <div>
                                    <span style="font-weight:700;"><i class="fa fa-venus-mars"></i> Gender: </span>
                                    ${profileUser.gender}
                                </div>
                            </c:if>

                            <c:if test="${not empty profileUser.allergies}">
                                <div>
                                    <span style="font-weight:700;"><i class="fa fa-exclamation-triangle"></i> Allergies:
                                    </span>
                                    ${profileUser.allergies}
                                </div>
                            </c:if>

                            <c:if test="${not empty profileUser.foodPreferences}">
                                <div>
                                    <span style="font-weight:700;"><i class="fa fa-cutlery"></i> Food preferences:
                                    </span>
                                    <div style="display:flex;flex-wrap:wrap;gap:6px;margin-top:6px;">
                                        <c:forTokens var="pref" items="${profileUser.foodPreferences}" delims=",">
                                            <span
                                                style="background:#FFF6ED;border:1px solid #E46B39;color:#E46B39;border-radius:20px;padding:3px 10px;font-size:12px;font-weight:600;">
                                                ${pref}
                                            </span>
                                        </c:forTokens>
                                    </div>
                                </div>
                            </c:if>

                        </div>

                        <c:if test="${isSelf}">
                            <div style="margin-top:16px; display:flex; gap:10px; align-items:center; flex-wrap:wrap;">
                                <a class="menu" href="Profile?mode=edit"
                                    style="display:inline-flex;align-items:center;gap:6px;background:#E46B39;color:white;padding:9px 18px;border-radius:12px;font-size:13px;font-weight:700;text-decoration:none;">
                                    <i class="fa fa-pencil"></i> Edit Profile
                                </a>
                            </div>

                            <div style="margin-top:24px; padding:16px; background:#FFF6ED; border:1px solid #CE9C6A; border-radius:12px;">
                                <h4 style="font-family:'Pacifico',cursive; color:#46331F; margin:0 0 10px 0; font-size:18px;">
                                    <i class="fa fa-shield"></i> Verification Status
                                </h4>
                                <c:choose>
                                    <c:when test="${profileUser.verified}">
                                        <div style="color:#3D7A5A; font-weight:700; font-size:13px;">
                                            <i class="fa fa-check-circle"></i> You are a verified user!
                                        </div>
                                    </c:when>
                                    <c:when test="${not empty verificationRequest and verificationRequest.status == 'pending'}">
                                        <div style="color:#E46B39; font-weight:700; font-size:13px;">
                                            <i class="fa fa-clock-o"></i> Your verification request is pending.
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${not empty verificationRequest and verificationRequest.status == 'rejected'}">
                                            <div style="color:#d9534f; font-weight:700; font-size:13px; margin-bottom:10px;">
                                                <i class="fa fa-times-circle"></i> Your previous request was rejected. You can apply again.
                                            </div>
                                        </c:if>
                                        <form method="post" action="RequestVerification" class="verification-form">
                                            <textarea name="message" placeholder="Why should you be verified?"
                                                style="width:100%;padding:9px 12px;border:1.5px solid #CE9C6A;border-radius:10px;font-size:13px;color:#46331F;margin-bottom:10px;resize:vertical;"></textarea>
                                            <button type="submit"
                                                style="background:#46331F;color:white;padding:8px 16px;border:none;border-radius:10px;font-size:13px;font-weight:700;cursor:pointer;">
                                                Request Verification
                                            </button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>

                    </div>

                </div>
            </c:otherwise>
        </c:choose>