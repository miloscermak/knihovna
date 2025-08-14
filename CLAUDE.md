# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a single-file cultural club landing page for "Knihovna Čermáka a Staňka" - a literary and cultural space website built with vanilla HTML, CSS, and JavaScript. The project is completely self-contained in one HTML file (`knihovna.html`) with comprehensive documentation in `knihovna-docs.md`.

## Development Commands

This is a static HTML project with no build system or package management. To work with this project:

- **View the site**: Open `knihovna.html` directly in a web browser
- **No build/test commands**: This is a pure client-side application with no dependencies
- **No linting setup**: Uses vanilla CSS and JavaScript with no external tools

## Architecture & Code Structure

### Single-File Architecture
The entire application is contained in `knihovna.html` with three main sections:
- **CSS (lines 7-709)**: Complete styling using CSS custom properties and modern CSS features
- **HTML (lines 711-1174)**: Semantic structure with sections for hero, about, program, contact, footer, and admin panel
- **JavaScript (lines 872-1173)**: Vanilla ES6+ code handling all interactivity

### Key Components

**Frontend Structure:**
- **Navigation**: Fixed header with smooth scrolling and mobile hamburger menu
- **Hero Section**: Full-viewport landing area with call-to-action
- **About Section**: Two-column layout with placeholder images
- **Program Section**: Event listing with filtering and month grouping
- **Admin Panel**: Slide-out admin interface for content management
- **Responsive Design**: Mobile-first approach with single breakpoint at 768px

**Data Management:**
- **localStorage**: Primary data storage for events, about text, and newsletter subscribers
- **Event Structure**: Objects with id, title, type, date, time, description fields
- **Data Keys**: `events`, `aboutText`, `subscribers` in localStorage

### JavaScript Architecture

**Core Functions:**
- `renderEvents(filter)`: Displays filtered and sorted events grouped by month
- `renderEventList()`: Admin panel event management list
- Event management: Add/delete events with localStorage persistence
- UI interactions: Admin panel toggle, navigation, smooth scrolling

**Event Types:**
- `cteni`: Autorské čtení (Author readings)
- `diskuze`: Diskuze (Discussions) 
- `workshop`: Workshop
- `film`: Film screenings

### Admin System

**Access Methods:**
- Gear button (⚙) in bottom-right corner
- Keyboard shortcut: Ctrl+Shift+A
- Slide-out panel from right side

**Admin Features:**
1. **Event Management**: Add new events with full form validation
2. **Content Editing**: Modify "About Us" section text
3. **Event Listing**: View and delete existing events
4. **Newsletter**: Automatic email collection storage

### Styling System

**CSS Architecture:**
- **CSS Custom Properties**: Centralized color and transition management in `:root`
- **Color Palette**: Black (#1a1a1a), white, grays, and gold accent (#c9a961)
- **Typography**: System font stack for optimal performance
- **Animations**: Intersection Observer for fade-in effects, CSS transitions

## Development Notes

- **No Framework**: Pure vanilla JavaScript - no external dependencies
- **Browser Compatibility**: Modern browsers (Chrome, Firefox, Safari, Edge)
- **File Size**: ~25KB total - extremely lightweight
- **Mobile Support**: Responsive design with hamburger menu and layout adaptations
- **Data Persistence**: Uses localStorage - not suitable for production without backend

## Sample Data

The application includes 8 pre-populated events across all event types, spanning February-March 2024, demonstrating the full functionality of the event system.