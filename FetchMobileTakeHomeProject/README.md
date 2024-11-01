### Steps to Run the App
1. Make sure packages are up to date: File -> Packages -> Update to Latest Package Versions
2. Build and run the app in a simulator or device running iOS 16 and above
3. Run unit tests: CMD + U  

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I focused on building a clean, scalable MVVM architecture. I choose to focus on concise and discrete model, view model, and view layers to facilitate easy testing and maintainability. 

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent approximately 5 hours on the project. I allocated my time by prioritizing code to build a MVVM architecture with the following timeline in mind:  
1. Create a network layer
2. Create a view model
3. Create a view
4. Create Unit tests 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
To speed up development, I leveraged 2 popular Swift packages that allowed me to handle mocking the network layer and handle image caching without bespoken code. I consider these decisions appropriate trade-offs because both packages are easy to use, well maintained, and include robust documentation and support.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I think the weakest part of the project is the tests. Specifically, I would approach mocking the network layer differently if given more time.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
I used 2 libraries:
1. Mocker - for the use of mocking the network requests
2. SDWebImage/SDWebImageSwiftUI - for the downloading and caching of images 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I had fun with this project! I appreciate the opportunity to showcase my knowledge through project based assignments instead of Leet code style problem sets.  
