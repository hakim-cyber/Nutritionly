

# Nutritionly

Nutritionly is a comprehensive iOS app built with Swift and SwiftUI, designed for users to track their calorie intake, nutrition, workouts, daily steps, and water consumption.

![App Screenshot](https://github.com/hakim-cyber/Nutritionly/assets/115820565/56d600be-dad1-4f18-83c6-f5298117d4b6)

---

## Features

- **Calorie & Nutrition Tracking:**  
  - Add food manually or from recent items.
  - Track daily totals for calories, protein, carbs, and fats.
  - Visualize nutrition breakdowns with custom UI elements.

- **Workout & Steps Tracking:**  
  - Integration with device health data for step counting.
  - Calculation of calories burned based on user profile (age, height, weight) and activity.
  - Dedicated views for tracking workouts.

- **Water Intake Monitoring:**  
  - Log water consumption and visualize progress.

- **User Profiles:**  
  - Store and display user details (name, email, age, height, gender).
  - View historical data (number of days tracked).
  - Editable profile section and detailed view.

- **Custom UI & Interactions:**  
  - Animated tab bar and switches for seamless navigation.
  - Custom cards and progress indicators.
  - Theming with dynamic colors and backgrounds.

- **Pro Features Overlay:**  
  - UI overlays promote premium features such as step, workout, and water tracking.

- **Local Storage & Sync:**  
  - Uses `UserDefaults` for settings like background color.
  - Firebase integration for data persistence and sync.
  - HealthKit integration (via `dataManager.healthRequest()`).

---

## Technical Overview

### Architecture

- **SwiftUI-first Design:**  
  All screens and components are built using SwiftUI, leveraging state management (`@State`, `@StateObject`, `@EnvironmentObject`) for reactive UI updates.

- **Data Management:**  
  - `NutritionData_Manager`: Handles data related to nutrition, workouts, steps, and water.  
  - `UserStore`: Manages user profile data and fetches user info.

- **Views & Components:**  
  - `MainView.swift`: The dashboard showing daily progress and summaries.
  - `AddFoodView.swift`, `ManualIngredAdding.swift`: Screens for adding and managing food items.
  - `CustomSwitch.swift`, `CustomTabBar.swift`: Custom UI controls for toggling and navigation.
  - `ProfileView.swift`, `ProfiledData.swift`: User profile and account management.
  - `NutritionsLine.swift`: Visualizes nutrition intake.
  - `overlayForPro.swift`: Promos for premium functionalities.

- **Firebase Integration:**  
  - App initializes Firebase in `NutritionlyApp.swift`.
  - Data sync and storage leverage Firebase and Firestore.

- **HealthKit Integration:**  
  - Used for step tracking and health-related authorizations.

- **Widget Support:**  
  - Imports `WidgetKit`, suggesting support for home screen widgets.

---

## Getting Started

1. **Requirements:**
   - Xcode 14+
   - iOS 15+
   - Firebase account and configuration (`GoogleService-Info.plist`)

2. **Installation:**
   - Clone the repo:  
     `git clone https://github.com/hakim-cyber/Nutritionly.git`
   - Open `Nutritionly.xcodeproj` in Xcode.
   - Add your Firebase config file.
   - Build and run on a simulator or device.

3. **Configuration:**
   - On first launch, configure profile data (age, height, etc.).
   - Authorize HealthKit for step tracking.

---

## Screenshots

![App Screenshot](https://github.com/hakim-cyber/Nutritionly/assets/115820565/56d600be-dad1-4f18-83c6-f5298117d4b6)

---

## Contribution

Interested in contributing? Fork the repo and submit a pull request! For major changes, please open an issue first to discuss what you’d like to change.

---

## License

This project is licensed under the MIT License.

---

## Contact

Developed by [hakim-cyber](https://github.com/hakim-cyber)  
For questions, open an issue or reach out via GitHub.

---

Let me know if you want this README added to your repository or need further customization!
