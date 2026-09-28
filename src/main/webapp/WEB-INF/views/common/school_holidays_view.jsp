<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
.holiday-container-wrap {
    width: 100%;
    box-sizing: border-box;
    font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    padding: 0.25rem 0 2rem;
}
.holiday-header-bar {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 1rem;
    padding: 1.25rem 1.5rem;
    margin-bottom: 1.25rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
}
.holiday-next-hero {
    background: linear-gradient(135deg, #0f172a 0%, #1e293b 55%, #0369a1 100%);
    color: #ffffff;
    border-radius: 1rem;
    padding: 1.35rem 1.6rem;
    position: relative;
    overflow: hidden;
    margin-bottom: 1.5rem;
    box-shadow: 0 4px 20px -2px rgba(15, 23, 42, 0.15);
}
.holiday-filter-bar {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
    gap: 0.75rem;
    margin-bottom: 1.5rem;
}
.holiday-toggle-pill {
    border-radius: 9999px;
    padding: 0.45rem 1.15rem;
    font-size: 0.82rem;
    font-weight: 600;
    border: 1px solid #e2e8f0;
    background: #ffffff;
    color: #475569;
    cursor: pointer;
    transition: all 0.15s ease;
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
}
.holiday-toggle-pill:hover {
    background: #f8fafc;
    color: #0f172a;
    border-color: #cbd5e1;
}
.holiday-toggle-pill.active {
    background: #0f172a;
    color: #ffffff;
    border-color: #0f172a;
    box-shadow: 0 2px 6px rgba(15, 23, 42, 0.15);
}
.holiday-search-wrap {
    position: relative;
    min-width: 240px;
}
.holiday-search-wrap input {
    height: 38px;
    border-radius: 9999px;
    padding-left: 2.25rem;
    padding-right: 1rem;
    font-size: 0.82rem;
    border: 1px solid #e2e8f0;
    transition: all 0.15s ease;
}
.holiday-search-wrap input:focus {
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
}
.holiday-search-wrap i {
    position: absolute;
    left: 0.85rem;
    top: 50%;
    transform: translateY(-50%);
    color: #94a3b8;
    font-size: 0.85rem;
}
.holiday-card-box {
    border: 1px solid #e2e8f0;
    border-radius: 1rem;
    background: #ffffff;
    padding: 1.5rem;
    transition: transform 0.18s ease, box-shadow 0.18s ease, border-color 0.18s ease;
    height: 100%;
    display: flex;
    align-items: flex-start;
    gap: 1.25rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
}
.holiday-card-box:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 22px -4px rgba(15, 23, 42, 0.08);
    border-color: #cbd5e1;
}
.holiday-card-box.is-festival {
    border-left: 4px solid #f59e0b;
}
.holiday-card-box.is-upcoming {
    border-left: 4px solid #0284c7;
}
.holiday-card-box.is-past {
    opacity: 0.82;
    background: #f8fafc;
    border-left: 4px solid #cbd5e1;
}
.holiday-date-badge {
    min-width: 64px;
    width: 76px;
    height: 76px;
    gap: 4px;
    border-radius: 0.85rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    flex-shrink: 0;
    box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.04);
}
.holiday-date-badge .h-mo {
    font-size: 0.68rem;
    font-weight: 800;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    line-height: normal;
}
.holiday-date-badge .h-dy {
    font-size: 1.25rem;
    font-weight: 800;
    line-height: normal;
    margin-top: 0;
    font-variant-numeric: tabular-nums;
}
.holiday-date-badge .h-dy.is-range {
    font-size: 0.95rem;
    letter-spacing: -0.03em;
}
.holiday-card-title {
    font-size: 0.95rem;
    font-weight: 700;
    color: #0f172a;
    line-height: 1.35;
    margin: 0.25rem 0 0.2rem;
    word-break: normal;
    overflow-wrap: break-word;
}
.holiday-card-meta {
    font-size: 0.78rem;
    color: #64748b;
    line-height: 1.35;
    margin: 0;
    word-break: normal;
    overflow-wrap: break-word;
}
.holiday-badge {
    font-size: 0.7rem;
    font-weight: 600;
    padding: 0.2rem 0.55rem;
    border-radius: 6px;
    line-height: 1.2;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
}
@media (max-width: 768px) {
    .holiday-header-bar {
        padding: 1rem 1.15rem;
        margin-bottom: 1rem;
    }
    .holiday-next-hero {
        padding: 1.15rem 1.25rem;
        margin-bottom: 1.25rem;
    }
    .holiday-card-box {
        padding: 0.9rem 1rem;
        gap: 0.85rem;
    }
    .holiday-date-badge {
        min-width: 58px;
        width: 66px;
        height: 66px;
    }
    .holiday-date-badge .h-dy {
        font-size: 1.15rem;
    }
    .holiday-date-badge .h-dy.is-range {
        font-size: 0.88rem;
    }
    .holiday-card-title {
        font-size: 0.9rem;
    }
    .holiday-card-meta {
        font-size: 0.74rem;
    }
    .holiday-search-wrap {
        width: 100%;
        min-width: 100%;
    }
}
</style>

