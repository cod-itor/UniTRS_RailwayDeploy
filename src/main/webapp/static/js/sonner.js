/**
 * Sonner Toast Notification Engine - UniTRS Design System
 * Lightweight, accessible, stackable toast alerts with auto-dismiss and pause on hover.
 */
(function (window, document) {
    'use strict';

    let toasterContainer = null;

    function getOrCreateToaster() {
        if (!toasterContainer || !document.body.contains(toasterContainer)) {
            toasterContainer = document.createElement('div');
            toasterContainer.className = 'sonner-toaster';
            toasterContainer.setAttribute('role', 'region');
            toasterContainer.setAttribute('aria-label', 'Notifications');
            document.body.appendChild(toasterContainer);
        }
        return toasterContainer;
    }

    const ICONS = {
        error: 'bi-x-circle-fill',
        success: 'bi-check-circle-fill',
        info: 'bi-info-circle-fill',
        warning: 'bi-exclamation-triangle-fill'
    };

    const TITLES = {
        error: 'Error',
        success: 'Success',
        info: 'Information',
        warning: 'Warning'
    };

    function createToast(options) {
        const type = options.type || 'info';
        const title = options.title || TITLES[type] || 'Notice';
        const message = options.message || '';
        const duration = options.duration !== undefined ? options.duration : 4500;

        const toaster = getOrCreateToaster();

        const toast = document.createElement('div');
        toast.className = 'sonner-toast sonner-' + type;
        toast.setAttribute('role', 'alert');
        toast.setAttribute('aria-live', type === 'error' ? 'assertive' : 'polite');

        const iconHtml = '<div class="sonner-icon-wrap"><i class="bi ' + (ICONS[type] || ICONS.info) + '"></i></div>';
        
        let contentHtml = '<div class="sonner-content">';
        if (title) {
            contentHtml += '<div class="sonner-title">' + escapeHtml(title) + '</div>';
        }
        if (message) {
            contentHtml += '<div class="sonner-description">' + escapeHtml(message) + '</div>';
        }
        contentHtml += '</div>';

        const closeBtnHtml = '<button type="button" class="sonner-close-btn" aria-label="Close notification"><i class="bi bi-x"></i></button>';
        const progressBarHtml = duration > 0 ? '<div class="sonner-progress-bar" style="animation-duration:' + duration + 'ms;"></div>' : '';

        toast.innerHTML = iconHtml + contentHtml + closeBtnHtml + progressBarHtml;

        let dismissTimeout = null;
        let isLeaving = false;

        function dismiss() {
            if (isLeaving) return;
            isLeaving = true;
            if (dismissTimeout) clearTimeout(dismissTimeout);
            toast.classList.add('sonner-leaving');
            toast.addEventListener('animationend', () => {
                if (toast.parentNode) {
                    toast.parentNode.removeChild(toast);
                }
            }, { once: true });
        }

        const closeBtn = toast.querySelector('.sonner-close-btn');
        if (closeBtn) {
            closeBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                dismiss();
            });
        }

        if (duration > 0) {
            dismissTimeout = setTimeout(dismiss, duration);

            const progressBar = toast.querySelector('.sonner-progress-bar');

            // Pause on hover
            toast.addEventListener('mouseenter', () => {
                if (dismissTimeout) clearTimeout(dismissTimeout);
                if (progressBar) progressBar.style.animationPlayState = 'paused';
            });

            toast.addEventListener('mouseleave', () => {
                if (isLeaving) return;
                if (progressBar) progressBar.style.animationPlayState = 'running';
                dismissTimeout = setTimeout(dismiss, 2000);
            });
        }

        toaster.appendChild(toast);
        return { dismiss };
    }

    function escapeHtml(str) {
        if (!str) return '';
        const div = document.createElement('div');
        div.textContent = str;
        return div.innerHTML;
    }

    const Sonner = {
        toast: createToast,
        error: function (message, title) {
            return createToast({ type: 'error', message: message, title: title || 'Action Failed' });
        },
        success: function (message, title) {
            return createToast({ type: 'success', message: message, title: title || 'Completed' });
        },
        info: function (message, title) {
            return createToast({ type: 'info', message: message, title: title || 'Notice' });
        },
        warning: function (message, title) {
            return createToast({ type: 'warning', message: message, title: title || 'Attention' });
        }
    };

    window.Sonner = Sonner;

    // Automatic server-side flash message detection
    document.addEventListener('DOMContentLoaded', function () {
        const triggers = document.querySelectorAll('.sonner-flash-trigger');
        triggers.forEach(function (el) {
            const type = el.getAttribute('data-type') || 'info';
            const title = el.getAttribute('data-title') || TITLES[type] || 'Notice';
            const message = el.getAttribute('data-message') || el.textContent.trim();
            if (message) {
                Sonner.toast({ type: type, title: title, message: message });
            }
        });
    });

})(window, document);
