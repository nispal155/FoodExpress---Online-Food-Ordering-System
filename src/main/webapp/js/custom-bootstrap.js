/**
 * Custom JavaScript to replace Bootstrap functionality
 */

// Modal functionality
document.addEventListener('DOMContentLoaded', function() {
    // Modal open
    document.querySelectorAll('[data-bs-toggle="modal"]').forEach(function(element) {
        element.addEventListener('click', function() {
            const target = document.querySelector(this.getAttribute('data-bs-target'));
            if (target) {
                target.classList.add('show');
                document.body.style.overflow = 'hidden';
            }
        });
    });

    // Modal close
    document.querySelectorAll('[data-bs-dismiss="modal"]').forEach(function(element) {
        element.addEventListener('click', function() {
            const modal = this.closest('.modal');
            if (modal) {
                modal.classList.remove('show');
                document.body.style.overflow = '';
            }
        });
    });

    // Close modal when clicking outside
    document.querySelectorAll('.modal').forEach(function(modal) {
        modal.addEventListener('click', function(event) {
            if (event.target === this) {
                this.classList.remove('show');
                document.body.style.overflow = '';
            }
        });
    });
});

// Dropdown functionality
document.addEventListener('DOMContentLoaded', function() {
    // Toggle dropdown
    document.querySelectorAll('[data-bs-toggle="dropdown"]').forEach(function(element) {
        element.addEventListener('click', function(event) {
            event.preventDefault();
            event.stopPropagation();
            
            const dropdownMenu = this.nextElementSibling;
            if (dropdownMenu && dropdownMenu.classList.contains('dropdown-menu')) {
                // Close all other dropdowns
                document.querySelectorAll('.dropdown-menu.show').forEach(function(menu) {
                    if (menu !== dropdownMenu) {
                        menu.classList.remove('show');
                    }
                });
                
                // Toggle current dropdown
                dropdownMenu.classList.toggle('show');
            }
        });
    });

    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.dropdown')) {
            document.querySelectorAll('.dropdown-menu.show').forEach(function(menu) {
                menu.classList.remove('show');
            });
        }
    });
});

// Tab functionality
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('[data-bs-toggle="tab"]').forEach(function(element) {
        element.addEventListener('click', function(event) {
            event.preventDefault();
            
            // Get the target tab
            const target = document.querySelector(this.getAttribute('data-bs-target'));
            if (!target) return;
            
            // Get the parent tab list
            const tabList = this.closest('.nav-tabs');
            if (!tabList) return;
            
            // Get the parent tab content
            const tabContent = document.querySelector(this.getAttribute('data-bs-target')).closest('.tab-content');
            if (!tabContent) return;
            
            // Deactivate all tabs
            tabList.querySelectorAll('.nav-link').forEach(function(tab) {
                tab.classList.remove('active');
                tab.setAttribute('aria-selected', 'false');
            });
            
            // Hide all tab panes
            tabContent.querySelectorAll('.tab-pane').forEach(function(pane) {
                pane.classList.remove('active');
                pane.classList.remove('show');
            });
            
            // Activate the clicked tab
            this.classList.add('active');
            this.setAttribute('aria-selected', 'true');
            
            // Show the target tab pane
            target.classList.add('active');
            target.classList.add('show');
        });
    });
});

// Tooltip functionality
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function(element) {
        const title = element.getAttribute('title') || element.getAttribute('data-bs-title');
        if (!title) return;
        
        // Create tooltip element
        const tooltip = document.createElement('div');
        tooltip.className = 'tooltip';
        tooltip.innerHTML = `<div class="tooltip-arrow"></div><div class="tooltip-inner">${title}</div>`;
        document.body.appendChild(tooltip);
        
        // Show tooltip on hover
        element.addEventListener('mouseenter', function() {
            const rect = this.getBoundingClientRect();
            const placement = this.getAttribute('data-bs-placement') || 'top';
            
            tooltip.classList.add('show');
            
            // Position tooltip based on placement
            if (placement === 'top') {
                tooltip.style.top = rect.top - tooltip.offsetHeight - 5 + 'px';
                tooltip.style.left = rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2) + 'px';
            } else if (placement === 'bottom') {
                tooltip.style.top = rect.bottom + 5 + 'px';
                tooltip.style.left = rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2) + 'px';
            } else if (placement === 'left') {
                tooltip.style.top = rect.top + (rect.height / 2) - (tooltip.offsetHeight / 2) + 'px';
                tooltip.style.left = rect.left - tooltip.offsetWidth - 5 + 'px';
            } else if (placement === 'right') {
                tooltip.style.top = rect.top + (rect.height / 2) - (tooltip.offsetHeight / 2) + 'px';
                tooltip.style.left = rect.right + 5 + 'px';
            }
        });
        
        // Hide tooltip on mouse leave
        element.addEventListener('mouseleave', function() {
            tooltip.classList.remove('show');
        });
    });
});
