# 🔧 Guide Matériel ACW02

Choisissez la carte ESP32 qui correspond le mieux à vos besoins et votre budget.

---

## 🎯 Quelle Carte ESP32 Choisir ?

### 🥇 **[ESP32 D1 Mini WROOM 32](esp32-d1-mini.md)** - *Recommandé pour débuter*
- ✅ **Le plus testé et documenté**
- ✅ **Bouton reset intégré** dans le boîtier
- ✅ **Prix abordable** (6-10€)
- ✅ **Large disponibilité**
- ❌ Signal Wi-Fi correct mais pas optimal
- ❌ Pas d'antenne externe

### 🥈 **[LOLIN ESP32 C3 Mini](esp32-c3-mini.md)** - *Meilleur signal Wi-Fi*
- ✅ **Signal Wi-Fi amélioré** vs ESP32 D1 Mini
- ✅ **Bouton reset intégré**
- ✅ **Architecture moderne** (RISC-V)
- ✅ **USB-C natif**
- ❌ Prix légèrement supérieur (8-12€)
- ❌ Pas d'antenne externe

### 🥉 **[XIAO ESP32 C3](xiao-esp32-c3.md)** - *Performance Wi-Fi maximale*
- ✅ **Meilleur signal Wi-Fi** avec antenne externe
- ✅ **Format ultra-compact**
- ✅ **USB-C natif**
- ✅ **Qualité Seeed Studio**
- ❌ **Pas de bouton reset** dans le boîtier
- ❌ Prix élevé (12-15€ avec antenne)

### ⚠️ **[XIAO ESP32 C6](xiao-esp32-c6.md)** - *Pour experts uniquement*
- ✅ **Wi-Fi 6 (802.11ax)** - Le plus récent
- ✅ **Architecture très moderne**
- ❌ **Antenne externe OBLIGATOIRE** (signal interne inutilisable)
- ❌ **Prix le plus élevé** (15-20€)
- ❌ **Moins testé** que les autres versions

---

## 🛠️ Comparaison Rapide

| Critère | D1 Mini | LOLIN C3 | XIAO C3 | XIAO C6 |
|---------|---------|----------|---------|---------|
| **🏆 Recommandation** | Débutant | Intermédiaire | Avancé | Expert |
| **📶 Signal Wi-Fi** | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **🔘 Bouton Reset** | ✅ | ✅ | ❌ | ❌ |
| **📡 Antenne Externe** | ❌ | ❌ | ✅ | ✅ Obligatoire |
| **💰 Prix Total** | €€ | €€€ | €€€€ | €€€€€ |
| **🧪 Maturité** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |

---

## 🎯 Guide de Choix par Situation

### 🏠 **Première Installation**
→ **[ESP32 D1 Mini WROOM 32](esp32-d1-mini.md)**
- Le plus documenté et testé
- Bouton reset pratique
- Prix abordable pour essayer

### 📶 **Problème de Signal Wi-Fi**
→ **[LOLIN ESP32 C3 Mini](esp32-c3-mini.md)** ou **[XIAO ESP32 C3](xiao-esp32-c3.md)**
- Signal amélioré garanti
- XIAO C3 si antenne externe possible

### 💰 **Budget Serré**
→ **[ESP32 D1 Mini WROOM 32](esp32-d1-mini.md)**
- Solution la moins chère
- Performance largement suffisante

### 🔬 **Installation Permanente Haut de Gamme**
→ **[XIAO ESP32 C3](xiao-esp32-c3.md)** avec antenne externe
- Meilleure performance à long terme
- Format compact et moderne

---

## 🧩 Composants Communs

Quelle que soit la carte choisie, vous aurez besoin de :

