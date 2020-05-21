# README

using ruby 2.7.1 and rails 6.0.2.2

*Make sure you are in the root directory of the Project folder and have the required version of ruby and rails
then run the following commands.*

``` 
    bundle install
    rails server
```
##### The application was deployed on Heroku #####

*Software requirement specification, Software Architecture and structural charts can be found in DOCS folder*

### Features Implemented : ###

* Sign In and Sign up to the website :
  * User can only post on the website only if he/she is registered and logged in to the website.
  * User name, email id and password are required for sign up. A confirmation email will be sent to the given email id and after              confirmation, the user is allowed to log in to the website

* Editing the profile:
  * UserProfile consists
    * Fullname (editable)
    * Dob (editable)
    * Country (editable)
    * College (editable)
    * profilePicture (editable)
    * Points ( not editable, can be modified based on his performance and usage of the site)
    * Interests (editable)
   * User can change only his profile
   * User can view profiles irrespective of login/logout
   * User can change his interests from Tags (can be created by the user)

* Friend Requests:
  * Friend requests can only be sent between users that are registered
  * Requesting
  * Accepting
  * Rejecting

* Messaging:
  * registered User can send messages to any registered user
  * Allowing only text messages
  * Reply msgs automatically loads without refreshing page
  * Empty msgs are not stored

* Notifications:
  * whenever a user sends a friend request it is notified to the user

* Tagging:
  * Tagging a question:
    * The user who is posting a question has the ability to add tags to it
    * These tags are used by other users while searching for a question
  * Tags added to a User:
    * Added as user interests for the user
    * Can be used for referring questions to the user

* Posting:
  * Questions
    * Only logged in users can post questions on the website.
    * Only the user who has posted the question has the ability to delete or edit the question
    * All the registered users can see who posted, when it was posted and when it was last edited.
    * The registered users have the ability to comment on the questions.
    * The registered users have the ability to upvote or downvote the questions.

  * Articles
    * Only the logged in users can post articles on the website
    * It is similar to posting questions
    * The registered users have the ability to only upvote the articles
    * All the registered users can see who posted it
    * Only the user who posted has the ability to edit the article

  * Answers
    * The registered users have the ability to post answers to the questions.
    * The user who posted the answer has the ability to delete and edit the answer.
    * The registered users have the ability to upvote or downvote the answer
    * The registered users have the ability to post comments on the answers also.
    * All the registered users can see who posted, when it was posted and when it was last edited.

  * Comments
    * The registered users have the ability to post comments to questions as well as the answers.
    * The user who posted the comment has the ability to edit or delete the comment
    * The registered users can see who posted, when it was posted and when it was last edited.

  * Voting:
    * The registered users can upvote or downvote any question or answer.
    * A user can upvote a particular question or answer only once. multiple votes to the same post will not be registered.
    * If a user upvotes a question and then downvotes the same question then his/her upvote will be deleted and downvote will be registered and vice-versa.

* Searching:
  * Searching question:
    * A search bar is provided to search for questions given a particular keyword as input.
    * The title of the questions that contain the keyword are shown as results

  * Searching question based on Tags:
    * A search bar is provided to search for questions given a particular tag as input
    * The questions which contain the exact tag names are returned as results

  * Searching Users:
    * A search bar is provided to search for users that are registered to the website.
    * It takes the uname as input and any user that has the uname as a part of their user name are returned as results


## Data Flow Diagaram ##

![DFD](https://github.com/TUJJIEVE/SocialNetwork_MedicalProfessionals/blob/master/DOCS/Data_Flow_Diagram.jpg?raw=true)



