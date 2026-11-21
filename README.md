# Munchly — Food Delivery App

A Flutter food delivery mobile application developed according to the authentic Figma design **"Munchly — Food Delivery App Design (Community)"** (`Munchly App UI – 5 Screen`) and integrated with live authentication REST APIs.

---

## 📱 Implemented Screens & User Flow

The app features the 5 core user journey screens (+ 1 storefront detail screen) directly inspected from the Figma design:

1. **Splash Screen (`/`)**:
   - Rich warm orange brand gradient (`#FF6540` to `#FF451D`) with subtle geometric circular ambient art.
   - Steaming bowl squircle icon with sparkle stars, "Munchly", "Crave it. Get it.", animated 3-dot loading indicator, and "Finding tasty spots near you".
   - Automatically initializes session from `SharedPreferences` and navigates smoothly.

2. **Onboarding Screen (`/onboarding`)**:
   - Soft warm cream canvas (`#FBF9F6`).
   - Top `Skip` pill button.
   - Dynamic food cards collage: Artisan pizza hero card with floating rating badge (`★ 4.8 · 1.2k reviews`) and time badge (`⏱ 25-35 min`), avocado salad bowl with `✓ Free delivery` tag, and fresh sushi platter.
   - Exact typography: *"Your favourite food, one tap away."* with subtitle and 3-dot page indicator.
   - Orange CTA pill: `Next →`.

3. **Login Screen (`/login`)**:
   - Munchly brand header with bowl squircle.
   - Real-time client-side validation for empty fields, email format, and password length.
   - Password visibility toggle (`Icons.visibility` / `Icons.visibility_off`).
   - Deep charcoal CTA (`#1E1B18`): `Log in` with loading spinner.
   - Integrated with live POST `/api/auth/login` endpoint supporting both email and mobile identifiers.
   - Full error handling for invalid credentials, connection timeout, and network failures.
   - Social sign-in options (`Google` and `Apple`) and link to Sign Up.

4. **Sign Up / Registration Screen (`/register`)**:
   - Fields: Full Name, Email Address, Mobile Number, Gender Selection, and Create Password.
   - Modern pill chip selection for Gender (`Male` / `Female` / `Other`).
   - Interactive square rounded checkbox for *Terms of Service & Privacy Policy*.
   - Live POST `/api/auth/register` integration handling duplicate email/mobile conflicts, validation errors, and loading states.
   - Seamless transition to Home Screen upon account creation.

5. **Home Dashboard Screen (`/home`)**:
   - Top bar: `DELIVER TO` -> `📍 Home · 14 Oakfield Rd ⌵`, notification bell with unread dot, and user profile avatar with logout sheet.
   - Search bar with magnifying glass and dark filter button (`#1E1B18`).
   - Promotional Hero Card: Orange gradient card with `FIRST ORDER` chip, *"30% off your first order"*, and `Use code MUNCH30` pill.
   - Horizontal category browser with circular imagery (`Pizza`, `Burgers`, `Sushi`, `Healthy`, `Desserts`).
   - **Popular near you**: Cards for `Napoli Street Pizza` (`20% OFF` badge, `★ 4.8 (1.2k)`, `⏱ 25-35 min`, `£1.49 delivery · Italian`, favorite toggle) and `Burger Barn`. Tapping `Napoli Street Pizza` navigates to the storefront menu.
   - **Order again**: Reorder cards for `Sakura Sushi` and `Green Bowl`.
   - Floating bottom navigation dock (`Home`, `Search`, `Orders`, `Profile`).

6. **Restaurant / Menu Detail Screen (`/restaurant-detail`)**:
   - Full-width hero photograph of Margherita pizza with circular Back, Share, and Favorite buttons.
   - Overlapping white rounded card (radius `24px`): Title, golden rating badge `★ 4.8 (1.2k)`, cuisine/distance metadata, delivery fee, and auto-applied `20% off orders over £20` banner.
   - Horizontal category chips (`Popular`, `Pizzas`, `Sides`, `Drinks`, `Desserts`).
   - Menu items: `Margherita` (`BESTSELLER`), `Diavola`, `Garlic Bread`, `Tiramisu` (`NEW`) with photos, descriptions, and circular orange `+` add-to-cart buttons.
   - Floating dark charcoal cart bar: Interactive item count badge and live total price (`View basket` · `£24.98`).

---

## 🛠️ Architecture & Technology Stack

- **Framework**: Flutter (Dart SDK `^3.10.4`)
- **State Management**: `Provider` (`ChangeNotifierProvider`, `AuthProvider`)
- **Networking**: `Dio` (`^5.7.0`) with custom request interceptor, timeout handling (25s), and structured error translation
- **Session Persistence**: `SharedPreferences` for token and profile storage
- **Typography & Theme**: `Google Fonts` (Plus Jakarta Sans) with light warm theme tokens
- **Project Structure**:
  ```
  lib/
  ├── main.dart
  ├── core/
  │   ├── constants/
  │   │   ├── api_constants.dart
  │   │   ├── app_colors.dart
  │   │   └── app_strings.dart
  │   ├── theme/
  │   │   └── app_theme.dart
  │   └── utils/
  │       └── validators.dart
  ├── models/
  │   ├── auth_response_model.dart
  │   ├── login_model.dart
  │   └── register_model.dart
  ├── services/
  │   └── auth_service.dart
  ├── providers/
  │   └── auth_provider.dart
  ├── screens/
  │   ├── auth/
  │   │   ├── login_screen.dart
  │   │   └── register_screen.dart
  │   ├── home/
  │   │   └── home_screen.dart
  │   ├── onboarding/
  │   │   └── onboarding_screen.dart
  │   ├── restaurant/
  │   │   └── restaurant_detail_screen.dart
  │   └── splash/
  │       └── splash_screen.dart
  ├── widgets/
  │   ├── custom_app_bar.dart
  │   ├── custom_button.dart
  │   ├── custom_text_field.dart
  │   └── loading_widget.dart
  └── routes/
      └── app_routes.dart
  ```

---

## 🔌 API Endpoints Integrated

- **Base URL**: `https://shoply-kj50.onrender.com/api`
- **Login**: `POST /auth/login`
  - Body: `{"identifier": "...", "password": "..."}`
  - Supports email or mobile number as identifier.
  - Returns JWT token and user ID on HTTP 200.
- **Registration**: `POST /auth/register`
  - Body: `{"name": "...", "email": "...", "password": "...", "mobile": "...", "gender": "male"}`
  - Returns JWT token and success message on HTTP 201.

---

## 🚀 Setup & Execution Instructions

1. **Clone or Open in Android Studio / VS Code**:
   ```bash
   cd "d:\android projects\munchly"
   ```

2. **Fetch Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run Static Analysis & Tests**:
   ```bash
   flutter analyze
   flutter test
   ```

4. **Launch Application**:
   ```bash
   flutter run
   ```

5. **Generate Release APK**:
   ```bash
   flutter build apk --release
   ```
   The generated APK will be placed at:
   `build/app/outputs/flutter-apk/app-release.apk`
