<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%--
  Professor teaching-availability picker (shared by the desktop Settings tab and the mobile Profile tab).
  Params: idPrefix (unique per include), returnTab (tab to reopen after saving)
  Expects request attribute: availableShifts (Set<String> of MORNING/AFTERNOON/EVENING/WEEKEND)
--%>
<c:set var="p" value="${empty param.idPrefix ? 'avail' : param.idPrefix}" />
<c:set var="isSet" value="${not empty availableShifts}" />

<c:if test="${empty requestScope.availabilityStyleLoaded}">
    <c:set var="availabilityStyleLoaded" value="true" scope="request" />
    <style>
        .avail-form { --avail-border: #e8edf3; }
        .avail-status { display: flex; align-items: flex-start; gap: 10px; padding: 12px 14px; border-radius: 14px; font-size: 0.85rem; margin-bottom: 16px; }
        .avail-status.is-set { background: #f0fdf4; color: #166534; border: 1px solid #bbf7d0; }
        .avail-status.is-unset { background: #fffbeb; color: #92400e; border: 1px solid #fde68a; }
        .avail-status i { font-size: 1.1rem; line-height: 1.2; flex-shrink: 0; }
        .avail-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 12px; margin-bottom: 16px; }
        .avail-option { position: relative; display: flex; align-items: center; gap: 12px; padding: 14px; min-height: 68px; border: 1.5px solid var(--avail-border); border-radius: 16px; background: #fff; cursor: pointer; transition: border-color .15s, background .15s, box-shadow .15s; margin: 0; }
        .avail-option:hover { border-color: #93c5fd; }
        .avail-option input { position: absolute; opacity: 0; pointer-events: none; }
        .avail-option:has(input:focus-visible) { outline: 2px solid #2563eb; outline-offset: 2px; }
        .avail-option:has(input:checked) { border-color: #2563eb; background: #eff6ff; box-shadow: 0 0 0 3px rgba(37, 99, 235, .12); }
        .avail-icon { width: 40px; height: 40px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.15rem; flex-shrink: 0; }
        .avail-icon.morning { background: #fef3c7; color: #b45309; }
        .avail-icon.afternoon { background: #ffedd5; color: #c2410c; }
        .avail-icon.evening { background: #e0e7ff; color: #4338ca; }
        .avail-icon.weekend { background: #dcfce7; color: #15803d; }
        .avail-text { min-width: 0; flex: 1; }
        .avail-name { font-weight: 700; font-size: 0.9rem; color: #0f172a; line-height: 1.25; }
        .avail-time { font-size: 0.78rem; color: #64748b; }
        .avail-check { width: 22px; height: 22px; border-radius: 50%; border: 1.5px solid #cbd5e1; display: flex; align-items: center; justify-content: center; color: transparent; font-size: 0.8rem; flex-shrink: 0; transition: all .15s; }
        .avail-option:has(input:checked) .avail-check { background: #2563eb; border-color: #2563eb; color: #fff; }
        .avail-actions { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; }
        .avail-hint { font-size: 0.78rem; color: #64748b; }
        @media (max-width: 767.98px) {
            .avail-grid { grid-template-columns: 1fr; }
            .avail-actions .btn { width: 100%; min-height: 44px; }
        }
    </style>
</c:if>

<form action="${pageContext.request.contextPath}/professor/availability" method="POST" class="avail-form" id="${p}Form">
    <input type="hidden" name="tab" value="${empty param.returnTab ? 'settings' : param.returnTab}">

    <div class="avail-status ${isSet ? 'is-set' : 'is-unset'}" role="status">
        <c:choose>
            <c:when test="${isSet}">
                <i class="bi bi-check-circle-fill" aria-hidden="true"></i>
                <div>Deans can currently schedule you for:
                    <strong>
                        <c:if test="${availableShifts.contains('MORNING')}">Morning </c:if>
                        <c:if test="${availableShifts.contains('AFTERNOON')}">Afternoon </c:if>
                        <c:if test="${availableShifts.contains('EVENING')}">Evening </c:if>
                        <c:if test="${availableShifts.contains('WEEKEND')}">Weekend</c:if>
                    </strong>
                </div>
            </c:when>
            <c:otherwise>
                <i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i>
                <div>You haven't set your availability yet, so deans can't assign you to any class. Choose the shifts you are free below.</div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="avail-grid" role="group" aria-label="Shifts you are available to teach">
        <label class="avail-option" for="${p}Morning">
            <input type="checkbox" name="shifts" value="MORNING" id="${p}Morning" ${availableShifts.contains('MORNING') ? 'checked' : ''}>
            <span class="avail-icon morning"><i class="bi bi-sunrise-fill" aria-hidden="true"></i></span>
            <span class="avail-text"><span class="avail-name d-block">Morning</span><span class="avail-time">08:00 AM - 11:15 AM</span></span>
            <span class="avail-check"><i class="bi bi-check-lg" aria-hidden="true"></i></span>
        </label>
        <label class="avail-option" for="${p}Afternoon">
            <input type="checkbox" name="shifts" value="AFTERNOON" id="${p}Afternoon" ${availableShifts.contains('AFTERNOON') ? 'checked' : ''}>
            <span class="avail-icon afternoon"><i class="bi bi-sun-fill" aria-hidden="true"></i></span>
            <span class="avail-text"><span class="avail-name d-block">Afternoon</span><span class="avail-time">02:00 PM - 05:15 PM</span></span>
            <span class="avail-check"><i class="bi bi-check-lg" aria-hidden="true"></i></span>
        </label>
        <label class="avail-option" for="${p}Evening">
            <input type="checkbox" name="shifts" value="EVENING" id="${p}Evening" ${availableShifts.contains('EVENING') ? 'checked' : ''}>
            <span class="avail-icon evening"><i class="bi bi-moon-stars-fill" aria-hidden="true"></i></span>
            <span class="avail-text"><span class="avail-name d-block">Evening</span><span class="avail-time">05:45 PM - 08:45 PM</span></span>
            <span class="avail-check"><i class="bi bi-check-lg" aria-hidden="true"></i></span>
        </label>
        <label class="avail-option" for="${p}Weekend">
            <input type="checkbox" name="shifts" value="WEEKEND" id="${p}Weekend" ${availableShifts.contains('WEEKEND') ? 'checked' : ''}>
            <span class="avail-icon weekend"><i class="bi bi-calendar-week-fill" aria-hidden="true"></i></span>
            <span class="avail-text"><span class="avail-name d-block">Weekend</span><span class="avail-time">Sat - Sun, 08:00 AM - 04:30 PM</span></span>
            <span class="avail-check"><i class="bi bi-check-lg" aria-hidden="true"></i></span>
        </label>
    </div>

    <div class="avail-actions">
        <span class="avail-hint" id="${p}Hint">Select one or more shifts, then confirm.</span>
        <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold" id="${p}Submit" disabled>
            <i class="bi bi-check2-circle me-1" aria-hidden="true"></i> Confirm Availability
        </button>
    </div>
</form>

<script>
(function () {
    var form = document.getElementById('${p}Form');
    if (!form) return;
    var boxes = form.querySelectorAll('input[name="shifts"]');
    var submit = document.getElementById('${p}Submit');
    var hint = document.getElementById('${p}Hint');
    var initial = Array.prototype.map.call(boxes, function (b) { return b.checked; }).join();
    function refresh() {
        var current = Array.prototype.map.call(boxes, function (b) { return b.checked; }).join();
        var anyChecked = Array.prototype.some.call(boxes, function (b) { return b.checked; });
        submit.disabled = !anyChecked || current === initial;
        hint.textContent = !anyChecked ? 'Select at least one shift.' : (current === initial ? 'No changes to confirm.' : 'Unsaved changes - confirm to apply.');
    }
    Array.prototype.forEach.call(boxes, function (b) { b.addEventListener('change', refresh); });
    refresh();
})();
</script>
