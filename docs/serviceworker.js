var CACHE_NAME = "CW_EPG_Remote";
var RUNTIME = "MyDynamicCache";
var NO_CONN_MSG = "NoConnMsg.html";
var CACHED_URLS = [
  "index.html",
  "https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/css/all.min.css",
  "https://cdn.jsdelivr.net/npm/luxon@latest/build/global/luxon.min.js",
  "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js",
  "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css",
  "https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/webfonts/fa-solid-900.woff2",
  "CW_EPG_Remote_1_0_2542.js",
  "CWRmainForm.html",
  "Details.html",
  "IconResHigh.png",
  "IconResLow.png",
  "IconResMid.png",
  "SchedUnit2.html"
  ];

self.addEventListener('install', function(event) {
                console.log(`serviceworker installed`);
                event.waitUntil(
                                caches.open(CACHE_NAME).then(function(cache) {
                                return cache.addAll(CACHED_URLS);
                })
                                );
});

// The activate handler takes care of cleaning up old caches.
self.addEventListener('activate', event => {
  console.log(`serviceworker activated`);
  const currentCaches = [CACHE_NAME, RUNTIME];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return cacheNames.filter(cacheName => !currentCaches.includes(cacheName));
    }).then(cachesToDelete => {
      return Promise.all(cachesToDelete.map(cacheToDelete => {
        return caches.delete(cacheToDelete);
      }));
    }).then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", event => {
   event.respondWith(
     fetch(event.request)
     .catch(error => {
       return caches.match(event.request) ;
     })
   );
});

//self.addEventListener("fetch", event => {
//   event.respondWith(
//     caches.match(event.request)
//     .then(cachedResponse => {
//	   // It can update the cache to serve updated content on the next request
//         return cachedResponse || fetch(event.request);
//     }
//   )
//  )
//});


//self.addEventListener('fetch',function(event) {
//  console.log(`serviceworker fetch of ${event.request.url}`);
//  if (event.request.url.startsWith(self.location.origin)) {
//   event.respondWith(
//     fetch(event.request).catch(function() {
//                   return caches.match(event.request).then(function(response) {
//       if (response) {
//                                   return response;
//       } else if (event.request.headers.get("accept").includes("text/html")) {
////                                   return caches.match("index.html");
//                                   return caches.match(NO_CONN_MSG);
//             }
//           });
//         })
//       );
//     }
//   });

// The fetch handler serves responses for same-origin resources from a cache.
// If no response is found, it populates the runtime cache with the response
// from the network before returning it to the page.
//self.addEventListener('fetch', event => {
//  // Skip cross-origin requests, like those for Google Analytics.
//  if (event.request.url.startsWith(self.location.origin)) {
//    event.respondWith(
//      caches.match(event.request).then(cachedResponse => {
//        if (cachedResponse) {
//          return cachedResponse;
//        }
//        return caches.open(RUNTIME).then(cache => {
//          return fetch(event.request).then(response => {
//            // Put a copy of the response in the runtime cache.
//            return cache.put(event.request, response.clone()).then(() => {
//              return response;
//            });
//          });
//        });
//      })
//    );
//  }
//});