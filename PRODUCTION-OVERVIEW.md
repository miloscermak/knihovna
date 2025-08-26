# Knihovna Čermáka a Staňka - Přehled produkce

Kompletní dokumentace současného stavu webové stránky a všech implementovaných funkcí.

## 🌐 Živé odkazy

- **Hlavní web**: https://miloscermak.github.io/knihovna/
- **Admin panel**: https://miloscermak.github.io/knihovna/admin-secure.html (🔒 Supabase Auth)
- **Archiv akcí**: https://miloscermak.github.io/knihovna/program.html
- **Archiv galerie**: https://miloscermak.github.io/knihovna/galerie.html

## 📁 Struktura projektu

```
knihovna/
├── knihovna.html          # Hlavní webová stránka
├── admin.html             # Administrační panel (legacy)
├── admin-secure.html      # Bezpečný admin s Supabase Auth
├── program.html           # Archiv všech akcí
├── galerie.html           # Archiv všech fotek
├── milos.avif            # Fotka Miloše Čermáka
├── ludek.avif            # Fotka Luďka Staňka
├── README.md             # Základní dokumentace
├── CLAUDE.md             # Instrukce pro Claude Code
├── PRODUCTION-OVERVIEW.md # Tento dokument
├── SUPABASE-AUTH-SETUP.md # Návod na nastavení bezpečné autentizace
├── instagram-*.md        # Návody pro Instagram integraci
├── supabase-auth-setup.sql # SQL migrace pro Supabase Auth
└── supabase-*.sql        # SQL migrace pro databázi
```

## 🏗️ Technická architektura

### Frontend Stack
- **HTML5 + CSS3** - Sémantický markup, moderní CSS
- **Tailwind CSS** - Utility-first CSS framework (CDN)
- **Vanilla JavaScript** - ES6+, žádné frameworky
- **Responsive design** - Mobile-first approach

### Backend & Data
- **Supabase** - PostgreSQL databáze + real-time API
  - URL: `https://eyfgtagudbvzorrdntdf.supabase.co`
  - Tabulky: `events`, `settings`, `gallery`, `newsletter`, `instagram_photos`
- **localStorage** - Fallback a offline funkcionalita
- **GitHub Pages** - Hosting a continuous deployment

### Databázové schéma

#### Tabulka `events`
```sql
- id (PRIMARY KEY)
- title (VARCHAR)
- date (DATE)
- time (TIME)
- description (TEXT)
- image (VARCHAR) - URL obrázku
- shop_link (VARCHAR) - Link na vstupenky
- button_text (VARCHAR) - Vlastní text tlačítka
- created_at (TIMESTAMP)
```

#### Tabulka `settings`
```sql
- id (PRIMARY KEY)
- key (VARCHAR UNIQUE) - klíč nastavení
- value (TEXT) - hodnota
- updated_at (TIMESTAMP)
```

#### Tabulka `gallery`
```sql
- id (PRIMARY KEY)
- url (VARCHAR) - URL fotky
- description (VARCHAR) - popis
- date/created_at (TIMESTAMP)
```

## 🎯 Hlavní funkce

### 🏠 Hlavní stránka (knihovna.html)

#### Sekce
1. **Hero sekce** - 70vh výška, call-to-action
2. **O nás** - Editovatelný text přes admin
3. **Program** - Max 10 nejbližších akcí
4. **Tým** - Miloš & Luděk s fotkami a popisky
5. **Instagram** - Skrytá sekce (připravena pro budoucí aktivaci)
6. **Galerie** - Max 12 fotek (3 řady)
7. **Kontakt** - Editovatelné kontaktní údaje

#### Klíčové funkce
- **Auto-refresh** - Každých 15 sekund
- **Supabase + localStorage** - Dual data strategy
- **Admin overlay** - Ctrl+Shift+A nebo ikona ⚙
- **Event detail modal** - Detaily akcí s fotkami
- **Responsive design** - Hamburger menu na mobilu

### 🔧 Admin panel (admin.html)

#### Správa obsahu
- **Události** - CRUD operace, fotky, eshop linky
- **Galerie** - Přidávání/mazání fotek přes URL
- **Instagram fotky** - Fallback správa pro automatický feed
- **Obsah webu** - "O nás", kontakty, otevírací doby
- **Newsletter** - Export přihlášených emailů

#### Statistiky
- Počet událostí
- Počet přihlášených k newsletteru
- Nadcházející události
- Počet fotek v galerii

