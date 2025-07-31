'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "a8297d555dd34879e8e48e1cf12acefa",
".git/config": "db0a38fa0ccfa1c5e49d8b518a5527be",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "921101ec5c9c7284a32aa33b205a76d4",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "0cff8a3daa4f186a06475e297a07d83f",
".git/logs/refs/heads/main": "7e1464ecb494b4dcfafd6e572254b871",
".git/logs/refs/remotes/origin/main": "0355a543289a5bf1d1a3a5ef68208c93",
".git/objects/05/c0bb2047eafa148da7b28645bb97c6464a431f": "a16885348ad66b2eac93aa58e94e6b41",
".git/objects/06/37a088a01e8ddab3bf3fa98dbe804cbde1a0dc": "2fedb3e87c69aac3dea537cfcd7943b2",
".git/objects/07/0473815a0027b0eb7ad8c96ea507f89deb061a": "a5753fb363f01e3b1a1c7e54be1db4c7",
".git/objects/14/9064edfd6566fa8092f445fd6f28d1796c1e3f": "608495e181eae1faf8892e5e5e31c1c4",
".git/objects/1a/ba9b5efce5a8b9348c5af416b0bc15fbf9fa77": "086441eb435f5e6ca790aa41f55587dd",
".git/objects/1a/d7683b343914430a62157ebf451b9b2aa95cac": "94fdc36a022769ae6a8c6c98e87b3452",
".git/objects/22/f2c739e64730b1c3ba2d070611c8f05aab234a": "1e12cf4c036e5e568caa7d761786226b",
".git/objects/30/6d6a6c37ec6b75ca57ea81494d77446243ae55": "ed7c18caa42b7fb2705302903f39c498",
".git/objects/36/38506407e9e2df6d177e6571879a5c1a17b721": "eaa068094bcf858713931c270bf7157a",
".git/objects/3f/3e75bfd3d3b9a813c9e0dbec572c2e9e5257e6": "2371a93c3217a51dddc25104c58bc454",
".git/objects/45/3c487cabdd422b551eab69cb18f8d3d42d48f1": "f960e79c2620a0891afb27b4807825c7",
".git/objects/46/f0e93fbbd7ec099f26222131b803d1134ff526": "1af32dbdf4e417121fbe5517c79fbad3",
".git/objects/48/2a68b70ee8cc1b39d91523aada1a4d3f3f4bf4": "11c47342ff4da261cacb4bf7f83f3e67",
".git/objects/48/94d00f74060a9763ead82cdcf26bdfda6c0275": "33dd7021284aed5090a35933be6fb0d6",
".git/objects/4a/85e2d28f0e0dc0fc49d54bdf3240afeb185101": "7412e2b8b95121b4fe712b17f55f8345",
".git/objects/4b/825dc642cb6eb9a060e54bf8d69288fbee4904": "75589287973d2772c2fc69d664e10822",
".git/objects/4c/51fb2d35630595c50f37c2bf5e1ceaf14c1a1e": "a20985c22880b353a0e347c2c6382997",
".git/objects/53/18a6956a86af56edbf5d2c8fdd654bcc943e88": "a686c83ba0910f09872b90fd86a98a8f",
".git/objects/53/3d2508cc1abb665366c7c8368963561d8c24e0": "4592c949830452e9c2bb87f305940304",
".git/objects/5d/112f2ff52f70f8a41cc00a41f9a91c39b9f270": "cf6d5639cc55b0767a1679892a10316b",
".git/objects/62/95371b982c1c6b17086a25a81ca6e8af5c62a0": "a00415e3ac276e6699026804774c5aae",
".git/objects/63/da2732b4d6c968ecd1f950a298a400ff5046eb": "930b3e2c3e9f0e8af0d8033b5e7db21a",
".git/objects/64/8fb0ed3ffd9ade86e52ccb939d1a4e3396c633": "a1e7925337c5616045f1a1e6e19df683",
".git/objects/68/4a5afb3df5dbb53d517952e791d2b803435fa8": "4e7dfacbb7add903cf84ded7615fac62",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/72/cded33fbe2bed6c1ef1435ff9140f538c6dc97": "486163d0ca81083f48b26f4d65830c5d",
".git/objects/73/c63bcf89a317ff882ba74ecb132b01c374a66f": "6ae390f0843274091d1e2838d9399c51",
".git/objects/7f/6ee798fc70f1e6957061d55ae96612d0790b38": "21ec59e041548caabcef9f0c9f47ee45",
".git/objects/7f/8e75b37931591058ea49368846bf6a3ec88022": "42fc0df4e4a91d96bcc80ed37e7d7e9a",
".git/objects/80/0efe43030af63c2ed4b2f5da5626a4ae7f9a55": "cceca006f88a765d51173b925f95967c",
".git/objects/83/f4479b0ac56ab94b001ffef918356b9222537d": "6e84487c2b32ca1ede026bdec06a4a6a",
".git/objects/87/94d55a7e5df05bcb10f607704220e6a0b2db90": "b5bf0035fd9e29670275c8a108f695a8",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/89/09f67aeaa89b741eb2bb80ddaee3706c8e2c4c": "1d4093f044bfc6c362459c97aa6e4f74",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8e/3c7d6bbbef6e7cefcdd4df877e7ed0ee4af46e": "025a3d8b84f839de674cd3567fdb7b1b",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/a7/a2a03d8f0bac35d1fa96bf044b6e9d6cd87ac3": "ef4929b5a6d7fb3c4f5906940b491ff2",
".git/objects/b0/68ac675941d61565ddee1517650f47f1a4a175": "e87c1cbd12a49cc1ce250a019c90199e",
".git/objects/b0/ad676cbcf52d6e079c55ba452570e721853a05": "04d391a14b8f3b3aa6dfaf468340985f",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b8/866ea5a91ce901a2642d7c1d71c4a223df8e45": "999ce95e2d2e4404762bb398a83d32c0",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/6a5236065a6c0fb7193cb2bb2f538b2d7b4788": "4227e5e94459652d40710ef438055fe5",
".git/objects/bd/607fddf495d3aa5a46b4ca0b2eb64a791172f2": "4bf10c748415448904b1effacd302d7d",
".git/objects/bd/ea9e4473a9af18c5ef914067d9808011127034": "32f8bcd37d23dc16332586ff7b92397c",
".git/objects/c0/f47614b5050597fa7fa90931cb48d011d77b0c": "f01c778f45d9a4304858f2660299fde6",
".git/objects/c4/334756003708442ede5ab0b70b215eecc71566": "b7c9fce83470e110fa5cff7938fec6c6",
".git/objects/c7/0838564daa4ebbc610e56ed8319a1555a48ca0": "cc6943896442df8d5656f9b3d010c0e3",
".git/objects/c8/08fb85f7e1f0bf2055866aed144791a1409207": "92cdd8b3553e66b1f3185e40eb77684e",
".git/objects/cc/07c8b08082d0df58a1c06a755e04055da01078": "74f1f34eb911cd7702345bdf64aea254",
".git/objects/cc/1b42e48fea04cc788f4336e06f1bb48077a2e7": "53493bf39ac96e3b0babc5c348c44403",
".git/objects/cc/7dca9d9684380cd9cab682b815ac77add4fc73": "c32217477f778d882b22f7f6dafe1beb",
".git/objects/cc/af4fa6457a136cc942461fdd196a3223de779a": "3e7d2e9ccc262d3bd02a0d54f765c587",
".git/objects/d1/59a06c94cd1cb948069ddb0b73a6cacc405e05": "8d46dd0dbe2f8b59965111fe61b6e8e2",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/dc/11fdb45a686de35a7f8c24f3ac5f134761b8a9": "761c08dfe3c67fe7f31a98f6e2be3c9c",
".git/objects/e0/7ac7b837115a3d31ed52874a73bd277791e6bf": "74ebcb23eb10724ed101c9ff99cfa39f",
".git/objects/e2/30749f16c9240bd236730371be377463cac85c": "0322f4b1b1c68fed4e146bfab887b6ec",
".git/objects/e8/9450006d25ce8ee4081ddf63a3743444d3d021": "af4f5dfd2896b40bd88fefefa0a88f7d",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ec/16930c9229ca5288102dc5a0763dea957e544e": "02a7e3f00226c2b14d070dbaa64fea6f",
".git/objects/f0/b75181ea0c1a322220f5998de5d4e84cc560f0": "ac87879132a9dce7e4c05195961dabab",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/fb/7f536b93a0fb7238b5d6cc951f2330026fe314": "c327ae3071234921ccee4f10f617cf24",
".git/objects/fb/b1429ba95ab18ef993b42f96f43469da80353f": "217c37d9ae6fbf78e19a4f0948ea5614",
".git/objects/fb/fbd036b37cac8fbf2f1b71eb3ba769899ee6ca": "53bf70409323695788e727bf3c3d9d9c",
".git/refs/heads/main": "d11a24c32e8240d4bcaabf3e55362c2f",
".git/refs/remotes/origin/main": "d11a24c32e8240d4bcaabf3e55362c2f",
"assets/AssetManifest.bin": "ef736ef90fba2e54017bb328afbcb4f0",
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
"flutter_bootstrap.js": "88024fd95bbec999a6aeb6d4461c88c8",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "007410a6cd88da43d70c2f54502e66b5",
"/": "007410a6cd88da43d70c2f54502e66b5",
"main.dart.js": "5fd67ca6de46322115a9793656df4b01",
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
