# snake

A simple Snake game in Haxe

## Notes

There is no UI except spacebar to start and stop the game and the control keys for individual snakes.

When the game is over you must quit and restart to play again.

Adding snakes is very easy; see the bottom of GameBoard.hx for how to
do it. Uncomment the expression in line 249 to add a snake whose
control keys are "IKLJ". You can add more snakes by adding similar
lines. To add more colors, see the code in Colors.hx.

Controls are implemented in Snake.hx. Adding controls for new snakes
is easy: pass an array of characters (i.e. one-character strings) to
the Snake constructor.

Adding new kinds of controls (for example mouse or gesture controls)
is pretty easy, but requires adding a layer of abstraction. We replace
the commandMap with a new class that presents the same or a similar
interface. Let's call the class KeyController. Then make KeyController
a subclass of an abstract controller class and add new sibling classes
for different styles of controllers. Replace canHandleKey() and
handleKey() with canHandle() and handle(), and add an API to each
controller class that enables these methods to work properly.

Changing the size of the board is as easy as changing the columnCount
and rowCount. It would be easy to change the game to do this at
runtime by adding a UI to accomplish it, and implementing a resize()
method to ensure that, for example, resizing the board doesn't kill
live snakes.

The current game supports any number of snake players, but finding
convenient keys for more than three or four is a problem. It might
actually be easier to use the Haxe network code to turn the game into
a peer-to-peer game with players using separate
keyboards. Alternatively, we might change the controller code to
support letting a player key in an ID or tap a UI widget and then use
the arrow keys to control his or her snake.

We can add AI by adding a strategy field to each snake and modifying
advance to run the strategy before executing the advance. If the snake
has no strategy then it is a player character.

We can add replays by adding a Log object. We record the initial game
state in the log, and all commands issued by advance(). To replay we
construct a new board in the same state that is stored in the Log,
then start the timer and execute the logged commands in order. Add a
UI widget to change the interval of the timer and we can control the
speed of the replay (or even rewind).

## Log

2017-02-09
11:50AM - started work on the program; experimenting with flash API
12:50PM - built simple apple sprite and added key-event handling
1:15PM - lunch break
2:15PM - add a simple snake
3:15PM - walk the poodle
3:30PM - add more snakes; refactor apple and snakes into simple classes
4:30PM - take the poodle to the park
9:00PM - add tails to the snakes
9:20PM - other business
9:40PM - add collision logic
10:00PM - other business

2017-02-10
7:16PM - refactoring

2017-02-11
9:00PM - supporting adjustable numbers of snakes

2017-02-12
12:52PM - tucked away early experiments; started with fresh organization
1:40PM  - stop
2:00PM  - refactored code into classes with distinct roles
2:30PM  - stop
5:35PM  - added support for the apple
6:00PM  - stop
7:00PM  - added code to stage a snake
8:00PM  - stop
10:40PM - implemented snake movement and extensible command-handlers
11:45PM - stop

2017-02-13
12:30AM - implemented growth, eating, and death
2:00 AM - stop

2017-02-14
12:30AM - implemented death, game over, and the timer-driven main game loop

