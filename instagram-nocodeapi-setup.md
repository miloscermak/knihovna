# Instagram Feed - NoCodeAPI Setup Guide

## Automatické načítání Instagram feedu pro @cermakstanekcomedy

Implementovali jsme hybridní řešení, které používá **NoCodeAPI** pro automatické načítání Instagram fotek, s fallback na ruční správu přes admin panel.

## Nastavení NoCodeAPI

### 1. Registrace na NoCodeAPI
1. Jděte na https://nocodeapi.com/
2. Registrujte se zdarma (má free tier)
3. Vytvořte nový projekt

### 2. Nastavení Instagram API
1. V NoCodeAPI dashboardu klikněte na "Add API"
2. Vyberte "Instagram"
3. Postupujte podle instrukcí pro připojení vašeho Instagram účtu @cermakstanekcomedy
4. Zkopírujte váš API endpoint URL

### 3. Aktualizace webu
V souboru `knihovna.html` na řádku 313 nahraďte:
```html
url="https://v1.nocodeapi.com/YOUR_ENDPOINT_HERE/instagram/YOUR_KEY_HERE"
```

Za váš skutečný endpoint z NoCodeAPI.

## Jak to funguje

### 🚀 Primární řešení: NoCodeAPI
- **Automatické načítání** z Instagram účtu @cermakstanekcomedy
- **Real-time aktualizace** - nové fotky se zobrazí automaticky
- **Žádná ruční správa** nutná
- **Stylování podle designu** webu

### 🔄 Fallback řešení: Admin panel
- Pokud NoCodeAPI nefunguje, automaticky se přepne na ruční správu
- Admin panel zůstává dostupný na `admin.html`
- Fotky se načítají z Supabase databáze
- Fallback se aktivuje automaticky po 3 sekundách

## Výhody tohoto řešení

✅ **Plně automatické** - nové Instagram fotky se zobrazí bez zásahu  
✅ **Spolehlivé** - má fallback pokud služba nefunguje  
✅ **Rychlé** - načítá se přímo z Instagramu  
✅ **Bezpečné** - používá oficiální způsoby přístupu  
✅ **Stylované** - respektuje design webu  

## Troubleshooting

### Pokud NoCodeAPI nefunguje
1. Zkontrolujte endpoint URL v kódu
2. Ověřte, že máte správně nastavenou integraci na NoCodeAPI
3. Zkontrolujte console v prohlížeči pro chybové hlášky
4. Fallback systém automaticky převezme kontrolu

### Pokud chcete upravit fallback fotky
1. Otevřete `admin.html`
2. Přihlaste se heslem "knihovna2024"  
3. V sekci "Správa Instagram fotek" přidejte/odeberte fotky
4. Tyto se zobrazí pouze pokud NoCodeAPI nefunguje

## Náklady

- **NoCodeAPI Free tier**: Obvykle stačí pro malé weby
- **Paid tier**: Pokud překročíte limity free verze
- **Fallback**: Zdarma (používá vaši Supabase databázi)

## Next Steps

1. **Nastavte NoCodeAPI endpoint** podle instrukcí výše
2. **Testujte funkčnost** - publikujte novou fotku na Instagram
3. **Ověřte fallback** - dočasně vypněte NoCodeAPI a zkontrolujte admin panel
4. **Customizace** - pokud chcete upravit vzhled, editujte CSS třídy

---

Tento systém vám poskytuje nejlepší z obou světů - plnou automatizaci s bezpečnou zálohou!