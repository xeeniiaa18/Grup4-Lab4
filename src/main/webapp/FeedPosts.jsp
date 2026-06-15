<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <c:choose>
                <c:when test="${empty posts}">
                    <div class="w3-white w3-round w3-card w3-section" style="overflow:hidden;">
                        <div style="height:5px; background:linear-gradient(90deg, #E46B39, #F4A83F, #CE9C6A);"></div>
                        <div style="padding: 40px 20px; text-align: center; color: #CE9C6A;">
                            <i class="fa fa-cutlery" style="font-size:48px; margin-bottom:12px; display:block;"></i>
                            <p style="margin: 0; font-size: 15px; font-weight: 600;">No posts to show yet.</p>
                            <p style="margin: 4px 0 0; font-size: 13px;">Be the first to share a recipe or review!</p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="post" items="${posts}">
                        <div id="${post.id}" class="w3-white w3-round w3-card w3-section" style="overflow:hidden;">
                            <div style="height:4px; background:linear-gradient(90deg, #E46B39, #F4A83F, #CE9C6A);">
                            </div>
                            <div style="padding: 16px 20px;">

                                <%-- Author row --%>
                                    <div
                                        style="display:flex; align-items:center; justify-content:space-between; margin-bottom:10px;">
                                        <div style="display:flex; align-items:center; gap:10px;">
                                            <c:choose>
                                                <c:when test="${not empty post.upicture}">
                                                    <img src="${post.upicture}" class="w3-circle"
                                                        style="width:42px;height:42px;object-fit:cover;border:2px solid #E46B39;"
                                                        alt="Avatar">
                                                </c:when>
                                                <c:otherwise>
                                                    <div
                                                        style="width:42px;height:42px;border-radius:50%;background:#FFF6ED;border:2px solid #E46B39;display:flex;align-items:center;justify-content:center;">
                                                        <i class="fa fa-user" style="color:#E46B39;font-size:18px;"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div>
                                                <a class="menu" href="ViewProfile?uid=${post.uid}"
                                                    style="font-weight:700;color:#46331F;font-size:14px;text-decoration:none;">
                                                    ${post.ufirstName} ${post.ulastName}
                                                </a>
                                                <span
                                                    style="color:#CE9C6A;font-size:12px;margin-left:4px;">@${post.uname}</span>
                                            </div>
                                        </div>
                                        <span style="color:#CE9C6A;font-size:11px;">${post.postDateTime}</span>
                                    </div>

                                    <%-- Type badge --%>
                                        <c:if test="${post.type == 'recipe'}">
                                            <span
                                                style="display:inline-flex;align-items:center;gap:5px;background:#E46B39;color:white;border-radius:8px;padding:2px 10px;font-size:11px;font-weight:700;margin-bottom:8px;">
                                                <i class="fa fa-cutlery"></i> Recipe
                                            </span>
                                        </c:if>
                                        <c:if test="${post.type == 'review'}">
                                            <span
                                                style="display:inline-flex;align-items:center;gap:5px;background:#3D7A5A;color:white;border-radius:8px;padding:2px 10px;font-size:11px;font-weight:700;margin-bottom:8px;">
                                                <i class="fa fa-pencil"></i> Review
                                            </span>
                                        </c:if>

                                        <%-- Recipe fields --%>
                                            <c:if test="${post.type == 'recipe'}">
                                                <c:if test="${not empty post.title}">
                                                    <h3 style="margin:8px 0 6px;color:#46331F;font-size:17px;">
                                                        ${post.title}</h3>
                                                </c:if>
                                                <div
                                                    style="display:flex;gap:16px;margin-bottom:10px;font-size:12px;color:#CE9C6A;font-weight:600;">
                                                    <c:if test="${post.servings != null}">
                                                        <span><i class="fa fa-users"></i> ${post.servings}
                                                            servings</span>
                                                    </c:if>
                                                    <c:if test="${post.cookingTime != null}">
                                                        <span><i class="fa fa-clock-o"></i> ${post.cookingTime}
                                                            min</span>
                                                    </c:if>
                                                </div>
                                                <c:if test="${not empty post.ingredients}">
                                                    <div
                                                        style="background:#FFF6ED;border-radius:10px;padding:10px 14px;margin-bottom:8px;">
                                                        <span
                                                            style="font-weight:700;color:#46331F;font-size:12px;display:block;margin-bottom:4px;">
                                                            <i class="fa fa-list-ul"></i> Ingredients
                                                        </span>
                                                        <span
                                                            style="color:#46331F;font-size:13px;white-space:pre-line;">${post.ingredients}</span>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty post.instructions}">
                                                    <div
                                                        style="background:#FFF6ED;border-radius:10px;padding:10px 14px;margin-bottom:8px;">
                                                        <span
                                                            style="font-weight:700;color:#46331F;font-size:12px;display:block;margin-bottom:4px;">
                                                            <i class="fa fa-tasks"></i> Instructions
                                                        </span>
                                                        <span
                                                            style="color:#46331F;font-size:13px;white-space:pre-line;">${post.instructions}</span>
                                                    </div>
                                                </c:if>
                                            </c:if>

                                            <%-- Review fields --%>
                                                <c:if test="${post.type == 'review'}">
                                                    <c:if test="${not empty post.reviewTitle}">
                                                        <h3 style="margin:8px 0 6px;color:#46331F;font-size:17px;">
                                                            ${post.reviewTitle}</h3>
                                                    </c:if>
                                                    <div
                                                        style="display:flex;gap:16px;margin-bottom:8px;font-size:12px;color:#CE9C6A;font-weight:600;">
                                                        <c:if test="${not empty post.reviewName}">
                                                            <span><i class="fa fa-cutlery"></i>
                                                                ${post.reviewName}</span>
                                                        </c:if>
                                                        <c:if test="${not empty post.location}">
                                                            <span><i class="fa fa-map-marker"></i>
                                                                ${post.location}</span>
                                                        </c:if>
                                                    </div>
                                                    <c:if test="${post.rating != null}">
                                                        <div
                                                            style="margin-bottom:8px;display:flex;align-items:center;gap:4px;">
                                                            <c:forEach begin="1" end="5" var="star">
                                                                <c:choose>
                                                                    <c:when test="${star le post.rating}">
                                                                        <i class="fa fa-star"
                                                                            style="color:#F4A83F;font-size:16px;"></i>
                                                                    </c:when>
                                                                    <c:when test="${(star - 0.5) le post.rating}">
                                                                        <i class="fa fa-star-half-o"
                                                                            style="color:#F4A83F;font-size:16px;"></i>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="fa fa-star-o"
                                                                            style="color:#CE9C6A;font-size:16px;"></i>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                            <span
                                                                style="color:#CE9C6A;font-size:12px;font-weight:600;margin-left:4px;">${post.rating}</span>
                                                        </div>
                                                    </c:if>
                                                </c:if>

                                                <%-- Text body --%>
                                                    <c:if test="${not empty post.content}">
                                                        <p
                                                            style="color:#46331F;font-size:14px;line-height:1.5;margin:8px 0 12px;">
                                                            ${post.content}</p>
                                                    </c:if>

                                                    <c:if test="${not empty post.image}">
                                                        <img src="${post.image}"
                                                            style="width:100%;border-radius:10px;margin-bottom:10px;"
                                                            alt="Post image">
                                                    </c:if>

                                                    <%-- Action buttons --%>
                                                        <div
                                                            style="display:flex;align-items:center;gap:4px;border-top:1px solid #f0e8df;padding-top:10px;margin-top:4px;">
                                                            <c:choose>
                                                                <c:when test="${not empty user}">
                                                                    <%-- Like / Unlike --%>
                                                                        <c:choose>
                                                                            <c:when test="${post.likedByCurrentUser}">
                                                                                <button type="button" class="unlikePost"
                                                                                    style="background:none;border:none;color:#E46B39;font-size:13px;font-weight:600;cursor:pointer;display:flex;align-items:center;gap:4px;padding:5px 9px;border-radius:8px;transition:0.2s;"
                                                                                    onmouseover="this.style.backgroundColor='#FFF6ED';"
                                                                                    onmouseout="this.style.backgroundColor='transparent';">
                                                                                    <i class="fa fa-heart"></i>
                                                                                    ${post.likesCount}
                                                                                </button>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <button type="button" class="likePost"
                                                                                    style="background:none;border:none;color:#CE9C6A;font-size:13px;font-weight:600;cursor:pointer;display:flex;align-items:center;gap:4px;padding:5px 9px;border-radius:8px;transition:0.2s;"
                                                                                    onmouseover="this.style.backgroundColor='#FFF6ED';"
                                                                                    onmouseout="this.style.backgroundColor='transparent';">
                                                                                    <i class="fa fa-heart-o"></i>
                                                                                    ${post.likesCount}
                                                                                </button>
                                                                            </c:otherwise>
                                                                        </c:choose>

                                                                        <%-- Comment toggle --%>
                                                                            <button type="button" class="toggleComments"
                                                                                style="background:none;border:none;color:#CE9C6A;font-size:13px;font-weight:600;cursor:pointer;display:flex;align-items:center;gap:4px;padding:5px 9px;border-radius:8px;transition:0.2s;"
                                                                                onmouseover="this.style.backgroundColor='#FFF6ED';"
                                                                                onmouseout="this.style.backgroundColor='transparent';">
                                                                                <i class="fa fa-comment-o"></i>
                                                                                ${post.commentsCount}
                                                                            </button>

                                                                            <%-- Save / Unsave --%>
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${post.savedByCurrentUser}">
                                                                                        <button type="button"
                                                                                            class="unsavePost"
                                                                                            style="background:none;border:none;color:#3D7A5A;font-size:13px;font-weight:600;cursor:pointer;display:flex;align-items:center;gap:4px;padding:5px 9px;border-radius:8px;transition:0.2s;"
                                                                                            onmouseover="this.style.backgroundColor='#FFF6ED';"
                                                                                            onmouseout="this.style.backgroundColor='transparent';">
                                                                                            <i
                                                                                                class="fa fa-bookmark"></i>
                                                                                            Saved
                                                                                        </button>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <button type="button"
                                                                                            class="savePost"
                                                                                            style="background:none;border:none;color:#CE9C6A;font-size:13px;font-weight:600;cursor:pointer;display:flex;align-items:center;gap:4px;padding:5px 9px;border-radius:8px;transition:0.2s;"
                                                                                            onmouseover="this.style.backgroundColor='#FFF6ED';"
                                                                                            onmouseout="this.style.backgroundColor='transparent';">
                                                                                            <i
                                                                                                class="fa fa-bookmark-o"></i>
                                                                                            Save
                                                                                        </button>
                                                                                    </c:otherwise>
                                                                                </c:choose>

                                                                                <%-- Delete (owner only) --%>
                                                                                    <c:if
                                                                                        test="${post.uid == user.id or user.role == 'admin'}">
                                                                                        <button type="button"
                                                                                            class="delPost"
                                                                                            style="background:none;border:none;color:#d9534f;font-size:13px;font-weight:600;cursor:pointer;display:flex;align-items:center;gap:4px;padding:5px 9px;border-radius:8px;transition:0.2s;margin-left:auto;"
                                                                                            onmouseover="this.style.backgroundColor='#fce4e4';"
                                                                                            onmouseout="this.style.backgroundColor='transparent';">
                                                                                            <i class="fa fa-trash"></i>
                                                                                            Delete
                                                                                        </button>
                                                                                    </c:if>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span style="color:#CE9C6A;font-size:12px;">
                                                                        <i class="fa fa-heart-o"></i> ${post.likesCount}
                                                                        likes &nbsp;
                                                                        <i class="fa fa-comment-o"></i>
                                                                        ${post.commentsCount} comments
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>

                                                        <%-- Comments panel (collapsed by default) --%>
                                                            <div id="comments-panel-${post.id}"
                                                                style="display:none; padding-top:12px; margin-top:4px;">
                                                                <div id="comments-list-${post.id}"
                                                                    style="margin-bottom:10px;"></div>
                                                                <c:if test="${not empty user}">
                                                                    <div
                                                                        style="display:flex;gap:8px;align-items:center;">
                                                                        <c:choose>
                                                                            <c:when test="${not empty user.picture}">
                                                                                <img src="${user.picture}"
                                                                                    class="w3-circle"
                                                                                    style="width:28px;height:28px;object-fit:cover;flex-shrink:0;border:1.5px solid #CE9C6A;"
                                                                                    alt="">
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div
                                                                                    style="width:28px;height:28px;border-radius:50%;background:#FFF6ED;border:1.5px solid #CE9C6A;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                                                                    <i class="fa fa-user"
                                                                                        style="color:#CE9C6A;font-size:12px;"></i>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                        <input type="text" id="comment-input-${post.id}"
                                                                            placeholder="Write a comment..."
                                                                            style="flex:1;padding:7px 14px;border:1.5px solid #CE9C6A;border-radius:20px;font-size:13px;font-family:'Nunito',sans-serif;outline:none;color:#46331F;background:#fff;"
                                                                            onfocus="this.style.borderColor='#E46B39';"
                                                                            onblur="this.style.borderColor='#CE9C6A';" />
                                                                        <button type="button" class="submitComment"
                                                                            data-pid="${post.id}"
                                                                            style="background:#E46B39;color:white;border:none;border-radius:50%;width:32px;height:32px;display:flex;align-items:center;justify-content:center;cursor:pointer;flex-shrink:0;transition:0.2s;"
                                                                            onmouseover="this.style.backgroundColor='#d05325';"
                                                                            onmouseout="this.style.backgroundColor='#E46B39';">
                                                                            <i class="fa fa-paper-plane"
                                                                                style="font-size:12px;margin-left:1px;"></i>
                                                                        </button>
                                                                    </div>
                                                                </c:if>
                                                            </div>

                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>