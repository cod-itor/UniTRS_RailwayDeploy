<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="modal fade" id="courseSessionsModal" tabindex="-1" aria-labelledby="courseSessionsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content rounded-4 border-0 shadow-xl overflow-hidden">
            <div class="modal-header border-bottom py-3 px-3 px-md-4 bg-light bg-opacity-75 d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center gap-2.5">
                    <div class="p-2 rounded-3 bg-primary bg-opacity-10 text-primary">
                        <i class="bi bi-calendar3-range fs-5"></i>
                    </div>
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-0.5">
                            <span class="badge bg-primary text-white rounded-pill px-2.5 py-0.5" id="csmCourseCode" style="font-size:0.75rem;">-</span>
                            <span class="badge bg-light text-dark border rounded-pill px-2 py-0.5" id="csmShiftBadge" style="font-size:0.72rem;">-</span>
                            <span class="badge bg-secondary-subtle text-secondary rounded-pill px-2 py-0.5" id="csmTermBadge" style="font-size:0.72rem;">-</span>
                        </div>
                        <h5 class="modal-title fw-bold text-dark mb-0 fs-6" id="csmCourseTitle">-</h5>
                    </div>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <div class="modal-body p-3 p-md-4 bg-light bg-opacity-50">
                <div class="p-3 bg-white rounded-3 border mb-3 shadow-xs">
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">
                        <div class="d-flex flex-wrap align-items-center gap-3 text-muted small" style="font-size:0.82rem;">
                            <span id="csmRoomMeta"><i class="bi bi-door-open text-primary me-1"></i> Room -</span>
                            <span id="csmProfMeta"><i class="bi bi-person text-secondary me-1"></i> -</span>
                            <span id="csmTimeMeta"><i class="bi bi-clock text-info me-1"></i> -</span>
                        </div>
                        <div id="csmProfActionWrap" style="display:none;">
                            <button type="button" class="btn btn-sm btn-primary rounded-pill px-3 py-1.5 fw-semibold d-inline-flex align-items-center gap-1.5 shadow-xs" onclick="openAddExtraClassModal()">
                                <i class="bi bi-calendar-plus"></i> Add Extra / Make-up Class
                            </button>
                        </div>
                    </div>

                    <div class="row g-2 mt-3 pt-3 border-top text-center" id="csmStatsRow">
                        <div class="col-3">
                            <div class="p-2 bg-light rounded-3">
                                <div class="text-muted small" style="font-size:0.72rem;">Total Sessions</div>
                                <div class="fw-bolder fs-6 text-dark" id="csmStatTotal">15</div>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="p-2 rounded-3" style="background:#f0fdf4;">
                                <div class="text-success small" style="font-size:0.72rem;">Conducted</div>
                                <div class="fw-bolder fs-6 text-success" id="csmStatConducted">0</div>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="p-2 rounded-3" style="background:#fef2f2;">
                                <div class="text-danger small" style="font-size:0.72rem;">Cancelled</div>
                                <div class="fw-bolder fs-6 text-danger" id="csmStatCancelled">0</div>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="p-2 rounded-3" style="background:#eff6ff;">
                                <div class="text-primary small" style="font-size:0.72rem;">Remaining</div>
                                <div class="fw-bolder fs-6 text-primary" id="csmStatRemaining">15</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex align-items-center justify-content-between mb-2.5 px-1">
                    <h6 class="fw-bold text-dark mb-0 d-flex align-items-center gap-1.5" style="font-size:0.88rem;">
                        <i class="bi bi-list-check text-primary"></i> 15-Week Academic Schedule
                    </h6>
                    <span class="text-muted small" style="font-size:0.75rem;">Showing start to 15th session</span>
                </div>

                <div class="d-flex flex-column gap-2.5" id="sessionsModalCardsContainer">
                </div>
            </div>

            <div class="modal-footer border-top py-2.5 px-3 bg-white d-flex justify-content-between">
                <span class="text-muted small" style="font-size:0.75rem;">
                    <i class="bi bi-info-circle me-1"></i>Upcoming sessions are highlighted; future sessions are scheduled.
                </span>
                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addExtraClassModal" tabindex="-1" aria-labelledby="addExtraClassModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header border-0 pb-0">
                <h6 class="modal-title fw-bold text-dark" id="addExtraClassModalLabel">
                    <i class="bi bi-calendar-plus me-1.5 text-primary"></i>Add Extra Class
                </h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/professor/attendance/add-extra" method="post" id="addExtraClassForm" class="m-0">
                <input type="hidden" name="classSectionId" id="extraClassSectionId" value="">
                <input type="hidden" name="tab" value="schedule">
                <div class="modal-body pt-2 pb-3">
                    <p class="small text-muted mb-3" style="font-size:0.8rem;">
                        Schedule an extra lecture or make-up class to ensure the full 15-week curriculum is completed.
                    </p>
                    <div class="mb-3">
                        <label for="extraSessionDateInput" class="form-label fw-bold text-dark small">Session Date</label>
                        <input type="date" class="form-control rounded-3" id="extraSessionDateInput" name="sessionDate" required>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0 bg-light rounded-bottom-4">
                    <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-sm btn-primary rounded-pill px-4 fw-bold shadow-xs">Schedule Session</button>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
