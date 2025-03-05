// Search functionality
document.addEventListener('DOMContentLoaded', function() {
    let searchIndex = null;
    let fuse = null;
    const searchInput = document.getElementById('search-input');
    const searchClear = document.getElementById('search-clear');
    const searchResults = document.getElementById('search-results');
    const resultsContainer = document.getElementById('results-container');
    const resultsCount = document.getElementById('results-count');
    const noResults = document.getElementById('no-results');
    const searchLoading = document.getElementById('search-loading');
    const resultTemplate = document.getElementById('search-result-template');

    // Fuse.js options
    const fuseOptions = {
        includeScore: true,
        threshold: 0.3,
        keys: [
            { name: 'title', weight: 1.0 },
            { name: 'description', weight: 0.8 },
            { name: 'content', weight: 0.6 },
            { name: 'venues', weight: 0.7 },
            { name: 'organisers', weight: 0.7 }
        ]
    };

    // Load the search index
    async function loadSearchIndex() {
        try {
            const response = await fetch('/index.json');
            searchIndex = await response.json();
            fuse = new Fuse(searchIndex.events, fuseOptions);
        } catch (error) {
            console.error('Error loading search index:', error);
        }
    }

    // Format date for display
    function formatEventDate(dateStr) {
        if (!dateStr) return '';
        const date = new Date(dateStr);
        return date.toLocaleDateString('en-GB', {
            weekday: 'long',
            day: 'numeric',
            month: 'long',
            year: 'numeric'
        });
    }

    // Perform search
    function performSearch(query) {
        if (!fuse || query.length < 2) {
            hideResults();
            return;
        }

        const results = fuse.search(query);
        displayResults(results);
    }

    // Display search results
    function displayResults(results) {
        resultsContainer.innerHTML = '';

        if (results.length === 0) {
            searchResults.classList.add('dn');
            noResults.classList.remove('dn');
            return;
        }

        noResults.classList.add('dn');
        searchResults.classList.remove('dn');
        resultsCount.textContent = `Found ${results.length} event${results.length === 1 ? '' : 's'}`;

        results.forEach(result => {
            const event = result.item;
            const resultElement = resultTemplate.content.cloneNode(true);

            // Fill in the template
            resultElement.querySelector('h3').textContent = event.title;
            resultElement.querySelector('.event-date').textContent = formatEventDate(event.eventStart);

            const venueElement = resultElement.querySelector('.venue');
            if (event.venues && event.venues.length > 0) {
                venueElement.querySelector('.venue-name').textContent = event.venues.join(', ');
            } else {
                venueElement.classList.add('dn');
            }

            const organiserElement = resultElement.querySelector('.organiser');
            if (event.organisers && event.organisers.length > 0) {
                organiserElement.querySelector('.organiser-name').textContent = event.organisers.join(', ');
            } else {
                organiserElement.classList.add('dn');
            }

            const link = resultElement.querySelector('a');
            link.href = event.permalink;

            resultsContainer.appendChild(resultElement);
        });
    }

    // Hide results
    function hideResults() {
        searchResults.classList.add('dn');
        noResults.classList.add('dn');
    }

    // Event listeners
    searchInput.addEventListener('input', debounce(function(e) {
        const query = e.target.value.trim();
        searchClear.classList.toggle('dn', query.length === 0);

        if (query.length >= 2) {
            performSearch(query);
        } else {
            hideResults();
        }
    }, 300));

    searchClear.addEventListener('click', function() {
        searchInput.value = '';
        searchClear.classList.add('dn');
        hideResults();
        searchInput.focus();
    });

    // Debounce function
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }

    // Initialize
    loadSearchIndex();
});
