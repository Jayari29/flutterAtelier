# Copilot Instructions for Atelier de Développement Mobile Flutter - UX/UI Frontend

## Project Overview
This project is a Flutter mobile app focused on learning and applying Material Design 3 (Material You) principles. It is organized as a series of practical workshops (ateliers) that guide the developer through building modern UI components and layouts using Material 3 widgets, colors, and typography.

## Key Files & Structure
- `main.dart`: Entry point. Switches between workshop pages (e.g., `ProfilePageM3`, `ProductListPageM3`).
- `atelier1.dart`: Implements a Material 3 user profile page with advanced UI elements.
- `atelier2.dart`: Implements a Material 3 product list with cards, badges, and actions.
- `images/`: Place user profile images and other assets here.

## Essential Patterns & Conventions
- **Material 3 Only**: Always use `ThemeData(useMaterial3: true)` and Material 3 widgets.
- **Color & Typography**: Use `Theme.of(context).colorScheme` and `textTheme` for all colors and text styles. Do not hardcode colors or fonts.
- **Widget Structure**: Follow the provided skeletons and TODOs. Use `Stack`, `Wrap`, `Card`, and `FloatingActionButton.extended` as shown in the atelier instructions.
- **Stateless Widgets**: Prefer `StatelessWidget` unless state is required.
- **Helper Functions**: Place UI helper functions (e.g., `_buildStatChip`) above the `build` method.
- **Testing**: Switch the `home:` property in `main.dart` to test different ateliers.

## Developer Workflows
- **Run & Test**: Use `flutter run` on a device/emulator. Hot reload is recommended for rapid iteration.
- **Asset Management**: Add images to the `images/` directory and reference them in widgets (e.g., `AssetImage('images/person1.png')`).
- **Debugging**: Use `debugPrint` for simple logging in button actions.

## Integration & Dependencies
- **No external dependencies** beyond Flutter SDK and Material 3.
- **No backend or API integration** in these ateliers.

## Examples
- Profile photo with badge: Use `Stack` and `CircleAvatar` as in Atelier 1.
- Product card with badge: Use `Stack` and conditional rendering as in Atelier 2.

## Resources
- [Material 3 for Flutter](https://m3.material.io/develop/flutter)
- [Flutter Material Widgets](https://docs.flutter.dev/ui/widgets/material)
- [Flutter Layout Widgets](https://docs.flutter.dev/ui/widgets/layout)

---

**When adding new features or ateliers:**
- Follow the structure and conventions above.
- Keep UI code modular and leverage Material 3 components.
- Document any new patterns in this file.
