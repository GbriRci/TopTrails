# 🚵🏻 Top Trails

**Top Trails** è un'applicazione mobile progettata per facilitare la **scoperta di sentieri, camminate e percorsi naturalistici**. L'obiettivo è offrire uno strumento intuitivo sia agli escursionisti esperti che ai principianti, rendendo più semplice l'esplorazione del territorio con percorsi adatti a diverse esigenze e livelli di esperienza.

Gli utenti possono cercare itinerari dalla propria posizione, esplorare la mappa interattiva o utilizzare la funzione di ricerca, applicando filtri per difficoltà e lunghezza. L'app consente inoltre di salvare i percorsi preferiti in cartelle personalizzabili e di tenere traccia delle escursioni completate.

## ✨ Funzionalità Principali

* **Ricerca Avanzata:** Trova itinerari dalla tua posizione attuale, tramite mappa interattiva o barra di ricerca.
* **Filtri Personalizzabili:** Filtra i risultati per livello di difficoltà e lunghezza del percorso.
* **Gestione Percorsi:** Salva i percorsi preferiti in cartelle personalizzabili e tieni un registro delle escursioni completate.
* **Personalizzazione:** Tema chiaro/scuro, recupero password e personalizzazione delle cartelle con nome e immagine.
* **Multilingua:** Supporto per diverse lingue basato sulle impostazioni locali del dispositivo.

## 🚀 Architettura e Tecnologie

Top Trails sfrutta diverse API e librerie per offrire un'esperienza ricca e funzionale:

### 🧩 API Utilizzate

* **Firestore:** Per la gestione dei dati utente, delle cartelle e dei percorsi completati.
* **Supabase:** Per l'hosting e la gestione delle immagini.
* **Overpass API:** Per filtrare e recuperare dati su percorsi e sentieri da OpenStreetMap.
* **Nominatim:** Per la geocodifica, convertendo nomi di luoghi in coordinate geografiche.

### 📚 Librerie Principali

L'applicazione è sviluppata in **Flutter**, utilizzando un'ampia gamma di librerie per gestire interfaccia utente, navigazione, autenticazione, mappe e accesso a sensori del dispositivo:

* `flutter/material.dart`, `go_router`, `http`, `firebase_auth`, `cloud_firestore`, `supabase_flutter`.
* `flutter_bloc` (per il pattern BLoC), `flutter_map`, `geolocator`, `latlong2`.
* `image_picker`, `camera`, `url_launcher`, `shared_preferences`, tra le altre.
