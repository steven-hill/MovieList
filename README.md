# MovieList

## A UIKit project to search for movies using the iTunes Search API.

### Features and technical details
* This app is written in Swift 5 and UIKit, and has a wholly programmatic UI.
* Users can search for a movie using the name of the movie. The app uses the [iTunes Search API](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html) to get results and display the data in a UITableView.
* The user can tap on a result to see more information about that movie and watch the trailer via AVPlayer.
* If the user is interested in watching the movie, they can add it to the favourites list (accessible via the tab bar).
* I chose UserDefaults for persistence of the favourites list as the memory space requirement is small.
* This project really helped me to get practice with the protocol and delegate pattern, coordinators, MVC, and the single responsibility principle.

### Screenshots
![Search screen](https://github.com/steven-hill/MovieList/assets/98730693/48e23009-162b-4969-806e-1fffefd4cd19)    ![Search results screen](https://github.com/steven-hill/MovieList/assets/98730693/b43899eb-8e84-461d-a041-69a7139dbc37)    ![Movie detail screen](https://github.com/steven-hill/MovieList/assets/98730693/3454c307-2bd3-40ff-a753-8af9a5420334)