#### Bezpečnost
- **🚨 MIGRACE NA SUPABASE AUTH (26.8.2025)** 
- **Nový admin**: admin-secure.html s plnou Supabase autentizací
- **Starý admin**: admin.html (legacy, nedoporučeno pro produkci)
- **Row Level Security** - RLS politiky na všech tabulkách
- **Server-side auth** - Žádné hardcoded hesla v kódu
- **Session management** - Automatické odhlašování při vypršení

### 📅 Archiv akcí (program.html)

#### Funkce
- **Kompletní seznam** všech akcí (aktuální + proběhlé)
- **Filtry**: Všechny / Nadcházející / Proběhlé
- **Event detail modal** - Stejný jako na hlavní stránce
- **Responzivní grid** - 1-3 sloupce podle obrazovky
- **Počítadlo akcí** - Dynamický počet podle filtru
- **Auto-refresh** - Každých 30 sekund

#### Design
- **Gradient hero** - Elegantní úvod
- **Event cards** - Hover efekty, datum prominentně
- **Indikace proběhlých** - Transparency + "Proběhlo" značka

### 🖼️ Archiv galerie (galerie.html)

#### Funkce
- **Nekonečná galerie** - Paginace po 20 fotkách
- **Modal viewer** - Fullscreen prohlížení
- **Navigace** - Šipky (myš + klávesnice)
- **Lazy loading** - "Načíst další fotky" tlačítko
- **Hover efekty** - Overlay s popiskem

#### Design
- **Tmavý theme** - Černé pozadí pro fotky
- **Masonry grid** - Dynamická mřížka
- **Plynulé animace** - Scale hover efekty

## 🎨 Design systém