.session-card-item {
    background: #ffffff;
    border-radius: 12px;
    border: 1px solid #e2e8f0;
    padding: 14px 16px;
    transition: all 0.2s ease;
    position: relative;
    overflow: hidden;
}
.session-card-item.status-attended {
    border-left: 4px solid #10b981 !important;
}
.session-card-item.status-cancelled {
    border-left: 4px solid #ef4444 !important;
    background-color: #fef2f2;
    border-style: dashed;
}
.session-card-item.status-upcoming {
    border-left: 4px solid #2563eb !important;
    background: #eff6ff;
    box-shadow: 0 4px 14px -3px rgba(37, 99, 235, 0.2);
}
.session-card-item.status-grayed {
    opacity: 0.62;
    background: #f8fafc;
    border-color: #cbd5e1;
}
.session-num-badge {
    font-size: 0.72rem;
    font-weight: 700;
    padding: 2px 8px;
    border-radius: 99px;
    background: #f1f5f9;
    color: #475569;
}
.session-card-item.status-upcoming .session-num-badge {
    background: #2563eb;
    color: #ffffff;
}
.session-card-item.status-cancelled .session-num-badge {
    background: #fee2e2;
    color: #991b1b;
}
</style>

<script>
var _activeCourseSessionsData = null;
var _activeIsProfessor = false;

