(function() {
    'use strict';

    function isAppInstalled() {
        return window.matchMedia('(display-mode: standalone)').matches ||
               window.navigator.standalone === true ||
               document.referrer.includes('android-app://');
    }

    const isIos = /iphone|ipad|ipod/.test(navigator.userAgent.toLowerCase()) && !window.MSStream;
    let deferredPrompt = null;

    function getContextPath() {
        const metaContext = document.querySelector('meta[name="app-context-path"]');
        if (metaContext && metaContext.content) {
            return metaContext.content.replace(/\/+$/, '');
        }
        const pathSegments = window.location.pathname.split('/').filter(Boolean);
        if (pathSegments.length > 0 && pathSegments[0] === 'ums') {
            return '/ums';
        }
        return '';
    }

    const contextPath = getContextPath();

    window.addEventListener('beforeinstallprompt', (e) => {
        e.preventDefault();
        deferredPrompt = e;
        window.deferredPwaPrompt = e;

        const installBtn = document.getElementById('pwaInstallBtn');
        if (installBtn && !isAppInstalled()) {
            installBtn.style.display = 'inline-flex';
        }

        renderFloatingBanner();
    });

    window.promptPwaInstall = function() {
        if (deferredPrompt) {
            deferredPrompt.prompt();
            deferredPrompt.userChoice.then((choiceResult) => {
                if (choiceResult.outcome === 'accepted') {
                    console.log('UniTRS PWA installed successfully.');
                }
                deferredPrompt = null;
                hideAllInstallUI();
            });
        } else if (isIos) {
            showIosModal();
        } else {
            showGenericModal();
        }
    };

    window.dismissPwaBanner = function() {
        sessionStorage.setItem('unitrs_pwa_banner_dismissed', 'true');
        const banner = document.getElementById('unitrsPwaFloatingBanner');
        if (banner) {
            banner.style.opacity = '0';
            banner.style.transform = 'translate(-50%, 30px)';
            setTimeout(() => banner.remove(), 300);
        }
    };

    function hideAllInstallUI() {
        const banner = document.getElementById('unitrsPwaFloatingBanner');
        if (banner) banner.remove();
        const installBtn = document.getElementById('pwaInstallBtn');
        if (installBtn) installBtn.style.display = 'none';
        const modal = document.getElementById('unitrsPwaModalOverlay');
        if (modal) modal.remove();
    }

    window.addEventListener('appinstalled', () => {
        console.log('UniTRS application was installed on the device.');
        deferredPrompt = null;
        hideAllInstallUI();
    });

    function showIosModal() {
        if (document.getElementById('unitrsPwaModalOverlay')) return;

        const overlay = document.createElement('div');
        overlay.id = 'unitrsPwaModalOverlay';
        overlay.style.cssText = 'position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.7);z-index:999999;display:flex;align-items:flex-end;justify-content:center;padding:16px;backdrop-filter:blur(8px);-webkit-backdrop-filter:blur(8px);animation:pwaFadeIn 0.25s ease-out;';

        overlay.innerHTML = 
            '<div style="background:#111c2e;border:1px solid rgba(79,172,254,0.35);border-radius:20px;max-width:420px;width:100%;padding:24px;color:#fff;box-shadow:0 20px 50px rgba(0,0,0,0.6);text-align:center;position:relative;margin-bottom:12px;">' +
                '<button onclick="document.getElementById(\'unitrsPwaModalOverlay\').remove()" style="position:absolute;top:14px;right:14px;background:none;border:none;color:#a0aec0;font-size:1.2rem;cursor:pointer;padding:4px 8px;">✕</button>' +
                '<div style="width:64px;height:64px;margin:0 auto 16px;border-radius:16px;overflow:hidden;box-shadow:0 6px 18px rgba(0,0,0,0.4);border:2px solid rgba(255,255,255,0.1);">' +
                    '<img src="' + contextPath + '/static/icons/icon-192.png" width="64" height="64" alt="UniTRS">' +
                '</div>' +
                '<h5 style="font-weight:700;margin-bottom:8px;font-size:1.2rem;">Install UniTRS on iPhone</h5>' +
                '<p style="color:#94a3b8;font-size:0.88rem;margin-bottom:20px;line-height:1.4;">Install as a standalone web app for fast access and a full-screen experience.</p>' +
                '<div style="background:rgba(255,255,255,0.06);border-radius:14px;padding:16px;text-align:left;margin-bottom:20px;font-size:0.86rem;line-height:1.6;">' +
                    '<div style="display:flex;align-items:center;margin-bottom:12px;">' +
                        '<div style="width:28px;height:28px;background:rgba(13,110,253,0.25);border-radius:50%;display:flex;align-items:center;justify-content:center;margin-right:12px;color:#4facfe;font-weight:700;font-size:0.8rem;">1</div>' +
                        '<div>Tap the <strong style="color:#fff;">Share</strong> button in the Safari toolbar below (or at the top on iPad).</div>' +
                    '</div>' +
                    '<div style="display:flex;align-items:center;margin-bottom:12px;">' +
                        '<div style="width:28px;height:28px;background:rgba(13,110,253,0.25);border-radius:50%;display:flex;align-items:center;justify-content:center;margin-right:12px;color:#4facfe;font-weight:700;font-size:0.8rem;">2</div>' +
                        '<div>Scroll down and select <strong style="color:#fff;">Add to Home Screen</strong>.</div>' +
                    '</div>' +
                    '<div style="display:flex;align-items:center;">' +
                        '<div style="width:28px;height:28px;background:rgba(13,110,253,0.25);border-radius:50%;display:flex;align-items:center;justify-content:center;margin-right:12px;color:#4facfe;font-weight:700;font-size:0.8rem;">3</div>' +
                        '<div>Tap <strong style="color:#fff;">Add</strong> in the top-right corner.</div>' +
                    '</div>' +
                '</div>' +
                '<button onclick="document.getElementById(\'unitrsPwaModalOverlay\').remove()" style="width:100%;padding:10px;border-radius:12px;background:linear-gradient(135deg,#0d6efd,#00f2fe);border:none;color:#fff;font-weight:600;font-size:0.95rem;cursor:pointer;">' +
                    'Got It' +
                '</button>' +
            '</div>';

        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) overlay.remove();
        });

        document.body.appendChild(overlay);
    }

    function showGenericModal() {
        if (document.getElementById('unitrsPwaModalOverlay')) return;

        const overlay = document.createElement('div');
        overlay.id = 'unitrsPwaModalOverlay';
        overlay.style.cssText = 'position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.7);z-index:999999;display:flex;align-items:center;justify-content:center;padding:16px;backdrop-filter:blur(8px);-webkit-backdrop-filter:blur(8px);';

        overlay.innerHTML = 
            '<div style="background:#111c2e;border:1px solid rgba(79,172,254,0.35);border-radius:20px;max-width:400px;width:100%;padding:24px;color:#fff;box-shadow:0 20px 50px rgba(0,0,0,0.6);text-align:center;position:relative;">' +
                '<button onclick="document.getElementById(\'unitrsPwaModalOverlay\').remove()" style="position:absolute;top:14px;right:14px;background:none;border:none;color:#a0aec0;font-size:1.2rem;cursor:pointer;padding:4px 8px;">✕</button>' +
                '<div style="width:60px;height:60px;margin:0 auto 16px;border-radius:16px;overflow:hidden;box-shadow:0 6px 18px rgba(0,0,0,0.4);">' +
                    '<img src="' + contextPath + '/static/icons/icon-192.png" width="60" height="60" alt="UniTRS">' +
                '</div>' +
                '<h5 style="font-weight:700;margin-bottom:8px;">Install UniTRS App</h5>' +
                '<p style="color:#94a3b8;font-size:0.88rem;margin-bottom:18px;">To install on your mobile device:</p>' +
                '<div style="background:rgba(255,255,255,0.06);border-radius:12px;padding:14px;text-align:left;margin-bottom:18px;font-size:0.86rem;line-height:1.5;">' +
                    'Tap the browser menu (<strong>⋮</strong> or <strong>Share</strong>) and select <strong>"Install app"</strong> or <strong>"Add to Home screen"</strong>.' +
                '</div>' +
                '<button onclick="document.getElementById(\'unitrsPwaModalOverlay\').remove()" style="width:100%;padding:10px;border-radius:12px;background:linear-gradient(135deg,#0d6efd,#00f2fe);border:none;color:#fff;font-weight:600;cursor:pointer;">' +
                    'Close' +
                '</button>' +
            '</div>';

        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) overlay.remove();
        });

        document.body.appendChild(overlay);
    }

    function renderFloatingBanner() {
        if (isAppInstalled()) return;
        if (sessionStorage.getItem('unitrs_pwa_banner_dismissed') === 'true') return;
        if (document.getElementById('unitrsPwaFloatingBanner')) return;

        const banner = document.createElement('div');
        banner.id = 'unitrsPwaFloatingBanner';
        banner.style.cssText = 
            'position:fixed;bottom:18px;left:50%;transform:translateX(-50%);width:calc(100% - 32px);max-width:440px;' +
            'background:rgba(13,27,42,0.95);border:1px solid rgba(79,172,254,0.4);border-radius:16px;' +
            'padding:12px 16px;box-shadow:0 12px 36px rgba(0,0,0,0.55),0 0 20px rgba(13,110,253,0.25);' +
            'z-index:99999;display:flex;align-items:center;gap:12px;backdrop-filter:blur(14px);-webkit-backdrop-filter:blur(14px);' +
            'color:#fff;font-family:system-ui,-apple-system,sans-serif;transition:all 0.3s cubic-bezier(0.4,0,0.2,1);' +
            'animation:pwaSlideIn 0.4s ease-out;';

        const subtext = isIos ? 'Tap to install on iPhone' : 'Add to home screen for full experience';

        banner.innerHTML = 
            '<img src="' + contextPath + '/static/icons/icon-192.png" width="42" height="42" style="border-radius:10px;box-shadow:0 2px 8px rgba(0,0,0,0.3);flex-shrink:0;">' +
            '<div style="flex-grow:1;min-width:0;">' +
                '<div style="font-weight:700;font-size:0.92rem;color:#ffffff;line-height:1.2;">UniTRS App</div>' +
                '<div style="color:#94a3b8;font-size:0.75rem;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">' + subtext + '</div>' +
            '</div>' +
            '<button id="unitrsPwaActionBtn" style="background:linear-gradient(135deg,#0d6efd,#00f2fe);border:none;border-radius:50px;padding:6px 14px;color:#fff;font-weight:600;font-size:0.82rem;cursor:pointer;white-space:nowrap;box-shadow:0 4px 12px rgba(13,110,253,0.4);flex-shrink:0;">' +
                'Install' +
            '</button>' +
            '<button onclick="window.dismissPwaBanner()" style="background:none;border:none;color:#64748b;font-size:1.1rem;cursor:pointer;padding:4px;flex-shrink:0;line-height:1;">' +
                '✕' +
            '</button>';

        document.body.appendChild(banner);

        document.getElementById('unitrsPwaActionBtn').addEventListener('click', () => {
            window.promptPwaInstall();
        });
    }

    // Inject CSS keyframe animations for banner & modal
    const styleEl = document.createElement('style');
    styleEl.textContent = 
        '@keyframes pwaSlideIn{from{transform:translate(-50%,60px);opacity:0;}to{transform:translate(-50%,0);opacity:1;}}' +
        '@keyframes pwaFadeIn{from{opacity:0;}to{opacity:1;}}';
    document.head.appendChild(styleEl);

    window.addEventListener('load', () => {
        // Check if page has #pwaInstallBtn and make it visible if app not installed
        const installBtn = document.getElementById('pwaInstallBtn');
        if (installBtn && !isAppInstalled()) {
            installBtn.style.display = 'inline-flex';
        }

        // On mobile or iOS devices, render the floating banner if not already installed
        if (!isAppInstalled()) {
            setTimeout(() => {
                renderFloatingBanner();
            }, 800);
        }

        // Register Service Worker
        if ('serviceWorker' in navigator) {
            let swPath = contextPath ? contextPath + '/sw.js' : '/sw.js';
            let swScope = contextPath ? contextPath + '/' : '/';

            navigator.serviceWorker.register(swPath, { scope: swScope })
                .then((registration) => {
                    registration.onupdatefound = () => {
                        const installingWorker = registration.installing;
                        if (installingWorker) {
                            installingWorker.onstatechange = () => {
                                if (installingWorker.state === 'installed' && navigator.serviceWorker.controller) {
                                    console.log('New UniTRS PWA version available.');
                                }
                            };
                        }
                    };
                })
                .catch((error) => {
                    console.warn('UniTRS ServiceWorker registration failed: ', error);
                });
        }
    });
})();
