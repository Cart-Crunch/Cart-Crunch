# CartCrunch

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [API Documentation/Reference](#API-Documentation-and-Reference)

## Overview
### Description
CartCrunch is an app that will allow users to search for groceries in the Kroger API and keep track of their prices. Users will get a notification upon a significant price increase or decrease. Users will be able to keep track of the price at the local level and the national price level according to the kroger family of stores. The app is currently under development as a capstone project for our CodePath iOS 102 course.

### App Evaluation
- **Category:** Shopping / Grocery
- **Mobile:** This app would be primarily developed for iOS mobile devices, making it convenient for users to access and track product prices while shopping in-store or planning their grocery trips.
- **Story:** Utilizes the Kroger API to help users track price changes for their favorite grocery products, providing notifications when prices drop or meet user-defined thresholds. Users can create a watchlist of products, compare prices across different Kroger stores, and make informed decisions about their grocery purchases.
- **Market:** The primary target audience for this app would be individuals who shop at Kroger stores, with a focus on budget-conscious consumers and those interested in tracking prices for better deals. The app could cater to a wide range of users, including families, college students, and working professionals.
- **Habit:** Users would engage with the app regularly to monitor price changes, manage their watchlist, and receive notifications about deals on their tracked products. The frequency of use could vary depending on the user's shopping habits and how often they visit Kroger stores or plan their grocery trips.
- **Scope:** The initial version of CartCrunch would focus on key features such as product search, watchlist management, price tracking, and notifications. Future expansions could include price history visualization, integration with shopping lists, personalized recommendations, loyalty program integration, and social sharing features.

## Product Spec
### User Stores (Required and Optional)

**Required Must-have Stories**
* User signs up and logs in to save product preferences and track price changes
* User searches for products using keywords or product names
* User adds products to their watchlist for tracking price updates
* Users receive push notifications when there's a significant price change for a product in their watchlist or when a product reaches a specific price
* Users can locate nearby Kroger stores based on their current location or a specified location

**Optional Nice-to-have Stories**
* Price update feed displays the latest price changes for products in the user's watchlist or in general
* Graph representation of the price history for each product in the user's watchlist
* Comparison of prices for the same product across different stores
* Integration of the watchlist with a shopping list, allowing users to add price-tracked products to their grocery list and check them off
* Users can share their watchlists or favorite product deals with others via social media, email, messaging apps, etc.
* Connection to the Kroger loyalty program, allowing users to earn and redeem reward points when purchasing tracked products
* Barcode scanning feature for quickly adding products to the user's watchlist in-store

### 2. Screen Archetypes
- Registration
- Login
- Home
- Settings
    - Profile Settings
- Watchlist
- Search
- Product (Detail View)
- Store Locator

### 3. Navigation

Tab Navigation (Tab to Screen)
- Home
- Search
- Wishlists
- Settings

Flow Navigation (Screen to Screen)
- Home (no forced login)
- Product -> Product details
- Wishlists (creating) -> Register/Login if needed -> Wishlists creation
- Search -> Filtered search
- Settings -> Toggle settings
- Store Locator -> List of stores with map view

## API Documentation and Reference
- https://developer.kroger.com/documentation
- https://developer.kroger.com/reference
