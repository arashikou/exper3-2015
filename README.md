# EXPER3 2015 - "Name Not Yet Decided"

Last year, my wife gave me the best 30th birthday present I could have asked for by challenging me to make some real progress on my dream of making video games. She organized a themed video game jam, which she dubbed EXPER3, for which I had to make either a game a week for four weeks or one game in a month. You can read more about that and check out the results at [the GitHub repository where I checked in my entry](https://github.com/arashikou/exper3-2014).

Since that went so well, except for me continuing to make any more games once the jam was over, we've decided to make this an annual event. For 2015, the theme is **ILLUSION**, and you can follow my work in this repo.

# This Year's Game

This year, I have decided to make one game in a month instead of four games in four weeks. The reason is that last year, EXPER3 helped me rediscover my love of narrative in games, but I didn't really have a strong narrative in any of my creations because of time constraints. This year, I want to make something narrative, and that means taking more time. It also means the game will probably be less technically ambitious than it could otherwise be, as I want to focus on making the story solid.

I've decided to make what Sam Ashwell calls a ["Floating Module" game](https://heterogenoustasks.wordpress.com/2015/01/26/standard-patterns-in-choice-based-games/) or what Alexis Kennedy calls a ["Quality-Based Narrative"](http://www.failbettergames.com/storynexus-developer-diary-2-fewer-spreadsheets-less-swearing/). I really love _Fallen London_, and I've read a lot of Kennedy's writings about the theory behind it. I think there's a lot of potential in this relatively novel form, and I want to explore it.

Unfortunately, every QBN engine out there has been formally or effectively abandoned by its creator. Even Failbetter's own [StoryNexus](http://storynexus.com/) has gone into maintenance mode after it failed to attract enough of an audience to fund its continued development. And while you can hack Twine to work, it's not a supremely user-friendly workflow. So I've decided to code my own framework for this game. I make no pretension that it will be general-purpose enough to work for other people, of course.

# Technologies at Work

I am using [AngularJS 1.4](https://angularjs.org/) as a framework. I am coding in [CoffeeScript](http://coffeescript.org/). And instead of HTML, I am using [Jade](http://jade-lang.com/). I won't be using its advanced templating ability, but it will make the HTML more pleasant to write.
