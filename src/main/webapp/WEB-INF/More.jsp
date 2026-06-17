<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

        <div class="w3-card w3-white w3-round-large w3-section" style="overflow:hidden;">
            <div style="height:5px;background:linear-gradient(90deg,#E46B39,#F4A83F,#CE9C6A);"></div>
            <div style="padding:24px;">
                <h3 style="font-family:'Pacifico',cursive;color:#46331F;margin:0 0 20px;">More Options</h3>

                <c:forEach var="item" items="${moreItems}">
                    <div style="display:flex;align-items:center;gap:16px;padding:14px 16px;border:1.5px solid #f0e8df;border-radius:14px;margin-bottom:10px;cursor:pointer;transition:all 0.2s;"
                        onmouseover="this.style.borderColor='#E46B39';this.style.background='#FFF6ED';"
                        onmouseout="this.style.borderColor='#f0e8df';this.style.background='white';">
                        <div
                            style="width:44px;height:44px;border-radius:50%;background:#FFF6ED;border:1.5px solid #CE9C6A;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="${fn:escapeXml(item.icon)}" style="color:#E46B39;font-size:18px;"></i>
                        </div>
                        <div>
                            <div style="font-weight:700;color:#46331F;font-size:14px;"><c:out value="${item.label}"/></div>
                            <div style="font-size:12px;color:#7A5533;"><c:out value="${item.description}"/></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
