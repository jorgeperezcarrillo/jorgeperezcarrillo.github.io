'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "ef736ef90fba2e54017bb328afbcb4f0",
"assets/AssetManifest.bin.json": "8f2181241dcb6fbc0a9423671bcff870",
"assets/AssetManifest.json": "28ce33c4552c0f07125d85c3f31877c2",
"assets/assets/background.jpg": "a8248dd7968df7c25b17ffab1ba6749c",
"assets/assets/cv.pdf": "5601bcc7e6bc56b0b68b2eed47a3f80f",
"assets/assets/hibsim.jpg": "46bcbdcba56ee2ed5bcb80b8b00ad8f2",
"assets/assets/hibsim_section1.jpg": "46bcbdcba56ee2ed5bcb80b8b00ad8f2",
"assets/assets/hibsim_section2.jpg": "2a3e8658a85b7dea90181fed2946024f",
"assets/assets/hibsim_section3.jpg": "fc3e3a77d34fbd2cc33b2f7541e5bfd8",
"assets/assets/hibsim_section4.jpg": "c98fea11a021151d077f70d66a877438",
"assets/assets/hibsim_section5.jpg": "2b89a0f74c8780232bea8b36ba64c11e",
"assets/assets/rocket.jpg": "a60dde0079c0e1ef3706c34c2aef6854",
"assets/assets/rocket_electronics1.jpg": "6ebe9a8d050a99757b4edfdfa17afbb2",
"assets/assets/rocket_electronics2.jpg": "8b2589d27f7eedaeabe12c327d06d171",
"assets/assets/rocket_engine_plan.jpg": "c96f95a78782abe02138ee8ec6ca59f0",
"assets/assets/rocket_section1.jpg": "200a9bd16370114f0ff28b73f2be6065",
"assets/assets/rocket_section2_left.jpg": "accb1bcf106092c4a511c77ec3a971f0",
"assets/assets/rocket_section2_right.jpg": "9ebb4300705dd61d0bd00cbb06357bc8",
"assets/assets/rocket_section3_left.jpg": "d1a41c7614c8d6b2397aff0473b3ea32",
"assets/assets/rocket_section3_right.jpg": "6730c2dfdb600e148d42fcee01a544dd",
"assets/assets/rocket_section4_left.jpg": "ca1d8382c80a199366321310e7e11e43",
"assets/assets/rocket_section4_right.jpg": "8ed32bb54a30107239ef17891e981fc5",
"assets/assets/rocket_section5_left.jpg": "0d942bddbbed1fb61d676f5235510e3e",
"assets/assets/rocket_section5_right.jpg": "4bb379f4b744be1f51bf5d965911da6e",
"assets/assets/section2.jpg": "46bcbdcba56ee2ed5bcb80b8b00ad8f2",
"assets/assets/section3.jpg": "a5ed711520e1ff517c3b5bb5246b7641",
"assets/assets/section4.jpg": "68aa97680e7da783a542150e4f98f437",
"assets/assets/sphib.jpg": "d3dcd3ef763adf195f636e1f5e956715",
"assets/assets/sphib_details1.jpg": "a5ed711520e1ff517c3b5bb5246b7641",
"assets/assets/sphib_details2.jpg": "732b861df0e47a1b18e8ce0a452d9f37",
"assets/assets/sphib_details3.jpg": "62f26406b5bb41d2112a73448bc640ea",
"assets/assets/sphib_plans1.jpg": "0e42a82c5c83ca63b9ee9ee84b19cc6f",
"assets/assets/sphib_plans2.jpg": "f74cdbbe2124b9e68d55d65040dde950",
"assets/assets/sphib_plans3.jpg": "9ba5e757347ca027a414334a147682ce",
"assets/assets/sphib_plans4.jpg": "baff8484f96c7778a8f627070c2acbd4",
"assets/assets/sphib_plans5.jpg": "68aa97680e7da783a542150e4f98f437",
"assets/assets/sphib_video.mp4": "7ad244f6dc9f063155544bcff4d3fdf4",
"assets/assets/sphib_video2.mp4": "49aa84ad0d69532225f56b75d2ef893b",
"assets/FontManifest.json": "d751713988987e9331980363e24189ce",
"assets/NOTICES": "3b127b5359b3481f9cfb97d23ade3b57",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "e2f57907d50d999b96e36f5aef789733",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "007410a6cd88da43d70c2f54502e66b5",
"/": "007410a6cd88da43d70c2f54502e66b5",
"main.dart.js": "c660c8a870be85ffdd9be60c9ee926cc",
"manifest.json": "67b1d1f5a0772f8a3e21fcb5a95bdb0d",
"version.json": "9e28a6fb62e19e020fc3634559213e4e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