### Barevné schéma
- **Primární**: Černá (#000000)
- **Akcent**: Červená (#DC2626, #EF4444)
- **Pozadí**: Bílá (#FFFFFF), Šedá (#F9FAFB)
- **Text**: Černá, šedé odstíny (#6B7280, #374151)

### Typography
- **Nadpisy**: Font-bold, različné velikosti (text-2xl až text-5xl)
- **Body text**: Font-normal, text-gray-600
- **Akcentní text**: Font-medium, červená barva

### Komponenty
- **Tlačítka**: Rounded-lg, hover efekty, transition-colors
- **Cards**: Shadow-lg, hover:shadow-xl, rounded-lg
- **Modaly**: Backdrop blur, centered, responsive
- **Grid**: Auto-responsive s gap-4/gap-6

## 📱 Responsivita

### Breakpointy
- **Mobile**: < 768px (default)
- **Tablet**: md: (768px+)
- **Desktop**: lg: (1024px+)

### Adaptace
- **Navigace**: Hamburger menu na mobilu
- **Grid**: 1 → 2 → 3 sloupce podle velikosti
- **Typography**: Menší texty na mobilu
- **Padding**: Responsive px-4 sm:px-6 lg:px-8

## 🔄 Data Flow & Synchronizace

### Strategie dat
1. **Primární: Supabase** - Real-time databáze
2. **Fallback: localStorage** - Offline funkcionalita
3. **Auto-sync** - Každých 15-60 sekund podle stránky

### Synchronizační události
- **Page load** - Načtení všech dat
- **Window focus** - Refresh při návratu na stránku
- **Storage events** - Sync mezi taby
- **Auto-refresh** - Periodické aktualizace

### Error handling
- **Try-catch** - Všechny async operace
- **Graceful degradation** - Fallback na localStorage
- **User feedback** - Console logy + alert zprávy

## 🌟 Speciální funkce

### Instagram integrace (připraveno)
- **NoCodeAPI** - Automatické načítání z @cermakstanekcomedy
- **Hybridní systém** - Auto + manuální fallback
- **Setup dokumentace** - instagram-nocodeapi-setup.md

### Newsletter systém
- **Email collection** - Ukládání do Supabase
- **Admin export** - Možnost stažení seznamu
- **Temporarily hidden** - Sekce je připravena, ale skrytá

### Admin overlay na hlavní stránce
- **Quick access** - Upravování textu přímo z hlavní stránky
- **Seamless UX** - Bez nutnosti přepínání stránek
- **Security** - Jen pro autentifikované uživatele

## 🚀 Deployment & CI/CD

### GitHub Pages
- **Auto-deploy** - Push na main branch = live update
- **Custom domain ready** - Možnost nastavení vlastní domény
- **HTTPS** - Automaticky zabezpečeno

### Git workflow
```bash
git add . 
git commit -m "Feature description"
git push origin main
# → Automaticky live za ~1 minutu
```

## 📊 Performance optimalizace

### Rychlost načítání
- **CDN resources** - Tailwind, Supabase z CDN
- **Image optimization** - AVIF formát pro team fotky
- **Lazy loading** - Galerie načítá postupně
- **Minimal JS** - Vanilla JavaScript, žádné frameworky

### SEO optimalizace
- **Semantic HTML** - Správné tagy (h1, nav, section, etc.)
- **Meta tags** - Title, viewport, charset
- **Alt texty** - Všechny obrázky mají popisy
- **Structured URLs** - Čisté linky bez parametrů

## 🔐 Bezpečnostní opatření

### Data protection
- **RLS (Row Level Security)** - Supabase úroveň
- **Public read, auth write** - Bezpečné API přístupy
- **No sensitive data exposure** - Žádné tajné klíče v kódu

### Admin security
- **🔒 SUPABASE AUTH (NEW)** - Server-side autentizace
- **Row Level Security** - Databázové políky pro ochranu dat
- **JWT tokeny** - Secure session management
- **Žádné hardcoded hesla** - Vše bezpečně uloženo v Supabase
- **Legacy admin.html** - Stále funkční, ale nedoporučeno

## 📈 Budoucí možnosti rozšíření

### Připravené funkce
1. **Instagram feed** - Jen aktivovat NoCodeAPI
2. **Newsletter** - Jen odkrýt sekci
3. **Multi-language** - Struktura připravena
4. **Events filtering** - Rozšíření kategorií
5. **User accounts** - Supabase Auth ready

### Technické vylepšení
- **PWA** - Service worker + offline cache
- **Push notifications** - Pro nové akce
- **Analytics** - Google Analytics integrace
- **A/B testing** - Různé verze stránek

## 🐛 Známé limitace

### Technické
- **No build process** - Vše přes CDN, žádný bundling
- **Client-side only** - Žádný server-side rendering
- **localStorage limits** - ~5MB limit na doménu

### Funkční
- **~~Admin password~~** - ✅ VYŘEŠENO: Implementován Supabase Auth
- **No user roles** - Jeden admin přístup (možnost rozšíření)
- **Manual image upload** - Přes URL, ne file upload

## 🛠️ Maintenance checklist

### Týdenní
- [ ] Zkontrolovat funkčnost všech stránek
- [ ] Ověřit synchronizaci dat
- [ ] Zkontrolovat admin panel

### Měsíční  
- [ ] Backup dat z Supabase
- [ ] Zkontrolovat performance
- [ ] Update dokumentace

### Podle potřeby
- [ ] ~~Změna admin hesla~~ → Nyní přes Supabase dashboard
- [ ] Přidání nových admin uživatelů přes Supabase Auth
- [ ] Přidání nových funkcí
- [ ] Design updates

## 📞 Kontakt & Podpora

### Repository
- **GitHub**: https://github.com/miloscermak/knihovna
- **Issues**: Pro bug reporty a feature requests

### Dokumentace
- **README.md** - Základní info
- **CLAUDE.md** - Instrukce pro AI asistenta
- **SUPABASE-AUTH-SETUP.md** - Návod na bezpečnou autentizaci
- **instagram-*.md** - Instagram integrace návody

## 🆕 Nedavné změny (26.8.2025)

### ✅ Implementace Supabase Auth
- **Bezpečnost**: Odstraněno hardcoded heslo `knihovna2024` z kódu
- **Nový admin panel**: `admin-secure.html` s plnou Supabase autentizací
- **SQL migrace**: Row Level Security políky pro všechny tabulky
- **Session management**: Automatické odhlašování a refresh tokenů
- **Dokumentace**: Kompletní návod v `SUPABASE-AUTH-SETUP.md`

### 🔄 Migrace
- **Hlavní stránka**: Admin gear a Ctrl+Shift+A nyní přesměrovává na secure admin
- **Legacy admin**: `admin.html` stále funkční pro zpětnou kompatibilitu
- **Production ready**: Bezpečné pro veřejné nasazení

---

*Posledni update: 26. srpna 2025*
*Status: ✅ Production Ready + 🔒 Security Enhanced*