### 🔌 Alimentation
- **[Régulateur 12V → 5V D24V10F5](https://shop.mchobby.be/fr/regulateurs/554--regul-5v-1a-step-down-d24v10f5-3232100005549-pololu.html)** (x1)

### 📡 Convertisseur de Niveau Logique
**Choisissez une option :**

#### Option 1 : Module Standard (Économique)
- **[Convertisseur 4 canaux CYT1076](https://amzn.eu/d/2MhG08s)** (x1)
- **Prix** : 3-5€
- **Disponibilité** : Immédiate

#### Option 2 : Assemblage JLCPCB (Performance)
- **[Guide d'assemblage JLCPCB](jlcpcb-guide.md)**
- **Prix** : 3-5€ par pièce (minimum 5)
- **Qualité** : Industrielle, optimisée UART

### 🔗 Connecteurs et Broches
- **Broches mâles** 2.54mm (quantité selon la carte)
- **Connecteur JST XA 2.5** mâle 4 pins (direction inversée)

### 📋 Carte PCB
Fichiers Gerber disponibles selon votre carte :
- **ESP32 D1 Mini** : PCB dédié
- **LOLIN C3, XIAO C3/C6** : PCB commun

---

## 🖨️ Impression 3D

### 📂 Fichiers STL Disponibles

#### Pour ESP32 D1 Mini
- **Dossier** : `3Dfiles/D1-MIMI/`
- **Versions** : Boîtier standard + version ventilée
- **Accessoires** : Bouton reset, support de soudure

#### Pour LOLIN C3 / XIAO C3-C6
- **Dossier** : `3Dfiles/LOLIN-C3-XIAO-C3-C6/`
- **Boîtier** : Commun aux 3 cartes
- **Supports d'antenne** : Rigide, flexible (horizontal/vertical/libre)

### 🎨 Matériaux d'Impression Recommandés
| Matériau | Compatible | Notes |
|----------|------------|-------|
| **PETG** | ✅ **Recommandé** | Résistance thermique ~80°C |
| **ABS** | ✅ Bon | Résistance thermique élevée |
| **ASA** | ✅ Excellent | Résistant UV pour extérieur |
| **PC** | ✅ Premium | Très résistant et haute température |
| **PLA** | ❌ **Éviter** | Ramollit à 45-50°C |

---

## 🛒 Où Acheter les Composants

### 🛒 Fournisseurs Recommandés

#### Cartes ESP32
- **ESP32 D1 Mini** : AZDelivery, Elegoo (éviter les clones < 5€)
- **LOLIN C3** : [Store officiel WEMOS](https://fr.aliexpress.com/store/1331105)
- **XIAO C3/C6** : [Seeed Studio officiel](https://www.seeedstudio.com/)

#### Composants Électroniques
- **Europe** : Kubii, GoTronic, RS Components
- **International** : DigiKey, Mouser, Farnell
- **Budget** : AliExpress (attention à la qualité)

#### PCB
- **JLCPCB** : Fabrication PCB + assemblage
- **PCBWay** : Alternative à JLCPCB  
- **AllPCB** : Option économique

---

## 📋 Liste de Courses Complète

### 🎯 Configuration Débutant (ESP32 D1 Mini)
- [ ] ESP32 D1 Mini WROOM 32 (AZDelivery) - **8€**
- [ ] Régulateur D24V10F5 - **6€**
- [ ] Convertisseur CYT1076 - **4€**
- [ ] Connecteurs et broches - **3€**
- [ ] PCB JLCPCB (5 pièces) - **8€**
- **Total** : **~29€**

### 🎯 Configuration Performance (XIAO C3)
- [ ] XIAO ESP32 C3 - **10€**
- [ ] Antenne FPC 2.4GHz - **4€**
- [ ] Régulateur D24V10F5 - **6€**
- [ ] Convertisseur JLCPCB (5 pièces) - **15€**
- [ ] Connecteurs et broches - **3€**
- [ ] PCB JLCPCB (5 pièces) - **8€**
- **Total** : **~46€**

---

## 🔧 Prochaines Étapes

1. **[Choisir votre carte ESP32](esp32-d1-mini.md)** selon vos besoins
2. **[Commander les composants](#-où-acheter-les-composants)** selon votre budget
3. **[Suivre l'installation](../installation/)** adaptée à votre système
4. **[Imprimer le boîtier 3D](../../hardware_new/3d-files/)** correspondant
5. **[Configurer le firmware](../usage/configuration.md)** selon votre matériel

---

## 💡 Conseils d'Achat

### ✅ À Faire
- **Commencer simple** avec ESP32 D1 Mini si premier projet
- **Acheter des marques reconnues** (éviter les clones très bon marché)
- **Commander en plusieurs exemplaires** (en cas de problème)
- **Vérifier la compatibilité** PCB/boîtier/carte avant commande

### ❌ À Éviter
- **Cartes ESP32 < 5€** (souvent défaillantes)
- **Mélanger les versions** de PCB et boîtiers
- **Oublier l'antenne** si XIAO C6
- **Sous-estimer les délais** de livraison Chine (2-4 semaines)