<div class="holiday-container-wrap" id="holidaysPageViewContainer">
    <div class="holiday-header-bar d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3">
        <div>
            <div class="d-flex align-items-center gap-2 mb-1">
                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-2.5 py-1 fw-bold text-uppercase" style="font-size:0.68rem; letter-spacing:0.04em;">
                    <i class="bi bi-calendar-heart me-1"></i>Official University Calendar
                </span>
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-2.5 py-1 fw-bold" style="font-size:0.68rem;">
                    2026 Academic Year
                </span>
            </div>
            <h2 class="h4 fw-bold text-dark mb-1" style="letter-spacing:-0.02em;">School & National Holidays</h2>
            <p class="text-muted small mb-0">Official public holidays, royal celebrations, and academic breaks for students, faculty, and administration</p>
        </div>

        
    </div>

    <div class="holiday-next-hero">
        <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between gap-3">
            <div>
                <div class="d-flex flex-wrap align-items-center gap-2 mb-1.5">
                    <span class="badge bg-warning text-dark fw-bold rounded-pill px-2.5 py-1 text-uppercase" style="font-size:0.65rem; letter-spacing:0.04em;">Next Upcoming Holiday</span>
                    <span class="next-holiday-countdown badge bg-white text-dark rounded-pill px-2.5 py-1 fw-semibold" style="font-size:0.7rem;">Calculating...</span>
                </div>
                <h3 class="next-holiday-title fw-bold mb-1 fs-4 text-white">Pchum Ben Festival</h3>
                <div class="next-holiday-subtitle text-white-50" style="font-size:0.85rem;">October 10, 11, 12, 2026 &bull; 3 Days Off &bull; Campus Closed</div>
            </div>
            <div class="text-md-end">
                <span class="badge bg-white text-dark border border-white border-opacity-25 rounded-pill px-3 py-2 small fw-semibold d-inline-flex align-items-center gap-1.5">
                    <i class="bi bi-door-closed"></i> Classes Suspended
                </span>
            </div>
        </div>
    </div>

    <div class="holiday-filter-bar">
        <div class="d-flex align-items-center gap-1.5">
            <button type="button" class="holiday-toggle-pill active" data-filter="upcoming">
                <i class="bi bi-calendar-check text-primary"></i> Upcoming (6)
            </button>
            <button type="button" class="holiday-toggle-pill" data-filter="all">
                <i class="bi bi-calendar3"></i> All Year (15)
            </button>
        </div>

        <div class="holiday-search-wrap">
            <i class="bi bi-search"></i>
            <input type="text" class="holiday-search-input form-control form-control-sm" placeholder="Search holidays or months...">
        </div>
    </div>

    <div class="upcoming-section mb-4">
        <div class="d-flex align-items-center justify-content-between mb-3">
            <h6 class="fw-bold text-dark mb-0 d-flex align-items-center gap-2" style="font-size:0.95rem;">
                <i class="bi bi-calendar-event text-primary fs-6"></i>
                Upcoming Holidays & Observances
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-2.5 py-0.5 upcoming-count-badge" style="font-size:0.7rem;">6</span>
            </h6>
        </div>

        <div class="row g-3 upcoming-cards-row">
            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="upcoming" data-start="2026-10-10" data-end="2026-10-12" data-name="Pchum Ben Festival">
                <div class="holiday-card-box is-festival is-upcoming">
                    <div class="holiday-date-badge bg-warning bg-opacity-15 text-warning-emphasis">
                        <span class="h-mo">OCT</span>
                        <span class="h-dy is-range">10–12</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#fef3c7; color:#92400e;">3 Days Off</span>
                        </div>
                        <h4 class="holiday-card-title">Pchum Ben Festival</h4>
                        <p class="holiday-card-meta">Saturday – Monday &bull; Traditional Ancestral Rite</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="upcoming" data-start="2026-10-15" data-end="2026-10-15" data-name="Commemoration Day of the Late King-Father">
                <div class="holiday-card-box is-upcoming">
                    <div class="holiday-date-badge" style="background:#ede9fe; color:#6b21a8;">
                        <span class="h-mo">OCT</span>
                        <span class="h-dy">15</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#475569;">1 Day Off</span>
                        </div>
                        <h4 class="holiday-card-title">Commemoration Day of King-Father</h4>
                        <p class="holiday-card-meta">Thursday &bull; Late King Norodom Sihanouk Memorial</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="upcoming" data-start="2026-10-29" data-end="2026-10-29" data-name="King Norodom Sihamoni's Coronation Day">
                <div class="holiday-card-box is-upcoming">
                    <div class="holiday-date-badge" style="background:#ede9fe; color:#6b21a8;">
                        <span class="h-mo">OCT</span>
                        <span class="h-dy">29</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#475569;">1 Day Off</span>
                        </div>
                        <h4 class="holiday-card-title">King Norodom Sihamoni's Coronation Day</h4>
                        <p class="holiday-card-meta">Thursday &bull; 22nd Royal Enthronement Anniversary</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="upcoming" data-start="2026-11-09" data-end="2026-11-09" data-name="National Independence Day">
                <div class="holiday-card-box is-upcoming">
                    <div class="holiday-date-badge bg-primary bg-opacity-10 text-primary">
                        <span class="h-mo">NOV</span>
                        <span class="h-dy">09</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#475569;">1 Day Off</span>
                        </div>
                        <h4 class="holiday-card-title">National Independence Day</h4>
                        <p class="holiday-card-meta">Monday &bull; 73rd National Independence Celebration</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="upcoming" data-start="2026-11-23" data-end="2026-11-25" data-name="Water Festival (Bon Om Touk)">
                <div class="holiday-card-box is-festival is-upcoming">
                    <div class="holiday-date-badge bg-warning bg-opacity-15 text-warning-emphasis">
                        <span class="h-mo">NOV</span>
                        <span class="h-dy is-range">23–25</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#fef3c7; color:#92400e;">3 Days Off</span>
                        </div>
                        <h4 class="holiday-card-title">Water Festival (Bon Om Touk)</h4>
                        <p class="holiday-card-meta">Monday – Wednesday &bull; Traditional Boat Races</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="upcoming" data-start="2026-12-29" data-end="2026-12-29" data-name="Peace Day in Cambodia">
                <div class="holiday-card-box is-upcoming">
                    <div class="holiday-date-badge bg-success bg-opacity-10 text-success">
                        <span class="h-mo">DEC</span>
                        <span class="h-dy">29</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#475569;">1 Day Off</span>
                        </div>
                        <h4 class="holiday-card-title">Peace Day in Cambodia</h4>
                        <p class="holiday-card-meta">Tuesday &bull; National Reconciliation & Peace Day</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="past-section" style="display:none;">
        <div class="d-flex align-items-center justify-content-between mb-3 pt-3 border-top">
            <h6 class="fw-bold text-muted mb-0 d-flex align-items-center gap-2" style="font-size:0.92rem;">
                <i class="bi bi-clock-history text-secondary"></i>
                Past Holidays (2026)
                <span class="badge bg-secondary bg-opacity-10 text-secondary border rounded-pill px-2.5 py-0.5" style="font-size:0.7rem;">9</span>
            </h6>
        </div>

        <div class="row g-3 past-cards-row">
            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="past" data-start="2026-01-01" data-end="2026-01-01" data-name="International New Year's Day">
                <div class="holiday-card-box is-past">
                    <div class="holiday-date-badge bg-secondary bg-opacity-10 text-secondary">
                        <span class="h-mo">JAN</span>
                        <span class="h-dy">01</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#64748b;">Past</span>
                        </div>
                        <h4 class="holiday-card-title text-muted">International New Year's Day</h4>
                        <p class="holiday-card-meta">Thursday &bull; Global Calendar Observance</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="past" data-start="2026-01-07" data-end="2026-01-07" data-name="Victory over Genocide Day">
                <div class="holiday-card-box is-past">
                    <div class="holiday-date-badge bg-secondary bg-opacity-10 text-secondary">
                        <span class="h-mo">JAN</span>
                        <span class="h-dy">07</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#64748b;">Past</span>
                        </div>
                        <h4 class="holiday-card-title text-muted">Victory over Genocide Day</h4>
                        <p class="holiday-card-meta">Wednesday &bull; National Liberation Day</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="past" data-start="2026-03-08" data-end="2026-03-08" data-name="International Women's Rights Day">
                <div class="holiday-card-box is-past">
                    <div class="holiday-date-badge bg-secondary bg-opacity-10 text-secondary">
                        <span class="h-mo">MAR</span>
                        <span class="h-dy">08</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#64748b;">Past</span>
                        </div>
                        <h4 class="holiday-card-title text-muted">International Women's Rights Day</h4>
                        <p class="holiday-card-meta">Sunday &bull; Global Women's Rights Observance</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="past" data-start="2026-04-14" data-end="2026-04-16" data-name="Khmer New Year (Chaul Chnam Thmey)">
                <div class="holiday-card-box is-past">
                    <div class="holiday-date-badge bg-secondary bg-opacity-10 text-secondary">
                        <span class="h-mo">APR</span>
                        <span class="h-dy is-range">14–16</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#64748b;">Past</span>
                        </div>
                        <h4 class="holiday-card-title text-muted">Khmer New Year (Chaul Chnam Thmey)</h4>
                        <p class="holiday-card-meta">Tuesday – Thursday &bull; Traditional Solar New Year</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="past" data-start="2026-05-01" data-end="2026-05-01" data-name="International Labor Day & Visak Bochea Day">
                <div class="holiday-card-box is-past">
                    <div class="holiday-date-badge bg-secondary bg-opacity-10 text-secondary">
                        <span class="h-mo">MAY</span>
                        <span class="h-dy">01</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#64748b;">Past</span>
                        </div>
                        <h4 class="holiday-card-title text-muted">International Labor Day & Visak Bochea</h4>
                        <p class="holiday-card-meta">Friday &bull; Workers' Rights & Buddhist Observance</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="past" data-start="2026-05-05" data-end="2026-05-05" data-name="Royal Ploughing Ceremony">
                <div class="holiday-card-box is-past">
                    <div class="holiday-date-badge bg-secondary bg-opacity-10 text-secondary">
                        <span class="h-mo">MAY</span>
                        <span class="h-dy">05</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#64748b;">Past</span>
                        </div>
                        <h4 class="holiday-card-title text-muted">Royal Ploughing Ceremony</h4>
                        <p class="holiday-card-meta">Tuesday &bull; Traditional Agricultural Rite</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="past" data-start="2026-05-14" data-end="2026-05-14" data-name="King Norodom Sihamoni's Birthday">
                <div class="holiday-card-box is-past">
                    <div class="holiday-date-badge bg-secondary bg-opacity-10 text-secondary">
                        <span class="h-mo">MAY</span>
                        <span class="h-dy">14</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#64748b;">Past</span>
                        </div>
                        <h4 class="holiday-card-title text-muted">King Norodom Sihamoni's Birthday</h4>
                        <p class="holiday-card-meta">Thursday &bull; Official Royal Birthday Observance</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="past" data-start="2026-06-18" data-end="2026-06-18" data-name="Queen Mother Norodom Monineath Sihanouk's Birthday">
                <div class="holiday-card-box is-past">
                    <div class="holiday-date-badge bg-secondary bg-opacity-10 text-secondary">
                        <span class="h-mo">JUN</span>
                        <span class="h-dy">18</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#64748b;">Past</span>
                        </div>
                        <h4 class="holiday-card-title text-muted">Queen Mother's Birthday</h4>
                        <p class="holiday-card-meta">Thursday &bull; Queen Mother Norodom Monineath Sihanouk</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-4 holiday-card-col" data-timeline="past" data-start="2026-09-24" data-end="2026-09-24" data-name="Constitution Day">
                <div class="holiday-card-box is-past">
                    <div class="holiday-date-badge bg-secondary bg-opacity-10 text-secondary">
                        <span class="h-mo">SEP</span>
                        <span class="h-dy">24</span>
                    </div>
                    <div class="flex-grow-1 min-w-0">
                        <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                            <span class="holiday-badge" style="background:#f1f5f9; color:#64748b;">Past</span>
                        </div>
                        <h4 class="holiday-card-title text-muted">Constitution Day</h4>
                        <p class="holiday-card-meta">Thursday &bull; Promulgation of National Constitution (1993)</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
