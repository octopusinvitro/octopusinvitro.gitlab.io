(function() {
  var
    search = document.getElementById('search'),
    input = search.querySelector('.search-input'),
    button = search.querySelector('.search-submit'),
    close = search.querySelector('.search-close'),
    more = document.getElementById('more'),
    isOpen = isAnimating = false,
    escapeKeyCode = 27,
    enterKeyCode = 13
  ;

  var toggleSearch = function(event) {
    if (event.type.toLowerCase() === 'focus' && isOpen) {
      return false;
    }

    if (isOpen) {
      classie.remove(search, 'open');
      // trick to hide input text once the search overlay closes
      // todo: hardcoded times, should be done after transition ends
      if (input.value !== '') {
        setTimeout(function() {
          classie.add(search, 'hideInput');

          setTimeout(function() {
            classie.remove(search, 'hideInput');
            input.value = '';
          }, 300);

        }, 500);
      }

      input.blur();
    }

    else {
      classie.add(search, 'open');
    }

    isOpen = !isOpen;
  };

  var replaceArticleGrid = function() {
    var
      articleGrid = document.getElementById('grid'),
      container = document.getElementById('search-results')
    ;

    if (articleGrid) {
      articleGrid.parentNode.removeChild(articleGrid);
    }

    if (container.getAttribute('style') === 'display:none') {
      container.setAttribute('style', 'display:block;margin-top:3em;background-color:transparent');
    }
  };

  var buildLinkedImg = function(response) {
    var
      link = document.createElement('a'),
      img = document.createElement('img')
    ;

    img.setAttribute('src', response.pagemap.cse_thumbnail.src);
    img.setAttribute('width', response.pagemap.cse_thumbnail.width);
    img.setAttribute('height', response.pagemap.cse_thumbnail.height);
    img.setAttribute('alt', response.items.title);

    link.setAttribute('href', response.pagemap.cse_image.src);
    link.appendChild(img);
    return link;
  };

  var showSearchResults = function(response, url) {
    var
      items = response.items,
      ulPosts = document.querySelector('#search-posts'),
      ulImgs = document.querySelector('#search-images'),
      fragmentPosts = document.createDocumentFragment(),
      fragmentImgs = document.createDocumentFragment(),
      li, date, rawDate, link, moreURL
    ;

    replaceArticleGrid();

    items.forEach(function(item) {
      li = document.createElement('li');

      if (response.pagemap) {
        link = buildLinkedImg(response);
        li.appendChild(link);
        fragmentImgs.appendChild(li);
      }

      else {
        date = document.createElement('span');
        link = document.createElement('a');
        rawDate = item.snippet.split(' ... ')[0];

        if (isNaN(Date.parse(rawDate))) {
          date.textContent = '';
        } else {
          date.textContent = rawDate;
        }

        link.textContent = item.title;
        link.setAttribute('href', item.link);

        li.appendChild(date);
        li.appendChild(link);
        fragmentPosts.appendChild(li);
      }
    });

    ulPosts.appendChild(fragmentPosts);
    ulImgs.appendChild(fragmentImgs);

    if (response.queries.nextPage === undefined) {
      more.setAttribute('style', 'display:none');
    }

    else {
      moreURL = url + '&start=' + response.queries.nextPage[0].startIndex;
      more.setAttribute('data-href', moreURL);
    }
  };

  var showErrors = function(request) {
    var message = 'There was an error.', p;

    replaceArticleGrid();

    if (request.status === 404) {
      message = 'No results.';
    }

    else if (request.status === 403) {
      message = 'Daily search limit (100 searches per day) exceeded. You can always google!';
    }

    p = document.createElement('p');
    p.textContent = message;
    more.parentNode.appendChild(p);
    more.parentNode.removeChild(more);
  };

  var ajax = function(url) {
    var request = new XMLHttpRequest(), DONE = 4, OK = 200;

    request.onreadystatechange = function() {
      if (request.readyState === DONE) {
        if (request.status === OK) {
          showSearchResults(JSON.parse(request.responseText), url);
        } else {
          showErrors(request);
        }
      }
    };

    request.open('GET', url);
    request.send(null);
  };

  var buildURL = function() {
    var
      inputText = document.querySelector('.search-input').value,

      apiURL = 'https://www.googleapis.com/customsearch/v1',
      query = '?q=' + inputText,
      searchId = '&cx=006696410474927510846%3Aafhgacvjtkm',
      apiKey = '&key=AIzaSyBI9KsLtQt0X6BcgHNaSuyZ6oWGxesSbyI',

      total = 'queries/request/totalResults',
      nav = 'queries/nextPage/startIndex,queries/previousPage/startIndex',
      items = 'items(title,link,snippet,pagemap/cse_thumbnail,pagemap/cse_image)',
      fields = '&fields=' + total + ',' + nav + ',' + items
    ;

    return apiURL + query + searchId + apiKey + fields;
  };


  document.addEventListener('keydown', function(event) {
    var keyCode = event.keyCode || event.which;

    if (keyCode === escapeKeyCode && isOpen) {
      toggleSearch(event);
    }
  });

  input.addEventListener('keydown', function(event) {
    var keyCode = event.keyCode || event.which;

    if (keyCode === enterKeyCode && isOpen) {
      toggleSearch(event);
      ajax(buildURL());
    }
  });

  button.addEventListener('click', function(event) {
    event.preventDefault();
    toggleSearch(event);
    ajax(buildURL());
  });

  more.addEventListener('click', function(event) {
    event.preventDefault();
    ajax(this.getAttribute('data-href'));
  });

  input.addEventListener('focus', toggleSearch);
  close.addEventListener('click', toggleSearch);
})();
