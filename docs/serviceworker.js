var CACHE_NAME = "CW_EPG_Remote";
var RUNTIME = "MyDynamicCache";
// var NO_CONN_MSG = "NoConnMsg.html";
var CACHED_URLS = [
  "index.html",
  "https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/css/all.min.css",
  "https://cdn.jsdelivr.net/npm/luxon@latest/build/global/luxon.min.js",
  "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js",
  "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css",
  "https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/webfonts/fa-solid-900.woff2",
  "CW_EPG_Remote_1_0_3156.js",
  "CWRmainForm.html",
  "Details.html",
  "IconResHigh.png",
  "IconResLow.png",
  "IconResMid.png",
  "SchedUnit2.html"
  ];

self.addEventListener('install', function(event) {
                console.log("serviceworker installed");
                event.waitUntil(
                                caches.open(CACHE_NAME).then(function(cache) {
                                return cache.addAll(CACHED_URLS);
                })
                                );
});

// The activate handler takes care of cleaning up old caches.
self.addEventListener('activate', event => {
  console.log("serviceworker activated");
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

self.addEventListener('fetch',function(event) {
   console.log(`serviceworker fetching ${event.request.url}`);
   event.respondWith(
     fetch(event.request).catch(function() {
                   return caches.match(event.request).then(function(response) {
       if (response) {
                                   return response;
       } else if (event.request.headers.get("accept").includes("text/html")) {
                                   return caches.match("index.html");
                   }
                   });
   })
                   );
});

var BADGE_COUNT = 0;

const PUSH_MESSAGE_CACHE = {};

self.addEventListener('message', function handler(event) {
    if (event.data.type === 'push') {
        if (event.data.id && PUSH_MESSAGE_CACHE[event.data.id]) {
            event.source.postMessage(PUSH_MESSAGE_CACHE[event.data.id]);
            delete PUSH_MESSAGE_CACHE[event.data.id];
        }
    }
});

self.addEventListener('push', function(event) {
    const payload = event.data.json();
    BADGE_COUNT++;

    if (navigator.setAppBadge) {
        navigator.setAppBadge(BADGE_COUNT);
    }

    event.waitUntil(
        self.registration.showNotification(payload.title, {
	        body: payload.body,
	        icon: payload.icon,
            badge: payload.badge,
            dir: payload.dir,
            lang: payload.lang,
            requireInteraction: payload.requireInteractions,
            silent: payload.silent,
            action: payload.action, //experimental
            image: payload.image, //experimental
            renotify: payload.renotify, //experimental
            timestamp: payload.timestamp, //experimental
            vibrate: payload.vibrate, //experimental
            data: { url: payload.url, custom: payload.data }
        })
    );
});

self.addEventListener('notificationclick', function(event) {
    BADGE_COUNT = 0;
    event.notification.close();

    if (navigator.clearAppBadge) {
        navigator.clearAppBadge();
    }

    event.waitUntil(
        clients.matchAll({includeUncontrolled: true, type: "window" }).then((clientsArr) => {
            if (event.notification.data) {
                let localUrl = new URL('./', location);
                let url = event.notification.data.url;
                if (!url) {
                    url = localUrl.href;
                }

                let targetClient = clientsArr.find((client) => { return client.url === url });
                if (targetClient) {
                    return targetClient.focus().then((client) => {
                        let remoteUrl = new URL(client.url);
                        if ((localUrl.origin === remoteUrl.origin) && event.notification.data.custom) {
                            client.postMessage(event.notification.data.custom)
                        }
                    });
                } else {
                    let remoteUrl = new URL(url);
                    let uuid = "";
                    if ((remoteUrl.origin === localUrl.origin) && event.notification.data.custom) {
                        uuid = crypto.randomUUID();
                        PUSH_MESSAGE_CACHE[uuid] = event.notification.data.custom;
                        uuid = "#update=" + uuid;
                    }
                    return clients.openWindow(url + uuid);
                }
            }
        })
    );
}, false);

self.addEventListener('pushsubscriptionchange', function(event) {
    let updateUrl = ""; //Change to app server update endpoint
    if (updateUrl !== "") {
        event.waitUntil(
            fetch(updateUrl, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    oldSubscription: event.oldSubscription ? event.oldSubscription : null,
                    newSubscription: event.newSubscription ? event.newSubscription : null
                })
            })
        );
    }
});

//self.addEventListener('fetch', event => {
//   event.respondWith(
//     fetch(event.request)
//     .catch(error => {
//       return caches.match(event.request) ;
//     })
//   );
//});

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