function calculateCourse15Sessions(course) {
    var shiftTimes = {
        'MORNING': { start: '08:00 AM', end: '11:15 AM', half1Start: '08:00 AM', half1End: '09:30 AM', half2Start: '09:45 AM', half2End: '11:15 AM', label: 'Morning' },
        'AFTERNOON': { start: '02:00 PM', end: '05:15 PM', half1Start: '02:00 PM', half1End: '03:30 PM', half2Start: '03:45 PM', half2End: '05:15 PM', label: 'Afternoon' },
        'EVENING': { start: '05:45 PM', end: '08:45 PM', half1Start: '05:45 PM', half1End: '07:15 PM', half2Start: '07:30 PM', half2End: '08:45 PM', label: 'Evening' },
        'WEEKEND': { start: '08:00 AM', end: '04:30 PM', half1Start: '08:00 AM', half1End: '12:00 PM', half2Start: '12:15 PM', half2End: '04:30 PM', label: 'Weekend' }
    };
    var shiftKey = (course.shift || 'MORNING').toUpperCase();
    var shiftInfo = shiftTimes[shiftKey] || shiftTimes['MORNING'];

    var termNumber = 1;
    if (course.termName) {
        var match = course.termName.match(/\d+/);
        if (match) termNumber = parseInt(match[0], 10);
    }
    var isEndTerm = (termNumber > 0 && termNumber % 3 === 0);

    var daysStr = (course.days || course.daysOfWeek || 'mon').toLowerCase();
    var courseIndex = 0;
    if (daysStr.indexOf('mon') !== -1) courseIndex = 0;
    else if (daysStr.indexOf('wed') !== -1) courseIndex = (isEndTerm ? 1 : 2);
    else if (daysStr.indexOf('thu') !== -1) courseIndex = (isEndTerm ? 2 : 3);
    else if (daysStr.indexOf('tue') !== -1) courseIndex = 1;
    else if (daysStr.indexOf('fri') !== -1) courseIndex = (isEndTerm ? 2 : 4);

    var startYear = 2026;
    if (course.academicYear) {
        var ym = course.academicYear.match(/\d{4}/);
        if (ym) startYear = parseInt(ym[0], 10);
    }
    var startMonth = 8;
    if (termNumber === 2 || termNumber === 5 || termNumber === 8 || termNumber === 11) startMonth = 0;
    else if (termNumber === 3 || termNumber === 6 || termNumber === 9 || termNumber === 12) startMonth = 4;

    var baseDate = new Date(startYear, startMonth, 1);
    while (baseDate.getDay() !== 1) {
        baseDate.setDate(baseDate.getDate() + 1);
    }
    var firstMonday = new Date(baseDate.getFullYear(), baseDate.getMonth(), baseDate.getDate());

    var records = course.records || [];
    var scheduledDatesSet = {};
    var sessions = [];
    var sessionNumber = 1;

    function pushSession(sDate, tStart, tEnd) {
        var yyyy = sDate.getFullYear();
        var mm = String(sDate.getMonth() + 1).padStart(2, '0');
        var dd = String(sDate.getDate()).padStart(2, '0');
        var iso = yyyy + '-' + mm + '-' + dd;
        scheduledDatesSet[iso] = true;
        sessions.push({
            sessionNumber: sessionNumber++,
            isExtra: false,
            dateObj: sDate,
            dateIso: iso,
            timeStart: tStart,
            timeEnd: tEnd,
            timeLabel: tStart + ' - ' + tEnd
        });
    }

    for (var w = 0; w < 15; w++) {
        var weekMonday = new Date(firstMonday.getFullYear(), firstMonday.getMonth(), firstMonday.getDate() + (w * 7));
        
        if (!isEndTerm) {
            var sDate = new Date(weekMonday.getFullYear(), weekMonday.getMonth(), weekMonday.getDate() + courseIndex);
            pushSession(sDate, shiftInfo.start, shiftInfo.end);
        } else {
            if (courseIndex === 0) {
                var d1 = new Date(weekMonday.getFullYear(), weekMonday.getMonth(), weekMonday.getDate());
                pushSession(d1, shiftInfo.start, shiftInfo.end);
                var d2 = new Date(weekMonday.getFullYear(), weekMonday.getMonth(), weekMonday.getDate() + 1);
                pushSession(d2, shiftInfo.half1Start, shiftInfo.half1End);
            } else if (courseIndex === 1) {
                var d1 = new Date(weekMonday.getFullYear(), weekMonday.getMonth(), weekMonday.getDate() + 1);
                pushSession(d1, shiftInfo.half2Start, shiftInfo.half2End);
                var d2 = new Date(weekMonday.getFullYear(), weekMonday.getMonth(), weekMonday.getDate() + 2);
                pushSession(d2, shiftInfo.start, shiftInfo.end);
            } else if (courseIndex === 2) {
                var d1 = new Date(weekMonday.getFullYear(), weekMonday.getMonth(), weekMonday.getDate() + 3);
                pushSession(d1, shiftInfo.start, shiftInfo.end);
                var d2 = new Date(weekMonday.getFullYear(), weekMonday.getMonth(), weekMonday.getDate() + 4);
                pushSession(d2, shiftInfo.half1Start, shiftInfo.half1End);
            }
        }
    }

    var extraCounter = 16;
    records.forEach(function(r) {
        var dStr = r.sessionDate || r.date;
        if (dStr && !scheduledDatesSet[dStr]) {
            scheduledDatesSet[dStr] = true;
            var parts = dStr.split('-');
            var extraDate = new Date(parseInt(parts[0], 10), parseInt(parts[1], 10) - 1, parseInt(parts[2], 10));
            sessions.push({
                sessionNumber: extraCounter++,
                isExtra: true,
                dateObj: extraDate,
                dateIso: dStr,
                timeStart: shiftInfo.start,
                timeEnd: shiftInfo.end,
                timeLabel: shiftInfo.start + ' - ' + shiftInfo.end
            });
        }
    });

    sessions.sort(function(a, b) {
        return a.dateObj - b.dateObj;
    });

    var today = new Date();
    today.setHours(0, 0, 0, 0);

    var upcomingAssigned = false;
    for (var k = 0; k < sessions.length; k++) {
        var ses = sessions[k];
        var sDate = new Date(ses.dateObj.getFullYear(), ses.dateObj.getMonth(), ses.dateObj.getDate());
        sDate.setHours(0, 0, 0, 0);

        var rec = records.find(function(r) {
            return (r.sessionDate || r.date) === ses.dateIso;
        });
        ses.record = rec || null;

        if (course.studentAttendance && course.studentAttendance[ses.dateIso]) {
            ses.studentStatus = course.studentAttendance[ses.dateIso];
        } else if (rec && rec.studentStatus) {
            ses.studentStatus = rec.studentStatus;
        } else {
            ses.studentStatus = null;
        }

        if (rec) {
            ses.status = 'ATTENDED';
            ses.isPast = true;
            ses.isUpcoming = false;
            ses.isGrayedOut = false;
        } else if (sDate < today) {
            ses.status = 'CANCELLED';
            ses.isPast = true;
            ses.isUpcoming = false;
            ses.isGrayedOut = false;
        } else if (!upcomingAssigned && sDate >= today) {
            ses.status = 'UPCOMING';
            ses.isPast = false;
            ses.isUpcoming = true;
            ses.isGrayedOut = false;
            upcomingAssigned = true;
        } else {
            ses.status = 'SCHEDULED';
            ses.isPast = false;
            ses.isUpcoming = false;
            ses.isGrayedOut = true;
        }
    }

    return sessions;
}

