# This repository contains: 



1. 1 To-Do list flutter application that was improved with 2 new functionalities: 1 timer that starts a counter from zero to  Close, Reset or Stop  button clicked. The timer is setted in the Brazilian standard (00 : 00 : 00) of hours, minutes and seconds. There is also 1 reverse timer that runs the same format but in a reverse timer from preset time coming back to zero, this funcionalitie is still being improved.



# The following external packages were used in this project:



1. **Intl:** used to format date and time of published tasks.

1. **flutter_slidable: ˆ0.6.0**:  used to get delete and stopwatch slidable buttons for each task added in containers

1. **shared_preferences:*ˆ2.0.15**: used to save data when the application closes and brings up the same data's state when the application opens again. 

   

# In lib's repository you can find the following organization of subrepositories:



1. **models:** respository created to host a TaskModel object that contains 2 importants attributes: title (to set a string description of task added) and datetime (to set a local time for each task added); and 2 important methods: toJson (converts TaskModel object in Json to save in SharedPreferences Repository) and fromJson (converts back json in TaskModel object to brings up data again on project when restarted) 

2. **pages:**  host the main widget of application: Homepage(), where the core functions are setted.    

3. **repositories:** setted to host the TaskRepository object where the SharedPreferences package are used to save and restart the same state of datas when the app closes and opens again. 

4. **widgets**:here where setted the TaskContainer widget that render the visual container of task model objects.  

   

# In this project you can find the following object models:



1. **TaskModel( ):** model created to set all the tasks datas: datetime and title. 
2. **TaskRepository( ):** model of repository created with SharedPreferences to save and restart the datas of project when it closes and opens again.



# In this project you can find the following widgets:



1. **MyApp( )**: basic default widget that returns the mainly widget Homepage()

2. **Homepage( ):** here you can find the all the functions and states used to brings up the funcionalities of application. 

3. **TaskContainer( ):** render the TaskModel object in a visual and slidable container with datetime and title of task..

   


# In this project you can find the following functions:



​		bellow the functions used to add and delete tasks in list "allTasks". 




1. **addTaskIfNotEmptyField():** firstly the function check if task content is not empty so then add the new task into the "allTasks" list where are hosted all tasks that will be render when the setState is called. 

2. **deleteTask(TaskModel task):** when the user clicks on Delete button firstly the function save content and index of deleted task for then finally delete. Once the task is deleted the function shows a ScaffoldMessenger with the Undelete action that makes possible reverts the deletion and brings up the task on list again with the same content and same index position.  

3. **deleteAllTasks():** Before clear the list with all tasks, the function shows an AlertDialog with Delete Confirmation where is possible cancel or definetely delete. 

   

   bellow the functions used in timer

   

4. **showTimerDialog:** show an AlertDialog with 4 action buttons: "Close, Reset, Stop, Start", eachone runs the four functions bellow. 

5. **startTimer:** the function starts the timer already in Brazilian's time format: hours : minutes : seconds (00 : 00 : 00).  

6. **resetTimer:** reset the timer to zero. 

7. **stopTimer:** stop the timer and save seconds, minutes and hours from stop click, so If the user clicks on Start again with no reset, the stopwatch starts to run again from the time's stopped. 

8. **quitTimerDialogAndResetTimer:** stop, reset and close the AlertDialog of timer.

   

   bellow basicaly the same actions but with functions programmed to runs reverse timer, that is, runs back to zero.  

   

9. **showReverseTimerDialog:** show an AlertDialog with the 4 action buttons: "Close, Reset, Stop, Start", eachone runs the 4 funvtions bellow.

10. **startReverseTimer:** start the timer from init time choosed or timer paused when the Stop button is clicked. 

11. **resetReverseTimer:** reset the timer 

12. **stopReverseTimer:** Stop the timer and save the numbers in case the start button is started again before the timer reset. 

1. **quiReverseTimerDialogAndResetTimer:** stop, reset and close the AlertDialog of timer.  



I like to bring up my functions setted into a minimal actions as possible because this way is easier to understand and find the details whos make difference in project's operation.

 

# In this project you can find the following variables, lists and getters:



instances

1. **taskRepository:** instance the TaskRepository object in Homepage widget, used to save infos 
2. **tasksController:** instance the TextEditingController in Homepage widget, used for task input captions 



lists

1. **allTasks:** list created to host all tasks who will be render and displayed on screen

variables



1. **errorText:** host the error mensage that will be dysplayed if the user try to add task without input content
2. **timer:** host the Timer object that will be used in timers functions 
3. **seconds:** used in Timer to set and count the seconds
4. **minutes:** used in Timer to set and count the minutes
5. **hours:** used in Timer to set and count the hours.
6. **secondsReverse:** used in Reverse Timer to set and count the seconds
7. **minutesReverse:** used in reverse Timer to set and count the minutes
8. **hoursReverse:** used in reverse Timer to set and count the hours.
9. **secondsReversePaused:** used to save the seconds where Reverse Timer was paused. 
10. **minutesReversePaused:** used to save the minutes where Reverse Timer was paused.
11. **hoursReversePaused:** used to save the hours where Reverse Timer was paused. 
12. **isTimerRunning:** bool variable used in Timer functions to get true when timer is runnning and false when it is off.
13.  **isTimerPaused:** this bool varibale was used especifically to save the numbers of reverse timer when the stopwatch is paused, so If the user click on 'Init' button without reset timer, the stopwatch starts from numbers saved instead from zero. This variable was used especifically in Reverse Timer buttons because the logical of Start Time is different between Start Timer and Start Reverse Timer, once the Start Timer comes back to zero and Start Reverse Timer comes back to preset values of Timer.



Getters

1. **bool get isTenSeconds:** it was get a bool value True when the seconds reachs 10 and was used in Timer's AlertDialog interpolation, because when the timer is smaller then 10, is necessary to display a string with 0 value before the number to set a correct timer format. For example, for one minute timer the corret is (00 : 01 : 00) and not (00 : 1 : 00).

2. **bool get isTenMinutes:** same explanation above but for minutes

3. **bool get isTenHours:** same explanation above but for hours. 

   
