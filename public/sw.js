/* Service Worker: hält die App auf dem iPad bereit, damit sie ohne Internet startet.

   Geantwortet wird immer zuerst aus dem Speicher. Im Hintergrund wird nachgeladen,
   übernommen wird aber nur eine heile Antwort (Status 200 von derselben Adresse).
   Ist die Seite weg oder kaputt, läuft die gespeicherte Fassung einfach weiter.
   Neue Fassungen gelten ab dem nächsten Öffnen. Die Kinderdaten liegen nicht hier,
   sondern in der IndexedDB – dieser Speicher enthält nur das Programm.

   Wer Symbole oder diese Datei ändert, zählt CACHE hoch. */
const CACHE = "anwesenheit-v1";
const DATEIEN = [
  "./",
  "./index.html",
  "./manifest.webmanifest",
  "./icons/apple-touch-icon.png",
  "./icons/icon-192.png",
  "./icons/icon-512.png",
  "./icons/icon-maskable-512.png",
  "./icons/favicon-32.png",
];

self.addEventListener("install", (ereignis) => {
  ereignis.waitUntil(caches.open(CACHE).then((c) => c.addAll(DATEIEN)).then(() => self.skipWaiting()));
});

self.addEventListener("activate", (ereignis) => {
  ereignis.waitUntil(
    caches.keys()
      .then((schluessel) => Promise.all(schluessel.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", (ereignis) => {
  const anfrage = ereignis.request;
  if (anfrage.method !== "GET" || new URL(anfrage.url).origin !== self.location.origin) return;
  const seite = anfrage.mode === "navigate";
  ereignis.respondWith(
    caches.open(CACHE).then(async (speicher) => {
      const gespeichert = await speicher.match(seite ? "./index.html" : anfrage, { ignoreSearch: true });
      const frisch = fetch(anfrage)
        .then((antwort) => {
          if (antwort && antwort.status === 200 && antwort.type === "basic") {
            speicher.put(seite ? "./index.html" : anfrage, antwort.clone());
          }
          return antwort;
        })
        .catch(() => null);
      if (gespeichert) {
        ereignis.waitUntil(frisch);
        return gespeichert;
      }
      return (await frisch) || new Response("Die App ist noch nicht auf diesem Gerät gespeichert und gerade offline.", {
        status: 503,
        headers: { "Content-Type": "text/plain; charset=utf-8" },
      });
    })
  );
});
