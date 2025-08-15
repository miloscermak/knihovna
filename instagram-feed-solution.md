# Instagram Feed - Řešení pro Knihovna Čermáka a Staňka

## Problém s Instagram API

Instagram již nepodporuje jednoduché načítání fotek z veřejných účtů. Oficiální API vyžaduje:
- Facebook Developer Account
- Schválení aplikace
- Access tokeny s omezenou platností
- Složité obnovování tokenů

## Doporučená řešení

### 1. Admin panel pro Instagram fotky (DOPORUČENO)
- Rozšířit stávající admin panel o sekci "Instagram fotky"
- Ruční nahrávání/přidávání fotek přes URL
- Ukládání do Supabase stejně jako galerie
- Rychlé, spolehlivé, pod vaší kontrolou

### 2. Třetí strany služby (PLATNÉ)
- **Elfsight Instagram Feed** - $5-20/měsíc
- **SnapWidget** - zdarma s brandem, $3-9/měsíc bez
- **EmbedSocial** - $29-79/měsíc

### 3. Instagram Basic Display API (SLOŽITÉ)
- Vyžaduje Facebook Developer setup
- Komplikované token management
- Risk výpadků při změnách API

## Implementace doporučení

Přidám do admin panelu sekci pro správu "Instagram fotek" s možnostmi:
- Přidání fotky (URL)
- Popis/caption
- Datum přidání  
- Smazání fotky
- Zobrazení na webu v mřížce

Chcete implementovat tuto možnost?