(function() {
    function initHolidayViewScope(root) {
        if (!root) return;

        var today = new Date();
        today.setHours(0, 0, 0, 0);

        var cards = root.querySelectorAll('.holiday-card-col');
        var nextHoliday = null;
        var minDiff = Infinity;

        cards.forEach(function(card) {
            var startStr = card.getAttribute('data-start');
            var endStr = card.getAttribute('data-end');
            var name = card.getAttribute('data-name');
            var pill = null;

            if (!startStr) return;

            var sp = startStr.split('-');
            var ep = endStr ? endStr.split('-') : sp;
            var startDate = new Date(parseInt(sp[0]), parseInt(sp[1]) - 1, parseInt(sp[2]));
            var endDate = new Date(parseInt(ep[0]), parseInt(ep[1]) - 1, parseInt(ep[2]));
            startDate.setHours(0, 0, 0, 0);
            endDate.setHours(23, 59, 59, 999);

            if (today > endDate) {
                if (pill) {
                    pill.style.background = '#f1f5f9';
                    pill.style.color = '#64748b';
                    pill.textContent = 'Past';
                }
            } else if (today >= startDate && today <= endDate) {
                if (pill) {
                    pill.style.background = '#dcfce7';
                    pill.style.color = '#166534';
                    pill.textContent = 'Today';
                }
                if (!nextHoliday) {
                    nextHoliday = { name: name, startDate: startDate, endDate: endDate, daysAway: 0, isToday: true };
                }
            } else {
                var diffDays = Math.ceil((startDate - today) / (1000 * 60 * 60 * 24));
                if (pill) {
                    pill.style.background = '#eff6ff';
                    pill.style.color = '#2563eb';
                    pill.style.border = '1px solid #bfdbfe';
                    pill.textContent = 'In ' + diffDays + 'd';
                }
                if (diffDays < minDiff) {
                    minDiff = diffDays;
                    nextHoliday = { name: name, startDate: startDate, endDate: endDate, daysAway: diffDays, isToday: false };
                }
            }
        });

        if (nextHoliday) {
            var heroTitle = root.querySelector('.next-holiday-title');
            var heroSubtitle = root.querySelector('.next-holiday-subtitle');
            var heroCountdown = root.querySelector('.next-holiday-countdown');

            if (heroTitle) heroTitle.textContent = nextHoliday.name;
            if (heroCountdown) {
                if (nextHoliday.isToday) {
                    heroCountdown.textContent = 'Happening Today';
                    heroCountdown.className = 'next-holiday-countdown badge bg-success text-white rounded-pill px-2.5 py-1 fw-bold';
                } else {
                    heroCountdown.textContent = 'In ' + nextHoliday.daysAway + ' days';
                }
            }
            if (heroSubtitle) {
                var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                var sm = months[nextHoliday.startDate.getMonth()];
                var sd = nextHoliday.startDate.getDate();
                var ed = nextHoliday.endDate.getDate();
                var dtStr = sm + ' ' + sd;
                if (sd !== ed) dtStr += '-' + ed;
                dtStr += ', ' + nextHoliday.startDate.getFullYear() + ' \u2022 Campus Closed';
                heroSubtitle.textContent = dtStr;
            }
        }

        var pastSec = root.querySelector('.past-section');
        var toggleBtns = root.querySelectorAll('.holiday-toggle-pill');

        toggleBtns.forEach(function(btn) {
            btn.addEventListener('click', function() {
                toggleBtns.forEach(function(b) { b.classList.remove('active'); });
                btn.classList.add('active');
                var mode = btn.getAttribute('data-filter');
                if (pastSec) {
                    pastSec.style.display = (mode === 'all') ? '' : 'none';
                }
            });
        });

        var searchInput = root.querySelector('.holiday-search-input');
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                var q = (this.value || '').toLowerCase().trim();
                cards.forEach(function(card) {
                    var n = (card.getAttribute('data-name') || '').toLowerCase();
                    var mo = (card.querySelector('.h-mo') ? card.querySelector('.h-mo').textContent : '').toLowerCase();
                    if (!q || n.indexOf(q) !== -1 || mo.indexOf(q) !== -1) {
                        card.style.display = '';
                    } else {
                        card.style.display = 'none';
                    }
                });
                if (q && pastSec) {
                    pastSec.style.display = '';
                }
            });
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        var el = document.getElementById('holidaysPageViewContainer');
        if (el) initHolidayViewScope(el);
    });
})();
</script>
