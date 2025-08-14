# Knihovna Čermáka a Staňka

Multifunkční kulturní klub s moderním webem pro správu událostí a galerie.

## 🌟 Funkce

- **Moderní responzivní design** s Tailwind CSS
- **Program událostí** s fotkami a linky na vstupenky
- **Galerie** s možností správy přes admin panel
- **Newsletter** pro přihlášení k odběru novinek
- **Admin panel** pro správu obsahu
- **Supabase integrace** s localStorage fallback

## 🚀 Živá verze

Web je dostupný na: [https://miloscermak.github.io/knihovna/](https://miloscermak.github.io/knihovna/)

## 📱 Administrace

Admin panel je dostupný na: [https://miloscermak.github.io/knihovna/admin.html](https://miloscermak.github.io/knihovna/admin.html)

**Heslo:** `knihovna2024`

### Admin funkce:
- ➕ Přidávání událostí s fotkami a eshop linky
- 🖼️ Správa galerie (přidávání/mazání fotek)
- 📝 Úprava obsahu webu (O nás, kontakty)
- 📊 Statistiky (události, newsletter, galerie)
- 📧 Export newsletter přihlášení

## 🎯 Typy událostí

- **Standup** - Stand-up comedy večery
- **Diskuze** - Tematické debaty s odborníky  
- **Kvízy** - Týmové kvízy různých tematik
- **Autorská čtení** - Literární večery
- **Workshopy** - Vzdělávací akce
- **Film** - Filmové projekce

## 🏗️ Technologie

- **Frontend:** Vanilla HTML, CSS, JavaScript
- **Styling:** Tailwind CSS (CDN)
- **Backend:** Supabase (PostgreSQL)
- **Storage:** localStorage (fallback)
- **Hosting:** GitHub Pages

## 📁 Struktura

```
/
├── index.html          # Hlavní stránka webu (přesměrování)
├── knihovna.html       # Kompletní web s všemi funkcemi
├── admin.html          # Administrační panel
├── CLAUDE.md          # Instrukce pro AI asistenta
├── knihovna-docs.md   # Původní dokumentace
└── README.md          # Tento soubor
```

## 🛠️ Nastavení pro development

1. **Klonování:**
   ```bash
   git clone https://github.com/miloscermak/knihovna.git
   cd knihovna
   ```

2. **Lokální testování:**
   - Otevřete `knihovna.html` v prohlížeči
   - Pro admin panel otevřete `admin.html`

3. **Supabase konfigurace:**
   - URL a klíče jsou již nastavené v kódu
   - Funguje localStorage fallback při nedostupnosti

## 🎨 Design

Web kombinuje moderní Tailwind CSS design s funkčností původního vanilla JS kódu. Inspirace z frontend/src složky byla převedena na čistý HTML/CSS/JS stack.

### Barevné schéma:
- **Primární:** Černá (#000000)
- **Akcent:** Červená (#DC2626) 
- **Pozadí:** Šedá (#F9FAFB)
- **Text:** Černá s šedými odstíny

## 📞 Kontakt

**Knihovna Čermáka a Staňka**  
Národní 28, 110 00 Praha 1  
Email: info@knihovnacs.cz  
Tel: +420 234 567 890

---

Vytvořeno s ❤️ a Claude Code