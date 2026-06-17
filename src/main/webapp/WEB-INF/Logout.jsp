<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
	<%@ taglib prefix="c" uri="jakarta.tags.core" %>

		<script>
			App.reloadChrome();
			 setTimeout(function() {
				$("#content").load("Content");
			}, 1500);
		</script>

		<div class="w3-container w3-padding-24 w3-white w3-round w3-card"
			style="text-align:center; padding: 40px 28px;">
			<div style="font-size:48px; margin-bottom:12px;">👋</div>
			<h3 style="color:#46331F; font-family:'Pacifico', cursive;">See you soon!</h3>
			<p style="color:#7A5533; font-size:14px;">You have successfully logged out.</p>
		</div>