function formatSessionDate(dateObj) {
    var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    var dayName = days[dateObj.getDay()];
    var monthName = months[dateObj.getMonth()];
    var dateNum = dateObj.getDate();
    var year = dateObj.getFullYear();
    return dayName + ', ' + monthName + ' ' + dateNum + ', ' + year;
}

function renderCourseSessionsModalUI(course, isProfessor) {
    _activeCourseSessionsData = course;
    _activeIsProfessor = isProfessor;

    document.getElementById('csmCourseCode').textContent = course.code || '';
    document.getElementById('csmCourseTitle').textContent = course.title || '';
    document.getElementById('csmShiftBadge').textContent = course.shift || 'Regular Shift';
    document.getElementById('csmTermBadge').textContent = course.termName || course.term || 'Current Term';

    document.getElementById('csmRoomMeta').innerHTML = '<i class="bi bi-door-open text-primary me-1"></i> Room ' + (course.room || 'TBA');
    if (isProfessor) {
        document.getElementById('csmProfMeta').innerHTML = '<i class="bi bi-people text-success me-1"></i> ' + (course.studentCount || 0) + ' Students Enrolled';
        document.getElementById('csmProfActionWrap').style.display = 'block';
    } else {
        document.getElementById('csmProfMeta').innerHTML = '<i class="bi bi-person text-secondary me-1"></i> ' + (course.prof || course.professor || 'Instructor');
        document.getElementById('csmProfActionWrap').style.display = 'none';
    }
    document.getElementById('csmTimeMeta').innerHTML = '<i class="bi bi-clock text-info me-1"></i> ' + (course.shift || 'Morning');

    var sessions = calculateCourse15Sessions(course);

    var conductedCount = 0;
    var cancelledCount = 0;
    var remainingCount = 0;
    sessions.forEach(function(s) {
        if (s.status === 'ATTENDED') conductedCount++;
        else if (s.status === 'CANCELLED') cancelledCount++;
        else remainingCount++;
    });

    document.getElementById('csmStatTotal').textContent = sessions.length;
    document.getElementById('csmStatConducted').textContent = conductedCount;
    document.getElementById('csmStatCancelled').textContent = cancelledCount;
    document.getElementById('csmStatRemaining').textContent = remainingCount;

    var container = document.getElementById('sessionsModalCardsContainer');
    var html = '';

    sessions.forEach(function(s) {
        var cardClass = 'session-card-item';
        if (s.status === 'ATTENDED') cardClass += ' status-attended';
        else if (s.status === 'CANCELLED') cardClass += ' status-cancelled';
        else if (s.status === 'UPCOMING') cardClass += ' status-upcoming';
        else if (s.isGrayedOut) cardClass += ' status-grayed';

        var formattedDate = formatSessionDate(s.dateObj);
        var labelText = s.isExtra ? 'Make-up Session' : 'Session ' + s.sessionNumber;

        html += '<div class="' + cardClass + '">';
        html += '  <div class="d-flex flex-column flex-sm-row align-items-start align-items-sm-center justify-content-between gap-2">';
        html += '    <div>';
        html += '      <div class="d-flex align-items-center gap-2 mb-1">';
        html += '        <span class="session-num-badge">' + labelText + '</span>';
        html += '        <span class="fw-bold text-dark" style="font-size:0.9rem;">' + formattedDate + '</span>';
        if (s.isExtra) {
            html += '        <span class="badge bg-warning text-dark rounded-pill" style="font-size:0.65rem;">Extra Class</span>';
        }
        html += '      </div>';
        html += '      <div class="text-muted small d-flex align-items-center gap-3" style="font-size:0.78rem;">';
        html += '        <span><i class="bi bi-clock me-1 text-primary"></i>' + s.timeLabel + '</span>';
        html += '        <span><i class="bi bi-geo-alt me-1 text-secondary"></i>Room ' + (course.room || 'TBA') + '</span>';
        html += '      </div>';
        html += '    </div>';

        html += '    <div class="d-flex align-items-center gap-2 text-sm-end">';
        if (isProfessor) {
            if (s.status === 'ATTENDED') {
                var pCount = s.record ? (s.record.presentCount || 0) : 0;
                var aCount = s.record ? (s.record.absentCount || 0) : 0;
                html += '      <div>';
                html += '        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-2.5 py-1" style="font-size:0.72rem;"><i class="bi bi-check-circle-fill me-1"></i>Conducted</span>';
                html += '        <div class="text-muted" style="font-size:0.7rem;">' + pCount + ' Present &bull; ' + aCount + ' Absent</div>';
                html += '      </div>';
                html += '      <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-2.5 py-1" style="font-size:0.72rem;" onclick="openTakeAttendanceForDate(' + course.id + ', \'' + s.dateIso + '\')"><i class="bi bi-pencil me-1"></i>Edit</button>';
            } else if (s.status === 'CANCELLED') {
                html += '      <div>';
                html += '        <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-2.5 py-1" style="font-size:0.72rem;"><i class="bi bi-slash-circle me-1"></i>Cancelled Class</span>';
                html += '        <div class="text-muted" style="font-size:0.68rem;">No attendance held</div>';
                html += '      </div>';
                html += '      <button type="button" class="btn btn-sm btn-warning text-dark fw-bold rounded-pill px-2.5 py-1 shadow-xs" style="font-size:0.72rem;" onclick="openAddExtraClassModal(' + course.id + ', \'' + s.dateIso + '\')"><i class="bi bi-calendar-plus me-1"></i>Add Extra</button>';
            } else if (s.status === 'UPCOMING') {
                html += '      <span class="badge bg-primary text-white rounded-pill px-3 py-1.5 shadow-xs" style="font-size:0.75rem;"><i class="bi bi-star-fill me-1"></i>Upcoming Class</span>';
                html += '      <button type="button" class="btn btn-sm btn-primary rounded-pill px-2.5 py-1 fw-bold shadow-xs" style="font-size:0.72rem;" onclick="openTakeAttendanceForDate(' + course.id + ', \'' + s.dateIso + '\')"><i class="bi bi-clipboard-check me-1"></i>Take</button>';
            } else {
                html += '      <span class="badge bg-light text-muted border rounded-pill px-2.5 py-1" style="font-size:0.72rem;">Scheduled</span>';
            }
        } else {
            if (s.status === 'ATTENDED') {
                var st = (s.studentStatus || 'PRESENT').toUpperCase();
                if (st === 'PRESENT') {
                    html += '      <span class="badge bg-success text-white rounded-pill px-2.5 py-1" style="font-size:0.75rem;"><i class="bi bi-check-circle-fill me-1"></i>Present</span>';
                } else if (st === 'LATE') {
                    html += '      <span class="badge bg-warning text-dark rounded-pill px-2.5 py-1" style="font-size:0.75rem;"><i class="bi bi-clock-fill me-1"></i>Late</span>';
                } else if (st === 'ABSENT') {
                    html += '      <span class="badge bg-danger text-white rounded-pill px-2.5 py-1" style="font-size:0.75rem;"><i class="bi bi-x-circle-fill me-1"></i>Absent</span>';
                } else if (st === 'EXCUSED') {
                    html += '      <span class="badge bg-info text-white rounded-pill px-2.5 py-1" style="font-size:0.75rem;"><i class="bi bi-shield-check me-1"></i>Excused</span>';
                } else {
                    html += '      <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-2.5 py-1" style="font-size:0.75rem;"><i class="bi bi-check2 me-1"></i>Held</span>';
                }
            } else if (s.status === 'CANCELLED') {
                html += '      <div>';
                html += '        <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-2.5 py-1" style="font-size:0.75rem;"><i class="bi bi-slash-circle me-1"></i>Cancelled Class</span>';
                html += '        <div class="text-muted text-end" style="font-size:0.68rem;">Professor did not hold attendance</div>';
                html += '      </div>';
            } else if (s.status === 'UPCOMING') {
                html += '      <span class="badge bg-primary text-white rounded-pill px-3 py-1.5 shadow-xs" style="font-size:0.75rem;"><i class="bi bi-star-fill me-1"></i>Upcoming Class</span>';
            } else {
                html += '      <span class="badge bg-light text-muted border rounded-pill px-2.5 py-1" style="font-size:0.72rem;">Scheduled</span>';
            }
        }
        html += '    </div>';
        html += '  </div>';
        html += '</div>';
    });

    container.innerHTML = html;

    var modalEl = document.getElementById('courseSessionsModal');
    var modal = bootstrap.Modal.getInstance(modalEl) || new bootstrap.Modal(modalEl);
    modal.show();
}

