# Targey

The Target store is my favorite place to go and shop for merchandise thanks to the feasibility of their mobile application. 
Their applicaiton inspired me to create my own application that would communicate with the RedCircle API that would return current inventory stock, details, reviews, and more.
Targey allows for users to recieve the same real time information, either through likes of searching for a product or using your devices camera to scan UPC codes. 
I narrowed down Targey to be as simple as the official Target Mobile app using Red Circle, but that came with drawbacks:

***Issues I found***
- The RedCircle API is not own by Target Co. and does not have information for every product.
- API calls are slower; taking almost more than 10 seconds to fetch and retrieve data depending on a product.
- Most JSON objects are incorrect or missing. This caused more objects on the app-side to contain optional value.
- Stores that have stock of a product do not have any additional information besides their addresses. Aisle numbers are not included.

This is a more abbreviated list of issues found developing around the Red Circle API.

***My Solution***
- Give the users options they can follow if important information is not avalible - view product in Target app, contact their nearest store, or check out similar products.
- There's still no solution to the slower API calls; but show graphics that may hold the users attention for the meantime
- Make extensions to those objects in attempt to make fail safes if the information does not accurately show.
- Match up store addresses and implement their own method that returns their map coordinates and show where a selected store is located.

At the end of completing most of the challenging problems came learning:

***What I learned***
- Implementing CoreData for creating the 'shopping list' portion of the application.
- Using @escaping closures and Result for either a success or faiure of network calls.
- Error handling of poor and interrupted network calls.
- CLLocationManager for device autorization status, current location, and nearby Target Stores based its coordinates.
- CoreData 
- AVMetaDataOutput for detecting specified metadata object types.
- Introduction to application onboarding.
- Retrieving users zip code from CLGeoCoder and feeding it to the RedCircle API for nearby store stock information.
