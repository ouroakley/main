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
    function formatEventDate(date) {
        if (!date) return '';
        const options = {
            weekday: 'long',
            day: 'numeric',
            month: 'long',
            year: 'numeric',
            hour: 'numeric',
            minute: 'numeric'
        };
        const d = new Date(date);
        let dateStr = d.toLocaleDateString('en-GB', options);
        // If time is midnight (00:00), only show the date
        if (d.getHours() === 0 && d.getMinutes() === 0) {
            dateStr = d.toLocaleDateString('en-GB', {
                weekday: 'long',
                day: 'numeric',
                month: 'long',
                year: 'numeric'
            });
        }
        return dateStr;
    }

    // Format date range for display
    function formatDateRange(startDate, endDate) {
        const start = new Date(startDate);
        const end = new Date(endDate);
        const startStr = formatEventDate(start);

        // If end date is same as start date
        if (start.toDateString() === end.toDateString()) {
            // If end time is different from start time and not midnight
            if (end.getHours() !== 0 || end.getMinutes() !== 0) {
                return `${startStr} - ${end.toLocaleTimeString('en-GB', { hour: 'numeric', minute: 'numeric' })}`;
            }
            return startStr;
        }

        return `${startStr} - ${formatEventDate(end)}`;
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

            // Handle event dates
            const eventDatesContainer = resultElement.querySelector('.event-dates');
            if (event.eventDates && event.eventDates.length > 0) {
                const dateStrings = event.eventDates.map(date => {
                    return `<p class="mv2"><span class="mr2">📅</span>${formatDateRange(date.start, date.end)}</p>`;
                });
                eventDatesContainer.innerHTML = dateStrings.join('');
            }

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

    // Initialize search functionality
    if (searchInput) {
        loadSearchIndex();

        searchInput.addEventListener('input', (e) => {
            const query = e.target.value.trim();
            if (query.length > 0) {
                searchClear.classList.remove('dn');
            } else {
                searchClear.classList.add('dn');
            }
            performSearch(query);
        });

        searchClear.addEventListener('click', () => {
            searchInput.value = '';
            searchClear.classList.add('dn');
            hideResults();
        });
    }
});
