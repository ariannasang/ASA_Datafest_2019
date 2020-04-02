# ASA Datafest 2019
My team won first place at the American Statistical Association 2019 Datafest competition held at Wesleyan University. We developed a dashboard tool to visualize player performance and player readiness for Canada's Rugby 7s women's team. 

For more information on the American Statistical Association's nationwide Datafest competition, please follow this link: https://ww2.amstat.org/education/datafest/index.cfm

## The Challenge
### How do we quantify the role of fatigue and workload in a team’s performance in Rugby 7s?
The Canadian National Women's Rugby Team seeks advice on the role of workload and fatigue in the Rugby 7s. Rugby is a fast-paced, physically demanding sport that pushes the limits of athletic speed, endurance, and toughness. Rugby 7s players may play in up to three games in a day, resulting ina tremendous amount of athletic exertion. Substantial exertion results in fatigue, which many lead to the physiological deficits (e.g., dehydration), reduced athletic performance, and greater risk of injury.

Despite the importance of managing player fatigue in professional athletics, very little is known about its effects, and many training decisions are based on “gut feel.” Currently, training load is measured through a combination of subjective measurements (asking players how hard they worked) and objective measurements from wearable technology. Fatigue is typically estimated by asking players how they feel in wellness surveys. However, there is no agreed-upon standard of defining fatigue so the relationship between workload and fatigue is unclear. In this challenge, we encourage you to explore new ways of measuring fatigue and examine its effects on players’ performance and physical wellness. The datasets provide a number of observations that we believe will be useful to measure fatigue in players of the Canadian National Women's Rugby Team in the 2017-2018 season. Remember that training load is not the same as fatigue, and one question to explore is whether you can find evidence that some measures of training load are better than others.

## Our Solution

### Player per Tournament Performance Analysis
Our project focused on analyzing the performance of the Canadian Women’s Rugby 7s team in order to  present a recommendation on how to improve the team through better use of data. Rugby is a complex sport with intricate dynamics between training regimes and performance. We believe that paying careful attention to the data gathered from training sessions and games is essential for sports coaches to design personalized training habits for each of their team players. 

We developed visualization tool to analyze each player's performance in game *(using GPS and acceleration data from the player's sensors in their wearable tech)* and player's readiness before each tournament *(using self-reported data and coach-assigned workout regimen)* 

👉[See our presentation](https://docs.google.com/presentation/d/1Qq2EdIHjCxT5hdI-aC_XERe6D3GoNwCnsT3aficZUXE/edit?usp=sharing)

![dashboard-screenshot](./static/dash_v1.PNG)

# Components

## Game Videos

In order to give the coach a snapshot view of a player’s performance during the game, we created a minimalist video graphic of their movement throughout. The coach can use this to gain an after-the-fact birds-eye understanding of a player’s match. Created with the matplotlib python package, the animation displays a player (represented by a point) moving around in space. Speed is indicated by the length of the player’s ‘tail’. If coordinates for the corners of the pitch were included with the data, an image of a pitch could be overlaid, and the movement could be properly scaled to match exact distances.

## At-A-Glance Stats:
We provide a pair of quick at-a-glance statistics that will help a coach judge a player’s physical performance during a match. Since rugby is such a physical sport, we believe that alongside metrics like points scored (which are readily available), a coach needs access to deeper statistics about a player’s performance in order to make crucial judgements for future matches.

## Acceleration Plot:
A good measure for a player’s capacity to put in effort during a game can be measured well by their acceleration. A hard-working player who puts in maximum effort will have high acceleration levels, while a tired or underperforming player will be slower, though perhaps not visibly by spectators during the match. This plot of player acceleration during a game could be a useful tool to judge just how much a player is putting into their gameplay.

## Training Before Tournament:
The life of a coach is a busy one, and none have time to track the day-to-day training routines of every player. This chart gives a snapshot view of of a player’s training regimen leading up to a match.

## Mental and Physical Readiness:
Measuring a player’s performance during a game is one thing, understanding why they performed how they did is another. We created two plots, which we call Mental and Physical Status respectively, which measure a player’s perceived preparedness before a game.

# Data Description

* Workouts type + frequency
  * RPE => which workouts take the most out of each athlete
  * AcuteChronicRatio: how many cycles of de/training
  * USG: de/hydrated before or after training
* Performance Proxy
  * AccelXYZ: Max. Acceleration
  * Long, Lat: Distance travelled 
  * Speed
* Physical fatigue
  * (Bedtime, WakeTime, SleepHours): Sleeping regularity
  * fatigue
  * SleepQuality
  * Pain
  * Illness
  * Menstruation
  * Nutrition


  
* Mental status
  * ObjectiveRating
  * FocusRating
  * TrainingReadiness
  * Desire
  * Irritability

