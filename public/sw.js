// public/sw.js
const CACHE_NAME = 'joao-guilherme-cache-v1';
const urlsToCache = [
  '/',
  '/manifest.json',
  '/favicon.ico',
  '/images/joao-guilherme-hero.jpg',
  '/images/fan-club.jpg',
  '/images/blog1.jpg',
  '/images/blog2.jpg',
  '/images/blog3.jpg',
  '/images/sponsor1.png',
  '/images/sponsor2.png',
  '/images/sponsor3.png',
  '/images/sponsor4.png',
  '/images/sponsor5.png',
  '/images/sponsor6.png',
  '/images/video1.jpg',
  '/images/video2.jpg',
  '/images/video3.jpg',
  '/images/video4.jpg',
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        return cache.addAll(urlsToCache);
      })
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        return response || fetch(event.request);
      })
  );
});

self.addEventListener('activate', event => {
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheWhitelist.indexOf(cacheName) === -1) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
