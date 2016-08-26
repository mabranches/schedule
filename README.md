# Schedule

###Heroku
This [app](https://schedule-ajax.herokuapp.com) was depolyed in heroku
##### User
There are 3 created users that can be accessed with the emails:
  * users1@email.com
  * users2@email.com
  * users3@email.com

All with password **123**

You can also create a new user by accessing [/users/sign_up](https://schedule-ajax.herokuapp.com/users/sign_up)

### Usage
  In the schedule are only shown schedulings for the current week
##### Creating a scheduling
  Any user can create a new scheduling by clicking the **Agendar** button.
##### Canceling a scheduling
  You can cancel a scheduling by clicking the **X** button.
  Users can cancel only their own schedulings
### Code
##### Databases
  The **schedulings** table has the following schema
  ```
  schedulings(id, user_id, day, hour)
  ```
  This way a user can only schedule fixed intervals of 1 hour.
  The advantage is that concurrent writes are possible.
  A unique index (day, hour) can be used as constraint to prevent that 2 users can schedule the same timeframe.
##### Ruby/Rails
  The controllers and models are very simples.
  in **/lib/renderes** there are classes to be used in view.
  * ScheduleRenderer - Main class responsible to render all scheduling in a table
  * SchedulingRenderer - Rende a unique scheduling
  * EmptySchedulingRenderer - Render an avaible timeframe
  
##### Javascript
  There are 2 main classes
  * Scheduling
  * EmptyScheduling
  
  Both classes have 2 methods

  * action - Execute action of each class
    * Scheduling 
      * send request to cancel the current scheduling
      * update html with a empty scheduling
    * EmptyScheduling
      * send request to create a scheduling
      * update html with a new scheduling
  * build - used in the above method to update the html
