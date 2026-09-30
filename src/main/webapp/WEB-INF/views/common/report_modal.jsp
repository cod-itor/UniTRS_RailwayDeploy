<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%--
  "Report an Issue" modal shared by the student and professor dashboards. Include it ONCE per page.
  Params:
    formAction   - URL the form posts to
    hiddenAction - optional value for a hidden "action" field (student uses "submitReport")
    returnTab    - optional tab the dashboard should reopen after submitting
  Expects request attribute: reportCatalog (Map<String, List<Issue>>), session user.
  Open it with: openReportModal()
--%>
<style>
    #reportModal .modal-content { border: 0; border-radius: 20px; }
    #reportModal .modal-header, #reportModal .modal-footer { border: 0; padding: 20px 24px 0; }
    #reportModal .modal-body { padding: 16px 24px 8px; }
    #reportModal .modal-footer { padding: 8px 24px 20px; gap: 8px; }
    #reportModal .report-icon { width: 40px; height: 40px; border-radius: 12px; background: #fee2e2; color: #dc2626; display: inline-flex; align-items: center; justify-content: center; font-size: 1.15rem; flex-shrink: 0; }
    #reportModal .form-label { font-size: 0.85rem; font-weight: 700; color: #334155; margin-bottom: 6px; }
    #reportModal .form-control, #reportModal .form-select { min-height: 46px; border-radius: 12px; font-size: 1rem; }
    #reportModal .report-desc { display: none; align-items: flex-start; gap: 8px; margin-top: 10px; padding: 10px 12px; border-radius: 12px; background: #f8fafc; border: 1px solid #e8edf3; color: #475569; font-size: 0.85rem; }
    #reportModal .report-desc.show { display: flex; }
    #reportModal .modal-footer .btn { min-height: 44px; }
    @media (max-width: 767.98px) {
        #reportModal .modal-dialog { margin: 16px; }
        #reportModal .modal-footer .btn { flex: 1; }
    }
</style>

<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <form action="${param.formAction}" method="POST" class="modal-content" id="reportForm">
            <c:if test="${not empty param.hiddenAction}">
                <input type="hidden" name="action" value="${param.hiddenAction}">
            </c:if>
            <c:if test="${not empty param.returnTab}">
                <input type="hidden" name="tab" value="${param.returnTab}">
            </c:if>

            <div class="modal-header">
                <div class="d-flex align-items-center gap-3">
                    <span class="report-icon"><i class="bi bi-flag-fill" aria-hidden="true"></i></span>
                    <h5 class="modal-title fw-bold text-dark mb-0" id="reportModalLabel">Report an Issue</h5>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label" for="reportName">Your name</label>
                    <input type="text" class="form-control" id="reportName" name="reporterName" maxlength="100" required autocomplete="name"
                           value="<c:out value='${sessionScope.user.fullName}'/>">
                </div>

                <div>
                    <label class="form-label" for="reportIssue">What happened?</label>
                    <select class="form-select" id="reportIssue" name="issue" required>
                        <option value="" selected disabled>-- Choose an option --</option>
                        <c:forEach var="entry" items="${reportCatalog}">
                            <optgroup label="<c:out value='${entry.key}'/>">
                                <c:forEach var="issue" items="${entry.value}">
                                    <option value="<c:out value='${entry.key}::${issue.label}'/>" data-desc="<c:out value='${issue.description}'/>"><c:out value="${issue.label}"/></option>
                                </c:forEach>
                            </optgroup>
                        </c:forEach>
                    </select>
                    <div class="report-desc" id="reportDesc" aria-live="polite">
                        <i class="bi bi-info-circle mt-1" aria-hidden="true"></i>
                        <span id="reportDescText"></span>
                    </div>
                </div>

                <div class="mt-3">
                    <label class="form-label" for="reportDetails">More details <span class="text-muted fw-normal">(optional)</span></label>
                    <textarea class="form-control" id="reportDetails" name="details" rows="3" maxlength="500" style="border-radius: 12px; font-size: 1rem; resize: vertical;" placeholder="Tell us more about what happened"></textarea>
                    <div class="text-end text-muted mt-1" style="font-size: 0.75rem;"><span id="reportDetailsCount">0</span>/500</div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light rounded-pill px-4 fw-semibold" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-danger rounded-pill px-4 fw-bold"><i class="bi bi-send me-1" aria-hidden="true"></i> Submit Report</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openReportModal() {
        var el = document.getElementById('reportModal');
        if (el && window.bootstrap) {
            bootstrap.Modal.getOrCreateInstance(el).show();
        }
    }
    (function () {
        var select = document.getElementById('reportIssue');
        var box = document.getElementById('reportDesc');
        var text = document.getElementById('reportDescText');
        var modal = document.getElementById('reportModal');
        if (!select || !box || !text) return;
        select.addEventListener('change', function () {
            var opt = select.options[select.selectedIndex];
            var desc = opt ? opt.getAttribute('data-desc') : '';
            text.textContent = desc || '';
            box.classList.toggle('show', !!desc);
        });
        var details = document.getElementById('reportDetails');
        var counter = document.getElementById('reportDetailsCount');
        if (details && counter) {
            details.addEventListener('input', function () { counter.textContent = details.value.length; });
        }
        if (modal) {
            modal.addEventListener('hidden.bs.modal', function () {
                if (details) { details.value = ''; if (counter) counter.textContent = '0'; }
                select.selectedIndex = 0;
                box.classList.remove('show');
            });
        }
    })();
</script>
