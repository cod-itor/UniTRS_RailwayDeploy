(function() {
    'use strict';

    if (!('serviceWorker' in navigator)) {
        return;
    }

    let deferredPrompt = null;

    window.addEventListener('beforeinstallprompt', (e) => {
        e.preventDefault();
        deferredPrompt = e;
        window.deferredPwaPrompt = e;

        const installBtn = document.getElementById('pwaInstallBtn');
        if (installBtn) {
            installBtn.style.display = 'inline-flex';
        }
    });

    window.promptPwaInstall = function() {
        if (deferredPrompt) {
            deferredPrompt.prompt();
            deferredPrompt.userChoice.then((choiceResult) => {
                if (choiceResult.outcome === 'accepted') {
                    console.log('UniTRS PWA installed successfully.');
                }
                deferredPrompt = null;
                const installBtn = document.getElementById('pwaInstallBtn');
                if (installBtn) {
                    installBtn.style.display = 'none';
                }
            });
        }
    };

    window.addEventListener('appinstalled', () => {
        console.log('UniTRS application was installed on the device.');
        deferredPrompt = null;
    });

    window.addEventListener('load', () => {
        const pathSegments = window.location.pathname.split('/').filter(Boolean);
        let swPath = '/sw.js';
        let swScope = '/';

        const metaContext = document.querySelector('meta[name="app-context-path"]');
        if (metaContext && metaContext.content) {
            const ctx = metaContext.content.replace(/\/+$/, '');
            swPath = ctx + '/sw.js';
            swScope = ctx + '/';
        } else if (pathSegments.length > 0 && pathSegments[0] === 'ums') {
            swPath = '/ums/sw.js';
            swScope = '/ums/';
        }

        navigator.serviceWorker.register(swPath, { scope: swScope })
            .then((registration) => {
                registration.onupdatefound = () => {
                    const installingWorker = registration.installing;
                    if (installingWorker) {
                        installingWorker.onstatechange = () => {
                            if (installingWorker.state === 'installed' && navigator.serviceWorker.controller) {
                                console.log('New UniTRS version available.');
                            }
                        };
                    }
                };
            })
            .catch((error) => {
                console.warn('UniTRS ServiceWorker registration failed: ', error);
            });
    });
})();
