# AGENTS.md — AI Coding Agent Guidelines for Sanatan Sathiya

This document specifies the mandatory coding standards, architectural rules, and operational workflows that all AI coding agents and human developers must follow when contributing to **Sanatan Sathiya**.

---

## 1. Core Engineering Principles

- **Simplicity & Clarity**: Follow KISS (Keep It Simple, Stupid) and YAGNI (You Aren't Gonna Need It). Prefer clean, readable code over clever abstractions.
- **Maintainable & Pragmatic Design**: Apply SOLID principles, DRY (Don't Repeat Yourself), and layered architecture pragmatically. Do not introduce interfaces, repositories, extra abstractions, or unnecessary layers without a clear, concrete benefit.
- **Avoid Overengineering**: Do not add speculative layers, premature optimizations, or excessive wrapper interfaces unless there is a concrete, immediate requirement.

---

## 2. Dart Standards

- **Effective Dart Guidelines**: Adhere to official [Effective Dart](https://dart.dev/effective-dart) style rules.
- **Sound Null Safety & Types**:
  - Leverage sound null safety fully. Avoid force-unwrapping (`!`) unless proven non-null by local invariants.
  - Use `final` by default for variables and parameters.
  - Use `const` wherever compile-time immutability is possible.
  - Discourage `dynamic`, raw types, force-unwrapping (`!`), and explicit casts (`as`) by default; allow them when necessary, safe, and justified. Use explicit types where clarity is enhanced.
- **Data & Error Handling**:
  - Prefer immutable data structures (`copyWith`, `unmodifiable` collections).
  - Use meaningful naming conventions (`camelCase` for variables/functions, `PascalCase` for classes/enums, `snake_case` for files).
  - Handle exceptions explicitly; never leave empty `catch` blocks or suppress errors silently.

---

## 3. Flutter Standards

- **Widget Focus & Performance**:
  - Keep widgets small and single-purpose. Extract sub-views into dedicated StatelessWidget/StatefulWidget components when beneficial.
  - Keep `build()` methods pure, lightweight, and fast. Perform no async operations, heavy calculations, or side-effects inside `build()`.
  - Use `const` constructors for widgets to eliminate redundant rebuilds.
- **State Management & UI Architecture**:
  - Inspect the existing project architecture before introducing new state packages. The core foundation currently uses lightweight `ChangeNotifier` / `ValueNotifier` and `ListenableBuilder`.
  - Handle UI states appropriately for each feature (e.g. loading, empty, error, or success states where relevant to the screen's behavior) without adding unnecessary state overhead to static screens.
  - Follow Material 3 conventions, adhering to standard color schemes, typography, and adaptive layouts.
  - Ensure accessibility (semantics, tap targets) and localization readiness (Hindi/English support) when building relevant user-facing features. Support Light and Dark themes smoothly.

---

## 4. Architecture & Dependencies

- **Offline-First Application**:
  - **Sanatan Sathiya** is an offline-first, Android-first devotional companion. Do not introduce mandatory cloud backends, paid APIs, external authentication, or user tracking without explicit approval.
- **Layer Separation**:
  - **Presentation**: Screen views, reusable widgets, navigation shells.
  - **Domain / Logic**: App state, theme management, content services.
  - **Data / Models**: Data models, local storage, immutable schemas.
- **Dependency Management**:
  - Check whether existing Flutter/Dart SDK capabilities or installed packages already solve the problem before adding dependencies.
  - Evaluate maintenance status, license, size impact, security, and offline suitability before adding packages. Obtain approval before introducing significant dependencies, external backends, or paid services.

---

## 5. Testing & Quality Assurance

- **Test Coverage Requirements**:
  - Write unit tests for core logic, models, and services (`test/`).
  - Write widget tests for navigation, user interactions, and screen states.
- **Verification Workflow**:
  - Run `dart format`, `flutter analyze`, and relevant tests (`flutter test`) for meaningful changes when the environment supports it.
  - **Never claim tests passed unless executed and verified against actual command output.**
  - Do not weaken existing tests, ignore lints, or suppress warnings simply to pass builds.

---

## 6. Security, Privacy & Reliability

- **Data Privacy**:
  - Respect user privacy. Collect no personal identifiers or analytics without user consent.
  - Never hardcode API keys, passwords, or credentials in source code or commits.
- **Resource & Lifecycle Management**:
  - Properly dispose of controllers, streams, and change notifiers in `dispose()`.
  - Handle async operations safely across state lifecycles (`if (!mounted) return;`).

---

## 7. Maintainability & Incremental Changes

- **Surgical Edits**:
  - Make small, focused, complete changes.
  - Preserve existing working code and formatting style.
  - Do not perform mass edits, rewrite unrelated files, or reformat code outside your task scope.
- **Honest Reporting**:
  - Summarize modified files, executed commands, test results, and any open limitations.

---

## 8. AI Agent Workflow Protocol

When carrying out tasks in this repository:
1. **Inspect First**: Review existing files, dependencies, and patterns before modifying code.
2. **SDK Path Note**: On Windows development setups, use the configured local Flutter SDK at `E:\SDKs\flutter\bin\flutter.bat` if `flutter` is not in global PATH.
3. **Execution Steps**:
   - Formulate a brief plan.
   - Implement minimal complete changes.
   - Perform quality checks: run `dart format`, `flutter analyze`, and relevant tests (`flutter test`) for meaningful changes.
   - Perform accessibility and localization checks for user-facing features.
4. **Final Review**: Inspect `git status` / diff for unintended edits and report concise results.
