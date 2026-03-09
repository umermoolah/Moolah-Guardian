## **Moolah Guardian API Log: Complete Analysis**

This document provides a comprehensive analysis of the API calls captured during a live app session. It details both successful and failed requests, server errors, and the resulting client-side crashes.

### **1. Successful API Calls**

These endpoints were called successfully and returned the expected JSON responses.

#### **1.1. Get Banner Ads**

Retrieves active ad campaigns.

*   **URL:** `https://api2.moolahmobile.com/getBannerAds`
*   **Method:** `POST`
*   **Request Body:** `{}`
*   **Response (200 OK):**
    ```json
    {
      "campaigns": [
        {
          "campaign_id": 133,
          "offer_name": "JCI Campaign",
          "banner_img": "https://firebasestorage.googleapis.com/v0/b/moolahmobilesystem.appspot.com/o/Banners%2F16057016104.png?alt=media",
          ...
        }
      ]
    }
    ```

#### **1.2. Guardian Login**

Authenticates the user and provides access tokens.

*   **URL:** `https://api2.moolahmobile.com/guardian/login`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "email": "umer1@gmail.com",
      "password": "Umer12345678!",
      "moolahApp": "guardian"
    }
    ```
*   **Response (200 OK):**
    ```json
    {
      "status": true,
      "message": "Login successful",
      "tokens": { ... },
      "data": [
        {
          "id": 6,
          "first_name": "umer",
          "last_name": "umer",
          "email": "umer1@gmail.com",
          "user_role": 2
        }
      ]
    }
    ```

#### **1.3. Submit Feedback**

Submits user-provided feedback to the server.

*   **URL:** `https://api2.moolahmobile.com/feedback`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "feedback": "hi I am umer"
    }
    ```
*   **Response (200 OK):**
    ```json
    {
      "status": true,
      "message": "Thank You. Your feedback was successfully posted."
    }
    ```

---

### **2. Failed API Calls & Errors**

These endpoints were called but resulted in server errors, client-side errors, or application crashes.

#### **2.1. Create Payment Intent (404 Not Found)**

This endpoint does not exist on the server, resulting in an HTML error page.

*   **URL:** `https://api2.moolahmobile.com/createPaymentIntent`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "amount": 399
    }
    ```
*   **Error Response (404 Not Found):** The server responded with an HTML page indicating the endpoint could not be found.
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <title>Error</title>
    </head>
    <body>
      <pre>Cannot POST /createPaymentIntent</pre>
    </body>
    </html>
    ```
*   **Client-Side Error:** The app tried to parse the HTML response as JSON, causing a `FormatException`.

#### **2.2. Refresh Tokens (502 Bad Gateway & App Crash)**

The server failed to handle the token refresh request, leading to a gateway error and a subsequent crash.

*   **URL:** `https://api2.moolahmobile.com/refreshTokens`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjYsImlhdCI6MTc3MjA1NjIyOCwiZXhwIjoxNzc0NjQ4MjI4LCJ0eXBlIjoicmVmcmVzaCJ9.Aa2HhIjtE47pB11N6OUwqXfWOyMc6u4EhANGBmhWh2o"
    }
    ```
*   **Error Response (502 Bad Gateway):**
    ```html
    <html>
    <head><title>502 Bad Gateway</title></head>
    <body>
      <center><h1>502 Bad Gateway</h1></center>
    </body>
    </html>
    ```
*   **Client-Side Crash:** The app received this HTML page instead of the expected JSON. The code at `authController.dart:140` then tried to access `res.data["access"]` on a `null` response object, causing the app to crash.
    > **Unhandled Exception: NoSuchMethodError: The method '[]' was called on null.**

#### **2.3. Submit Review (Logical Failure)**

The server accepted the request but returned a generic error message, indicating a failure in the backend logic.

*   **URL:** `https://api2.moolahmobile.com/submitReview`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "rating": "5",
      "message": "supper"
    }
    ```
*   **Logical Error Response (200 OK):** Although the status code was 200, the body indicates failure.
    ```json
    {
      "status": false,
      "message": "An error occurred. Please try again."
    }
    ```

---

### **3. Other Notable Log Entries**

*   **SVG Rendering Warning:** `unhandled element <style/>; Picture key: Svg loader`
    *   This indicates that an SVG image in the app contains a `<style>` tag that the Flutter SVG renderer (flutter_svg) does not support. This can lead to the image not displaying correctly.
*   **IronSource Ad Load Failure:** `onAdLoadFailed:::::errorCode: 606, message:Empty waterfall`
    *   This log from the IronSource ad network means that it tried to load a banner ad but found no available ads to fill the request in its network.
