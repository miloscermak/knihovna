# Knihovna Čermáka a Staňka - Landing Page

## 📋 Přehled projektu

Minimalistická landing page pro kulturní klub "Knihovna Čermáka a Staňka" s integrovaným administračním rozhraním. Design inspirovaný webem Edison Filmhub s důrazem na typografii, eleganci a funkčnost.

## 🎨 Design koncept

### Vizuální styl
- **Minimalistický design** s důrazem na typografii a velkorysý white space
- **Barevná paleta**: 
  - Primární černá (#1a1a1a)
  - Čistá bílá (#ffffff)
  - Odstíny šedé (#f5f5f5, #888888, #333333)
  - Akcentová zlatá (#c9a961)
- **Typografie**: Systémové fonty (San Francisco, Segoe UI, Roboto) pro optimální čitelnost
- **Fotografie**: Velkoformátové, atmosférické snímky (placeholder SVG v demo verzi)

### Struktura stránky

1. **Navigace**
   - Fixní hlavička s průhledným pozadím
   - Efekt při scrollování (přidání stínu)
   - Responzivní hamburger menu pro mobilní zařízení

2. **Hero sekce**
   - Celostránkové pozadí
   - Velký název klubu
   - Podtitul: "Prostor pro literaturu, diskuzi a setkávání"
   - CTA tlačítko pro rychlý přesun na program

3. **O klubu**
   - Dvousloupcový layout (text + fotografie)
   - Informace o poslání a atmosféře klubu
   - Otevírací doba
   - Efekt černobílých fotografií s barevným hover efektem

4. **Program akcí**
   - Elegantní řádkové zobrazení inspirované Edison Filmhub
   - Filtry podle typu události
   - Skupinování podle měsíců
   - Hover efekty pro lepší interaktivitu

5. **Kontakt & Lokace**
   - Adresa a kontaktní údaje
   - Placeholder pro interaktivní mapu
   - Odkazy na sociální sítě

6. **Patička**
   - Newsletter formulář
   - Copyright informace

## ⚙️ Administrační rozhraní

### Přístup
- **Tlačítko ⚙** v pravém dolním rohu
- **Klávesová zkratka**: Ctrl+Shift+A
- Vysuvný panel zprava

### Funkce administrace

#### 1. Správa událostí
- **Přidávání nových událostí** s následujícími poli:
  - Název události
  - Typ (Autorské čtení, Diskuze, Workshop, Film)
  - Datum a čas
  - Popis
- **Seznam všech událostí** s možností mazání
- Automatické ukládání do localStorage

#### 2. Editace textů
- Možnost upravit text v sekci "O nás"
- Okamžité zobrazení změn na stránce

#### 3. Newsletter
- Sběr e-mailových adres
- Ukládání do localStorage

## 💾 Datové úložiště

### localStorage klíče
- `events` - pole všech událostí
- `aboutText` - text sekce O nás
- `subscribers` - seznam přihlášených k newsletteru

### Struktura události
```javascript
{
  id: number,           // Unikátní ID (timestamp)
  title: string,        // Název události
  type: string,         // Typ: 'cteni', 'diskuze', 'workshop', 'film'
  date: string,         // Datum ve formátu YYYY-MM-DD
  time: string,         // Čas ve formátu HH:MM
  description: string   // Popis události
}
```

## 🎯 Interaktivní prvky

### Animace a efekty
- **Fade-in animace** při scrollování (Intersection Observer)
- **Smooth scrolling** mezi sekcemi
- **Hover efekty** na všech interaktivních prvcích
- **Transition efekty** pomocí CSS cubic-bezier

### JavaScript funkcionality
- Dynamické renderování událostí
- Filtrování podle typu události
- Skupinování událostí podle měsíců
- Automatické řazení podle data
- Responzivní mobilní menu
- Admin panel toggle

## 📱 Responzivní design

### Breakpointy
- Desktop: 768px+
- Mobile: <768px

### Mobilní úpravy
- Hamburger menu
- Jednosloupcové layouty
- Vertikální zobrazení událostí
- Plná šířka admin panelu

## 🚀 Nasazení a další kroky

### Aktuální stav
- Plně funkční HTML/CSS/JS v jednom souboru
- Data uložená v localStorage
- Připraveno k okamžitému použití

### Doporučené vylepšení pro produkci

1. **Backend integrace**
   - Nahradit localStorage databází (PostgreSQL, MySQL)
   - API endpoints pro CRUD operace
   - Autentizace pro admin panel

2. **Vylepšení obsahu**
   - Nahradit placeholder obrázky skutečnými fotografiemi
   - Integrace Google Maps
   - Propojení se sociálními sítěmi

3. **Rozšíření funkcí**
   - Rezervační systém na události
   - Online platby
   - Automatické e-maily
   - RSS feed událostí
   - Kalendářová integrace (iCal export)

4. **SEO optimalizace**
   - Meta tagy
   - Strukturovaná data (Schema.org)
   - Sitemap
   - Open Graph tagy

5. **Performance**
   - Lazy loading obrázků
   - Minifikace CSS/JS
   - CDN pro statické soubory
   - Service Worker pro offline funkcionalitu

## 📝 Ukázková data

Stránka obsahuje 8 předvyplněných událostí různých typů:
- Autorská čtení (Petr Novák, Anna Bolavá, Slam poetry)
- Workshopy (Tvůrčí psaní, Dětská dílna)
- Diskuze (Budoucnost knihoven, Filozofická kavárna)
- Film (Projekce: Paterson)

## 🔧 Technické detaily

### Použité technologie
- Čisté HTML5
- CSS3 s CSS Variables
- Vanilla JavaScript (ES6+)
- localStorage API
- Intersection Observer API

### Kompatibilita
- Moderní prohlížeče (Chrome, Firefox, Safari, Edge)
- iOS Safari
- Android Chrome

### Velikost
- Celý soubor: ~25 KB
- Žádné externí závislosti
- Rychlé načítání

## 📞 Kontakt pro další vývoj

Pro implementaci backendu, databáze nebo dalších funkcí je potřeba:
1. Webový server (Node.js, PHP, Python)
2. Databáze (PostgreSQL doporučeno)
3. Hosting (Vercel, Netlify, vlastní VPS)
4. Doména a SSL certifikát

---

*Vytvořeno jako moderní, elegantní a funkční řešení pro prezentaci kulturního klubu s inspirací z nejlepších současných webových designů.*