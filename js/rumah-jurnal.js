/**
 * Rumah Jurnal OJS 3.5 Interactive Features
 */

document.addEventListener('DOMContentLoaded', () => {
    // Copy ISSN to clipboard with interactive toast
    window.copyToClipboard = function(text, label) {
        if (!navigator.clipboard) {
            const textarea = document.createElement('textarea');
            textarea.value = text;
            document.body.appendChild(textarea);
            textarea.select();
            document.execCommand('copy');
            document.body.removeChild(textarea);
            showToast(`${label} (${text}) berhasil disalin!`);
            return;
        }

        navigator.clipboard.writeText(text).then(() => {
            showToast(`${label} (${text}) berhasil disalin!`);
        }).catch(err => {
            console.error('Gagal menyalin:', err);
        });
    };

    // Toast Notification Creator
    function showToast(message) {
        let toastContainer = document.getElementById('rj-toast-container');
        if (!toastContainer) {
            toastContainer = document.createElement('div');
            toastContainer.id = 'rj-toast-container';
            toastContainer.className = 'fixed bottom-5 right-5 z-50 flex flex-col gap-2 pointer-events-none';
            document.body.appendChild(toastContainer);
        }

        const toast = document.createElement('div');
        toast.className = 'bg-primary text-white px-4 py-2.5 rounded-xl shadow-xl flex items-center gap-2.5 text-sm font-medium border border-accent transition-all transform duration-300 translate-y-3 opacity-0';
        toast.innerHTML = `
            <svg class="w-4 h-4 text-accent flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
            <span>${message}</span>
        `;
        toastContainer.appendChild(toast);

        // Animate in
        requestAnimationFrame(() => {
            toast.classList.remove('translate-y-3', 'opacity-0');
        });

        // Animate out
        setTimeout(() => {
            toast.classList.add('opacity-0', 'translate-y-2');
            setTimeout(() => {
                toast.remove();
            }, 300);
        }, 2800);
    }
});