function openAddExtraClassModal(sectionId, suggestedDate) {
    var sid = sectionId || (_activeCourseSessionsData ? _activeCourseSessionsData.id : null);
    if (!sid) return;
    document.getElementById('extraClassSectionId').value = sid;
    var dateInput = document.getElementById('extraSessionDateInput');
    if (suggestedDate) {
        dateInput.value = suggestedDate;
    } else {
        dateInput.valueAsDate = new Date();
    }
    var modalEl = document.getElementById('addExtraClassModal');
    var modal = bootstrap.Modal.getInstance(modalEl) || new bootstrap.Modal(modalEl);
    modal.show();
}

function openTakeAttendanceForDate(sectionId, dateIso) {
    var csmModal = bootstrap.Modal.getInstance(document.getElementById('courseSessionsModal'));
    if (csmModal) csmModal.hide();

    var targetModalId = 'attendanceModal' + sectionId;
    var attModalEl = document.getElementById(targetModalId);
    if (attModalEl) {
        var dateInput = document.getElementById('sessionDate_' + sectionId);
        if (dateInput && dateIso) {
            dateInput.value = dateIso;
        }
        var m = bootstrap.Modal.getInstance(attModalEl) || new bootstrap.Modal(attModalEl);
        m.show();
    } else if (typeof openClassRollCall === 'function') {
        currentActiveSectionId = sectionId;
        openSubSheet('attendanceSheet');
        var mobileInput = document.querySelector('#attendanceSheet_' + sectionId + ' .att-date-input');
        if (mobileInput && dateIso) mobileInput.value = dateIso;
    }
}
</script>
